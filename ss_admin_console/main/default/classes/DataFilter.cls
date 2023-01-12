/**
 *  Provides a data filtration dividing records to three status: Changed/Duplicated/Ok.
 *  If key fields are not changed but non key fields changed, record is Changed and ready to be updated.
 *  If data fields are not changed, record is Duplicated and upsertion is skipped.
 */
public inherited sharing class DataFilter {
    private final DataDefinition metadata;
    private final List<SObject> records;
    
    /**
     * Constructor.
     *
     * @param metadata SObject metadata
     * @param records records to filter
     */
    // TODO Replace Map with List
    public DataFilter(DataDefinition metadata, List<SObject> records) {
        this.metadata = metadata;
        this.records = records;
    }

    /** 
     * Determines OK, Duplicated and Changed records.
     * @return list of filtered records with determined status
     */
    public List<SSACResult> filter() {
        if (records == null && records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new List<SSACResult>();
        List<SObject> existentRecords = loadExistentRecords(records);
        Map<RecordKey, SObject> existentMap = generateRecordsMap(existentRecords);
        for (SObject record : records) {
            RecordKey recordKey = new RecordKey(metadata.keyFields, record);
            SObject existentSObject = existentMap.get(recordKey);
            if (existentSObject != null) {
                Integer matchedNonKeyFields = 0;
                for (FieldReference nonKeyField : metadata.dataFields) {
                    if (nonKeyField.getFrom(record) == nonKeyField.getFrom(existentSObject)) {
                        matchedNonKeyFields++;
                    } else {
                        results.add(new SSACResult()
                            .setStatus(ApexActionStatus.CHANGED.value())
                            .setRecordKey(recordKey.toString())
                            .setRecordId(existentSObject.Id)
                            .setSObjectApiName(metadata.objectType.getDescribe().getName()));
                        break;
                    }
                }
                if (matchedNonKeyFields == metadata.dataFields.size()) {
                    results.add(new SSACResult()
                        .setStatus(ApexActionStatus.DUPLICATED.value())
                        .setRecordKey(recordKey.toString())
                        .setSObjectApiName(metadata.objectType.getDescribe().getName()));
                }
            } else {
                results.add(new SSACResult()
                    .setStatus(ApexActionStatus.OK.value())
                    .setRecordKey(recordKey.toString())
                    .setSObjectApiName(metadata.objectType.getDescribe().getName()));
            }
        }
        return results;
    }

    /**
     * Generates map with keys and records.
     * @param records contains list of records
     * @return map with RecordKey as a key and sobject as a value
     */
    @TestVisible
    private Map<RecordKey, SObject> generateRecordsMap(List<SObject> records) {
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
    private List<SObject> loadExistentRecords(List<SObject> records) {
        List<Set<Object>> keyFieldValues = this.getKeyFieldValues(records);
        Integer fieldsNumber = keyFieldValues.size();
        Object pr0 = (fieldsNumber > 0) ? SetUtils.toSetOfType(metadata.keyFields[0], keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ? SetUtils.toSetOfType(metadata.keyFields[1], keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ? SetUtils.toSetOfType(metadata.keyFields[2], keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ? SetUtils.toSetOfType(metadata.keyFields[3], keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ? SetUtils.toSetOfType(metadata.keyFields[4], keyFieldValues[4]) : null;
        String query = this.buildQuery();
        return Database.query(query);
    }

    /**
     * Retrieves list of key field values from sample data.
     * @param records contains list of sample data
     * @return list of values of all key fields 
     */
    @TestVisible
    private List<Set<Object>> getKeyFieldValues(List<SObject> records) {
        List<Set<Object>> constantValues = new List<Set<Object>>();
        for (FieldReference field : metadata.keyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : records) {
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
        if (metadata.dataFields != null || metadata.keyFields != null) {
            for (FieldReference field : metadata.keyFields) {
                result += field.toString() + ',';
            }
            for (FieldReference field : metadata.dataFields) {
                result += field.toString() + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM ' + metadata.objectType.getDescribe().getName() + ' WHERE ';
        for (FieldReference field : metadata.keyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter++;
        } 
        result = result.removeEnd(' AND ');
        return result;
    }
}