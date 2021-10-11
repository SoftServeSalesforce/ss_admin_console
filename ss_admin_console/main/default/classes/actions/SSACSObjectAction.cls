public with sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private String additionCondition;

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, String externalIdApiName) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
    }

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records,
            String externalIdApiName, String additionCondition) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
        this.additionCondition = additionCondition;
    }

    public List<SSACResult> execute() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> filterResults = this.test();
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, Constants.OK_STATUS);
        Database.SaveResult[] saveResults = Database.insert(this.getRecords(okResults), false);
        List<SSACResult> results = util.generateDiagnosticResults(saveResults, this.sObjectApiName);
        this.logger.generateLoadLog(results);
        return results;
    }

    public List<SSACResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records,
                this.externalIdApiName, this.additionCondition).filter();
        logger.generateTestLog(results);
        return results;
    }

    @TestVisible
    private List<SObject> getRecords(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        for (SSACResult result : results) {
            records.add(this.records.get(result.recordKey));
        }
        return records;
    }
}