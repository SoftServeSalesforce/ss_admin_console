@IsTest
public with sharing class DataFilterTest {

    private static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
            addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.FirstName).
            addReferenceField(Contact.AccountId, new String[] {'Name'});

    @IsTest
    private static void testFilter() {
        insertData();
        Test.startTest();
        List<SSACResult> filteredRecords = new DataFilter(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData).getMetadata(), generateMap()).filter();
        Test.stopTest();
        System.assertEquals(3, filteredRecords.size(), 'Filter method is not returning the right amount of records');
        System.assert(filteredRecords.get(0).status != null, 'Status is not populated');
        System.assertEquals(ApexActionStatus.OK.value(), filteredRecords.get(0).status, 'Filter status is not correct');
        System.assertEquals(ApexActionStatus.CHANGED.value(), filteredRecords.get(1).status, 'Filter status is not correct');
        System.assertEquals(ApexActionStatus.DUPLICATED.value(), filteredRecords.get(2).status, 'Filter status is not correct');
    }

    @IsTest
    private static void testGetExistentContactRecords() { 
        insertData();
        Test.startTest();
        List<SObject> queriedRecords = new DataFilter(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData).getMetadata(), generateMap()).getExistentRecords(generateMap());
        Test.stopTest();
        System.assertEquals(queriedRecords.size(), 2, 'Query does not return the right amount of records');
        System.assertEquals(sampleTestData[2].LastName, queriedRecords[1].get('LastName'));
        System.assertEquals(sampleTestData[2].FirstName, queriedRecords[1].get('FirstName'));
        System.assertEquals(sampleTestData[2].Email.toLowerCase(), queriedRecords[1].get('Email'));
    }

    static void insertData() {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
                Account.SObjectType,
                Contact.SObjectType
            }
        );
        Account a1 = new Account(Name='Social Software');
        uow.registerNew(a1);
        Contact c1 = new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'); 
        uow.registerNew(c1);
        uow.registerRelationship(c1, Contact.AccountId, a1);    
        Account a2 = new Account(Name='Adept Software');
        uow.registerNew(a2);
        Contact c2 = new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'EmmaBrown@testmail.com'); 
        uow.registerNew(c2);
        uow.registerRelationship(c2, Contact.AccountId, a2);    
        Account a3 = new Account(Name='Boss Software');
        uow.registerNew(a3);
        Contact c3 = new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com'); 
        uow.registerNew(c3);
        uow.registerRelationship(c3, Contact.AccountId, a3);    
        uow.commitWork();
    }

    public static List<Contact> sampleTestData = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };

    private static Map<RecordKey, SObject> generateMap() {
        Map<RecordKey, SObject> recordsMap = new Map<RecordKey, SObject>();
        for (SObject item : sampleTestData) {
            recordsMap.put(new RecordKey(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData).getMetadata().keyFields, item), item);
        }
        return recordsMap;
    }
    
}