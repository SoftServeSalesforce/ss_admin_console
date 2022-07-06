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
        Map<String, SObject> existentMap = generateExistentRecordsMap(existentRecords);
       
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
    private Map<String, SObject> generateExistentRecordsMap(List<SObject> existentRecords) {
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

    //existent sobject extraction
    @TestVisible
    private List<SObject> getExistentRecords(List<SObject> records) {
        List<Set<Object>> keyFieldValues = this.getKeyFieldValues(records);

        Integer fieldsNumber = keyFieldValues.size();
        String sObjectType = sObjectApiName.getDescribe().getName();
        TypesSetter ts = new TypesSetter();
        Object pr0 = (fieldsNumber > 0) ?  ts.toSetOfType(keyFields[0], sObjectType, keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ?  ts.toSetOfType(keyFields[1], sObjectType, keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ?  ts.toSetOfType(keyFields[2], sObjectType, keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ?  ts.toSetOfType(keyFields[3], sObjectType, keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ?  ts.toSetOfType(keyFields[4], sObjectType, keyFieldValues[4]) : null;

        String query = this.buildQuery(records);
        return Database.query(query);
    }

    //formatting map with all fields and its values
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
    private String buildQuery(List<SObject> records) {
        Integer counter = 0;
        String result = 'SELECT Id, ';
        if (dataFields != null) {
            for (FieldReference field : dataFields) {
                result += field.toString() + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ sObjectApiName.getDescribe().getName() + ' WHERE ';
        for (FieldReference field : keyFields) {
            result += field.toString() + ' IN :pr' + counter + ' AND ';
            counter += 1;
        } 

        result = result.removeEnd(result.right(4));
        return result;
    }
}