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
        Test.stopTest();
        System.assertEquals(2, dd.keyFields.size());
        System.assertEquals(String.valueOf(OpportunityLineItem.Quantity), dd.keyFields[0].toString());
        System.assertEquals('Product2.ProductCode', dd.keyFields[1].toString());
        System.assertEquals(2, dd.dataFields.size());
        System.assertEquals(2, dd.referenceFields.size());
    }

    @IsTest
    static void testDDBInvalidSObjectType() {
        Test.startTest();
        try {
            DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(null);
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBInvalidKeyFieldsBuild() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType);
        
        Test.startTest();
        try {
            ddb.build();
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidKeyField() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType);

        Test.startTest();
        try {
            ddb.addKeyField('');
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidDataField() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(Account.SObjectType);

        Test.startTest();
        try {
            ddb.addDataField('');
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReferenceField() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(null, new String[] {'Product2.ProductCode'});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReferenceKeyFields() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(OpportunityLineItem.OpportunityId, new String[] {});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidSObjectFieldReferences() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(OpportunityLineItem.OpportunityId, new SObjectField[] {});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testDDBAddInvalidReference() {
        DataDefinition.DataDefinitionBuilder ddb = new DataDefinition.DataDefinitionBuilder(OpportunityLineItem.SObjectType);
                
        Test.startTest();
        try {
            ddb.addReferenceField(null, new SObjectField[] {OpportunityLineItem.Opportunity.Name});
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }
}