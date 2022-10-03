@IsTest
public with sharing class BaseDataFeederTest {

    @IsTest 
    private static void testFeedUpsertMocksNegative() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, true, true);
        Test.startTest();
        df.feed(true, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).error(fflib_Match.stringStartsWith('FAILED'));
    }

    @IsTest 
    private static void testFeedUpsertMocksPositive() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        fflib_SObjectUnitOfWork fflibUnitofWork = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
        fflibUnitofWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {Contact.SObjectType, Account.SObjectType});
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, true);
        Test.startTest();
        df.feed(true, logger);
        Test.stopTest();
        ((fflib_SObjectUnitOfWork) mocks.verify(fflibUnitofWork, 1)).commitWork();
    }

    @IsTest 
    private static void testFeedInsertMocksNegative() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, true, true);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).error(fflib_Match.stringStartsWith('FAILED'));
    }

    @IsTest 
    private static void testFeedInsertMocksPositive() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        fflib_SObjectUnitOfWork fflibUnitofWork = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
        fflibUnitofWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {Contact.SObjectType, Account.SObjectType});
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, true);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((fflib_SObjectUnitOfWork) mocks.verify(fflibUnitofWork, 1)).commitWork();
    }

    @IsTest 
    private static void testFeedInsertMocksPositiveAccounts() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        fflib_SObjectUnitOfWork fflibUnitofWork = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);
        fflibUnitofWork = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {Account.SObjectType});
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, false);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((fflib_SObjectUnitOfWork) mocks.verify(fflibUnitofWork, 1)).commitWork(); 
    }

    private static BaseDataFeeder baseDataFeederInstance(fflib_ApexMocks mocks, Boolean clearResults, Boolean isChild) {
       DataDefinition.DataDefinitionBuilder dataDefinitionBuilderAccount = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name);
    
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilderContact = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
            addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name')
            .addDataField(Contact.FirstName)
            .addReferenceField(Contact.AccountId, new String[] {'Name'});

        DataFilter filter = (DataFilter) mocks.mock(DataFilter.class);
        mocks.startStubbing();
        if (clearResults) {
            mocks.when(filter.filter()).thenReturn(new List<SSACResult>());
        } else {
            mocks.when(filter.filter()).thenReturn(isChild ? resultsContact() : resultsAccount());
        }
        mocks.stopStubbing();
        DataSupplier accountDataSupplier = new StaticDataSupplier(dataDefinitionBuilderAccount.build(), sampleTestDataAccount());
        DataSupplier contactDataSupplier = new StaticDataSupplier(dataDefinitionBuilderContact.build(), sampleTestDataContact());
        BaseDataFeeder df = new BaseDataFeeder(isChild ? contactDataSupplier : accountDataSupplier);
        df.mockedDF = filter;
        return df;
    }

    private static List<SSACResult> resultsContact() {
        List<SSACResult> contactsList = new List<SSACResult>();
        contactsList.add(new SSACResult()
            .setStatus(ApexActionStatus.OK.value())
            .setRecordKey('oliviasmith@testmail.comtestsocial software')
            .setSObjectApiName('Contact')
            .setErrorMessage('Error message')
            .setDescription('Description'));
        contactsList.add(new SSACResult()
            .setStatus(ApexActionStatus.CHANGED.value())
            .setRecordKey('emmabrown@testmail.combrownadept software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Contact.SObjectType)))
            .setSObjectApiName('Contact'));
        contactsList.add(new SSACResult()
            .setStatus(ApexActionStatus.DUPLICATED.value())
            .setRecordKey('ameliawilson@testmail.comwilsonboss software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Contact.SObjectType)))
            .setSObjectApiName('Contact')
        );
        return contactsList;
    }

    private static List<SSACResult> resultsAccount() {
        List<SSACResult> accountsList = new List<SSACResult>();
        accountsList.add(new SSACResult()
            .setStatus(ApexActionStatus.OK.value())
            .setRecordKey('velocity software')
            .setSObjectApiName('Account')
            .setErrorMessage('Error message')
            .setDescription('Description'));
        accountsList.add(new SSACResult()
            .setStatus(ApexActionStatus.CHANGED.value())
            .setRecordKey('urge software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Account.SObjectType)))
            .setSObjectApiName('Account'));
        accountsList.add(new SSACResult()
            .setStatus(ApexActionStatus.DUPLICATED.value())
            .setRecordKey('access software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Account.SObjectType)))
            .setSObjectApiName('Account')
        );
        return accountsList;
    }

    private static List<Account> sampleTestDataAccount() {
        List<Account> sampleAccounts = new List<Account>();
        sampleAccounts.add(new Account(Name = 'Velocity Software')); // OK
        sampleAccounts.add(new Account(Name = 'Urge Software')); // Changed
        sampleAccounts.add(new Account(Name = 'Access Software')); // Duplicated
        return sampleAccounts;
    }   

    private static List<Contact> sampleTestDataContact() {
        List<Contact> sampleContacts = new List<Contact>();
        sampleContacts.add(new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software'))); // OK
        sampleContacts.add(new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software'))); // Changed
        sampleContacts.add(new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software'))); // Duplicated
        return sampleContacts;
    }   
}