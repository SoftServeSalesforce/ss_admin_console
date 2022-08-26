@IsTest
public with sharing class BaseDataFeederTest {

    private static final DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Contact.SObjectType).
                addKeyField(Contact.Email).addKeyField(Contact.LastName).addKeyField('Account.Name').addDataField(Contact.Email).
                addDataField(Contact.LastName).addDataField(Contact.FirstName).addDataField('Account.Name').
                addReferenceField(Contact.AccountId, new String[] {'Account.Name'});

    @IsTest 
    private static void testFeedUpsertMocksNegative() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, true);
        Test.startTest();
        df.feed(true, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).error(fflib_Match.stringStartsWith('FAILED'));
    }

    @IsTest 
    private static void testFeedUpsertMocksPositive() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, false);
        Test.startTest();
        df.feed(true, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).log('Contact', fflib_Match.anyString(), SSACConstants.UPSERTED_STATUS);
    }

    @IsTest 
    private static void testFeedInsertMocksNegative() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, true);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).error(fflib_Match.stringStartsWith('FAILED'));
    }

    @IsTest 
    private static void testFeedInsertMocksPositive() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        BaseDataFeeder df = baseDataFeederInstance(mocks, false);
        Test.startTest();
        df.feed(false, logger);
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 1)).log('Contact', fflib_Match.anyString(), SSACConstants.INSERTED_STATUS);
    }
    
    private static BaseDataFeeder baseDataFeederInstance(fflib_ApexMocks mocks, Boolean clearResults) {
        DataFilter filter = (DataFilter) mocks.mock(DataFilter.class);
        mocks.startStubbing();
        if (clearResults) {
            results.clear();
        }
        mocks.when(filter.filter()).thenReturn(results);
        mocks.stopStubbing();     
        BaseDataFeeder df = new BaseDataFeeder(new StaticDataSupplier(dataDefinitionBuilder.build(), sampleTestData));
        df.mockedDF = filter;
        return df;
    }

    private static List<SSACResult> results = new List<SSACResult> {
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

    private static List<Contact> sampleTestData = new List<Contact> {
        new Contact(LastName = 'Test', FirstName = 'Olivia', Email = 'OliviaSmith@testmail.com', Account = new Account(Name='Social Software')), // OK
        new Contact(LastName = 'Brown', FirstName = 'Test', Email = 'EmmaBrown@testmail.com', Account = new Account(Name='Adept Software')), // Changed
        new Contact(LastName = 'Wilson', FirstName = 'Amelia', Email = 'AmeliaWilson@testmail.com', Account = new Account(Name='Boss Software')) // Duplicated
    };
}
