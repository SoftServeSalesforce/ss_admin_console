public interface FeedLogger {
    void error(String messageError);
    void log(String sObjectType, String message, String status);
}