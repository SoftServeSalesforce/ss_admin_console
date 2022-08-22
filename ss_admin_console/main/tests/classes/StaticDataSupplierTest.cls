@IsTest
public inherited sharing class StaticDataSupplierTest {
    
    @IsTest
    static void testSDDInvalidMetadata() {
        Test.startTest();
        try {
            StaticDataSupplier sdd = new StaticDataSupplier(null, new Account[] { 
                new Account(Name = 'Social Software') });
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testSDDInvalidData() {
        DataDefinition metadata = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name).build();

        Test.startTest();
        try {
            StaticDataSupplier sdd = new StaticDataSupplier(metadata, new List<SObject>());
            System.assert(false, 'IllegalArgumentException is expected here');
        } catch (IllegalArgumentException e) {}
        Test.stopTest();
    }

    @IsTest
    static void testSDDGetMetadata() {
        DataDefinition metadata = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name).build();

        Test.startTest();
        StaticDataSupplier sdd = new StaticDataSupplier(metadata, new Account[] { 
            new Account(Name = 'Social Software') });
        DataDefinition dd = sdd.getMetadata();
        Test.stopTest();
        System.assertEquals(metadata, dd);
    }

    @IsTest
    static void testSDDSupply() {
        DataDefinition metadata = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name).build();

        Test.startTest();
        StaticDataSupplier sdd = new StaticDataSupplier(metadata, new Account[] { 
            new Account(Name = 'Social Software') });
        List<SObject> data = sdd.supply();
        Test.stopTest();
        System.assertEquals(1, data.size());
        System.assertEquals('Social Software', data[0].get('Name'));
    }
}