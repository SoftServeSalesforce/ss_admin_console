public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String messageError) {
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitleLog, String messageLog, String statusLog) {
        System.debug('messageTitleLog: ' + messageTitleLog);
        System.debug('messageLog: ' + messageLog);
        System.debug('statusLog: ' + statusLog);
    }
}