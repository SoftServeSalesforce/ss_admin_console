public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String messageError);
    void log(String messageTitleLog, String messageLog, String statusLog);
}