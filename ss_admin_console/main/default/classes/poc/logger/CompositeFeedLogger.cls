public with sharing class CompositeFeedLogger implements FeedLogger {

    private FeedLogger[] feedLoggers;

    public CompositeFeedLogger(FeedLogger[] loggers) {
        this.feedLoggers = loggers;
    }

    public void error(String messageError) {
        for (FeedLogger feedLogger : feedLoggers) {
            feedLogger.error(messageError);
        }
    }

    public void log(String messageTitleLog, String messageLog, String statusLog) {
        for (FeedLogger feedLogger : feedLoggers) {
            feedLogger.log(messageTitleLog, messageLog, statusLog);
        }
    }
}