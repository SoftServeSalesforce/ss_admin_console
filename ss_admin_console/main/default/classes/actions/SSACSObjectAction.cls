public with sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private Map<String, SObject> records;
    private String externalIdApiName;
    private Set<String> externalFields;
    private String sObjectApiName;
    private String additionCondition;
    private Boolean generateTestLog;

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, Set<String> externalFields) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalFields = externalFields;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;
    }

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, String externalIdApiName, Set<String> externalFields, String additionCondition) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalFields = externalFields;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
        this.additionCondition = additionCondition;
        this.generateTestLog = true;
    }
    //TODO Add update/upsert feature 
    public List<SSACResult> execute() {
        this.generateTestLog = false;
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> filterResults = this.test();
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
        List<SSACResult> results = new List<SSACResult>();
        System.debug(changedResults);
        if (!okResults.isEmpty()) {
            Database.SaveResult[] saveResults = Database.insert(this.getRecords(okResults), false);
            results = util.generateDiagnosticResultsInsert(saveResults, this.sObjectApiName);
        } else if (!changedResults.isEmpty()) {
            Database.SaveResult[] updateResults = Database.update(this.setId(changedResults), false);
            results = util.generateDiagnosticResultsUpdated(updateResults, this.sObjectApiName);
        } else {
            results = util.getResultsByStatus(filterResults, SSACConstants.DUPLICATED_STATUS);
        }
        this.logger.generateLoadLog(results);
        return results;
    }


    public List<SSACResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records, this.externalIdApiName, this.externalFields, this.additionCondition).filter();
        if (this.generateTestLog) {
            logger.generateTestLog(results);
        }
        return results;
    }

    @TestVisible
    private List<SObject> getRecords(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        for (SSACResult result : results) {
            records.add(this.records.get(result.recordKey));
        }
        System.debug(records);
        return records;
    }

    private List<SObject> setId(List<SSACResult> results) {
        Map<String, SObject> records = new Map<String, SObject>();
        Integer accountCounter = 0;
        for (SSACResult result : results) {
            for (String item : this.records.keySet()) {
                if(item == result.recordKey) {
                    this.records.get(item).put('Id', results.get(accountCounter).recordId);
                    accountCounter = results.size() - 1 > accountCounter ? ++accountCounter : 0;
                    records.put(item, this.records.get(item));
                }
            }
        }
        System.debug(records);
        return records.values();
    }
}
