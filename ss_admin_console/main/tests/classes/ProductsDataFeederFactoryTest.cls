@IsTest
public with sharing class ProductsDataFeederFactoryTest {
    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new ProductsDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new ProductsDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}
