public with sharing class DataFilter {
    private DataSupplier supplier;
    private List<FieldReference> keyFields;
    private List<FieldReference> dataFields;
    private SObjectType objectType;

    public DataFilter(DataSupplier supplier) {
        this.supplier = supplier;

        DataDefinition metadata = supplier.getMetadata();
        this.keyFields = metadata.keyFields;
        this.dataFields = metadata.dataFields;
        this.objectType = metadata.objectType;
    }
}
