public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    SSACResultsUtil util;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
    }

    public void feed(Boolean updateRecords, Boolean checkOnly, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> results = new DataFilter(supplier).filter();
        List<SSACResult> okResults = util.getResultsByStatus(results, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS);
        List<SSACResult> recordsToUpsert = new List<SSACResult>();
        recordsToUpsert.addAll(okResults);
        recordsToUpsert.addAll(changedResults);
        fflib_SObjectUnitOfWork uow = new UnitOfWorkHelper().linkSObjects(this.convertToSObject(recordsToUpsert), supplier.getMetadata().objectType);
        if (updateRecords) {
            if (!results.isEmpty()) {
                try {
                    Database.UpsertResult[] upsertedResults = Database.upsert(this.convertToSObject(recordsToUpsert));
                    if (checkOnly) {
                        new LoggerConnector().log(results, supplier.getMetadata().objectType, logger);
                    } else {
                        if (!recordsToUpsert.isEmpty()){
                            new LoggerConnector().logUpsert(upsertedResults, supplier.getMetadata().objectType, logger);
                        } else {
                            logger.log(String.valueOf(supplier.getMetadata().objectType), 'No records to be upserted.', 'FAILED');
                        }
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            }
        } else {
            if (!recordsToUpsert.isEmpty()) {
                try {
                    Database.SaveResult[] insertedResults = Database.insert(this.convertToSObject(okResults));
                    new LoggerConnector().logInsert(insertedResults, supplier.getMetadata().objectType, logger);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            } else {
                logger.log(String.valueOf(supplier.getMetadata().objectType), 'No records to be inserted.', 'FAILED');
            }
        }
    }

    @TestVisible
    private List<SObject> convertToSObject(List<SSACResult> results) {
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

    public class LoggerConnector {
       
        SSACResultsUtil util;
        public LoggerConnector() {
            this.util = new SSACResultsUtil();
        }

        public void log(List<SSACResult> results, Schema.SObjectType sObjectType, FeedLogger logger) {
            Map<String, List<SSACResult>> resultsByStatus = genarateResultsMap(results);

            for (String status : resultsByStatus.keySet()) {
                List<SSACResult> res = resultsByStatus.get(status);
                if (res != null && !res.isEmpty()) {
                    if (status == SSACConstants.FAILED_STATUS) {
                        logger.error(util.errorsToString(res));
                    } else if (status == SSACConstants.UPDATED_STATUS || status == SSACConstants.INSERTED_STATUS) {
                        logger.log(String.valueOf(sObjectType), this.handleMessageUpsertedText(res), status);
                    } else {
                        logger.log(String.valueOf(sObjectType), this.handleMessageText(res), status);
                    }
                } 
            }
        }

        public void logUpsert(Database.UpsertResult[] upsertedResults, Schema.SObjectType sObjectType, FeedLogger logger) {
            List<SSACResult> results = new List<SSACResult>();
            for (Database.UpsertResult result : upsertedResults) {
                if (result.isSuccess()) {
                    results.add(new SSACResult()
                            .setStatus(SSACConstants.UPDATED_STATUS)
                            .setRecordId(result.getId())
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                } else {
                    String errorMessage = '';
                    for (Database.Error err : result.getErrors()) {
                        errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                                + String.valueOf(sObjectType) + ' fields that affected this error: ' + err.getFields() + '. ';
                    }
                    results.add(new SSACResult()
                            .setStatus(SSACConstants.FAILED_STATUS)
                            .setErrorMessage(errorMessage)
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                }
            }
        }

        public void logInsert(Database.SaveResult[] savedResulits, Schema.SObjectType sObjectType, FeedLogger logger) {
            List<SSACResult> results = new List<SSACResult>();
            for (Database.SaveResult result : savedResulits) {
                if (result.isSuccess()) {
                    results.add(new SSACResult()
                            .setStatus(SSACConstants.INSERTED_STATUS)
                            .setRecordId(result.getId())
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                } else {
                    String errorMessage = '';
                    for (Database.Error err : result.getErrors()) {
                        errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                                + String.valueOf(sObjectType) + ' fields that affected this error: ' + err.getFields() + '. ';
                    }
                    results.add(new SSACResult()
                            .setStatus(SSACConstants.FAILED_STATUS)
                            .setErrorMessage(errorMessage)
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                }
            }
        }

        private Map<String, List<SSACResult>> genarateResultsMap(List<SSACResult> results) {
            Map<String, List<SSACResult>> resultsByStatus = new Map<String, List<SSACResult>>();
            resultsByStatus.put(SSACConstants.DUPLICATED_STATUS, this.util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS));
            resultsByStatus.put(SSACConstants.OK_STATUS, this.util.getResultsByStatus(results, SSACConstants.OK_STATUS));
            resultsByStatus.put(SSACConstants.CHANGED_STATUS, this.util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS));
            resultsByStatus.put(SSACConstants.UPDATED_STATUS, this.util.getResultsByStatus(results, SSACConstants.UPDATED_STATUS));
            resultsByStatus.put(SSACConstants.INSERTED_STATUS, this.util.getResultsByStatus(results, SSACConstants.INSERTED_STATUS));
            resultsByStatus.put(SSACConstants.FAILED_STATUS, this.util.getResultsByStatus(results, SSACConstants.FAILED_STATUS));
            return resultsByStatus;
        }

        @TestVisible
        private String handleMessageText(List<SSACResult> results) {
            return results.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.keysToString(results) : this.handleAmountOfRecordsProceed(results.size());
        }

        @TestVisible
        private String handleMessageUpsertedText(List<SSACResult> results) {
            return results.size() < SSACConstants.MAX_RECORDS_PER_PAGE ? this.util.idsToString(results) : this.handleAmountOfRecordsProceed(results.size());
        }

        @TestVisible
        private String handleAmountOfRecordsProceed(Integer size) {
            return String.valueOf(size) + ' records were proceed.';
        }
    }
}