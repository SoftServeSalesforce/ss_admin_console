public with sharing class SSACFilter {
    private Map<String, SObject> records;
    private String externalIdApiName;
    private Set<String> externalFields;
    private String sObjectApiName;
    private String additionCondition;
    private Set<String> keys;
    private Map<String, SObject> existentSObjects;
    private Map<String, Set<String>> existentFieldValues;
    private Map<String, Set<Object>> constantFields;


    public SSACFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, Set<String> externalFields, String additionCondition) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalFields = externalFields;
        this.externalIdApiName = externalIdApiName;
        this.additionCondition = additionCondition;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.constantFields = this.getConstantFields();
            this.existentSObjects = this.getExistentSObjects();
            this.existentFieldValues = this.getExistentFieldValues();
        }
    }

    public List<SSACResult> filter() {
        List<SSACResult> result = new List<SSACResult>();
        result.addAll(this.getNonExistentRecords());
        result.addAll(this.getExistentRecords());
        result.addAll(this.getExistentChangedRecords());
        return result;
    }

    @TestVisible
    private List<SSACResult> getNonExistentRecords() {
        List<SSACResult> results = new List<SSACResult>();
        for(String recordKey: this.records.keySet()){
            Integer flag = 0;
            for (String key: this.existentFieldValues.keySet()){
                String existentSetValues = String.valueOf(this.records.get(recordKey).get(key)).toLowerCase();
                if (!existentFieldValues.get(key).contains(existentSetValues)){
                    flag += 1;
                }    
            }          
            if (flag == this.existentFieldValues.keySet().size()){
                results.add(new SSACResult()
                        .setStatus(SSACConstants.OK_STATUS)
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private List<SSACResult> getExistentRecords() {
        List<SSACResult> results = new List<SSACResult>();
        for (String recordKey: this.records.keySet()){
            Integer flag = 0;
            for (String key: this.existentFieldValues.keySet()){
                String existentSetValues = String.valueOf(this.records.get(recordKey).get(key)).toLowerCase();
                if (existentFieldValues.get(key).contains(existentSetValues)){
                    flag += 1;
                }
            }
            if (flag == this.existentFieldValues.keySet().size()){
                results.add(new SSACResult()
                        .setStatus(SSACConstants.DUPLICATED_STATUS)
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private List<SSACResult> getExistentChangedRecords() {
        List<SSACResult> results = new List<SSACResult>();
        for (String recordKey: this.records.keySet()){
            Integer flag = 0;
            for (String key: this.existentFieldValues.keySet()){
                String existentSetValues = String.valueOf(this.records.get(recordKey).get(key)).toLowerCase();
                if (!existentFieldValues.get(key).contains(existentSetValues)){
                    flag += 1;
                }
            }
            if (flag > 0 && flag < this.existentFieldValues.keySet().size()){
                results.add(new SSACResult()
                        .setStatus(SSACConstants.CHANGED_STATUS)
                        .setRecordId(String.valueOf(this.existentSObjects.get(recordKey.toLowerCase()).Id))
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private Map<String, SObject> getExistentSObjects(){
        Map<String, SObject> result = new Map<String, SObject>();
        String query = this.buildQuery();
        List<SObject> existentRecords = Database.query(query);
        for (SObject obj : existentRecords) {
            result.put(String.valueOf(obj.get(this.externalIdApiName)).toLowerCase(), obj);
        }
		System.debug(result);
        return result;
    }

    @TestVisible
    private Map<String, Set<String>> getExistentFieldValues() {
        Map<String, Set<String>> result = new Map<String, Set<String>>();
        for (String key: externalFields){
            Set<String> testSet = new Set<String>();
            for (SObject obj: this.existentSObjects.values()){
                testSet.add(String.valueOf(obj.get(key)).toLowerCase());
            }
            result.put(key,testSet);
        }
        return result;
    }

    @TestVisible
    private String buildQuery() {
        String result = 'SELECT Id,';
        if (this.externalFields != null){
            for (String item : this.externalFields) {
                result += item + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ this.sObjectApiName + ' WHERE ';
        for (String field: this.externalFields){
            result += field + ' IN (';
            for (Object value : this.constantFields.get(field)) {
                result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
            }
        result = result.removeEnd(result.right(1)) + ') AND ';
        } result = result.removeEnd(result.right(4));
        if (this.additionCondition != null) {
            result += 'AND (' + this.additionCondition + ')';
        }
		System.debug(result);
        return result;
    }

    @TestVisible
    private Map<String, Set<Object>> getConstantFields(){
        Map<String, Set<Object>> mp = new Map<String, Set<Object>>();
        for(String field: this.externalFields){
            Set<Object> values = new Set<Object>();
            for(SObject obj: this.records.values()){
                values.add(obj.get(field));
            }
            mp.put(field, values);
        }
        return mp;
    }
}