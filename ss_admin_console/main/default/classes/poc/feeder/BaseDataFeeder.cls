public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    private FeedLogger logger;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;
    private SObjectType sObjectApiName;

    public BaseDataFeeder(DataSupplier supplier, List<FieldReference> keyFields, List<FieldReference> dataFields, FeedLogger logger) {
        this.supplier = supplier;
        this.logger = logger;
        this.keyFields = keyFields;
        this.datafields = dataFields;
        this.sObjectApiName = supplier.getListType();
    }

    public void feed(Boolean updateRecords) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = new DataFilter(supplier, keyFields, dataFields).filter();
        List<SSACResult> allResults = this.getAllResults(util, results);
        if (updateRecords) { 
            if (!allResults.isEmpty()) {
                Database.UpsertResult[] upsertResults = Database.upsert(this.setId(allResults), false);
                results = util.generateDiagnosticResultsUpsert(upsertResults, this.sObjectApiName);
            }
            logger.generateLoadLog(results);
        } else {
            // TODO for Mykola: implement rollback 


            logger.generateTestLog(results);
        } 
    }

    @TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        Integer counter = 0;
        for (SObject item : supplier.supply()) {
            String recordKeysFingerprint = '';
            for (FieldReference keyField: this.keyFields) {
                recordKeysFingerprint += String.valueOf(keyField.getFrom(item)).toLowerCase() + '_';
            }
            recordKeysFingerprint = recordKeysFingerprint.removeEnd('_');
            for (SSACResult result : results) {
                if (recordKeysFingerprint == result.recordKey) {
                    item.Id = result.recordId;
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