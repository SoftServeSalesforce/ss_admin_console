public with sharing class SSACFilter {
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private String additionCondition;
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
        String result = 'SELECT Id, ' + this.externalIdApiName + ' FROM ' + this.sObjectApiName + ' WHERE '
                + this.externalIdApiName + ' IN (';
        for (String externalId : this.keys) {
            result += '\'' + externalId + '\',';
        }
        result = result.removeEnd(result.right(1)) + ')';
        if (this.additionCondition != null) {
            result += ' AND (' + this.additionCondition + ')';
        }

        return result;
    }
}