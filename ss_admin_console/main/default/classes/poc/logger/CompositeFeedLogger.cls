public with sharing class CompositeFeedLogger implements FeedLogger {

    //Collection of FeedLoger ojects.
    private FeedLogger[] feedLoggers;

    public CompositeFeedLogger(FeedLogger[] loggers) {
        this.feedLoggers = loggers;
    }

    public void error(String messageError) {
        for (FeedLoger feedLoger : listFeedLoger) {
            feedLoger.error(messageError);  //Delegation
        }
    }

    public void log(String stringMessageTitleLog, String stringMessageLog, String stringStatusLog) {
        for (FeedLoger feedLoger : listFeedLoger) {
            feedLoger.log(stringMessageTitleLog, stringMessageLog, stringStatusLog);  //Delegation
        }
    }

}