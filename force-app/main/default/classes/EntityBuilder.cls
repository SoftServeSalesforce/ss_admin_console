public with sharing class EntityBuilder {
    private class FieldNotFoundException extends Exception {
    }
    private String sObjectApiName;
    private String externalIdApiName;
    private Set<String> externalIds;
    private Set<String> existingExternalIds;
    private List<SObject> entities;
    private static String ID_SEPARATOR = ', ';

    public EntityBuilder(String sObjectApiName, String externalIdApiName, List<SObject> entities) {
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        this.entities = entities;
        if (!this.entities.isEmpty()) {
            this.externalIds = this.getExternalIds();
            this.existingExternalIds = this.getExistingExternalIds();
        }
    }

    public List<Id> insertEntities() {
        List<Id> ids = new List<Id>();
        List<SObject> sObjects = this.getValidEntities();
        if (!sObjects.isEmpty()) {
            Database.SaveResult[] results = Database.insert(sObjects, false);
            ids = this.getSuccessIds(results);
            String errorMessageTitle = this.handleErrorMessage(results);
            String successMessage = this.handleSuccessMessage(ids);
            String successMessageTitle = this.handleSuccessMessageTitle();
            if (successMessage != null) {
                JobLogEvent__e successEvent = new JobLogEvent__e(
                        Message__c = successMessage,
                        Message_Title__c = successMessageTitle,
                        Message_Type__c = Constants.OK_STATUS);
                EventBus.publish(successEvent);
            }
            if (errorMessageTitle != null) {
                JobLogEvent__e errorEvent = new JobLogEvent__e(
                        Message_Title__c = errorMessageTitle,
                        Message_Type__c = Constants.FAILED_STATUS);
                EventBus.publish(errorEvent);
            }
        }

        return ids;
    }

    @TestVisible
    private Boolean isDuplication() {
        Boolean result = false;
        if (this.existingExternalIds != null && !this.existingExternalIds.isEmpty()) {
            result = true;
        }
        return result;
    }

    public void handleDuplication() {
        if (isDuplication()) {
            JobLogEvent__e duplicateEvent = new JobLogEvent__e (
                    Message__c = this.handleDuplicateMessage(this.existingExternalIds),
                    Message_title__c = this.handleDuplicateMessageTitle(),
                    Message_Type__c = Constants.STATUS_DUPLICATE_VALUE);
            EventBus.publish(duplicateEvent);
            List<SObject> sObjects = this.getValidEntities();
            if (!sObjects.isEmpty()) {
                JobLogEvent__e validRecordsEvent = new JobLogEvent__e (
                        Message__c = this.handleValidRecordsMessage(sObjects),
                        Message_title__c = this.handleValidRecordsMessageTitle(),
                        Message_Type__c = Constants.OK_STATUS);
                EventBus.publish(validRecordsEvent);
            }
        } else {
            JobLogEvent__e duplicateEvent = new JobLogEvent__e (
                    Message_title__c = 'No duplication for ' + this.sObjectApiName + '`s records',
                    Message_Type__c = Constants.OK_STATUS);
            EventBus.publish(duplicateEvent);
        }
    }

    @TestVisible
    private String handleSuccessMessage(List<Id> ids) {
        String successMessage;
        if (!ids.isEmpty()) {
            successMessage = this.sObjectApiName + ' IDs: ';
            for (String id : ids) {
                successMessage += id + ID_SEPARATOR;
            }
            successMessage = successMessage.removeEnd(ID_SEPARATOR);
        }

        return successMessage;
    }

    @TestVisible
    private String handleSuccessMessageTitle() {
        return 'Successfully inserted ' + this.sObjectApiName + '`s records. ';
    }

    @TestVisible
    private String handleDuplicateMessage(Set<String> existingExternalIds) {
        String duplicateMessage;
        if (!existingExternalIds.isEmpty()) {
            duplicateMessage = '';
            for (String externalId : existingExternalIds) {
                duplicateMessage += externalId + ID_SEPARATOR;
            }
            duplicateMessage = duplicateMessage.removeEnd(ID_SEPARATOR);
        }
        return duplicateMessage;
    }

    @TestVisible
    private String handleValidRecordsMessage(List<SObject> sObjects) {
        String result;
        if (!sObjects.isEmpty()) {
            result = '';
            for (sObject sobj : sObjects) {
                result += sobj.get(this.externalIdApiName) + ID_SEPARATOR;
            }
            result = result.removeEnd(ID_SEPARATOR);
        }
        return result;
    }

    @TestVisible
    private String handleDuplicateMessageTitle() {
        return 'The following ' + this.sObjectApiName + '\'s records they already exist: ';
    }

    @TestVisible
    private String handleValidRecordsMessageTitle() {
        return 'The following ' + this.sObjectApiName + '\'s records can be inserted: ';
    }

    @TestVisible
    private List<Id> getSuccessIds(Database.SaveResult[] results) {
        List<Id> ids = new List<Id>();
        for (Database.SaveResult result : results) {
            if (result.isSuccess()) {
                ids.add(result.getId());
            }
        }

        return ids;
    }

    @TestVisible
    private String handleErrorMessage(Database.SaveResult[] results) {
        String errorMessage;
        for (Database.SaveResult result : results) {
            if (!result.isSuccess()) {
                errorMessage = errorMessage == null ? '' : errorMessage;
                for (Database.Error err : result.getErrors()) {
                    errorMessage += 'The following error has occurred. /n' + err.getStatusCode() + ': ' + err.getMessage()
                            + this.sObjectApiName + ' fields that affected this error: ' + err.getFields() + '. \n';
                }
            }
        }

        return errorMessage;
    }

    @TestVisible
    private List<sObject> getValidEntities() {
        List<sObject> result = new List<SObject>();
        for (SObject entity : this.entities) {
            if (entity.getSobjectType().getDescribe().fields.getMap().keySet().contains(this.externalIdApiName.toLowerCase())
                    && !this.containsIgnoreCase(this.existingExternalIds, String.valueOf(entity.get(this.externalIdApiName)))) {
                result.add(entity);
            }
        }

        return result;
    }

    private Boolean containsIgnoreCase(Set<String> existingExternalIds, String externalId) {
        Boolean result = false;
        for (String str : existingExternalIds) {
            if (externalId.equalsIgnoreCase(str)) {
                result = true;
            }
        }

        return result;
    }

    @TestVisible
    private Set<String> getExternalIds() {
        Set<String> externalIds = new Set<String>();
        for (SObject entity : this.entities) {
            if (entity.getSobjectType().getDescribe().fields.getMap().keySet().contains(this.externalIdApiName.toLowerCase())) {
                externalIds.add(String.valueOf(entity.get(this.externalIdApiName)));
            }
        }

        return externalIds;
    }

    @TestVisible
    private Set<String> getExistingExternalIds() {
        Set<String> result = new Set<String>();
        String query = this.obtainQuery();
        List<sObject> sobjList = Database.query(query);
        for (sObject sObj : sobjList) {
            result.add(String.valueOf(sObj.get(this.externalIdApiName)));
        }

        return result;
    }

    @TestVisible
    private String obtainQuery() {
        String query = 'SELECT Id, ' + this.externalIdApiName + ' FROM ' + this.sObjectApiName + ' WHERE '
                + this.externalIdApiName + ' IN (';
        for (String externalId : this.externalIds) {
            query += '\'' + externalId + '\',';
        }
        query = query.removeEnd(query.right(1)) + ')';

        return query;
    }
}