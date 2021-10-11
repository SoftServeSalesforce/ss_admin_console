public with sharing class SSACLogger {
    SSACResultsUtil util;
    public SSACLogger() {
        this.util = new SSACResultsUtil();
    }

    public void generateLoadLog(List<SSACResult> results) {
        if (results == null || results.isEmpty()) {
            return;
        }
        List<SSACResult> failedResults = this.util.getResultsByStatus(results, Constants.FAILED_STATUS);
        List<SSACResult> okResults = this.util.getResultsByStatus(results, Constants.OK_STATUS);
        if (!okResults.isEmpty()) {
            SObjectLoadEvent__e successEvent = new SObjectLoadEvent__e(
                    Message__c = this.util.idsToString(okResults),
                    Message_Title__c = this.handleSuccessMessageTitle(okResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.OK_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.EXECUTE_ACTION_TYPE);
            EventBus.publish(successEvent);
        }
        if (!failedResults.isEmpty()) {
            SObjectLoadEvent__e errorEvent = new SObjectLoadEvent__e(
                    Message_Title__c = 'Error occurred: ',
                    Message__c = util.errorsToString(failedResults),
                    Message_Type__c = Constants.FAILED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.EXECUTE_ACTION_TYPE);
            EventBus.publish(errorEvent);
        }
    }

    public void generateTestLog(List<SSACResult> results) {
        if (results == null || results.isEmpty()) {
            return;
        }
        List<SSACResult> duplicatedResults = this.util.getResultsByStatus(results, Constants.DUPLICATED_STATUS);
        List<SSACResult> okResults = this.util.getResultsByStatus(results, Constants.OK_STATUS);
        if (!duplicatedResults.isEmpty()) {
            SObjectLoadEvent__e duplicateEvent = new SObjectLoadEvent__e (
                    Message__c = this.util.keysToString(duplicatedResults),
                    Message_title__c = this.handleDuplicateMessageTitle(duplicatedResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.DUPLICATED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.TEST_ACTION_TYPE);
            EventBus.publish(duplicateEvent);
        }
        if (!okResults.isEmpty()) {
            SObjectLoadEvent__e validRecordsEvent = new SObjectLoadEvent__e (
                    Message__c = this.util.keysToString(okResults),
                    Message_title__c = this.handleValidRecordsMessageTitle(okResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.OK_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.TEST_ACTION_TYPE);
            EventBus.publish(validRecordsEvent);
        }
    }

    public void publishResultLog(String jobName, String jobAction) {
        ResultLogEvent__e event = new ResultLogEvent__e(
                Action_Name__c = jobName,
                Action_Completed__c = true,
                Action_Type__c = jobAction
        );
        EventBus.publish(event);
    }

    public void publishLog(String title, String message, String status) {
        ResultLogEvent__e event = new ResultLogEvent__e (
                Action_Message__c = message,
                Action_Title__c = title,
                Action_Status__c = status
        );
        EventBus.publish(event);
    }

    @TestVisible
    private String handleValidRecordsMessageTitle(String sObjectApiName) {
        return 'The following ' + sObjectApiName + '\'s records should be inserted: ';
    }

    @TestVisible
    private String handleDuplicateMessageTitle(String sObjectApiName) {
        return 'The following ' + sObjectApiName + '\'s records they already exist: ';
    }

    @TestVisible
    private String handleSuccessMessageTitle(String sObjectApiName) {
        return 'Successfully inserted ' + sObjectApiName + '`s records. ';
    }
}