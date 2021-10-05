public with sharing class SObjectDiagnosticAction implements IAction {
    private DiagnosticLogger logger;
    private Map<String, SObject> records;
    private String externalIdApiName;
    private String sObjectApiName;
    private String additionCondition;

    public SObjectDiagnosticAction(String sObjectApiName, Map<String, SObject> records, String externalIdApiName) {
        this.logger = new DiagnosticLogger();
        this.records = records;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
    }

    public SObjectDiagnosticAction(String sObjectApiName, Map<String, SObject> records,
            String externalIdApiName, String additionCondition) {
        this.logger = new DiagnosticLogger();
        this.records = records;
        this.externalIdApiName = externalIdApiName;
        this.sObjectApiName = sObjectApiName;
        this.additionCondition = additionCondition;
    }

    public List<DiagnosticResult> execute() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<DiagnosticResult>();
        }
        List<DiagnosticResult> filterResults = this.test();
        DiagnosticResultsUtil util = new DiagnosticResultsUtil();
        List<DiagnosticResult> okResults = util.getResultsByStatus(filterResults, Constants.OK_STATUS);
        Database.SaveResult[] saveResults = Database.insert(this.getRecords(okResults), false);
        List<DiagnosticResult> results = util.generateDiagnosticResults(saveResults, this.sObjectApiName);
        this.logger.generateLoadLog(results);
        return results;
    }

    public List<DiagnosticResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<DiagnosticResult>();
        }
        List<DiagnosticResult> results;
        if (this.additionCondition != null) {
            results = new DiagnosticFilter(this.sObjectApiName, this.records,
                    this.externalIdApiName, this.additionCondition).filter();
        } else {
            results = new DiagnosticFilter(
                    this.sObjectApiName, this.records,
                    this.externalIdApiName).filter();
        }
        this.logger.generateTestLog(results);
        return results;
    }

    @TestVisible
    private List<SObject> getRecords(List<DiagnosticResult> results) {
        List<SObject> records = new List<SObject>();
        for (DiagnosticResult result : results) {
            records.add(this.records.get(result.recordKey));
        }
        return records;
    }
}