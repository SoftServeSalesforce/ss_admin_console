public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String message);
    void log(String messageTitle, String message, String status);
}