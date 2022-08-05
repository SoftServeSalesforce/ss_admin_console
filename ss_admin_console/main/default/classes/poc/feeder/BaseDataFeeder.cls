public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = new DataFilter(supplier).filter();
        List<SSACResult> resultsToUpsert = this.getresultsToUpsert(util, results);
        if (updateRecords) {
            if (!resultsToUpsert.isEmpty()) {
                Database.UpsertResult[] upsertResults = Database.upsert(this.setId(resultsToUpsert), false);
                logger.log(upsertResults, supplier.getMetadata().objectType);
            }
        } else {
            if (!resultsToUpsert.isEmpty()) {
                Savepoint sp = Database.setSavepoint();
                try {
                    Database.upsert(this.setId(resultsToUpsert), false);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {
                    Database.rollback(sp);
                }
            }
            logger.log(results);
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
    private List<SSACResult> getresultsToUpsert(SSACResultsUtil util, List<SSACResult> filterResults) {
        List<SSACResult> resultsToUpsert = new List<SSACResult>();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
        resultsToUpsert.addAll(okResults);
        resultsToUpsert.addAll(changedResults);
        return resultsToUpsert;
    }
}