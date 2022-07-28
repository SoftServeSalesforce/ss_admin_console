public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    private FeedLogger logger;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;
    private SObjectType sObjectApiName;

    public BaseDataFeeder(DataSupplier supplier, List<FieldReference> keyFields, List<FieldReference> dataFields, FeedLogger logger) {
        this.supplier = supplier;
        this.logger = logger;
        this.keyFields = keyFields;
        this.datafields = dataFields;
        this.sObjectApiName = supplier.getListType();
    }

    private List<SSACResult> filter() {
        if(supplier.supply() == null && supplier.supply().isEmpty()){
            return new List<SSACResult>();
        }
        List<SObject> records = supplier.supply();
        List<SSACResult> results = new List<SSACResult>();

        List<SObject> existentRecords = getExistentRecords(records);
        Map<String, SObject> existentMap = generateExistentRecordsMap(existentRecords);
       
        Set<FieldReference> nonKeyFields = new Set<FieldReference>(dataFields.clone());
        nonKeyFields.removeAll(keyFields);
        
        for (SObject record : records) {
            Integer matchedNonKeyFields = 0;
            String recordKeysFingerprint = generateRecordFingerprint(record);
            SObject existentSObject = existentMap.get(recordKeysFingerprint);            
            if (existentSObject != null) {
                for (FieldReference nonKeyField : nonKeyFields) {
                    if (nonKeyField.getFrom(record) == nonKeyField.getFrom(existentSObject)) {
                        matchedNonKeyFields++;
                    } else {
                        results.add(new SSACResult()
                            .setStatus(SSACConstants.CHANGED_STATUS)
                            .setRecordKey(recordKeysFingerprint)
                            .setRecordId(existentSObject.Id)
                            .setSObjectApiName(sObjectApiName.getDescribe().getName()));
                        break;
                    }
                }
                if (matchedNonKeyFields == nonKeyFields.size()) {
                    results.add(new SSACResult()
                        .setStatus(SSACConstants.DUPLICATED_STATUS)
                        .setRecordKey(recordKeysFingerprint)
                        .setSObjectApiName(sObjectApiName.getDescribe().getName()));
                }
            } else {
                results.add(new SSACResult()
                    .setStatus(SSACConstants.OK_STATUS)
                    .setRecordKey(recordKeysFingerprint)
                    .setSObjectApiName(sObjectApiName.getDescribe().getName()));
            }
        }
        return results;
    }

    public void feed(Boolean updateRecords) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = filter();
        List<SSACResult> allResults = this.getAllResults(util, results);
        if (updateRecords) { 
            if (!allResults.isEmpty()) {
                Database.UpsertResult[] upsertResults = Database.upsert(this.setId(allResults), false);
                results = util.generateDiagnosticResultsUpsert(upsertResults, this.sObjectApiName);
            }
            logger.generateLoadLog(results);
        } else {
            // TODO for Mykola: implement rollback 


            logger.generateTestLog(results);
        } 
    }

    @TestVisible
    private String generateRecordFingerprint(SObject record) {
        String recordKeysFingerprint = '';
        for (FieldReference keyField : keyFields) {
            recordKeysFingerprint += String.valueOf(keyField.getFrom(record)).toLowerCase() + '_';
        }
        return recordKeysFingerprint.removeEnd('_');
    }

    /**
     * generate map with existent records and key fields
     * @param existentRecords contains list of queried records
     * @return map with recordFingerprint key and sobject as a value
     */
    @TestVisible
    private Map<String, SObject> generateExistentRecordsMap(List<SObject> existentRecords) {
        Map<String, SObject> existentMap = new Map<String, SObject>();
        for (SObject existSObj : existentRecords) {
            String recordKeysFingerprint = generateRecordFingerprint(existSObj);          
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

     /**
     * Query records from database with key field values
     * @param records contains list of sample data
     * @return list of queried records
     */
    @TestVisible
    private List<SObject> getExistentRecords(List<SObject> records) {
        List<Set<Object>> keyFieldValues = this.getKeyFieldValues(records);

        Integer fieldsNumber = keyFieldValues.size();
        Object pr0 = (fieldsNumber > 0) ?  SetUtils.toSetOfType(keyFields[0], keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ?  SetUtils.toSetOfType(keyFields[1], keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ?  SetUtils.toSetOfType(keyFields[2], keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ?  SetUtils.toSetOfType(keyFields[3], keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ?  SetUtils.toSetOfType(keyFields[4], keyFieldValues[4]) : null;

        String query = this.buildQuery();
        return Database.query(query);
    }

    /**
     * Retrieving list of key field values from sample data
     * @param records contains list of sample data
     * @return list of values of all key fields 
     */
    @TestVisible
    private List<Set<Object>> getKeyFieldValues(List<SObject> records) {
        List<Set<Object>> constantValues = new List<Set<Object>>();
        for (FieldReference field : keyFields) {
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
        if (dataFields != null) {
            for (FieldReference field : dataFields) {
                result += field.toString() + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM ' + sObjectApiName.getDescribe().getName() + ' WHERE ';
        for (FieldReference field : keyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter++;
        } 
        result = result.removeEnd(' AND ');
        return result;
    }

    @TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        Integer counter = 0;
        for (SObject item : supplier.supply()) {
            String recordKeysFingerprint = '';
            for (FieldReference keyField: this.keyFields) {
                recordKeysFingerprint += String.valueOf(keyField.getFrom(item)).toLowerCase() + '_';
            }
            recordKeysFingerprint = recordKeysFingerprint.removeEnd('_');
            for (SSACResult result : results) {
                if (recordKeysFingerprint == result.recordKey) {
                    item.Id = result.recordId;
                    records.add(item);
                }
            }
        }
        return records;
    }

    @TestVisible
    private List<SSACResult> getAllResults(SSACResultsUtil util, List<SSACResult> filterResults) {
        List<SSACResult> allResults = new List<SSACResult>();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
        allResults.addAll(okResults);
        allResults.addAll(changedResults);
        return allResults;
    }
}