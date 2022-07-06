public inherited sharing class SSACDataFilter {
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
                            .setStatus(DiagnosticConstants.CHANGED_STATUS)
                            .setRecordKey(recordKeysFingerprint)
                            .setRecordId(existentSObject.Id)
                            .setSObjectApiName(sObjectApiName.getDescribe().getName()));
                        break;
                    }
                }
                if (matchedNonKeyFields == nonKeyFields.size()) {
                    results.add(new SSACResult()
                        .setStatus(DiagnosticConstants.DUPLICATED_STATUS)
                        .setRecordKey(recordKeysFingerprint)
                        .setSObjectApiName(sObjectApiName.getDescribe().getName()));
                }
            } else {
                results.add(new SSACResult()
                    .setStatus(DiagnosticConstants.OK_STATUS)
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


    @TestVisible
    private Map<String, SObject> generateExistentRecordsMap(List<SObject> existentRecords) {
        Map<String, SObject> existentMap = new Map<String, SObject>();
        for (SObject existSObj : existentRecords) {
            String recordKeysFingerprint = generateRecordFingerprint(existSObj);          
            existentMap.put(recordKeysFingerprint, existSObj);
        }
        return existentMap;
    }

    //existent sobject extraction
    @TestVisible
    private List<SObject> getExistentRecords(List<SObject> records) {
        List<Set<Object>> keyFieldValues = this.getKeyFieldValues(records);

        Integer fieldsNumber = keyFieldValues.size();
        SetConverter sc = new SetConverter();
        Object pr0 = (fieldsNumber > 0) ?  sc.toSetOfType(keyFields[0], sObjectApiName, keyFieldValues[0]) : null;
        Object pr1 = (fieldsNumber > 1) ?  sc.toSetOfType(keyFields[1], sObjectApiName, keyFieldValues[1]) : null;
        Object pr2 = (fieldsNumber > 2) ?  sc.toSetOfType(keyFields[2], sObjectApiName, keyFieldValues[2]) : null;
        Object pr3 = (fieldsNumber > 3) ?  sc.toSetOfType(keyFields[3], sObjectApiName, keyFieldValues[3]) : null;
        Object pr4 = (fieldsNumber > 4) ?  sc.toSetOfType(keyFields[4], sObjectApiName, keyFieldValues[4]) : null;

        String query = this.buildQuery();
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
