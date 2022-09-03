public with sharing class UnitOfWorkHelper {
    private DataSupplier supplier;
    private String parentSObjectType;
    private fflib_SObjectUnitOfWork uow;

    public UnitOfWorkHelper(fflib_SObjectUnitOfWork uow, DataSupplier supplier) {
        this.supplier = supplier;
        this.uow = uow;
        if (!supplier.getMetadata().referenceFields.isEmpty()) {
            this.parentSObjectType = String.valueOf(supplier.getMetadata().referenceFields[0].parentSObjectType);
        }
    }


    public fflib_SObjectUnitOfWork registerRecords(List<SObject> data, Boolean isChild, FeedLogger logger) {
        if (isChild) {
            uow = registerChildsToParent(data, logger);
        } else {
            uow = registerParents(data);
        }
        return uow;
    }

    @TestVisible
    private fflib_SObjectUnitOfWork registerParents(List<SObject> data) {      
        for (SObject item : data) {
            if (item.Id != null) {
                uow.registerDirty(item);
            } else {
                uow.registerNew(item);     
            }
        }
        return uow;
    }

    @TestVisible
    private fflib_SObjectUnitOfWork registerChildsToParent(List<SObject> data, FeedLogger logger) {     
        List<SObject> existentParentRecords = getRecords(data);
        if (existentParentRecords.isEmpty()) {
            logger.error('NOTE: Please, insert ' + parentSObjectType + '\'s records first.');
        }
        Map<String, SObject> existentMap = generateExistentRecordsMap(existentParentRecords);
        for (SObject item : data) {
            String recordKeysFingerprint = generateRecordFingerprint(item.getSObject(parentSObjectType));
            SObject existentSObject = existentMap.get(recordKeysFingerprint);
            if (existentSObject != null) { // parent record exists
                item.putSObject(parentSObjectType, existentSObject);
                if (item.Id == null) { 
                    uow.registerNew(item); 
                } else { 
                    uow.registerDirty(item); 
                } 
                uow.registerRelationship(item, supplier.getMetadata().referenceFields[0].referenceField, item.getSObject(parentSObjectType));   
            } 
        }
        return uow;
    }

    @TestVisible
    private String generateRecordFingerprint(SObject record) {
        String recordKeysFingerprint = '';
        for (FieldReference keyField : supplier.getMetadata().referenceFields[0].parentFields) {
            recordKeysFingerprint += String.valueOf(keyField.getFrom(record)).toLowerCase() + '_';
        }
        return recordKeysFingerprint;
    }

    /**
     * Generates map with existent records and key fields.
     * @param existentParentRecords contains list of queried records
     * @return map with recordFingerprint key and sobject as a value
     */
    @TestVisible
    private Map<String, SObject> generateExistentRecordsMap(List<SObject> existentParentRecords) {
        Map<String, SObject> existentMap = new Map<String, SObject>();
        for (SObject existSObj : existentParentRecords) {
            String recordKeysFingerprint = generateRecordFingerprint(existSObj);          
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

    @TestVisible
    private List<SObject> getRecords(List<SObject> data) {
        List<Set<Object>> referenceFieldValues = this.getReferenceFieldValues(data);
        Integer fieldsNumber = referenceFieldValues.size();
        List<ReferenceFieldDefinition> referenceFields = supplier.getMetadata().referenceFields[0];
        Object pr0 = (fieldsNumber > 0) ? SetUtils.toSetOfType(referenceFields.referencedKeyFields[0], referenceFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ? SetUtils.toSetOfType(referenceFields.referencedKeyFields[1], referenceFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ? SetUtils.toSetOfType(referenceFields.referencedKeyFields[2], referenceFieldValues[2]) : null;
        String query = this.buildQuery();
        return Database.query(query);
    }

    @TestVisible
    private List<Set<Object>> getReferenceFieldValues(List<SObject> data) {
        List<Set<Object>> constantValues = new List<Set<Object>>();
        for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : data) {
                values.add(field.getFrom(obj));
            }
            constantValues.add(values);
        }
        return constantValues;
    }

    @TestVisible
    private String buildQuery() {
        Integer counter = 0;
        String result = 'SELECT Id, ';
        for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            result += field.toString() + ',';
        }
        result = result.removeEnd(',');
        result += ' FROM ' + parentSObjectType + ' WHERE ';
        for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter++;
        } 
        result = result.removeEnd(' AND ');
        return result;
    }
}