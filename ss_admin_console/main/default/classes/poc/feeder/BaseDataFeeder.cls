public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    SSACResultsUtil util;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
        
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = new DataFilter(supplier).filter();
        List<SSACResult> resultsToUpsert = this.getResultsToUpsert(util, results);
        if (updateRecords) {
            if (!resultsToUpsert.isEmpty()) {
                Database.UpsertResult[] upsertResults = Database.upsert(this.setId(resultsToUpsert), false);
                //new LoggerConnector().logTest(upsertResults, supplier.getMetadata().objectType, logger);
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
            new LoggerConnector().logTest(results, supplier.getMetadata().objectType, logger);
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
    private List<SSACResult> getResultsToUpsert(SSACResultsUtil util, List<SSACResult> filterResults) {
        List<SSACResult> resultsToUpsert = new List<SSACResult>();
        List<SSACResult> okResults = util.getResultsByStatus(filterResults, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(filterResults, SSACConstants.CHANGED_STATUS);
        resultsToUpsert.addAll(okResults);
        resultsToUpsert.addAll(changedResults);
        return resultsToUpsert;
    }

    public class LoggerConnector {
       
        SSACResultsUtil util;
        public LoggerConnector() {
            this.util = new SSACResultsUtil();
        }
        public void logTest(List<SSACResult> results, Schema.SObjectType sObjectType, FeedLogger logger) {
            Map<String, List<SSACResult>> resultsByStatus = new Map<String, List<SSACResult>>();
            resultsByStatus.put(this.handleDuplicateMessageTitle(String.valueOf(sObjectType)), this.util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS));
            resultsByStatus.put(this.handleValidRecordsMessageTitle(String.valueOf(sObjectType)), this.util.getResultsByStatus(results, SSACConstants.OK_STATUS));
            resultsByStatus.put(this.handleChangedMessageTitle(String.valueOf(sObjectType)), this.util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS));
            for (String result : resultsByStatus.keySet()) {
                System.debug(resultsByStatus);
                if (resultsByStatus.get(result) != null || resultsByStatus.get(result).isEmpty()) {
                    logger.log(result, sObjectType, resultsByStatus.get(result).get(0).status, SSACConstants.TEST_ACTION_TYPE);
                }
            }
        }

        @TestVisible
        private String handleValidRecordsMessageTitle(String sObjectApiName) {
            return 'The following ' + sObjectApiName + '\'s records should be inserted: ';
        }

        @TestVisible
        private String handleDuplicateMessageTitle(String sObjectApiName) {
            return 'The following ' + sObjectApiName + '\'s records already exist: ';
        }

        @TestVisible
        private String handleChangedMessageTitle(String sObjectApiName) {
            return 'The following ' + sObjectApiName + '\'s records could be updated: ';
        }
        @TestVisible
        private String handleSuccessUpsertMessageTitle(String sObjectApiName) {
            return 'Successfully upserted ' + sObjectApiName + '\'s records. ';
        }
        @TestVisible
        private String handleAmountOfRecordsProceed(Integer size) {
            return String.valueOf(size) + ' records were proceed.';
        }

        @TestVisible
        private String handleAmountOfRecordsTested(Integer size) {
            return String.valueOf(size) + ' records were tested.';
        }
    }
}