@IsTest
public inherited sharing class ContactsDataFeederFactoryTest {

    @IsTest
    static void testGetName() {
        Test.startTest();
        String returnedValue = new ContactsDataFeederFactory().getName();
        Test.stopTest();
        System.assert(String.isNotBlank(returnedValue), 'Method can not return empty string or null!');
    }

    @IsTest
    static void testGetDataFeeder() {
        Test.startTest();
        DataFeeder df = new ContactsDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, df);
    }
}