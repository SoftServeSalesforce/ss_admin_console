public with sharing class SystemFeedLogger implements FeedLogger {
    public static String voidName = '';

    @TestVisible
    private static SystemFeedLogger instance;

    private SystemFeedLogger() {

    }

    public static SystemFeedLogger getInstance() {
        if (instance == null) {
            instance = new SystemFeedLogger();
        }
        return instance;
    }

    public static void error(String messageError) {
        voidName = 'public void error';
        System.debug('messageError: ' + messageError);
    }

    public static void log(String messageTitle, String message, String status) {
        voidName = 'public void log';
        System.debug('messageTitle: ' + messageTitle);
        System.debug('message: ' + message);
        System.debug('status: ' + status);
    }
}