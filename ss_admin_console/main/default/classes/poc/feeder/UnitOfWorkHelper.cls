public with sharing class UnitOfWorkHelper {
    private DataSupplier supplier;
    private String parentSObjectType;
    private List<SObject> data;

    public UnitOfWorkHelper(List<SObject> data, DataSupplier supplier) {
        this.supplier = supplier;
        this.data = data;
        this.parentSObjectType = String.valueOf(supplier.getMetadata().referenceFields[0].referenceField).removeEnd('Id');
    }

    public fflib_SObjectUnitOfWork linkSObjects() {
        fflib_SObjectUnitOfWork uow = 
            new fflib_SObjectUnitOfWork( 
                new Schema.SObjectType[] {supplier.getMetadata().objectType});
                
            System.debug('16 line');
            List<SObject> existentParentRecords = getParentRecords();
            System.debug('18 line' + existentParentRecords);
            Map<String, SObject> existentMap = generateExistentParentRecordsMap(existentParentRecords);
            System.debug('19 line');
            for (SObject item : data) {
                String parentFingerprint = generateRecordFingerprint(item);
                SObject parentSObject = existentMap.get(parentFingerprint);      
                for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
                    System.debug('24 line');
                    if (field.getFrom(item) == field.getFrom(parentSObject)) {
                        SObject sRefObj = Schema.getGlobalDescribe().get(parentSObjectType).newSObject();
                        sRefObj.put('Id', parentSObject.Id);
                        item.putSObject(parentSObjectType, sRefObj);
                    }
                }
            System.debug(JSON.serializePretty(item));
            //uow.registerNew(item);
            }
        return uow;
    }

    @TestVisible
    private String generateRecordFingerprint(SObject record) {
        String recordKeysFingerprint = '';
        for (FieldReference keyField : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            recordKeysFingerprint += String.valueOf(keyField.getFrom(record)).toLowerCase() + '_';
        }
        return recordKeysFingerprint.removeEnd('_');
    }

    /**
     * Generates map with existent records and key fields.
     * @param existentRecords contains list of queried records
     * @return map with recordFingerprint key and sobject as a value
     */
    @TestVisible
    private Map<String, SObject> generateExistentParentRecordsMap(List<SObject> existentRecords) {
        Map<String, SObject> existentMap = new Map<String, SObject>();
        for (SObject existSObj : existentRecords) {
            String recordKeysFingerprint = generateRecordFingerprint(existSObj);          
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

    @TestVisible
    public List<SObject> getParentRecords() {
        List<Set<Object>> referenceFieldValues = this.getReferenceFieldValues();
        Integer fieldsNumber = referenceFieldValues.size();
        Object pr0 = (fieldsNumber > 0) ? SetUtils.toSetOfType(supplier.getMetadata().referenceFields[0].referencedKeyFields[0], referenceFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ? SetUtils.toSetOfType(supplier.getMetadata().referenceFields[0].referencedKeyFields[1], referenceFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ? SetUtils.toSetOfType(supplier.getMetadata().referenceFields[0].referencedKeyFields[2], referenceFieldValues[2]) : null;
        String query = this.buildQuery();
        return Database.query(query);
    }

    @TestVisible
    private List<Set<Object>> getReferenceFieldValues() {
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
    public String buildQuery() {
        Integer counter = 0;
        String result = 'SELECT Id, Name FROM ' + parentSObjectType;
        result = result.removeEnd('Id');
        result += ' WHERE ';
        for (FieldReference field : supplier.getMetadata().referenceFields[0].referencedKeyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter++;
        } 
        result = result.removeEnd(' AND ');
        return result;
    }
}