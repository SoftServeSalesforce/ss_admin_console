public with sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private SObjectType sObjectApiName;
    private List<SObject> records;
    private List<SObjectField> keyFields;
    private List<SObjectField> allFields;
    private Boolean generateTestLog;

    public SSACSObjectAction(SObjectType sObjectApiName, List<SObject> records, List<SObjectField> keyFields, List<SObjectField> allFields) {
        this.logger = new SSACLogger();
        this.records = records;
        this.keyFields = keyFields;
        this.allFields = allFields;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;
    }

    public List<SSACResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new SSACFilter(this.sObjectApiName, this.records, this.keyFields, this.allFields).filter();
        if (this.generateTestLog) {
            logger.generateTestLog(results);
        }
        return results;
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

	@TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        Integer counter = 0;
		for (SObject item : this.records) {
			String concatenatedString = '';
			for (SObjectField keyField: this.keyFields) {
				if (String.valueof(keyField).contains('.')) {
					List<String> splittedField = String.valueOf(keyField).split('\\.');
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
