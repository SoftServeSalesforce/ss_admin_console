@IsTest
public with sharing class PriceBookDataFeederFactoryTest {
    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new PriceBookDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new PriceBookDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}