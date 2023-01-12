@IsTest
public with sharing class DataFilterTest {

    private static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
            addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.FirstName).
            addReferenceField(Contact.AccountId, new String[] {'Name'});

    @IsTest
    private static void testFilter() {
        insertData();

        Test.startTest();
        DataSupplier supplier = new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData);
        List<SSACResult> filteredRecords = new DataFilter(supplier.getMetadata(), sampleTestData).filter();
        Test.stopTest();

        System.assertEquals(3, filteredRecords.size(), 'Filter method is not returning the right amount of records');
        System.assertNotEquals(null, filteredRecords[0].status, 'Status is not populated');
        System.assertEquals(ApexActionStatus.OK.value(), filteredRecords[0].status, 'Filter status is not correct');
        System.assertEquals(ApexActionStatus.CHANGED.value(), filteredRecords[1].status, 'Filter status is not correct');
        System.assertEquals(ApexActionStatus.DUPLICATED.value(), filteredRecords[2].status, 'Filter status is not correct');
    }

    @IsTest
    private static void testGetExistentContactRecords() { 
        insertData();

        System.assertEquals(3, [SELECT Id FROM Account].size());
        System.assertEquals(3, [SELECT Id FROM Contact].size());

        Test.startTest();
        DataSupplier supplier = new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData);
        DataFilter filter = new DataFilter(supplier.getMetadata(), sampleTestData);
        List<Contact> queriedRecords = (List<Contact>) filter.loadExistentRecords(sampleTestData);
        Test.stopTest();

        System.assertEquals(queriedRecords.size(), 2, 'Query does not return the right amount of records');
        Integer index = -1;
        for (Integer i = 0; i < queriedRecords.size(); i++) {
            if (queriedRecords[i].Email == sampleTestData[2].Email) {
                index = i;
                break;
            }
        }
        System.assert(index > -1);
        System.assertEquals(sampleTestData[2].LastName, queriedRecords[index].get('LastName'));
        System.assertEquals(sampleTestData[2].FirstName, queriedRecords[index].get('FirstName'));
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
        Contact c1 = new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'olivia.smith@testmail.com');
        uow.registerNew(c1);
        uow.registerRelationship(c1, Contact.AccountId, a1);    
        Account a2 = new Account(Name='Adept Software');
        uow.registerNew(a2);
        Contact c2 = new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'emma.brown@testmail.com');
        uow.registerNew(c2);
        uow.registerRelationship(c2, Contact.AccountId, a2);    
        Account a3 = new Account(Name='Boss Software');
        uow.registerNew(a3);
        Contact c3 = new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'amelia.wilson@testmail.com');
        uow.registerNew(c3);
        uow.registerRelationship(c3, Contact.AccountId, a3);    
        uow.commitWork();
    }

    public static List<Contact> sampleTestData = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'olivia.smith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'emma.brown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'amelia.wilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };
}