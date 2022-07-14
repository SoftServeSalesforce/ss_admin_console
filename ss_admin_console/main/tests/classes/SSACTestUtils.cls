public with sharing class SSACTestUtils {

    public void insertCustomerData(){
        Database.insert(customerData, true);
    }

    public static List<Contact> customerData = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'), //OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com'), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com') //Duplicated
    };
}
