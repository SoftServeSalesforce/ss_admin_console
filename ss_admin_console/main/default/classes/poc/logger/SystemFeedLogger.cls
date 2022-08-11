public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String messageError) {
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitleLog, String messageLog, String statusLog) {
        System.debug('messageTitle: ' + messageTitleLog);
        System.debug('message: ' + messageLog);
        System.debug('status: ' + statusLog);
    }
}