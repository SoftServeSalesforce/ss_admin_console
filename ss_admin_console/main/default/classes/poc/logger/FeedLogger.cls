public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String message);
    void log(String message, String type, String sObjectName, String data);
}