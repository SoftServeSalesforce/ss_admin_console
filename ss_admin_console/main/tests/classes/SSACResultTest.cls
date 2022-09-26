@IsTest
public with sharing class SSACResultTest {
    @IsTest
    static void testSetStatus() {
        SSACResult obj = new SSACResult();
        Test.startTest();
        //String str = obj.setStatus('');
        obj.setStatus('');
        Test.stopTest();
    }

    @IsTest
    static void testSetRecordKey() {
        Test.startTest();
        new SSACResult().setRecordKey('recordKey');
        Test.stopTest();
    }

    @IsTest
    static void testSetRecordId() {
        Test.startTest();
        new SSACResult().setRecordId('recordId');
        Test.stopTest();
    }

    @IsTest
    static void testSetErrorMessage() {
        Test.startTest();
        new SSACResult().setErrorMessage('ErrorMessage');
        Test.stopTest();
    }

    @IsTest
    static void testSetDescription() {
        Test.startTest();
        new SSACResult().setDescription('Description');
        Test.stopTest();
    }

    @IsTest
    static void testSetSObjectApiName() {
        Test.startTest();
        new SSACResult().setSObjectApiName('SObjectApiName');
        Test.stopTest();
    }
}
