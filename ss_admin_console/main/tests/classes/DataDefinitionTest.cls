@IsTest
public inherited sharing class DataDefinitionTest {

    @IsTest
    static void testDDBBuild() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType).
                addKeyField(OpportunityLineItem.Quantity).addKeyField('Product2.ProductCode').
                addDataField(OpportunityLineItem.Quantity).addDataField('Product2.ProductCode').
                addReferenceField(OpportunityLineItem.OpportunityId, new SObjectField[] {OpportunityLineItem.Opportunity.Name}).
                addReferenceField(OpportunityLineItem.Product2Id, new String[] {'Product2.ProductCode'});

        Test.startTest();
        DataDefinition dd = ddb.build();
        System.assertEquals(2, dd.keyFields.size());
        System.assertEquals(2, dd.dataFields.size());
        System.assertEquals(2, dd.referenceFields.size());
        Test.stopTest();
    }

    @IsTest
    static void testDDBInvalidSObjectTypeBuild() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(null);
        
        Test.startTest();
        try {
            ddb.build();
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBInvalidKeyFieldsBuild() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType);
        
        Test.startTest();
        try {
            ddb.build();
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBInvalidDataFieldsBuild() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField('Name');
        
        Test.startTest();
        try {
            ddb.build();
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidKeyField() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType);

        Test.startTest();
        try {
            ddb.addKeyField('Invalid');
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReferenceField() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(null, new String[] {'Product2.ProductCode'});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReferenceKeyFields() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(OpportunityLineItem.OpportunityId, new String[] {});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidSObjectFieldReferences() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(OpportunityLineItem.OpportunityId, new SObjectField[] {});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReference() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(null, new SObjectField[] {OpportunityLineItem.Opportunity.Name});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
        Test.stopTest();
    }
}