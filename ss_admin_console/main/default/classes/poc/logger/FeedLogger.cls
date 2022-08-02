public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String message);
    void log(String message, String type, String sObjectName, String data);

    // remove the following three methods from interface
    void generateTestLog(List<SSACResult> results);
    void generateLoadLog(List<SSACResult> results);
    void publishResultLog(String jobName, String jobAction);
}