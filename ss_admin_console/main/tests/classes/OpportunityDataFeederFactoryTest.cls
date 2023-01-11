@IsTest
public with sharing class OpportunityDataFeederFactoryTest {
    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new OpportunityDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new OpportunityDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}
