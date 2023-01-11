public inherited sharing class UnitOfWorkHelper {
    private final DataSupplier supplier;
    private final String parentSObjectType;
    private final fflib_ISObjectUnitOfWork uow;

    public UnitOfWorkHelper(fflib_ISObjectUnitOfWork uow, DataSupplier supplier) {
        this.supplier = supplier;
        this.uow = uow;
        if (!supplier.getMetadata().referenceFields.isEmpty()) {
            // TODO Add support for multiple reference fields
            this.parentSObjectType = String.valueOf(supplier.getMetadata().referenceFields[0].referenceField.getDescribe().getReferenceTo()[0]);
        }
    }

    public void registerRecords(List<SObject> data, Integer referenceFieldsSize, FeedLogger logger) {
        if (referenceFieldsSize > 0) {
            registerChildrenToParent(data, logger);
        } else {
            registerParents(data);
        }
    }

    @TestVisible
    private void registerParents(List<SObject> data) {
        for (SObject item : data) {
            if (item.Id != null) {
                uow.registerDirty(item);
            } else {
                uow.registerNew(item);     
            }
        }
    }

    @TestVisible
    private void registerChildrenToParent(List<SObject> data, FeedLogger logger) {
        List<SObject> existentParentRecords = getRecords(data);
        if (existentParentRecords.isEmpty()) {
            logger.error('NOTE: Please, insert ' + parentSObjectType + '\'s records first.');
            return;
        }
        Map<RecordKey, SObject> existentMap = generateRecordsMap(existentParentRecords);
        List<FieldReference> parentObjectKeyFields = supplier.getMetadata().referenceFields[0].referencedKeyFields;
        for (SObject sampleRecord : data) {
            SObject parentRecord = sampleRecord.getSObject(parentSObjectType);
            if (parentRecord != null) {
                RecordKey parentRecordKey = new RecordKey(parentObjectKeyFields, parentRecord);
                SObject existingParentRecord = existentMap.get(parentRecordKey);
                if (existingParentRecord != null) {
                    if (sampleRecord.Id == null) {
                        uow.registerNew(sampleRecord);
                    } else {
                        uow.registerDirty(sampleRecord);
                    }

                    sampleRecord.put(supplier.getMetadata().referenceFields[0].referenceField, existingParentRecord.Id);
                    //uow.registerRelationship(sampleRecord, supplier.getMetadata().referenceFields[0].referenceField, existingParentRecord);
                }
            }
        }
    }

    @TestVisible
    private Map<RecordKey, SObject> generateRecordsMap(List<SObject> records) {
        Map<RecordKey, SObject> recordsMap = new Map<RecordKey, SObject>();
        List<FieldReference> keyFields = supplier.getMetadata().referenceFields[0].referencedKeyFields;
        for (SObject existSObj : records) {          
            recordsMap.put(new RecordKey(keyFields, existSObj), existSObj);
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
        DataDefinition.ReferenceFieldDefinition parentFieldDefinition = supplier.getMetadata().referenceFields[0];
        for (FieldReference field : parentFieldDefinition.referencedKeyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : data) {
                SObject parentSObj = obj.getSObject(parentFieldDefinition.referenceField);
                values.add(field.getFrom(parentSObj));
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