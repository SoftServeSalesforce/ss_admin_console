public with sharing class SystemFeedLogger implements FeedLogger {
    public void log(String message) {
        System.debug(message);
    }
}