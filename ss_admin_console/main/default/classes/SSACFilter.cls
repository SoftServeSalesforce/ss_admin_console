public with sharing class SSACFilter {
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private String additionCondition;

    private Map<String, Set<String>> additionConditions;

    private Set<String> keys;
    private Set<String> existentKeys;

    public SSACFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, String additionCondition) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        this.additionCondition = additionCondition;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.existentKeys = this.getExistentKeys();
        }
    }

    public SSACFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, Map<String, Set<String>> additionConditions) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        this.additionConditions = additionConditions;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.existentKeys = this.getExistentKeys();
        }
    }


    public List<SSACResult> filter() {
        List<SSACResult> result = new List<SSACResult>();
        result.addAll(this.getNonExistentRecords());
        result.addAll(this.getExistentRecords());
        return result;
    }

    @TestVisible
    private List<SSACResult> getNonExistentRecords() {
        List<SSACResult> results = new List<SSACResult>();
        for (String recordKey : this.records.keySet()) {
            if (!existentKeys.contains(recordKey.toLowerCase())) {
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
        for (String recordKey : this.records.keySet()) {
            if (existentKeys.contains(recordKey.toLowerCase())) {
                results.add(new SSACResult()
                        .setStatus(SSACConstants.DUPLICATED_STATUS)
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private Set<String> getExistentKeys() {
        Set<String> result = new Set<String>();
        String query = this.buildQuery();

        List<SObject> existentRecords = Database.query(query);
        for (SObject sObj : existentRecords) {
            result.add(String.valueOf(sObj.get(this.externalIdApiName)).toLowerCase());
        }
        return result;
    }

    @TestVisible
    private String buildQuery() {
        String fields = '';
        String condition = '';

        if (this.additionConditions != null) {
            
            for(String field: this.additionConditions.keySet()){
                fields += field + ' ,';
                String values = '';
                for(String value: this.additionConditions.get(field)){
                    values +=  '\'' + value + '\',';
                }
                condition += ' (' + field + ' IN ( ' + values.removeEnd(values.right(1))  + '))  AND'; 
            }
            fields =  fields.removeEnd(fields.right(1));
            condition = condition.removeEnd(condition.right(3));

        } else {

            fields = this.externalIdApiName;
            condition += fields + ' IN (';
            for (String externalId : this.keys) {
                condition += '\'' + externalId + '\',';
            }
            condition = condition.removeEnd(condition.right(1)) + ')';
        }

        String result = 'SELECT Id, ' + fields + ' FROM ' + this.sObjectApiName + ' WHERE ' + condition;

        return result;
    }
}