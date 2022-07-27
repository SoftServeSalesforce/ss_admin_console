public inherited sharing class StaticDataSupplier implements DataSupplier {

    private List<SObject> data;
    private List<FieldReference> keyFields = new List<FieldReference>();
    private List<FieldReference> dataFields = new List<FieldReference>();

    public StaticDataSupplier(List<String> keyFields, List<String> dataFields, List<SObject> data) {
        this.data = data;
        for (String field : keyFields) {
            this.keyFields.add(FieldReference.build(getListType(), field));
        }

        for (String field : dataFields) {
            this.dataFields.add(FieldReference.build(getListType(), field));
        }
    }

    public StaticDataSupplier(List<SObjectField> keyFields, List<SObjectField> dataFields, List<SObject> data) {
        this.data = data;
        for (SObjectField field : keyFields) {
            this.keyFields.add(FieldReference.build(field));
        }

        for (SObjectField field : dataFields) {
            this.dataFields.add(FieldReference.build(field));
        }
    }
    

    public List<SObject> supply() {
        return data;
    }

    public SObjectType getListType() {
        return data.getSObjectType();
    }

    public List<FieldReference> getKeyFields() {
        return keyFields;
    }

    public List<FieldReference> getDataFields() {
        return dataFields;
    }
}