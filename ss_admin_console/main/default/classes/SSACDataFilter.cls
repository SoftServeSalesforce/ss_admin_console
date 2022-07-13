/**
 *  Provides a data filtration dividing records to three status: Changed/Duplicated/Ok
 *  If at least one key field of current record is changed, record is Ok and ready to be inserted
 *  If key fields are not changed but non key fields changed, record is Changed and ready to be updated
 *  If data fields are not changed, record is Duplicated and upsertion is skipped
 */
public inherited sharing class SSACDataFilter {

    private SObjectType sObjectApiName;
    private List<SObject> records;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;

    /**
     * @param sObjectApiName describes filtered SObject 
     * @param keyFields contains list of unique key fields
     * @param datafields contains list of all fields used in filtration
     */
    public SSACDataFilter(SObjectType sObjectApiName, List<FieldReference> keyFields, List<FieldReference> dataFields) {
        this.sObjectApiName = sObjectApiName;
        this.keyFields = keyFields;
        this.dataFields = dataFields; 
    }

    /** filter method for determining OK, Duplicated and Changed records
     * 
     *  @param records contains sample data from constants 
     *  @return list of filtered records with determined status
     */
    public List<SSACResult> filter(List<SObject> records) {
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
        SetUtils sc = new SetUtils();
        Object pr0 = (fieldsNumber > 0) ?  sc.toSetOfType(keyFields[0], keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ?  sc.toSetOfType(keyFields[1], keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ?  sc.toSetOfType(keyFields[2], keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ?  sc.toSetOfType(keyFields[3], keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ?  sc.toSetOfType(keyFields[4], keyFieldValues[4]) : null;

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
}