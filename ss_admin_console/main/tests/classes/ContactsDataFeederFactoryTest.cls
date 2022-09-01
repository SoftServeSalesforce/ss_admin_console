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
        BaseDataFeeder bdf = (BaseDataFeeder) new ContactsDataFeederFactory().getDataFeeder();
        Test.stopTest();
        System.assertNotEquals(null, bdf);
        System.assertNotEquals(null, bdf.getSupplier());
        System.assert(bdf.getSupplier().supply() != null &&  !bdf.getSupplier().supply().isEmpty(), 'Data in supplier can not be null or empty!');
        System.assertNotEquals(null, bdf.getSupplier().getMetadata());
    }
}