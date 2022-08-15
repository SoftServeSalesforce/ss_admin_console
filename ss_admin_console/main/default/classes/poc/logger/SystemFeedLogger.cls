public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String messageError) {
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitle, String message, String status) {
        System.debug('messageTitle: ' + messageTitle);
        System.debug('message: ' + message);
        System.debug('status: ' + status);
    }
}