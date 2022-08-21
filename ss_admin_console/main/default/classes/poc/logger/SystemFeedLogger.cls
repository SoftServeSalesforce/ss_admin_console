public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String messageError) {
        System.debug('Error occured: ' + messageError);
    }

    public void log(String sObjectType, String message, String status) {
        System.debug('sObjectType: ' + sObjectType);
        System.debug('message: ' + message);
        System.debug('status: ' + status);
    }
}