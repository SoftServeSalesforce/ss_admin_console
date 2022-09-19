@IsTest
public inherited sharing class CompositeFeedLoggerTest {
    @IsTest
    static void testError() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ApexMocksConfig.HasIndependentMocks = true;
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        CompositeFeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.startTest();
        logger.error('errTestMsg');
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger1, 1)).error('errTestMsg');
        ((FeedLogger) mocks.verify(logger2, 1)).error('errTestMsg');
    }

    @IsTest
    static void testLog() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ApexMocksConfig.HasIndependentMocks = true;
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.startTest();
        logger.log('logTestMsg', '', '');
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger1, 2)).log('logTestMsg', '', '');
        ((FeedLogger) mocks.verify(logger2, 2)).log('logTestMsg', '', '');
    }
}
