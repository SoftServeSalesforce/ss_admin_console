public with sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private Map<String, SObject> records;
    private List<String> externalIdApiNames;
    private List<String> externalFields;
    private String sObjectApiName;
    private String additionCondition;
    private Boolean generateTestLog;

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, List<String> externalIdApiNames, List<String> externalFields) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalFields = externalFields;
        this.externalIdApiNames = externalIdApiNames;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;
    }

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, List<String> externalIdApiNames, List<String> externalFields, String additionCondition) {
        this.logger = new SSACLogger();
        this.records = records;
        this.externalFields = externalFields;
        this.externalIdApiNames = externalIdApiNames;
        this.sObjectApiName = sObjectApiName;
        this.additionCondition = additionCondition;
        this.generateTestLog = true;
    }
 
    public List<SSACResult> execute() {
		List<SSACResult> results = new List<SSACResult>();
		SSACResultsUtil util = new SSACResultsUtil();
        this.generateTestLog = false;
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
		List<SSACResult> filterResults = this.test();
		List<SSACResult> allResults = this.getAllResults(util, filterResults);
		if (!allResults.isEmpty()) {
			Database.UpsertResult[] upsertResults = Database.upsert(this.setId(allResults), false);
			results = util.generateDiagnosticResultsUpsert(upsertResults, this.sObjectApiName);
		}else {
            results = util.getResultsByStatus(filterResults, SSACConstants.DUPLICATED_STATUS);
        }
        this.logger.generateLoadLog(results);
        return results;
    }


    public List<SSACResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records, this.externalIdApiNames, this.externalFields, this.additionCondition).filter();
        if (this.generateTestLog) {
            logger.generateTestLog(results);
        }
        return results;
    }

	@TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        Map<String, SObject> records = new Map<String, SObject>();
        Integer counter = 0;
        for (SSACResult result : results) {
			if(result.recordKey != null){
				this.records.get(result.recordKey).put('Id', results.get(counter).recordId);
				counter = results.size() - 1 > counter ? ++counter : 0;
				records.put(result.recordKey, this.records.get(result.recordKey));
			}
        }
        return records.values();
    }

	@TestVisible
	private List<SSACResult> getAllResults(SSACResultsUtil util, List<SSACResult> filterResults){
		List<SSACResult> allResults = new List<SSACResult>();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
		allResults.addAll(okResults);
        allResults.addAll(changedResults);
		return allResults;
	}
}
