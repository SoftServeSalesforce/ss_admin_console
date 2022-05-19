public with sharing class SSACFilter {
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private Set<String> additionCondition;
    private Set<String> keys;
    private Set<String> existentKeys;
    private List<SObject> existentSObjects;

    public SSACFilter(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, Set<String> additionCondition) {
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.externalIdApiName = externalIdApiName;
        this.additionCondition = additionCondition;
        if (records != null && !records.isEmpty()) {
            this.keys = records.keySet();
            this.existentKeys = this.getExistentSObjects().keySet();
            this.existentSObjects = this.getExistentSObjects().values();
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
    private List<SSACResult> getExistentChangedRecords() {
        List<SSACResult> results = new List<SSACResult>();
        if(existentKeys.isEmpty()) {
            return new List<SSACResult>();
        }
        for (String recordKey : this.records.keySet()) {
            //need to replace condition
            if (!existentKeys.contains(String.valueOf(this.records.get(recordKey).get(this.externalIdApiName)).toLowerCase())) {
                results.add(new SSACResult()
                    .setStatus(SSACConstants.CHANGED_STATUS)
                    .setRecordKey(recordKey)
                    .setSObjectApiName(this.sObjectApiName));
            }
        }
        return results;
    }

    @TestVisible
    public Map<String, SObject> getExistentSObjects() {
        Map<String, SObject> result = new Map<String, SObject>();
        String query = this.buildQuery();
        List<SObject> existentRecords = Database.query(query);
        for (SObject sObj : existentRecords) {
            result.put((String.valueOf(sObj.get(this.externalIdApiName)).toLowerCase()), sObj);
        }
        return result;
    }

    @TestVisible
    private String buildQuery() {
        String result = 'SELECT Id,'+ this.externalIdApiName+ ',';
        if(this.additionCondition != null){
            for (String additionCondition : this.additionCondition) {
                result += additionCondition + ',';
            }
        }
            result = result.removeEnd(result.right(1));
        result += ' FROM '+ this.sObjectApiName + ' WHERE ';
            result += this.externalIdApiName + ' IN (';
            for (String externalId : this.keys) {
                result += '\'' + externalId + '\',';
            }
            result = result.removeEnd(result.right(1)) + ')';
            System.debug(result);
        return result;
    }
}