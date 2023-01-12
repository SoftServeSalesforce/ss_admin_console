public inherited sharing class BaseDataFeeder implements DataFeeder {
    private final DataSupplier supplier;
    private final DataDefinition metadata;
    private final SObjectType parentObjectType;

    @TestVisible
    private DataFilter mockedDF;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
        this.metadata = supplier.getMetadata();
        if (!metadata.referenceFields.isEmpty()) {
            this.parentObjectType = metadata.referenceFields[0].referenceField.getDescribe().getReferenceTo()[0];
        }
    }

    private DataFilter createDataFilter(DataDefinition metadata, List<SObject> records) {
        if (mockedDF != null) {
            return mockedDF;
        }
        return new DataFilter(metadata, records);
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        fflib_ISObjectUnitOfWork uow;
        DataDefinition metadata = supplier.getMetadata();
        if (metadata.referenceFields.isEmpty()) {
            uow = ApplicationFactories.UNIT_OF_WORK.newInstance(new Schema.SObjectType[] {metadata.objectType});
        } else {
            uow = ApplicationFactories.UNIT_OF_WORK.newInstance(new Schema.SObjectType[] {metadata.objectType, parentObjectType});
        }
        UnitOfWorkHelper uowHelper = new UnitOfWorkHelper(uow, supplier);
        List<SSACResult> results = createDataFilter(metadata, supplier.supply()).filter();
        List<SObject> okResults = assignId(util.getResultsByStatus(results, ApexActionStatus.OK.value()));
        List<SObject> changedResults = assignId(util.getResultsByStatus(results, ApexActionStatus.CHANGED.value()));
        List<SObject> duplicatedResults = assignId(util.getResultsByStatus(results, ApexActionStatus.DUPLICATED.value()));
        List<SObject> recordsToUpsert = new List<SObject>();
        recordsToUpsert.addAll(okResults);
        recordsToUpsert.addAll(changedResults);
        if (updateRecords) {
            if (!recordsToUpsert.isEmpty()) {
                try {
                    uowHelper.registerRecords(recordsToUpsert, metadata.referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(metadata.objectType), this.handleAmountOfRecordsProceed(okResults.size()), ApexActionStatus.INSERTED.value());
                    logger.log(String.valueOf(metadata.objectType), this.handleAmountOfRecordsProceed(changedResults.size()), ApexActionStatus.UPDATED.value());
                } catch (Exception e) {
                   logger.error(e.getMessage());
                }
            } else if (!duplicatedResults.isEmpty()) {
                logger.log(String.valueOf(metadata.objectType), this.handleAmountOfRecordsProceed(duplicatedResults.size()), ApexActionStatus.DUPLICATED.value());
            } else {
                logger.error('FAILED: No records to be displayed. Check the sample data again.');
            }
        } else {
            if (!okResults.isEmpty()) {
                try {
                    uowHelper.registerRecords(okResults, supplier.getMetadata().referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(metadata.objectType), this.handleAmountOfRecordsProceed(okResults.size()), ApexActionStatus.INSERTED.value());
                } catch (Exception e) {
                   logger.error(e.getMessage());
                }
            } else {
                logger.error('FAILED: No records to be inserted. Check the sample data again.');
            }
        }
    }

    @TestVisible
    private List<SObject> assignId(List<SSACResult> results) {
        List<SObject> records = new List<SObject>();

        Map<String, SSACResult> recordKeyToId = new Map<String, SSACResult>();
        for (SSACResult result : results) {
            recordKeyToId.put(result.recordKey, result);
        }

        for (SObject record : supplier.supply()) {
            RecordKey recordKey = new RecordKey(metadata.keyFields, record);
            SSACResult result = recordKeyToId.get(recordKey.toString());
            if (result != null) {
                record.Id = result.recordId;
                records.add(record);
            }
        }
        return records;
    }

    @TestVisible
    private String handleAmountOfRecordsProceed(Integer size) {
        return String.valueOf(size) + ' records were proceed.';
    }
}