public inherited sharing class ContactsDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Contacts';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
                addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.FirstName).
                addReferenceField(Contact.AccountId, new String[] {'Name'});
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Contact[] {
                        new Contact(LastName = 'Smith', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')),
                        new Contact(LastName = 'Brown', FirstName = 'Emma', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')),
                        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')),
                        new Contact(LastName = 'Thomson', FirstName = 'Ava', Email = 'AvaThomson@testmail.com', Account = new Account(Name='Scope Software')),
                        new Contact(LastName = 'Robertson', FirstName = 'Sophia', Email = 'SophiaRobertson@testmail.com', Account = new Account(Name='Variable Software')),
                    
                        new Contact(LastName = 'Simpson', FirstName = 'Isla', Email = 'IslaSimpson@testmail.com', Account = new Account(Name='Social Software')),
                        new Contact(LastName = 'Martin', FirstName = 'Penelope', Email = 'PenelopeMartin@testmail.com', Account = new Account(Name='Adept Software')),
                        new Contact(LastName = 'Ferguson', FirstName = 'Elizabeth', Email = 'ElizabethFerguson@testmail.com', Account = new Account(Name='Boss Software')),
                        new Contact(LastName = 'Cameron', FirstName = 'Eleanor', Email = 'EleanorCameron@testmail.com', Account = new Account(Name='Scope Software')),
                        new Contact(LastName = 'Duncan', FirstName = 'Elena', Email = 'ElenaDuncan@testmail.com', Account = new Account(Name='Variable Software')),
                        
                        new Contact(LastName = 'Johnstone', FirstName = 'Ethan', Email = 'EthanJohnstone@testmail.com', Account = new Account(Name='Social Software')),
                        new Contact(LastName = 'Hughes', FirstName = 'Leo', Email = 'LeoHughes@testmail.com', Account = new Account(Name='Adept Software')),
                        new Contact(LastName = 'Watt', FirstName = 'Jack', Email = 'JackWatt@testmail.com', Account = new Account(Name='Boss Software')),
                        new Contact(LastName = 'Mcmillan', FirstName = 'Jackson', Email = 'JacksonMcmillan@testmail.com', Account = new Account(Name='Scope Software')),
                        new Contact(LastName = 'Mcintosh', FirstName = 'Leriel', Email = 'LerielMcintosh@testmail.com', Account = new Account(Name='Variable Software')),
                        
                        new Contact(LastName = 'Findlay', FirstName = 'Luca', Email = 'LucaFindlay@testmail.com', Account = new Account(Name='Social Software')),
                        new Contact(LastName = 'Jamieson', FirstName = 'Anthony', Email = 'AnthonyJamieson@testmail.com', Account = new Account(Name='Adept Software')),
                        new Contact(LastName = 'Aitken', FirstName = 'Isaiah', Email = 'IsaiahAitken@testmail.com', Account = new Account(Name='Boss Software')),
                        new Contact(LastName = 'Reilly', FirstName = 'Kai', Email = 'KaiReilly@testmail.com', Account = new Account(Name='Scope Software')),
                        new Contact(LastName = 'Thompson', FirstName = 'John', Email = 'JohnThompson@testmail.com', Account = new Account(Name='Variable Software')),
                        
                        new Contact(LastName = 'Cooper', FirstName = 'Alina', Email = 'AlinaCooper@testmail.com', Account = new Account(Name='Social Software')),
                        new Contact(LastName = 'Peterson', FirstName = 'Bailey', Email = 'BaileyPeterson@testmail.com', Account = new Account(Name='Adept Software')),
                        new Contact(LastName = 'Bailey', FirstName = 'Juniper', Email = 'JuniperBailey@testmail.com', Account = new Account(Name='Boss Software')),
                        new Contact(LastName = 'Reed', FirstName = 'Maeve', Email = 'MaeveReed@testmail.com', Account = new Account(Name='Scope Software')),
                        new Contact(LastName = 'Kelly', FirstName = 'Molly', Email = 'MollyKelly@testmail.com', Account = new Account(Name='Variable Software'))
                    } 
                )
        );
    }
}