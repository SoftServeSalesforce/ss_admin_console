public interface FeedLogger {
    // TODO add overloaded methods as needed
    void error(String message);
    void log(String message, Schema.SObjectType sObjectType, String status, String type);
    //void log(Database.UpsertResult[] upsertResults, Schema.SObjectType sObjectType);
}