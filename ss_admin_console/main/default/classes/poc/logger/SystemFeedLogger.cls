public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String message) {
        System.debug('Error: ' + message);
    }

    public void log(String message, String type, String sObjectName, String data) {
        if (data == null) {
            System.debug(String.format('{0}({1}): {2})', new Object[] {
                    type, sObjectName, message
            }));
        } else {
            System.debug(String.format('{0}({1}): {2} ({3})', new Object[] {
                    type, sObjectName, message, data
            }));
        }
    }
}