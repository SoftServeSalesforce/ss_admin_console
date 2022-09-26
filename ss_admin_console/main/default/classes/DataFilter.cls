/**
 *  Provides a data filtration dividing records to three status: Changed/Duplicated/Ok.
 *  If at least one key field of current record is changed, record is Ok and ready to be inserted.
 *  If key fields are not changed but non key fields changed, record is Changed and ready to be updated.
 *  If data fields are not changed, record is Duplicated and upsertion is skipped.
 */
public inherited sharing class DataFilter {
    private DataDefinition metadata;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;
    private SObjectType objectType;
    private Map<RecordKey, SObject> records;
    
    /**
     * @param supplier contains data to filter
     */
    public DataFilter(DataDefinition metadata, Map<RecordKey, SObject> records) {
        this.metadata = metadata;
        this.keyFields = metadata.keyFields;
        this.dataFields = metadata.dataFields;
        this.objectType = metadata.objectType;
        this.records = records;
    }

    /** 
     * Determines OK, Duplicated and Changed records.
     *  @return list of filtered records with determined status
     */
    public List<SSACResult> filter() {
        if(records == null && records.isEmpty()){
            return new List<SSACResult>();
        }
        List<SSACResult> results = new List<SSACResult>();
        List<SObject> existentRecords = getExistentRecords(records);
        Map<RecordKey, SObject> existentMap = generateExistingRecordsMap(existentRecords);
        for (RecordKey item : records.keySet()) {
            SObject existentSObject = existentMap.get(item);
            if (existentSObject != null) {
                Integer matchedNonKeyFields = 0;
                SObject sampleSObject = records.get(item);
                for (FieldReference nonKeyField : dataFields) {
                    if (nonKeyField.getFrom(sampleSObject) == nonKeyField.getFrom(existentSObject)) {
                        matchedNonKeyFields++;
                    } else {
                        results.add(new SSACResult()
                            .setStatus(ApexActionStatus.CHANGED.value())
                            .setRecordKey(item.toString())
                            .setRecordId(existentSObject.Id)
                            .setSObjectApiName(objectType.getDescribe().getName()));
                        break;
                    }
                }
                if (matchedNonKeyFields == dataFields.size()) {
                    results.add(new SSACResult()
                        .setStatus(ApexActionStatus.DUPLICATED.value())
                        .setRecordKey(item.toString())
                        .setSObjectApiName(objectType.getDescribe().getName()));
                }
            } else {
                results.add(new SSACResult()
                    .setStatus(ApexActionStatus.OK.value())
                    .setRecordKey(item.toString())
                    .setSObjectApiName(objectType.getDescribe().getName()));
            }    
        }
        return results;
    }

    /**
     * Generates map with existent records and key fields.
     * @param existentRecords contains list of queried records
     * @return map with recordFingerprint key and sobject as a value
     */
    @TestVisible
    private Map<RecordKey, SObject> generateExistingRecordsMap(List<SObject> records) {
        Map<RecordKey, SObject> recordsMap = new Map<RecordKey, SObject>();
        for (SObject existSObj : records) {
            recordsMap.put(new RecordKey(metadata.keyFields, existSObj), existSObj);
        }
        return recordsMap;
    }

    /**
     * Query records from database with key field values.
     * @param records contains list of sample data
     * @return list of queried records
     */
    @TestVisible
    private List<SObject> getExistentRecords(Map<RecordKey, SObject> records) {
        List<Set<Object>> keyFieldValues = this.getKeyFieldValues(records);
        Integer fieldsNumber = keyFieldValues.size();
        Object pr0 = (fieldsNumber > 0) ? SetUtils.toSetOfType(keyFields[0], keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ? SetUtils.toSetOfType(keyFields[1], keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ? SetUtils.toSetOfType(keyFields[2], keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ? SetUtils.toSetOfType(keyFields[3], keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ? SetUtils.toSetOfType(keyFields[4], keyFieldValues[4]) : null;
        String query = this.buildQuery();
        return Database.query(query);
    }

    /**
     * Retrieves list of key field values from sample data.
     * @param records contains list of sample data
     * @return list of values of all key fields 
     */
    @TestVisible
    private List<Set<Object>> getKeyFieldValues(Map<RecordKey, SObject> records) {
        List<Set<Object>> constantValues = new List<Set<Object>>();
        for (FieldReference field : keyFields) {
            Set<Object> values = new Set<Object>();
            for (RecordKey item : records.keySet()) {
                values.add(field.getFrom(records.get(item)));
            }
            constantValues.add(values);
        }
        return constantValues;
    }

    @TestVisible
    private String buildQuery() {
        Integer counter = 0;
        String result = 'SELECT Id, ';
        if (dataFields != null || keyFields != null) {
            for (FieldReference field : keyFields) {
                result += field.toString() + ',';
            }
            for (FieldReference field : dataFields) {
                result += field.toString() + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM ' + objectType.getDescribe().getName() + ' WHERE ';
        for (FieldReference field : keyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter++;
        } 
        result = result.removeEnd(' AND ');
        return result;
    }
}