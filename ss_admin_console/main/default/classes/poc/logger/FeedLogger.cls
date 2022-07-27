public interface FeedLogger {
    void log(String message);
    void generateTestLog(List<SSACResult> results);
    void generateLoadLog(List<SSACResult> results);

    // TODO add overloaded methods as needed
}