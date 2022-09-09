@IsTest
public inherited sharing class AccountsDataFeederFactoryTest {
    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new AccountsDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new AccountsDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}