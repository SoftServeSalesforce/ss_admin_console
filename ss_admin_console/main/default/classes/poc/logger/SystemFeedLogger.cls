public with sharing class SystemFeedLogger implements FeedLogger {
    public void error(String message) {
        System.debug('Error: ' + message);
    }

    public void log(String message, String type, String sObjectName, String data) {
        if (data == null) {
            System.debug(String.format('{0}({1}): {2})', new Object[] {
                    type, sObjectName, message
            }));
        } else {
            System.debug(String.format('{0}({1}): {2} ({3})', new Object[] {
                    type, sObjectName, message, data
            }));
        }
    }

    // TODO Remove the following code from this class

    SSACResultsUtil util;
    public SystemFeedLogger() {
        this.util = new SSACResultsUtil();
    }

    public void generateTestLog(List<SSACResult> results) {
        if (results == null || results.isEmpty()) {
            return;
        }
        List<SSACResult> duplicateResults = this.util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS);
        List<SSACResult> okResults = this.util.getResultsByStatus(results, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = this.util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS);
        if (!duplicateResults.isEmpty()) {
            SObjectLoadEvent__e duplicateEvent = new SObjectLoadEvent__e(
                    Message__c = duplicateResults.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.keysToString(duplicateResults) : this.handleAmountOfRecordsTested(duplicateResults.size()),
                    Message_title__c = this.handleDuplicateMessageTitle(duplicateResults.get(0).sObjectApiName),
                    Message_Type__c = SSACConstants.DUPLICATED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.TEST_ACTION_TYPE
            );
            EventBus.publish(duplicateEvent);
        }
        if (!okResults.isEmpty()) {
            SObjectLoadEvent__e validRecordsEvent = new SObjectLoadEvent__e(
                    Message__c = okResults.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.keysToString(okResults) : this.handleAmountOfRecordsTested(okResults.size()),
                    Message_title__c = this.handleValidRecordsMessageTitle(okResults.get(0).sObjectApiName),
                    Message_Type__c = SSACConstants.OK_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.TEST_ACTION_TYPE
            );
            EventBus.publish(validRecordsEvent);
        }
        if (!changedResults.isEmpty()) {
            SObjectLoadEvent__e changedEvent = new SObjectLoadEvent__e(
                    Message__c = changedResults.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.keysToString(changedResults) : this.handleAmountOfRecordsTested(changedResults.size()),
                    Message_title__c = this.handleChangedMessageTitle(changedResults.get(0).sObjectApiName),
                    Message_Type__c = SSACConstants.CHANGED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.TEST_ACTION_TYPE
            );
            EventBus.publish(changedEvent);
        }
    }

    public void generateLoadLog(List<SSACResult> results) {
        if (results == null || results.isEmpty()) {
            SObjectLoadEvent__e successEvent = new SObjectLoadEvent__e(
                    Message__c = '',
                    Message_Title__c = 'Nothing to load, check test results',
                    Message_Type__c = SSACConstants.OK_STATUS,
                    SObject_Type__c = '',
                    Action_Type__c = SSACConstants.EXECUTE_ACTION_TYPE
            );
            EventBus.publish(successEvent);
            return;
        }
        List<SSACResult> failedResults = this.util.getResultsByStatus(results, SSACConstants.FAILED_STATUS);
        List<SSACResult> upsertedResults = this.util.getResultsByStatus(results, SSACConstants.UPSERTED_STATUS);
        List<SSACResult> duplicateResults = this.util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS);
        if (!duplicateResults.isEmpty()) {
            SObjectLoadEvent__e duplicateEvent = new SObjectLoadEvent__e(
                    Message__c = duplicateResults.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.keysToString(duplicateResults) : this.handleAmountOfRecordsProceed(duplicateResults.size()),
                    Message_title__c = this.handleDuplicateMessageTitle(duplicateResults.get(0).sObjectApiName),
                    Message_Type__c = SSACConstants.DUPLICATED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.EXECUTE_ACTION_TYPE
            );
            EventBus.publish(duplicateEvent);
        }
        if (!upsertedResults.isEmpty()) {
            SObjectLoadEvent__e successEvent = new SObjectLoadEvent__e(
                    Message__c = upsertedResults.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.idsToString(upsertedResults) : this.handleAmountOfRecordsProceed(upsertedResults.size()),
                    Message_Title__c = this.handleSuccessUpsertMessageTitle(upsertedResults.get(0).sObjectApiName),
                    Message_Type__c = SSACConstants.UPSERTED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.EXECUTE_ACTION_TYPE
            );
            EventBus.publish(successEvent);
        }
        if (!failedResults.isEmpty()) {
            SObjectLoadEvent__e errorEvent = new SObjectLoadEvent__e(
                    Message_Title__c = 'Error occurred: ',
                    Message__c = util.errorsToString(failedResults),
                    Message_Type__c = SSACConstants.FAILED_STATUS,
                    SObject_Type__c = results.get(0).sObjectApiName,
                    Action_Type__c = SSACConstants.EXECUTE_ACTION_TYPE
            );
            EventBus.publish(errorEvent);
        }
    }

    public void publishResultLog(String jobName, String jobAction) {
        ResultLogEvent__e event = new ResultLogEvent__e(Action_Name__c = jobName, Action_Completed__c = true, Action_Type__c = jobAction);
        EventBus.publish(event);
    }

    public void publishLog(String title, String message, String status) {
        ResultLogEvent__e event = new ResultLogEvent__e(Action_Message__c = message, Action_Title__c = title, Action_Status__c = status);
        EventBus.publish(event);
    }

    @TestVisible
    private String handleValidRecordsMessageTitle(String sObjectApiName) {
        return 'The following ' + sObjectApiName + '\'s records should be inserted: ';
    }

    @TestVisible
    private String handleDuplicateMessageTitle(String sObjectApiName) {
        return 'The following ' + sObjectApiName + '\'s records already exist: ';
    }

    @TestVisible
    private String handleChangedMessageTitle(String sObjectApiName) {
        return 'The following ' + sObjectApiName + '\'s records could be updated: ';
    }
    @TestVisible
    private String handleSuccessUpsertMessageTitle(String sObjectApiName) {
        return 'Successfully upserted ' + sObjectApiName + '\'s records. ';
    }
    @TestVisible
    private String handleAmountOfRecordsProceed(Integer size) {
        return String.valueOf(size) + ' records were proceed.';
    }

    @TestVisible
    private String handleAmountOfRecordsTested(Integer size) {
        return String.valueOf(size) + ' records were tested.';
    }
}