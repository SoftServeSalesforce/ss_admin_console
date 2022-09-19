@IsTest
public inherited sharing class CompositeFeedLoggerTest {
    @IsTest
    static void testCompositeFeedLogger() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        Test.startTest();
        FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.stopTest();
    }

    @IsTest
    static void testError() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.startTest();
        logger.error('errTestMsg');
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 2)).error('errTestMsg');
    }

    @IsTest
    static void testLog() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.startTest();
        logger.log('logTestMsg', '', '');
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger, 2)).log('logTestMsg', '', '');
    }
}
