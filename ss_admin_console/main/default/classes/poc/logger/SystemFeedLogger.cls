public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String message) {
        System.debug('Error: ' + message);
    }

    public void log(String messageTitle, String message, String status) {

    }
}