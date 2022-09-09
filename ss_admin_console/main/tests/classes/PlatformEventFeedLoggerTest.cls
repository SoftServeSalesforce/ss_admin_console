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

    @IsTest
    static void testDummyError(){
        Test.startTest();
        PlatformEventFeedLogger.getInstance().error('');
        Test.stopTest();
    }

    @IsTest
    static void testDummyLog(){
        Test.startTest();
        PlatformEventFeedLogger.getInstance().log('', '', '');
        Test.stopTest();
    }

    @IsTest
    static void testDummyPublishResultLog(){
        Test.startTest();
        PlatformEventFeedLogger.getInstance().publishResultLog('', '');
        Test.stopTest();
    }

    @IsTest
    static void testDummyPublishLog(){
        Test.startTest();
        PlatformEventFeedLogger.getInstance().publishLog('', '', '');
        Test.stopTest();
    }
}
