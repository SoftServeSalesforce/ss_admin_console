public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    private SSACResultsUtil util;

    @TestVisible
    private DataFilter mockedDF;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
    }

    private DataFilter createDataFilter(DataSupplier supplier) {
        if (mockedDF != null) {
            return mockedDF;
        }
        return new DataFilter(supplier);
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        LoggerAppender appender = new LoggerAppender(logger);
        List<SSACResult> results = createDataFilter(supplier).filter();
        List<SSACResult> okResults = util.getResultsByStatus(results, SSACConstants.OK_STATUS);
        List<SSACResult> changedResults = util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS);
        List<SSACResult> duplicatedResults = util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS);
        List<SSACResult> recordsToUpsert = new List<SSACResult>();
        recordsToUpsert.addAll(okResults);
        recordsToUpsert.addAll(changedResults);
        //fflib_SObjectUnitOfWork uow = new UnitOfWorkHelper(this.convertToSObject(recordsToUpsert), supplier).linkSObjects();
        if (updateRecords) {
            if (!recordsToUpsert.isEmpty()) {
                try {
                    Database.UpsertResult[] upsertedResults = Database.upsert(this.convertToSObject(recordsToUpsert));
                    appender.logUpsert(upsertedResults, duplicatedResults, supplier.getMetadata().objectType);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            } else {
                logger.error('FAILED: No records to be upserted. Check the sample data again.');
            }
        } else {
            if (!okResults.isEmpty()) {
                try {
                    Database.SaveResult[] insertedResults = Database.insert(this.convertToSObject(okResults));
                    appender.logInsert(insertedResults, supplier.getMetadata().objectType);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            } else {
                logger.error('FAILED: No records to be inserted. Check the sample data again.');
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

    public class LoggerAppender {
       
        private SSACResultsUtil util;
        private FeedLogger logger;
        public LoggerAppender(FeedLogger logger) {
            this.util = new SSACResultsUtil();
            this.logger = logger;
        }

        public void logUpsert(Database.UpsertResult[] upsertedResults, List<SSACResult> duplicatedResults, Schema.SObjectType sObjectType) {
            List<SSACResult> upsertedRecords = new List<SSACResult>();
            if (!duplicatedResults.isEmpty()) {
                logger.log(String.valueOf(sObjectType), this.handleMessageText(duplicatedResults), SSACConstants.DUPLICATED_STATUS);
            }
            for (Database.UpsertResult result : upsertedResults) {
                if (result.isSuccess()) {
                    upsertedRecords.add(new SSACResult()
                            .setStatus(SSACConstants.UPDATED_STATUS)
                            .setRecordId(result.getId())
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    logger.log(String.valueOf(sObjectType), this.handleMessageUpsertedText(upsertedRecords), SSACConstants.UPSERTED_STATUS);
                } else {
                    String errorMessage = '';
                    for (Database.Error err : result.getErrors()) {
                        errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                                + String.valueOf(sObjectType) + ' fields that affected this error: ' + err.getFields() + '. ';
                    }
                    upsertedRecords.add(new SSACResult()
                            .setStatus(SSACConstants.FAILED_STATUS)
                            .setErrorMessage(errorMessage)
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    logger.error(util.errorsToString(upsertedRecords));
                }
            }
        }

        public void logInsert(Database.SaveResult[] savedResulits, Schema.SObjectType sObjectType) {
            List<SSACResult> insertedResults = new List<SSACResult>();
            for (Database.SaveResult result : savedResulits) {
                if (result.isSuccess()) {
                    insertedResults.add(new SSACResult()
                            .setStatus(SSACConstants.INSERTED_STATUS)
                            .setRecordId(result.getId())
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    System.debug(String.valueOf(sObjectType) +', '+ this.handleMessageUpsertedText(insertedResults) +', '+ SSACConstants.INSERTED_STATUS);
                    logger.log(String.valueOf(sObjectType), this.handleMessageUpsertedText(insertedResults), SSACConstants.INSERTED_STATUS);
                } else {
                    String errorMessage = '';
                    for (Database.Error err : result.getErrors()) {
                        errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                                + String.valueOf(sObjectType) + ' fields that affected this error: ' + err.getFields() + '. ';
                    }
                    insertedResults.add(new SSACResult()
                            .setStatus(SSACConstants.FAILED_STATUS)
                            .setErrorMessage(errorMessage)
                            .setSObjectApiName(sObjectType.getDescribe().getName()));
                    logger.error(util.errorsToString(insertedResults));
                }
            }
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