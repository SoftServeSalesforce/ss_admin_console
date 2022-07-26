public inherited sharing class SampleDataSuppliers {

    public static DataSupplier getAccountSampleData() {
        return new StaticDataSupplier(
            new List<SObjectField>{Account.Name}, 
            new List<SObjectField>{Account.Name}, 
            new Account[] {
                new Account(Name = 'Sooocial Software'),
                new Account(Name = 'Adept Software'),
                new Account(Name = 'Boss Software'),
                new Account(Name = 'Scope Software'),
                new Account(Name = 'Variable Software')
        });
    }

    public static DataSupplier getContactSampleData() {
        return new StaticDataSupplier(
            new List<SObjectField>{Contact.Email, Contact.LastName},
            new List<SObjectField>{Contact.Email, Contact.LastName, Contact.FirstName},
            new Contact[] {
                new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'),
                new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'EmmaBrown@testmail.com'),
                new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com'),
                new Contact(LastName = 'Thomson', FirstName = 'Ava', Email = 'AvaThomson@testmail.com'),
                new Contact(LastName = 'Robertson', FirstName = 'Sophia', Email = 'SophiaRobertson@testmail.com')
        });
    }
}