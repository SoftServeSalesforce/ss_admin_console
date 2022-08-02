public inherited sharing class BaseDataFeeder implements DataFeeder{
    private DataSupplier supplier;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = new DataFilter(supplier).filter();
        List<SSACResult> allResults = this.getAllResults(util, results);
        if (updateRecords) {
            if (!allResults.isEmpty()) {
                Database.UpsertResult[] upsertResults = Database.upsert(this.setId(allResults), false);
                results = util.generateDiagnosticResultsUpsert(upsertResults, supplier.getMetadata().objectType);
                logger.generateLoadLog(results);
            }
        } else {
            if (!allResults.isEmpty()) {
                // Create a savepoint while AccountNumber is null
                Savepoint sp = Database.setSavepoint();
                try {
                    Database.UpsertResult[] upsertResults = Database.upsert(this.setId(allResults), false);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {
                    // Rollback to the previous null value
                    Database.rollback(sp);
                }
                logger.generateTestLog(results);
            }
        }
    }

    @TestVisible
    private List<SObject> setId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();
        Integer counter = 0;
        for (SObject item : supplier.supply()) {
            String recordKeysFingerprint = '';
            for (FieldReference keyField: supplier.getMetadata().keyFields) {
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