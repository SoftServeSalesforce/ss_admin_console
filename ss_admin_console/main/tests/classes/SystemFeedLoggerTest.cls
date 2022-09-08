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

    @IsTest
    static void testErrorMethod(){
        Test.startTest();
        SystemFeedLogger.getInstance().error('');
        Test.stopTest();
        
        System.assertEquals('public void error', SystemFeedLogger.getInstance().voidName);
    }

    @IsTest
    static void testLogMethod(){
        Test.startTest();
        SystemFeedLogger.getInstance().log('','','');
        Test.stopTest();
        
        System.assertEquals('public void log', SystemFeedLogger.getInstance().voidName);
    }
}
