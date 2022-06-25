public with sharing class SSACFilter {
    private String sObjectApiName;
    private Map<String, SObject> records;
    private List<String> keyFields;
    private List<String> allFields;
    private String additionCondition;
    private List<SObject> constantSObjects;
    private Map<String, Set<Object>> constantFields;
    private Map<String, Set<String>> existentKeyFields;
    private List<SObject> existentSObjects;

    public SSACFilter(String sObjectApiName, Map<String, SObject> records, List<String> keyFields, List<String> allFields, String additionCondition) {
        this.sObjectApiName = sObjectApiName;
        this.records = records;
        this.keyFields = keyFields;
        this.allFields = allFields;
        this.additionCondition = additionCondition;
        this.constantSObjects = this.recordsToList();
        this.constantFields = this.getConstantFields();
        this.existentSObjects = this.getExistentSObjects();
    }

    public List<SSACResult> filter() {
        List<SSACResult> result = new List<SSACResult>();
        result.addAll(this.getFilteredRecords());
        return result;
    }

    //values extraction from map
    @TestVisible
    private List<SObject> recordsToList() {
        List<SObject> result = new List<SObject>();
        for (String item : this.records.keySet()) {
            result.add(this.records.get(item));
        }
        return result;
    }

    // fitter method for determining new, dublicated and existing records
    @TestVisible
    private List<SSACResult> getFilteredRecords() {
        List<SSACResult> results = new List<SSACResult>();
        Map<String, SObject> existentMap = new Map<String, SObject>();
        Set<String> nonKeyFields = new Set<String>(this.allFields.clone());
        nonKeyFields.removeAll(this.keyFields);
    
        for (SObject existSObj: this.existentSObjects) {
            String concatenatedString = '';
            for (String keyField: this.keyFields) {
                if (keyField.contains('.')) {
                    List<String> splittedField = keyField.split('\\.');
                    String nextField = splittedField[1];
                    concatenatedString += String.valueOf(existSObj.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
                } else {
                    concatenatedString += String.valueOf(existSObj.get(keyField)).toLowerCase() + '_';	
                }
            }
            concatenatedString = concatenatedString.removeEnd(concatenatedString.right(1));
            existentMap.put(concatenatedString, existSObj);
        }

        for (SObject record: this.constantSObjects) {
            Integer matchedNonKeyFields = 0;
            String concatenatedString = '';
            for (String keyField: this.keyFields) {
                if (keyField.contains('.')) {
                    List<String> splittedField = keyField.split('\\.');
                    String nextField = splittedField[1];
                    concatenatedString += String.valueOf(record.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
                } else {
                    concatenatedString += String.valueOf(record.get(keyField)).toLowerCase() + '_';	
                }
            }
            concatenatedString = concatenatedString.removeEnd(concatenatedString.right(1));
            if (existentMap.get(concatenatedString) != null) { 
            for (String nonKeyField: nonKeyFields) {
                    if (record.get(nonKeyField) == existentMap.get(concatenatedString).get(nonKeyField)) {
                        matchedNonKeyFields += 1;
                    } else {
                        results.add(new SSACResult()
                            .setStatus(SSACConstants.CHANGED_STATUS)
                            .setRecordKey(concatenatedString)
                            .setRecordId(existentMap.get(concatenatedString).Id)
                            .setSObjectApiName(this.sObjectApiName));
                        break;
                    }
                }
                if (matchedNonKeyFields == nonKeyFields.size()) {
                    results.add(new SSACResult()
                    .setStatus(SSACConstants.DUPLICATED_STATUS)
                    .setRecordKey(concatenatedString)
                    .setSObjectApiName(this.sObjectApiName));
                }
            } else {
                results.add(new SSACResult()
                .setStatus(SSACConstants.OK_STATUS)
                .setRecordKey(concatenatedString)
                .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    // existent sobject extraction
    @TestVisible
    private List<SObject> getExistentSObjects() {
        String query = this.buildQuery();
        return Database.query(query);
    }

    // formatting map with all fields and its values
    @TestVisible
    private Map<String, Set<Object>> getConstantFields() {
        Map<String, Set<Object>> constantValues = new Map<String, Set<Object>>();
        for (String field: this.allFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj: this.constantSObjects) {
                if (field.contains('.')) {
                    List<String> splittedField = field.split('\\.');
                    values.add(obj.getSObject(splittedField[0]).get(splittedField[1]));
                } else {
                    values.add(obj.get(field));
                }
            }
            constantValues.put(field, values);
        }
        return constantValues;
    }

    @TestVisible
    private String buildQuery() {
        String result = 'SELECT Id, ';
        if (this.allFields != null) {
            for (String item : this.allFields) {
                result += item + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ this.sObjectApiName + ' WHERE ';
        for (String field: this.keyFields) {
            result += field + ' IN (';
            for (Object value : this.constantFields.get(field)) {
                result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
            }
            result = result.removeEnd(result.right(1)) + ') AND ';
        } 
        result = result.removeEnd(result.right(4));
        if (this.additionCondition != null) {
            result += 'AND (' + this.additionCondition + ')';
        }
        return result;
    }
}