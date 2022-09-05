@IsTest
public with sharing class SystemFeedLoggerTest {
    @IsTest
    static void testSingletone() {
        Test.startTest();
        SystemFeedLogger feedLogger1 = SystemFeedLogger.getInstance();
        SystemFeedLogger feedLogger2 = SystemFeedLogger.getInstance();
        Test.stopTest();
        
        System.assertEquals(feedLogger1, feedLogger2);
    }
}
