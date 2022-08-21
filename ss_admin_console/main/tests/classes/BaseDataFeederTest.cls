@IsTest
public with sharing class BaseDataFeederTest {

    public static final FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{new PlatformEventFeedLogger(), new SystemFeedLogger()});
    public static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
                addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.Email).
                addDataField(Contact.LastName).addDataField(Contact.FirstName).addDataField('Account.Name').
                addReferenceField(Contact.AccountId, new String[] {'Account.Name'});

    @TestSetup
    static void makeData(){
        new TestDataFactory().insertData();
    }

    @IsTest
    static void testFeedNegative() {
        Test.startTest();
        try {
            new BaseDataFeeder(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleCustomerDataToConst)).feed(true, true, logger);
            System.assert(false, 'DmlException expected');
        } catch (DmlException e) {
            // DmlException is expected here 
            System.assert(e.getMessage().contains('failed'), 'DmlException is not catched correctly');
         }
         Test.stopTest();
    }

    public static List<Contact> sampleCustomerDataToConst = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };
}
