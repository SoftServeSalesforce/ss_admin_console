@IsTest
public with sharing class PlatformEventFeedLoggerTest {
    @IsTest
    static void testSingletone() {
        Test.startTest();
        PlatformEventFeedLogger feedLogger1 = PlatformEventFeedLogger.getInstance();
        PlatformEventFeedLogger feedLogger2 = PlatformEventFeedLogger.getInstance();
        Test.stopTest();
        
        System.assertEquals(feedLogger1, feedLogger2);
    }
}

