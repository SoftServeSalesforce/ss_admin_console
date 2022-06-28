public with sharing class SSACFilter {
    private SObjectType sObjectApiName;
    private List<SObject> records;
    private List<SObjectField> keyFields;
    private List<SObjectField> allFields;
    private List<SObject> constantSObjects;
    private Map<String, Set<Object>> constantFields;
    private List<SObject> existentSObjects;
    private Map<String, SObject> existentMap;

    public SSACFilter(SObjectType sObjectApiName, List<SObject> records, List<SObjectField> keyFields, List<SObjectField> allFields) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.keyFields = keyFields;
        this.allFields = allFields;
        this.constantFields = this.getConstantFields();
        this.existentSObjects = this.getExistentSObjects();
        this.existentMap = this.generateExistentMap();
    }

    public List<SSACResult> filter() {
        List<SSACResult> result = new List<SSACResult>();
        result.addAll(this.getFilteredRecords());
        return result;
    }

    // filter method for determining new, dublicated and existing records
    @TestVisible
    private List<SSACResult> getFilteredRecords() {
        List<SSACResult> results = new List<SSACResult>();
        Map<String, SObject> existentMap = new Map<String, SObject>();
        Set<SObjectField> nonKeyFields = new Set<SObjectField>(allFields.clone());
        nonKeyFields.removeAll(this.keyFields);
        

        for (SObject record: records) {
            Integer matchedNonKeyFields = 0;
            String concatenatedString = '';
            for (SObjectField keyField: keyFields) {
                if (String.valueof(keyField).contains('.')) {
                    List<String> splittedField = String.valueof(keyField).split('\\.');
                    String nextField = splittedField[1];
                    concatenatedString += String.valueOf(record.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '';	
                } else {
                    concatenatedString += String.valueOf(record.get(String.valueof(keyField))).toLowerCase() + ' : ';	
                }
            }
            concatenatedString = concatenatedString.removeEnd(concatenatedString.right(1));
            if (existentMap.get(concatenatedString) != null) { 
            for (SObjectField nonKeyField: nonKeyFields) {
                    if (record.get(nonKeyField) == existentMap.get(concatenatedString).get(nonKeyField)) {
                        matchedNonKeyFields += 1;
                    } else {
                        results.add(new SSACResult()
                            .setStatus(SSACConstants.CHANGED_STATUS)
                            .setRecordKey(concatenatedString)
                            .setRecordId(existentMap.get(concatenatedString).Id)
                            .setSObjectApiName(String.valueOf(sObjectApiName)));
                        break;
                    }
                }
                if (matchedNonKeyFields == nonKeyFields.size()) {
                    results.add(new SSACResult()
                    .setStatus(SSACConstants.DUPLICATED_STATUS)
                    .setRecordKey(concatenatedString)
                    .setSObjectApiName(String.valueOf(sObjectApiName)));
                }
            } else {
                results.add(new SSACResult()
                .setStatus(SSACConstants.OK_STATUS)
                .setRecordKey(concatenatedString)
                .setSObjectApiName(String.valueOf(sObjectApiName)));
            }
        }
        return results;
    }

    @TestVisible
    private Map<String, SObject> generateExistentMap(){
        Map<String, SObject> existentMap = new Map<String, SObject>();
        for (SObject existSObj: existentSObjects) {
            String concatenatedString = '';
            for (SObjectField keyField: keyFields) {
                if (String.valueof(keyField).contains('.')) {
                    List<String> splittedField = String.valueof(keyField).split('\\.');
                    String nextField = splittedField[1];
                    concatenatedString += String.valueOf(existSObj.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
                } else {
                    concatenatedString += String.valueOf(existSObj.get(String.valueof(keyField))).toLowerCase() + '_';	
                }
            }
            concatenatedString = concatenatedString.removeEnd(concatenatedString.right(1));
            existentMap.put(concatenatedString, existSObj);
        }
        return existentMap;
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
        for (SObjectField field: allFields) {
            Set<Object> values = new Set<Object>();
            for (SObject obj: records) {
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
    private String buildQuery() {
        String result = 'SELECT Id, ';
        if (allFields != null) {
            for (SObjectField item : allFields) {
                result += String.valueOf(item) + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ String.valueOf(sObjectApiName) + ' WHERE ';
        for (SObjectField field: keyFields) {
            result += String.valueOf(field) + ' IN (';
            for (Object value : constantFields.get(String.valueOf(field))) {
                result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
            }
            result = result.removeEnd(result.right(1)) + ') AND ';
        } 
        result = result.removeEnd(result.right(4));
        return result;
    }
}