public inherited sharing class SSACSObjectAction implements ISSACAction {
    private SSACLogger logger;
    private SObjectType sObjectApiName;
    private List<SObject> records;
    private Boolean generateTestLog;

    private List<FieldReference> keyFields = new List<FieldReference>();
    private List<FieldReference> dataFields = new List<FieldReference>();

    public SSACSObjectAction(SObjectType sObjectApiName, List<SObject> records, List<SObjectField> keyFields, List<SObjectField> dataFields) {
        this.logger = new SSACLogger();
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;

        for (SObjectField field : keyFields) {
            this.keyFields.add(FieldReference.build(field));
        }

        for (SObjectField field : dataFields) {
            this.dataFields.add(FieldReference.build(field));
        }
    }

    public SSACSObjectAction(SObjectType sObjectApiName, List<SObject> records, List<String> keyFields, List<String> dataFields) {
        this.logger = new SSACLogger();
        this.records = records;
        this.sObjectApiName = sObjectApiName;
        this.generateTestLog = true;

        for (String field : keyFields) {
            this.keyFields.add(FieldReference.build(field));
        }

        for (String field : dataFields) {
            this.dataFields.add(FieldReference.build(field));
        }
    }

    public List<SSACResult> test() {
        if (this.records == null || this.records.isEmpty()) {
            return new List<SSACResult>();
        }
        List<SSACResult> results = new SSACDataFilter(this.sObjectApiName, this.keyFields, this.dataFields).filter(this.records);
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
			String recordKeysFingerprint = '';
			for (FieldReference keyField: this.keyFields) {
                recordKeysFingerprint += String.valueOf(keyField.getFrom(item)).toLowerCase() + '_';
			}
			recordKeysFingerprint = recordKeysFingerprint.removeEnd('_');
			for (SSACResult result : results) {
				if (recordKeysFingerprint == result.recordKey) {
					item.put('Id', result.recordId);
					records.add(item);
				}
			}
		}
        return records;
    }

	@TestVisible
	private List<SSACResult> getAllResults(SSACResultsUtil util, List<SSACResult> filterResults) {
		List<SSACResult> allResults = new List<SSACResult>();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
		allResults.addAll(okResults);
        allResults.addAll(changedResults);
		return allResults;
	}
}
