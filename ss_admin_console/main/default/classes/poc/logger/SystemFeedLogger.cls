public with sharing class SystemFeedLogger implements FeedLogger {
    @TestVisible 
    private String voidName = '';

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

    public void error(String messageError) {
        voidName = 'public void error';
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitle, String message, String status) {
        voidName = 'public void log';
        System.debug('messageTitle: ' + messageTitle);
        System.debug('message: ' + message);
        System.debug('status: ' + status);
    }
}