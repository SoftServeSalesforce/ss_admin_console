public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String message);
    void log(List<SSACResult> data);
    void log(Database.UpsertResult[] upsertResults, Schema.SObjectType sObjectType);
}