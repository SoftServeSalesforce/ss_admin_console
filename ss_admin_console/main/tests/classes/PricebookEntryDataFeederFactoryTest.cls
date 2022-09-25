@IsTest
public with sharing class PricebookEntryDataFeederFactoryTest {
    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new PricebookEntryDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new PricebookEntryDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}