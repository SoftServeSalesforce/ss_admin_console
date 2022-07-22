@IsTest
public inherited sharing class FieldReferenceTest {

    @IsTest
    static void testSchemaGetField() {
        FieldReference field = FieldReference.build(Account.Name);

        Test.startTest();
        SObjectField sobjField = field.getField();
        Test.stopTest();

        System.assertEquals(Account.Name, sobjField, 'Method must return Account.Name SObjectField');
    }

    @IsTest
    static void testSchemaGetFrom() {
        FieldReference field = FieldReference.build(Account.Name);
        Account acc = new Account(Name = 'TestAcct');

        Test.startTest();
        Object obj = field.getFrom(acc);
        Test.stopTest();

        System.assertEquals(acc.Name, obj, 'Method must return value of Account.Name field');
    }

    @IsTest
    static void testSchemaToString() {
        FieldReference field = FieldReference.build(Account.Name);

        Test.startTest();
        String strField = field.toString();
        Test.stopTest();

        System.assertEquals(Account.Name.getDescribe().getName(), strField);
    }

    @IsTest
    static void testSchemaInvalidField() {
        Test.startTest();
        try {
            FieldReference field = FieldReference.build(Schema.Account.getSObjectType(), 'Invalid Field');
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Field is invalid', e.getMessage());
        }
        Test.stopTest();
    }

    @IsTest 
    static void testChainedGetField() {
        FieldReference field = FieldReference.build(Schema.Opportunity.getSObjectType(), 'Account.Owner.Name');
        
        Test.startTest();
        SObjectField sobjField = field.getField();
        Test.stopTest();

        System.assertEquals(User.Name, sobjField, 'Method must return Account.Owner.Name SObjectField');
    }

    @IsTest 
    static void testChainedInvalidField() {
        Test.startTest();
        try {
            FieldReference field = FieldReference.build(Schema.Account.getSObjectType(), 
                                                    'Account.Name');
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testChainedGetFrom() {
        FieldReference field = FieldReference.build(Schema.Contact.getSObjectType(), 'Account.Name');
        Contact cont = new Contact(FirstName = 'Test', LastName = 'Test', Account = new Account(Name = 'TestAcct'));

        Test.startTest();
        Object obj = field.getFrom(cont);
        Test.stopTest();

        System.assertEquals(cont.Account.Name, obj, 'Method must return value of Account.Name field');
    }

    @IsTest
    static void testChainedToString() {
        FieldReference field = FieldReference.build(Schema.Contact.getSObjectType(), 'Account.Name');

        Test.startTest();
        String strField = field.toString();
        Test.stopTest();

        System.assertEquals('Account.Name', strField);
    }
}