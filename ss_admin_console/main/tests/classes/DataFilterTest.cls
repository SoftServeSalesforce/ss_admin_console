@IsTest
public with sharing class DataFilterTest {

    public static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
                addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.Email).
                addDataField(Contact.LastName).addDataField(Contact.FirstName).addDataField('Account.Name').
                addReferenceField(Contact.AccountId, new String[] {'Account.Name'});

    @TestSetup
    static void makeData(){
        new TestDataFactory().insertData();
    }

    @IsTest
    static void testFilterForContact() {
        Test.startTest();
        List<SSACResult> filteredRecords = new DataFilter(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleCustomerDataToConst)).filter();
        Test.stopTest();
        System.assert(filteredRecords.size() > 0, 'Filter method is not working properly');
        System.assert(filteredRecords.get(0).status != null, 'Status is null');
        System.assertEquals(SSACConstants.OK_STATUS, filteredRecords.get(0).status, 'Filter status is not correct');
        System.assertEquals(SSACConstants.CHANGED_STATUS, filteredRecords.get(1).status, 'Filter status is not correct');
        System.assertEquals(SSACConstants.DUPLICATED_STATUS, filteredRecords.get(2).status, 'Filter status is not correct');
    }

    @IsTest
    static void testGetExistentContactRecords() { 
        Test.startTest();
        List<SObject> queriedRecords = new DataFilter(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleCustomerDataToConst)).getExistentRecords(sampleCustomerDataToConst);
        Test.stopTest();
        System.assert(queriedRecords.size() > 0, 'Query does not return records');
    }

    public static List<Contact> sampleCustomerDataToConst = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };
}