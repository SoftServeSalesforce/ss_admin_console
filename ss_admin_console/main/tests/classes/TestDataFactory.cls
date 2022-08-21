public with sharing class TestDataFactory {
    
    public void insertData() {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
            new Schema.SObjectType[] {
            Account.SObjectType,
            Contact.SObjectType
            }
        );
        Account a1 = new Account(Name='Social Software');
        uow.registerNew(a1);
        Contact c1 = new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com'); 
        uow.registerNew(c1);
        uow.registerRelationship(c1, Contact.AccountId, a1);    
        Account a2 = new Account(Name='Adept Software');
        uow.registerNew(a2);
        Contact c2 = new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'EmmaBrown@testmail.com'); 
        uow.registerNew(c2);
        uow.registerRelationship(c2, Contact.AccountId, a2);    
        Account a3 = new Account(Name='Boss Software');
        uow.registerNew(a3);
        Contact c3 = new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com'); 
        uow.registerNew(c3);
        uow.registerRelationship(c3, Contact.AccountId, a3);    
        uow.commitWork();
    }
}
