@IsTest
public with sharing class CompositeDataFeederTest {
    @IsTest
    static void testFeedPositive() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ApexMocksConfig.HasIndependentMocks = true;
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        DataFeeder dfAccount = (DataFeeder) mocks.mock(DataFeeder.class);
        DataFeeder dfContact = (DataFeeder) mocks.mock(DataFeeder.class);
        CompositeDataFeeder cdfTest = new CompositeDataFeeder(new List<DataFeeder>{dfAccount, dfContact}, logger);
        Test.startTest();
        cdfTest.feed(false, logger);
        Test.stopTest();
        ((DataFeeder) mocks.verify(dfAccount, 1)).feed(false, logger);
        ((DataFeeder) mocks.verify(dfContact, 1)).feed(false, logger);
    }

    @IsTest
    static void testFeedNegative() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ApexMocksConfig.HasIndependentMocks = true;
        FeedLogger logger = (FeedLogger) mocks.mock(FeedLogger.class);
        DataFeeder dfAccount = (DataFeeder) mocks.mock(DataFeeder.class);
        DataFeeder dfContact = (DataFeeder) mocks.mock(DataFeeder.class);
        mocks.startStubbing();
        ((DataFeeder) mocks.doThrowWhen(new TestException(), dfAccount)).feed(false, logger);
        mocks.stopStubbing();
        CompositeDataFeeder cdfTest = new CompositeDataFeeder(new List<DataFeeder>{dfAccount, dfContact}, logger);
        Test.startTest();
        try {
            cdfTest.feed(false, logger);
            System.assert(false);
        } catch (Exception e) {
        }
        Test.stopTest();
        ((DataFeeder) mocks.verify(dfAccount, 1)).feed(false, logger);
        ((DataFeeder) mocks.verify(dfContact, 0)).feed(false, logger);
    }

    private class TestException extends Exception  {
    }
}
