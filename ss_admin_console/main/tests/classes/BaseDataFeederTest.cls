@IsTest
public with sharing class BaseDataFeederTest {

    private static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilderAccount = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name);
     
    private static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilderContact = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
            addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.Email).
            addDataField(Contact.LastName).addDataField(Contact.FirstName).addDataField('Account.Name').
            addReferenceField(Contact.AccountId, new String[] {'Name'});


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
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, true);
        Test.startTest();
        df.feed(true, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).log('Contact', '2 records were proceed.', SSACConstants.UPSERTED_STATUS);
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
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, true);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).log('Contact', '1 records were proceed.', SSACConstants.INSERTED_STATUS);
    }

    @IsTest 
    private static void testFeedInsertMocksPositiveAccounts() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, false, false);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).log('Account', '1 records were proceed.', SSACConstants.INSERTED_STATUS);
    }
    
    private static BaseDataFeeder baseDataFeederInstance(fflib_ApexMocks mocks, Boolean clearResults, Boolean isChild) {
        DataFilter filter = (DataFilter) mocks.mock(DataFilter.class);
        mocks.startStubbing();
        if (clearResults) {
            if (isChild) {
                resultsContact.clear();
            } else {
                resultsAccount.clear();
            }
        }
        mocks.when(filter.filter()).thenReturn(isChild ? resultsContact : resultsAccount);
        mocks.stopStubbing();
        DataSupplier accountDataSupplier = new StaticDataSupplier(dataDefinitionBuilderAccount.build(), sampleTestDataAccount);
        DataSupplier contactDataSupplier = new StaticDataSupplier(dataDefinitionBuilderContact.build(), sampleTestDataContact);
        BaseDataFeeder df = new BaseDataFeeder(isChild ? contactDataSupplier : accountDataSupplier);
        df.mockedDF = filter;
        return df;
    }

    private static List<SSACResult> resultsContact = new List<SSACResult> {
        new SSACResult()
            .setStatus(SSACConstants.OK_STATUS)
            .setRecordKey('oliviasmith@testmail.com_test_social software')
            .setSObjectApiName('Contact')
            .setErrorMessage('Error message')
            .setDescription('Description'),
        new SSACResult()
            .setStatus(SSACConstants.CHANGED_STATUS)
            .setRecordKey('emmabrown@testmail.com_brown_adept software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Contact.SObjectType)))
            .setSObjectApiName('Contact'),
        new SSACResult()
            .setStatus(SSACConstants.DUPLICATED_STATUS)
            .setRecordKey('ameliawilson@testmail.com_wilson_boss software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Contact.SObjectType)))
            .setSObjectApiName('Contact')
    };

    private static List<Contact> sampleTestDataContact = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };

    private static List<SSACResult> resultsAccount = new List<SSACResult> {
        new SSACResult()
            .setStatus(SSACConstants.OK_STATUS)
            .setRecordKey('velocity software')
            .setSObjectApiName('Account')
            .setErrorMessage('Error message')
            .setDescription('Description'),
        new SSACResult()
            .setStatus(SSACConstants.CHANGED_STATUS)
            .setRecordKey('urge software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Account.SObjectType)))
            .setSObjectApiName('Account'),
        new SSACResult()
            .setStatus(SSACConstants.DUPLICATED_STATUS)
            .setRecordKey('access software')
            .setRecordId(String.valueOf(fflib_IDGenerator.generate(Account.SObjectType)))
            .setSObjectApiName('Account')
    };

    private static List<Account> sampleTestDataAccount = new List<Account> {
        new Account(Name = 'Velocity Software'), // OK
        new Account(Name = 'Urge Software'), // Changed
        new Account(Name = 'Access Software') // Duplicated
    };
}