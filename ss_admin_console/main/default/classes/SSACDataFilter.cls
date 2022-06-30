public with sharing class SSACDataFilter {
    private SObjectType sObjectApiName;
    private List<SObject> records;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;

    public SSACDataFilter(SObjectType sObjectApiName, List<FieldReference> keyFields, List<FieldReference> dataFields) {
        this.sObjectApiName = sObjectApiName;
        this.keyFields = keyFields;
        this.dataFields = dataFields;
       
    }

    // filter method for determining new, dublicated and existing records
    public List<SSACResult> filter(List<SObject> records) {
        List<SSACResult> results = new List<SSACResult>();
        List<SObject> existentRecords = getExistentRecords(records);
        Map<String, SObject> existentMap = generateExistentMap(existentRecords);
       
        Set<FieldReference> nonKeyFields = new Set<FieldReference>(dataFields.clone());
        nonKeyFields.removeAll(this.keyFields);
        
        for (SObject record : records) {
            Integer matchedNonKeyFields = 0;
            String recordKeysFingerprint = '';
            for (FieldReference keyField : keyFields) {
                recordKeysFingerprint += String.valueOf(keyField.getFrom(record)).toLowerCase() + '_';
            }

            recordKeysFingerprint = recordKeysFingerprint.removeEnd(recordKeysFingerprint.right(1));
            if (existentMap.get(recordKeysFingerprint) != null) {
                for (FieldReference nonKeyField : nonKeyFields) {
                        if(nonKeyField.getFrom(record) == nonKeyField.getFrom(existentMap.get(recordKeysFingerprint))){
                            matchedNonKeyFields += 1;
                        } else {
                            results.add(new SSACResult()
                                .setStatus(DiagnosticConstants.CHANGED_STATUS)
                                .setRecordKey(recordKeysFingerprint)
                                .setRecordId(existentMap.get(recordKeysFingerprint).Id)
                                .setSObjectApiName(String.valueOf(sObjectApiName)));
                            break;
                        }
                    }
                if (matchedNonKeyFields == nonKeyFields.size()) {
                    results.add(new SSACResult()
                        .setStatus(DiagnosticConstants.DUPLICATED_STATUS)
                        .setRecordKey(recordKeysFingerprint)
                        .setSObjectApiName(String.valueOf(sObjectApiName)));
                }
            } else {
                results.add(new SSACResult()
                    .setStatus(DiagnosticConstants.OK_STATUS)
                    .setRecordKey(recordKeysFingerprint)
                    .setSObjectApiName(String.valueOf(sObjectApiName)));
            }
        }
        return results;
    }

    @TestVisible
    private Map<String, SObject> generateExistentMap(List<SObject> existentRecords) {
        Map<String, SObject> existentMap = new Map<String, SObject>();
              for (SObject existSObj : existentRecords) {
            String recordKeysFingerprint = '';
            for (FieldReference keyField : keyFields) {
                recordKeysFingerprint += String.valueOf(keyField.getFrom(existSObj)).toLowerCase() + '_';
            }
            recordKeysFingerprint = recordKeysFingerprint.removeEnd(recordKeysFingerprint.right(1));
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

    // // existent sobject extraction
    @TestVisible
    public List<SObject> getExistentRecords(List<SObject> records) {
        String query = this.buildQuery(records);
        System.debug(query);
        return Database.query(query);
    }

    // // formatting map with all fields and its values
    @TestVisible
    public Map<String, Set<Object>> getKeyFieldValues(List<SObject> records) {
        Map<String, Set<Object>> constantValues = new Map<String, Set<Object>>();
        for (FieldReference field : keyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : records) {
                values.add(field.getFrom(obj));
            }
            constantValues.put(String.valueOf(field), values);
        }
        return constantValues;
    }

    @TestVisible
    private String buildQuery(List<SObject> records) {
        Map<String, Set<Object>> keyFieldValues = this.getKeyFieldValues(records);
        String result = 'SELECT Id, ';
        if (dataFields != null) {
            for (FieldReference field : dataFields) {
                result += field.toString() + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ String.valueOf(sObjectApiName) + ' WHERE ';
        for (FieldReference field : keyFields) {
            result += field.toString() + ' IN (';
            for (Object value : keyFieldValues.get(field.toString())) {
                result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
            }
            result = result.removeEnd(result.right(1)) + ') AND ';
        } 
        result = result.removeEnd(result.right(4));
        return result;
    }
}