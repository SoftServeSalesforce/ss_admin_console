@IsTest
public with sharing class CompositeFeedLoggerTest {
    @IsTest
    static void testError() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        fflib_ApexMocksConfig.HasIndependentMocks = true;
        FeedLogger logger1 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger logger2 = (FeedLogger) mocks.mock(FeedLogger.class);
        FeedLogger compositeLogger = new CompositeFeedLogger(new List<FeedLogger>{logger1, logger2});
        Test.startTest();
        compositeLogger.error('errTestMsg');
        Test.stopTest();
        ((FeedLogger) mocks.verify(logger1, 1)).error('errTestMsg');
        ((FeedLogger) mocks.verify(logger2, 1)).error('errTestMsg');
    }
}