public with sharing class EntityBuilder {
    private class FieldNotFOundException extends Exception {}
    private String sObjectApiName;
    private String externalIdApiName;
    private Set<String> externalIds;
    private Set<String> existingExternalIds;
    private List<Map<String, String>> entities;
    private static String ID_SEPARATOR = ', ';

    public EntityBuilder (String sObjectApiName, String externalIdApiName, List<Map<String, String>> entities) {
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
        if (this.existingExternalIds != null && !this.existingExternalIds.isEmpty()) {
            JobLogEvent__e duplicateEvent = new JobLogEvent__e(Message__c = this.handleDuplicateMessage(this.existingExternalIds),
                Message_Type__c = Constants.STATUS_DUPLICATE_VALUE);
        	EventBus.publish(duplicateEvent);
        }
        if (!sObjects.isEmpty()) {
            Database.SaveResult[] results = Database.insert(sObjects, false);
            ids = this.getSuccessIds(results);
            String errorMessage = this.handleErrorMessage(results);
            String successMessage = this.handleSuccessMessage(ids);
            if (successMessage != null) {
                JobLogEvent__e successEvent = new JobLogEvent__e(Message__c = successMessage, 
                    Message_Type__c = Constants.OK_STATUS);
                EventBus.publish(successEvent);
            }
            if (errorMessage != null) {
                JobLogEvent__e errorEvent = new JobLogEvent__e(Message__c = errorMessage, 
                    Message_Type__c = Constants.FAILED_STATUS);
                EventBus.publish(errorEvent);
            }
        }

        return ids;
    }

    @TestVisible
    private String handleSuccessMessage(List<Id> ids) {
        String successMessage;
        if (!ids.isEmpty()) {
            successMessage = 'Successfully inserted ' + this.sObjectApiName + '. ' + this.sObjectApiName + ' IDs: ';
            for (String id: ids) {
                successMessage += id + ID_SEPARATOR;
            }
            successMessage = successMessage.removeEnd(ID_SEPARATOR);
        }

        return successMessage;
    }

    @TestVisible
    private String handleDuplicateMessage(Set<String> existingExternalIds) {
        String duplicateMessage;
        if (!existingExternalIds.isEmpty()) {
            duplicateMessage = 'The following ' + this.sObjectApiName + '\'s records were not created, because they already exist: ';
            for (String externalId: existingExternalIds) {
                duplicateMessage += externalId + ID_SEPARATOR;
            }
            duplicateMessage = duplicateMessage.removeEnd(ID_SEPARATOR);
        }

        return duplicateMessage;
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
                for(Database.Error err : result.getErrors()) {
                    errorMessage += 'The following error has occurred. /n' + err.getStatusCode() + ': ' + err.getMessage()
                    + this.sObjectApiName + ' fields that affected this error: ' + err.getFields() + '. \n';
                }
            }
        }
        
        return errorMessage;
    }

    @TestVisible
    private List<sObject> getValidEntities() {
        List<sObject> newSObjects = new List<SObject>();
        for (Map<String, String> entity: this.entities) {
            if (entity.keySet().contains(this.externalIdApiName) 
                && !this.existingExternalIds.contains(entity.get(this.externalIdApiName))) {
                    newSObjects.add(this.createEntity(entity));
            }
        }

        return newSObjects;
    }

    @TestVisible
    private SObject createEntity(Map<String, String> entity) {
        Type sObjectType = Type.forName(sObjectApiName);
        SObject sObj = (SObject) (sObjectType.newInstance());
        for (String apiField: entity.keySet()) {
            sObj.put(apiField, this.convertFieldValue(this.getFieldType(apiField), entity.get(apiField)));
        }

        return sObj;
    }

    @TestVisible
    private Set<String> getExternalIds() {
        Set<String> externalIds = new Set<String>();
        for (Map<String, String> entity: this.entities) {
            if (entity.containsKey(this.externalIdApiName)) {
                externalIds.add(entity.get(this.externalIdApiName));
            }
        }

        return externalIds;
    }

    @TestVisible
    private Object convertFieldValue(Schema.DisplayType fieldType, String fieldValue) {
        if (fieldType == Schema.DisplayType.REFERENCE || fieldType == Schema.DisplayType.ID) {
            return Id.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DOUBLE || fieldType == Schema.DisplayType.PERCENT) {
            return Double.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.CURRENCY) {
            return Decimal.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.BOOLEAN) {
            return Boolean.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.INTEGER) {
            return Integer.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DATE) {
            return Date.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DATETIME) {
            return Datetime.valueOf(fieldValue);
        } else {
            return fieldValue;
        }
    }

    @TestVisible
    private Schema.DisplayType getFieldType(STring fieldApiName) {
        if (!Schema.getGlobalDescribe().get(this.sObjectApiName).getDescribe().fields.getMap().containsKey(fieldApiName)) {
            throw new FieldNotFOundException(this.sObjectApiName + ' does not have such field: ' + fieldApiName);
        }
        Schema.DisplayType fieldType = Schema.getGlobalDescribe().get(this.sObjectApiName).getDescribe().fields
            .getMap().get(fieldApiName).getDescribe().getType();

        return fieldType;
    }

    @TestVisible
    private Set<String> getExistingExternalIds() {
        Set<String> result = new Set<String>();
        String query = this.obtainQuery();
        List<sObject> sobjList = Database.query(query);
        for (sObject sObj: sobjList) {
            result.add(String.valueOf(sObj.get(this.externalIdApiName)));
        }

        return result;
    }

    @TestVisible
    private String obtainQuery() {
        String query = 'SELECT Id, ' + this.externalIdApiName + ' FROM ' + this.sObjectApiName + ' WHERE ' 
                + this.externalIdApiName + ' IN (';
        for (String externalId: this.externalIds) {
            query += '\'' + externalId + '\',';
        }
        query = query.removeEnd(query.right(1)) + ')';
    
        return query;
    }
}
