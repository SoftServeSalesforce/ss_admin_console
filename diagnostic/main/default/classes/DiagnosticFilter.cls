public with sharing class DiagnosticFilter { // TODO: Rename to DiagnosticFilter
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private String additionCondition;
    private Set<String> keys;
    private Set<String> existentKeys;

    public DiagnosticFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.existentKeys = this.getExistentKeys();
        }
    }

    public DiagnosticFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, String additionCondition) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        this.additionCondition = additionCondition;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.existentKeys = this.getExistentKeys();
        }
    }

    public List<DiagnosticResult> filter() {
        List<DiagnosticResult> result = new List<DiagnosticResult>();
        result.addAll(this.getNonExistentRecords());
        result.addAll(this.getExistentRecords());
        return result;
    }

    @TestVisible
    private List<DiagnosticResult> getNonExistentRecords() {
        List<DiagnosticResult> results = new List<DiagnosticResult>();
        for (String recordKey : this.records.keySet()) {
            if (!this.containsIgnoreCase(this.existentKeys, recordKey)) {
                results.add(new DiagnosticResult()
                        .setStatus(Constants.OK_STATUS)
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private List<DiagnosticResult> getExistentRecords() {
        List<DiagnosticResult> results = new List<DiagnosticResult>();
        for (String recordKey : this.records.keySet()) {
            if (this.containsIgnoreCase(this.existentKeys, recordKey)) {
                results.add(new DiagnosticResult()
                        .setStatus(Constants.DUPLICATED_STATUS)
                        .setRecordKey(recordKey)
                        .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    private Boolean containsIgnoreCase(Set<String> existentKeys, String key) {
        for (String str : existentKeys) {
            if (key.equalsIgnoreCase(str)) {
                return true;
            }
        }
        return false;
    }

    @TestVisible
    private Set<String> getExistentKeys() {
        Set<String> result = new Set<String>();
        String query = this.buildQuery();
        List<SObject> existentRecords = Database.query(query);
        for (SObject sObj : existentRecords) {
            result.add(String.valueOf(sObj.get(this.externalIdApiName)));
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