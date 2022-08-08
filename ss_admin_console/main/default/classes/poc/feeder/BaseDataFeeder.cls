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
        if (checkOnly) {
            if (!results.isEmpty()) {
                Savepoint sp = Database.setSavepoint();
                try {
                    Database.upsert(this.convertToSObject(results), true);
                    new LoggerConnector().log(results, supplier.getMetadata().objectType, logger);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                } finally {
                    Database.rollback(sp);
                }
            }
        } else {
            if (!results.isEmpty()) {
                System.debug(this.convertToSObject(changedResults));
                System.debug(this.convertToSObject(okResults));
                try {
                    if (updateRecords) {
                        System.debug('here');
                        System.debug(this.convertToSObject(changedResults));
                        Database.SaveResult[] updatedResults = Database.update(this.convertToSObject(changedResults), true);
                        new LoggerConnector().logUpsert(updatedResults, supplier.getMetadata().objectType, logger, updateRecords);
                    } else {
                        System.debug('here');
                        Database.SaveResult[] insertedResults = Database.insert(this.convertToSObject(okResults), true);
                        new LoggerConnector().logUpsert(insertedResults, supplier.getMetadata().objectType, logger, updateRecords);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
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
                if (resultsByStatus.get(status) != null && !resultsByStatus.get(status).isEmpty()) {
                    if (status == SSACConstants.FAILED_STATUS) {
                        logger.log(this.handleMessageTitle(String.valueOf(sObjectType), status), util.errorsToString(resultsByStatus.get(status)), status);
                    } else if (status == SSACConstants.UPDATED_STATUS || status == SSACConstants.INSERTED_STATUS) {
                        logger.log(this.handleMessageTitle(String.valueOf(sObjectType), status), this.handleMessageUpsertedText(resultsByStatus.get(status)), status);
                    } else {
                        logger.log(this.handleMessageTitle(String.valueOf(sObjectType), status), this.handleMessageText(resultsByStatus.get(status)), status);
                    }
                }
            }
        }

        public void logUpsert(Database.SaveResult[] updatedResults, Schema.SObjectType sObjectType, FeedLogger logger, Boolean updateResults) {
            List<SSACResult> results = new List<SSACResult>();
            for (Database.SaveResult result : updatedResults) {
                if (result.isSuccess()) {
                    if (updateResults) {
                    results.add(new SSACResult()
                            .setStatus(SSACConstants.UPDATED_STATUS)
                            .setRecordId(result.getId())
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                    } else {
                        results.add(new SSACResult()
                        .setStatus(SSACConstants.INSERTED_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectType.getDescribe().getName()));
                    log(results, sObjectType, logger);
                    }
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

        //TODO: replace it to lwc
        @TestVisible
        private String handleMessageTitle(String sObjectApiName, String status) {
            if (status == SSACConstants.DUPLICATED_STATUS) {
                return 'The following ' + sObjectApiName + '\'s records already exist: ';
            } else if (status == SSACConstants.OK_STATUS) {
                return 'The following ' + sObjectApiName + '\'s records should be inserted: ';
            } else if (status == SSACConstants.CHANGED_STATUS) {
                return 'The following ' + sObjectApiName + '\'s records could be updated: ';
            } else if (status == SSACConstants.INSERTED_STATUS) {
                return 'Successfully inserted ' + sObjectApiName + '\'s records. ';    
            } else if (status == SSACConstants.UPDATED_STATUS) {
                return 'Successfully updated ' + sObjectApiName + '\'s records. ';
            } else {
                return 'Error occured: ';
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