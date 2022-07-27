public interface FeedLogger {
    void log(String message);
    void generateTestLog(List<SSACResult> results);
    void generateLoadLog(List<SSACResult> results);
    void publishResultLog(String jobName, String jobAction);

    // TODO add overloaded methods as needed
}