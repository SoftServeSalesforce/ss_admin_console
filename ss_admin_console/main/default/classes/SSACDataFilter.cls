public with sharing class SSACDataFilter {
    private SObjectType sObjectApiName;
    private List<SObject> records;
    private List<SObjectField> keyFields;
    private List<SObjectField> dataFields;

    public SSACDataFilter(SObjectType sObjectApiName, List<SObjectField> keyFields, List<SObjectField> dataFields) {
        this.sObjectApiName = sObjectApiName;
        this.keyFields = keyFields;
        this.dataFields = dataFields;
    }

    // filter method for determining new, dublicated and existing records
    public List<SSACResult> filter(List<SObject> records) {
        List<SSACResult> results = new List<SSACResult>();

        List<SObject> existentRecords = getExistentRecords(records);
        Map<String, SObject> existentMap = generateExistentMap(existentRecords);
       
        Set<SObjectField> nonKeyFields = new Set<SObjectField>(dataFields.clone());
        nonKeyFields.removeAll(this.keyFields);
        
        for (SObject record : records) {
            Integer matchedNonKeyFields = 0;
            String recordKeysFingerprint = '';
            for (SObjectField keyField : keyFields) {
                if (String.valueof(keyField).contains('.')) {
                    List<String> splittedField = String.valueof(keyField).split('\\.');
                    String nextField = splittedField[1];
                    recordKeysFingerprint += String.valueOf(record.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
                } else {
                    recordKeysFingerprint += String.valueOf(record.get(keyField)).toLowerCase() + '_';	
                }
            }
            recordKeysFingerprint = recordKeysFingerprint.removeEnd(recordKeysFingerprint.right(1));
            if (existentMap.get(recordKeysFingerprint) != null) {
            for (SObjectField nonKeyField : nonKeyFields) {
                    if (record.get(nonKeyField) == existentMap.get(recordKeysFingerprint).get(nonKeyField)) {
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
            for (SObjectField keyField : keyFields) {
                if (String.valueof(keyField).contains('.')) {
                    List<String> splittedField = String.valueof(keyField).split('\\.');
                    String nextField = splittedField[1];
                    recordKeysFingerprint += String.valueOf(existSObj.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
                } else {
                    recordKeysFingerprint += String.valueOf(existSObj.get(keyField)).toLowerCase() + '_';	
                }
            }
            recordKeysFingerprint = recordKeysFingerprint.removeEnd(recordKeysFingerprint.right(1));
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

    // existent sobject extraction
    @TestVisible
    private List<SObject> getExistentRecords(List<SObject> records) {
        String query = this.buildQuery(records);
        return Database.query(query);
    }

    // formatting map with all fields and its values
    @TestVisible
    private Map<String, Set<Object>> getKeyFieldValues(List<SObject> records) {
        Map<String, Set<Object>> constantValues = new Map<String, Set<Object>>();
        for (SObjectField field : keyFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj : records) {
                if (String.valueof(field).contains('.')) {
                    List<String> splittedField = String.valueof(field).split('\\.');
                    values.add(obj.getSObject(splittedField[0]).get(splittedField[1]));
                } else {
                    values.add(obj.get(field));
                }
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
            for (SObjectField item : dataFields) {
                result += String.valueOf(item) + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ String.valueOf(sObjectApiName) + ' WHERE ';
        for (SObjectField field : keyFields) {
            result += String.valueOf(field) + ' IN (';
            for (Object value : keyFieldValues.get(String.valueOf(field))) {
                result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
            }
            result = result.removeEnd(result.right(1)) + ') AND ';
        } 
        result = result.removeEnd(result.right(4));
        return result;
    }
}