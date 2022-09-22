public inherited sharing class UnitOfWorkHelper {
    private DataSupplier supplier;
    private String parentSObjectType;
    private fflib_SObjectUnitOfWork uow;

    public UnitOfWorkHelper(fflib_SObjectUnitOfWork uow, DataSupplier supplier) {
        this.supplier = supplier;
        this.uow = uow;
        if (!supplier.getMetadata().referenceFields.isEmpty()) {
            this.parentSObjectType = String.valueOf(supplier.getMetadata().referenceFields[0].referenceField.getDescribe().getReferenceTo()[0]);
        }
    }


    public fflib_SObjectUnitOfWork registerRecords(List<SObject> data, Integer referenceFieldsSize, FeedLogger logger) {
        if (referenceFieldsSize > 0) {
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
            return uow;
        }
        Map<Integer, SObject> existentMap = generateRecordsMap(existentParentRecords);
        Map<Integer, SObject> sampleDataMap = generateSampleRecordsMap(data, parentSObjectType);
        for (Integer item : sampleDataMap.keySet()) {
            SObject sampleSObject = sampleDataMap.get(item);
            if (existentMap.containsKey(item)) {
                SObject existentSObject = existentMap.get(item);
                if (existentSObject != null) { // parent record exists
                    sampleSObject.putSObject(parentSObjectType, existentSObject);
                    if (sampleSObject.Id == null) { 
                        uow.registerNew(sampleSObject); 
                    } else { 
                        uow.registerDirty(sampleSObject); 
                    } 
                    uow.registerRelationship(sampleSObject, supplier.getMetadata().referenceFields[0].referenceField, sampleSObject.getSObject(parentSObjectType));   
                } 
            } 
        }
        return uow;
    }

    @TestVisible
    private Map<Integer, SObject> generateRecordsMap(List<SObject> records) {
        Map<Integer, SObject> recordsMap = new Map<Integer, SObject>();
        for (SObject existSObj : records) {          
            recordsMap.put(new RecordKey(supplier.getMetadata().referenceFields[0].referencedKeyFields, existSObj).hashCode(), existSObj);
        }
        return recordsMap;
    }

    @TestVisible
    private Map<Integer, SObject> generateSampleRecordsMap(List<SObject> records, String parentSObjectType) {
        Map<Integer, SObject> recordsMap = new Map<Integer, SObject>();
        for (SObject existSObj : records) {          
            recordsMap.put(new RecordKey(supplier.getMetadata().referenceFields[0].referencedKeyFields, existSObj.getSObject(parentSObjectType)).hashCode(), existSObj);
        }
        return recordsMap;
    }
    @TestVisible
    private List<SObject> getRecords(List<SObject> data) {
        List<Set<Object>> referenceFieldValues = this.getReferenceFieldValues(data);
        Integer fieldsNumber = referenceFieldValues.size();
        DataDefinition.ReferenceFieldDefinition referenceFieldsList = supplier.getMetadata().referenceFields[0];
        Object pr0 = (fieldsNumber > 0) ? SetUtils.toSetOfType(referenceFieldsList.referencedKeyFields[0], referenceFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ? SetUtils.toSetOfType(referenceFieldsList.referencedKeyFields[1], referenceFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ? SetUtils.toSetOfType(referenceFieldsList.referencedKeyFields[2], referenceFieldValues[2]) : null;
        String query = this.buildQuery();
        return Database.query(query);
    }

    @TestVisible
    private List<Set<Object>> getReferenceFieldValues(List<SObject> data) {
        List<Set<Object>> constantValues = new List<Set<Object>>();
        SObject parentSobj;
        for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : data) {
                parentSobj = obj.getSObject(supplier.getMetadata().referenceFields[0].referenceField);
                values.add(field.getFrom(parentSobj));
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