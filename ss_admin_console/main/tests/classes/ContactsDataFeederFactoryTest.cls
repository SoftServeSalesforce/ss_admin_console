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
        System.assertNotEquals(null, df.getSupplier());
        System.assert(df.getSupplier().supply() != null &&  !df.getSupplier().supply().isEmpty(), 'Data in supplier can not be null or empty!');
        System.assertNotEquals(null, df.getSupplier().getMetadata());
    }
}