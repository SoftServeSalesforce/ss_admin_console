public with sharing class PlatformEventFeedLogger implements FeedLogger {

    public void error(String messageError) {
        SObjectLoadEvent__e event = new SObjectLoadEvent__e(
                sObjectType__c = 'Error occured: ',
                Message__c = messageError,
                Message_Type__c = null
        );
        EventBus.publish(event);
    }

    public void log(String sObjectType, String message, String status) {
        SObjectLoadEvent__e event = new SObjectLoadEvent__e(
                sObjectType__c = sObjectType,
                Message__c = message,
                Message_Type__c = status
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