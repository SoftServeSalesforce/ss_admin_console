@isTest
public with sharing class SSACDataFilterTest {
    
    @isTest
    static void testFilterForContactPositive() {
        new SSACTestUtils().insertCustomerData();
        Test.startTest();
        List<SSACResult> filteredRecords = new SSACSObjectAction(CustomerConstants.CONTACT_API_NAME, CustomerConstants.CONTACT_DATA.values(), CustomerConstants.CONTACT_KEYFIELDS, CustomerConstants.CONTACT_DATAFIELDS).test();
        Test.stopTest();
        System.assert(filteredRecords.size() > 0, 'Filter method is not working properly');
        System.assert(filteredRecords.get(0).status != null, 'Status is null');
        System.assertEquals('OK', filteredRecords.get(0).status, 'Filter status is not correct');
        System.assertEquals('CHANGED', filteredRecords.get(1).status, 'Filter status is not correct');
        System.assertEquals('DUPLICATED', filteredRecords.get(2).status, 'Filter status is not correct');
    }

    @isTest
    static void testFilterForContactNegative() {
        Test.startTest();
        List<SSACResult> filteredRecords = new SSACSObjectAction(CustomerConstants.CONTACT_API_NAME, null, CustomerConstants.CONTACT_KEYFIELDS, CustomerConstants.CONTACT_DATAFIELDS).test();
        Test.stopTest();
        System.assert(filteredRecords.isEmpty() || filteredRecords == null, 'Constant records are null');
    }
    
    @isTest
    static void testGetExistentContactRecordsPositive() {
        List<FieldReference> keyFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.Email)};
        List<FieldReference> dataFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.FirstName), FieldReference.build(Contact.Email)};
        new SSACTestUtils().insertCustomerData();
        Test.startTest();
        List<SObject> queriedRecords = new SSACDataFilter(CustomerConstants.CONTACT_API_NAME, keyFields, dataFields).getExistentRecords(CustomerConstants.CONTACT_DATA.values());
        Test.stopTest();
        System.assert(queriedRecords.size() > 0, 'Query does not return records');
    }

    @isTest
    static void testGetExistentContactRecordsNegative() {
        List<FieldReference> keyFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.Email)};
        List<FieldReference> dataFields = new List<FieldReference> {FieldReference.build(Contact.LastName), FieldReference.build(Contact.FirstName), FieldReference.build(Contact.Email)};
        new SSACTestUtils().insertCustomerData();
        Test.startTest();
        try {
            List<SObject> queriedRecords = new SSACDataFilter(CustomerConstants.ACCOUNT_API_NAME, keyFields, dataFields).getExistentRecords(CustomerConstants.CONTACT_DATA.values());
        } catch (Exception e) {
            System.assertEquals('System.QueryException', e.getTypeName());
        }
        Test.stopTest();
    }
}