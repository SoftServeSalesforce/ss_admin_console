public with sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private Map<String, SObject> records;
	private String keyFieldApiName;
    private Set<String> externalIdApiNames;
    private Set<String> externalFields;
    private String sObjectApiName;
    private String additionCondition;
    private Boolean generateTestLog;

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, String keyFieldApiName, Set<String> externalIdApiNames, Set<String> externalFields) {
        this.logger = new SSACLogger();
        this.records = records;
		this.keyFieldApiName = keyFieldApiName;
        this.externalFields = externalFields;
        this.externalIdApiNames = externalIdApiNames;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;
    }

    public SSACSObjectAction(String sObjectApiName, Map<String, SObject> records, String keyFieldApiName, Set<String> externalIdApiNames, Set<String> externalFields, String additionCondition) {
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
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records, this.keyFieldApiName, this.externalIdApiNames, this.externalFields, this.additionCondition).filter();
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
        return records;
    }

	@TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        Map<String, SObject> records = new Map<String, SObject>();
        Integer counter = 0;
        for (SSACResult result : results) {
            for (String item : this.records.keySet()) {
                if(item == result.recordKey) {
                    this.records.get(item).put('Id', results.get(counter).recordId);
                    counter = results.size() - 1 > counter ? ++counter : 0;
                    records.put(item, this.records.get(item));
                }
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
