public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String message) {
        System.debug('Error: ' + message);
    }

    // public void log(List<SSACResult> data) {
    //     if (data != null && !data.isEmpty()) {
    //         new PlatformEventFeedLogger().generateEvent(data, SSACConstants.TEST_ACTION_TYPE);
    //     }
    // }

    public void log(String message, Schema.SObjectType sObjectType, String status, String type) {

    }

    /*public void log(Database.UpsertResult[] upsertResults, Schema.SObjectType sObjectType) {
        List<SSACResult> results = new List<SSACResult>();
        for (Database.UpsertResult result : upsertResults) {
            if (result.isSuccess()) {
                results.add(new SSACResult()
                        .setStatus(SSACConstants.UPSERTED_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectType.getDescribe().getName()));
                new PlatformEventFeedLogger().generateEvent(results, SSACConstants.EXECUTE_ACTION_TYPE);
            } else {
                String errorMessage = '';
                for (Database.Error err : result.getErrors()) {
                    errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                            + String.valueOf(sObjectType) + ' fields that affected this error: ' + err.getFields() + '. ';
                }
                results.add(new SSACResult()
                        .setStatus(SSACConstants.FAILED_STATUS)
                        .setErrorMessage(errorMessage)
                        .setSObjectApiName(sObjectType.getDescribe().getName()));
                new PlatformEventFeedLogger().generateEvent(results, SSACConstants.EXECUTE_ACTION_TYPE);
            }
        }
    }*/
}