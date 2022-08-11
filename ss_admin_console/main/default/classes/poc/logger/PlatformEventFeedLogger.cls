public with sharing class PlatformEventFeedLogger implements FeedLogger {

    //TODO error to event
    public void error(String messageError) {
        System.debug('messageError: ' + messageError);
    }

    public void log(String messageTitleLog, String messageLog, String statusLog) {
        SObjectLoadEvent__e event = new SObjectLoadEvent__e(
                Message_title__c = messageTitleLog,
                Message__c = messageLog,
                Message_Type__c = statusLog
        );
        EventBus.publish(event);
    }

    public void publishResultLog(String jobName, String jobAction) {
        ResultLogEvent__e event = new ResultLogEvent__e(Action_Name__c = jobName, Action_Completed__c = true, Action_Type__c = jobAction);
        EventBus.publish(event);
    }

    public void publishLog(String title, String message, String status) {
        ResultLogEvent__e event = new ResultLogEvent__e(Action_Message__c = message, Action_Title__c = title, Action_Status__c = status);
        EventBus.publish(event);
    }
}