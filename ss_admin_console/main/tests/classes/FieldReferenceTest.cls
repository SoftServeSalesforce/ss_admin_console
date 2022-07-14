@IsTest
public inherited sharing class FieldReferenceTest {

    @TestSetup static void setup() {
        Account acc = new Account(Name = 'TestAcct');
        insert acc;
        Contact cont = new Contact(FirstName='Test', LastName='Test', Accountid= acc.id);
		insert cont;      
    }
    
    @IsTest
    static void testSchemaGetField(){
        FieldReference field = FieldReference.build(Account.Name);

        Test.startTest();
        SObjectField sobjField = field.getField();
        Test.stopTest();

        System.assertEquals(sobjField, Account.Name, 'Method must return SObjectField');
    }

    @IsTest
    static void testSchemaGetFrom(){
        FieldReference field = FieldReference.build(Account.Name);
        SObject sobj = [SELECT ID, Name FROM Account LIMIT 1];

        Test.startTest();
        Object obj = field.getFrom(sobj);
        Test.stopTest();

        System.assertEquals(obj, 'TestAcct', 'Method must return field value of sobject');
    }

    @IsTest
    static void testSchemaToString(){
        FieldReference field = FieldReference.build(Account.Name);
        SObject sobj = [SELECT Name FROM Account LIMIT 1];

        Test.startTest();
        String strField = field.toString();
        Test.stopTest();

        System.assertEquals(strField, 'Name', 'Method must return field name sobject');
    }

    @IsTest
    static void testSchemaInvalidField(){
        Test.startTest();
        try {
            FieldReference field = FieldReference.build(Schema.Account.getSObjectType(), 'Invalid Field');
        } catch (Exception e) {
            System.assertEquals('Field is invalid', e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest 
    static void testChainedGetField(){
        FieldReference field = FieldReference.build(Schema.Opportunity.getSObjectType(), 'Account.Owner.Name');
       
        Test.startTest();
        SObjectField sobjField = field.getField();
        Test.stopTest();

        System.assertEquals(sobjField, User.Name, 'Method must return SObjectField');
    }

    @IsTest 
    static void testChainedInvalidField(){
        Test.startTest();
        try {
            FieldReference field = FieldReference.build(Schema.Account.getSObjectType(), 
                                                    'Account.Name');
        } catch (Exception e) {
            System.assertEquals(e.getTypeName(), 'System.IllegalArgumentException');
        }
        Test.stopTest();
    }

    @IsTest
    static void testChainedGetFrom(){
        FieldReference field = FieldReference.build(Schema.Contact.getSObjectType(), 'Account.Name');
        SObject sobj = [SELECT ID, Account.Name FROM Contact LIMIT 1];

        Test.startTest();
        Object obj = field.getFrom(sobj);
        Test.stopTest();

        System.assertEquals(obj, 'TestAcct', 'Method must return field value of sobject');
    }

    @IsTest
    static void testChainedToString(){
        FieldReference field = FieldReference.build(Schema.Contact.getSObjectType(), 'Account.Name');

        Test.startTest();
        String strField = field.toString();
        Test.stopTest();

        System.assertEquals(strField, 'Account.Name', 'Method must return field name sobject');
    }
}