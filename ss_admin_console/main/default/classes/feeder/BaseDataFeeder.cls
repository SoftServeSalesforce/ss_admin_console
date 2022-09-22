public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    private DataDefinition metadata;
    private SObjectType objectType;
    private SObjectType parentObjectType;
    private List<FieldReference> keyFields; 
    private List<FieldReference> dataFields; 
    private SSACResultsUtil util;

    @TestVisible
    private DataFilter mockedDF;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
        this.metadata = supplier.getMetadata();
        this.objectType = metadata.objectType;
        if (!metadata.referenceFields.isEmpty()) {
            this.parentObjectType = metadata.referenceFields[0].referenceField.getDescribe().getReferenceTo()[0];
        }
        this.keyFields = metadata.keyFields;
        this.dataFields = metadata.dataFields;
    }

    private DataFilter createDataFilter(DataSupplier supplier) {
        if (mockedDF != null) {
            return mockedDF;
        }
        return new DataFilter(supplier);
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        SSACResultsUtil util = new SSACResultsUtil();
        fflib_SObjectUnitOfWork uow;
        DataDefinition metadata = supplier.getMetadata();
        if (metadata.referenceFields.isEmpty()) {
            uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {objectType});
        } else {
            uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {objectType, parentObjectType});
        }
        UnitOfWorkHelper uowHelper = new UnitOfWorkHelper(uow, supplier);
        List<SSACResult> results = createDataFilter(metadata, generateRecordsMap()).filter();
        List<SObject> okResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.OK_STATUS));
        List<SObject> changedResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.CHANGED_STATUS));
        List<SObject> duplicatedResults = this.convertToSObject(util.getResultsByStatus(results, SSACConstants.DUPLICATED_STATUS));
        List<SObject> recordsToUpsert = new List<SObject>();
        recordsToUpsert.addAll(okResults);
        recordsToUpsert.addAll(changedResults);
        if (updateRecords) {
            if (!recordsToUpsert.isEmpty()) {
                try {
                    uow = uowHelper.registerRecords(recordsToUpsert, metadata.referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(objectType), this.handleAmountOfRecordsProceed(okResults.size()), ApexActionStatus.INSERTED.value());
                    logger.log(String.valueOf(objectType), this.handleAmountOfRecordsProceed(changedResults.size()), ApexActionStatus.UPDATED.value());
                } catch (Exception e) {
                   logger.error(e.getMessage());
                }
            } else if (!duplicatedResults.isEmpty()) {
                logger.log(String.valueOf(objectType), this.handleAmountOfRecordsProceed(duplicatedResults.size()), SSACConstants.DUPLICATED_STATUS);
            } else {
                logger.error('FAILED: No records to be displayed. Check the sample data again.');
            }
        } else {
            if (!okResults.isEmpty()) {
                try {
                    uow = uowHelper.registerRecords(okResults, supplier.getMetadata().referenceFields.size(), logger);
                    uow.commitWork();
                    logger.log(String.valueOf(objectType), this.handleAmountOfRecordsProceed(okResults.size()), status);
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
        Map<RecordKey, SObject> recordsMap = generateRecordsMap();
        List<SObject> records = new List<SObject>();
        for (RecordKey item : recordsMap.keySet()) {
            for (SSACResult result : results) {
                if (item.hashCode() == result.recordKey) {
                    recordsMap.get(item).Id = result.recordId;
                    records.add(recordsMap.get(item));
                }
            }
        }
        return records;
    }

    @TestVisible
    private String handleAmountOfRecordsProceed(Integer size) {
        return String.valueOf(size) + ' records were proceed.';
    } 

    @TestVisible
    private Map<RecordKey, SObject> generateRecordsMap() {
        Map<RecordKey, SObject> recordsMap = new Map<RecordKey, SObject>();
        for (SObject item : supplier.supply()) {
            recordsMap.put(new RecordKey(metadata.keyFields, item), item);
        }
        return recordsMap;
    }
}