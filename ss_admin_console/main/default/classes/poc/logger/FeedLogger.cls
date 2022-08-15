public interface FeedLogger {
    void error(String messageError);
    void log(String messageTitle, String message, String status);
}