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
        Schema.SObjectType parentSObjectType = supplier.getMetadata().referenceFields[0].referenceField.getDescribe().getReferenceTo()[0];
        fflib_SObjectUnitOfWork uow;
        if (supplier.getMetadata().referenceFields.isEmpty()) {
            uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {supplier.getMetadata().objectType});
        } else {
            uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {supplier.getMetadata().objectType, parentSObjectType});
        }
        UnitOfWorkHelper uowHelper = new UnitOfWorkHelper(uow, supplier);
        List<SSACResult> results = createDataFilter(supplier).filter();
        List<SObject> okResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.OK_STATUS));
        List<SObject> changedResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS));
        List<SObject> duplicatedResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS));
        List<SObject> recordsToUpsert = new List<SObject>();
        recordsToUpsert.addAll(okResults);
        recordsToUpsert.addAll(changedResults);
        if (updateRecords) {
            if (!recordsToUpsert.isEmpty()) {
                try {
                    uow = uowHelper.registerRecords(recordsToUpsert, supplier.getMetadata().referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(supplier.getMetadata().objectType), this.handleAmountOfRecordsProceed(recordsToUpsert.size()), SSACConstants.UPSERTED_STATUS);
                } catch (Exception e) {
                    logger.error(e.getMessage());
                }
            } else if (!duplicatedResults.isEmpty()) {
                logger.log(String.valueOf(supplier.getMetadata().objectType), this.handleAmountOfRecordsProceed(duplicatedResults.size()), SSACConstants.DUPLICATED_STATUS);
            } else {
                logger.error('FAILED: No records to be displayed. Check the sample data again.');
            }
        } else {
            if (!okResults.isEmpty()) {
                try {
                    uow = uowHelper.registerRecords(okResults, supplier.getMetadata().referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(supplier.getMetadata().objectType), this.handleAmountOfRecordsProceed(okResults.size()), SSACConstants.INSERTED_STATUS);
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

    @TestVisible
    private String handleAmountOfRecordsProceed(Integer size) {
        return String.valueOf(size) + ' records were proceed.';
    } 
}