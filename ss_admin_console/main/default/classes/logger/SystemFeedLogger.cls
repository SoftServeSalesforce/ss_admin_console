public with sharing class SystemFeedLogger implements FeedLogger {
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
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitle, String message, String status) {
        System.debug('messageTitle: ' + messageTitle);
        System.debug('message: ' + message);
        System.debug('status: ' + status);
    }
}