@isTest
public with sharing class SSACDataFilterTest {

    public static void insertCustomerData() {
        Database.insert(customerData, true);
    }
    
    public static List<Contact> customerData = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'), //OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com'), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com') //Duplicated
    };

    @IsTest
    static void testFilterForContactPositive() {
        insertCustomerData();
        Test.startTest();
        List<SSACResult> filteredRecords = new SSACSObjectAction(CustomerConstants.CONTACT_API_NAME, CustomerConstants.CONTACT_DATA.values(), CustomerConstants.CONTACT_KEYFIELDS, CustomerConstants.CONTACT_DATAFIELDS).test();
        Test.stopTest();
        System.assert(filteredRecords.size() > 0, 'Filter method is not working properly');
        System.assert(filteredRecords.get(0).status != null, 'Status is null');
        System.assertEquals(SSACConstants.OK_STATUS, filteredRecords.get(0).status, 'Filter status is not correct');
        System.assertEquals(SSACConstants.CHANGED_STATUS, filteredRecords.get(1).status, 'Filter status is not correct');
        System.assertEquals(SSACConstants.DUPLICATED_STATUS, filteredRecords.get(2).status, 'Filter status is not correct');
    }

    @IsTest
    static void testFilterForContactNegative() {
        Test.startTest();
        List<SSACResult> filteredRecords = new SSACSObjectAction(CustomerConstants.CONTACT_API_NAME, null, CustomerConstants.CONTACT_KEYFIELDS, CustomerConstants.CONTACT_DATAFIELDS).test();
        Test.stopTest();
        System.assert(filteredRecords == null || filteredRecords.isEmpty(), 'Constant records list is null');
    }
    
    @IsTest
    static void testGetExistentContactRecordsPositive() {
        List<FieldReference> keyFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.Email)};
        List<FieldReference> dataFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.FirstName), FieldReference.build(Contact.Email)};
        insertCustomerData();
        Test.startTest();
        List<SObject> queriedRecords = new SSACDataFilter(CustomerConstants.CONTACT_API_NAME, keyFields, dataFields).getExistentRecords(CustomerConstants.CONTACT_DATA.values());
        Test.stopTest();
        System.assert(queriedRecords.size() > 0, 'Query does not return records');
    }

    @IsTest
    static void testGetExistentContactRecordsNegative() {
        List<FieldReference> keyFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.Email)};
        List<FieldReference> dataFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.FirstName), FieldReference.build(Contact.Email)};
        insertCustomerData();
        Test.startTest();
        try {
            List<SObject> queriedRecords = new SSACDataFilter(CustomerConstants.ACCOUNT_API_NAME, keyFields, dataFields).getExistentRecords(CustomerConstants.CONTACT_DATA.values());
            System.assert(false, 'QueryException expected');
        } catch (Exception e) {
            System.assert(e instanceof QueryException, 'Exception Type is not QueryException');
        }
        Test.stopTest();
    }
}