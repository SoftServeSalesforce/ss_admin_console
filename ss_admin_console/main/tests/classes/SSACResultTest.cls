@IsTest
public with sharing class SSACResultTest {
    @IsTest
    static void testSetStatus() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setStatus('Duplicated');
        Test.stopTest();
        System.assertEquals('Duplicated', obj.status);
    }

    @IsTest
    static void testSetRecordKey() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setRecordKey('recordKey');
        Test.stopTest();
        System.assertEquals('recordKey', obj.recordKey);
    }

    @IsTest
    static void testSetRecordId() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setRecordId('recordId');
        Test.stopTest();
        System.assertEquals('recordId', obj.recordId);
    }

    @IsTest
    static void testSetErrorMessage() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setErrorMessage('ErrorMessage');
        Test.stopTest();
        System.assertEquals('ErrorMessage', obj.errorMessage);
    }

    @IsTest
    static void testSetDescription() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setDescription('Description');
        Test.stopTest();
        System.assertEquals('Description', obj.description);
    }

    @IsTest
    static void testSetSObjectApiName() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        obj.setSObjectApiName('SObjectApiName');
        Test.stopTest();
        System.assertEquals('SObjectApiName', obj.sObjectApiName);
    }
}
