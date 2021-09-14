public with sharing class Logger { //TODO: Rename to DiagnosticLogger
    DiagnosticResultsUtil util;
    public Logger() {
        this.util = new DiagnosticResultsUtil();
    }

    public void generateLoadLog(List<DiagnosticResult> results) {
        if (results == null || results.isEmpty()) {
            return;
        }
        List<DiagnosticResult> failedResults = this.util.getResultsByStatus(results, Constants.FAILED_STATUS);
        List<DiagnosticResult> okResults = this.util.getResultsByStatus(results, Constants.OK_STATUS);
        if (!okResults.isEmpty()) {
            JobLogEvent__e successEvent = new JobLogEvent__e(
                    Message__c = this.util.idsToString(okResults),
                    Message_Title__c = this.handleSuccessMessageTitle(okResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.OK_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.EXECUTE_ACTION_TYPE);
            EventBus.publish(successEvent);
        }
        if (!failedResults.isEmpty()) {
            JobLogEvent__e errorEvent = new JobLogEvent__e(
                    Message_Title__c = 'Error occurred: ',
                    Message__c = this.util.errorsToString(failedResults),
                    Message_Type__c = Constants.FAILED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.EXECUTE_ACTION_TYPE);
            EventBus.publish(errorEvent);

        }
    }

    public void generateTestLog(List<DiagnosticResult> results) {
        if (results == null || results.isEmpty()) {
            return;
        }
        List<DiagnosticResult> duplicatedResults = this.util.getResultsByStatus(results, Constants.DUPLICATED_STATUS);
        List<DiagnosticResult> okResults = this.util.getResultsByStatus(results, Constants.OK_STATUS);
        if (!duplicatedResults.isEmpty()) {
            JobLogEvent__e duplicateEvent = new JobLogEvent__e (
                    Message__c = this.util.keysToString(duplicatedResults),
                    Message_title__c = this.handleDuplicateMessageTitle(duplicatedResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.DUPLICATED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.TEST_ACTION_TYPE);
            EventBus.publish(duplicateEvent);
        }
        if (!okResults.isEmpty()) {
            JobLogEvent__e validRecordsEvent = new JobLogEvent__e (
                    Message__c = this.util.keysToString(okResults),
                    Message_title__c = this.handleValidRecordsMessageTitle(okResults.get(0).sObjectApiName),
                    Message_Type__c = Constants.OK_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = Constants.TEST_ACTION_TYPE);
            EventBus.publish(validRecordsEvent);
        }
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