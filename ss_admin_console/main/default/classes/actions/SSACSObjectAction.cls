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
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records, this.externalIdApiNames, this.externalFields, this.additionCondition).filter();
        if (this.generateTestLog) {
            logger.generateTestLog(results);
        }
        return results;
    }

	@TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        Integer counter = 0;
		for (SObject item : this.records.values()) {
			String concatenatedString = '';
			for (String keyField: this.externalIdApiNames) {
				if (keyField.contains('.')) {
					List<String> splittedField = keyField.split('\\.');
					String nextField = splittedField[1];
					concatenatedString += String.valueOf(item.getSObject(splittedField[0]).get(nextField)).toLowerCase() + '_';	
				} else {
                	concatenatedString += String.valueOf(item.get(keyField)).toLowerCase() + '_';	
				}
			}
			concatenatedString = concatenatedString.removeEnd(concatenatedString.right(1));
			for (SSACResult result : results) {
				if (concatenatedString == result.recordKey) {
					item.put('Id', result.recordId);
					records.add(item);
				}
			}
		}
        return records;
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
