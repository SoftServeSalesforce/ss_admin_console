public inherited sharing class StaticDataSupplier implements DataSupplier {
    private DataDefinition metadata;
    private List<SObject> data;

    public StaticDataSupplier(List<String> keyFields, List<String> dataFields, List<SObject> data) {
        // TODO verify input parameters
        SObjectType objectType = data.getSObjectType();
        if (data != null && !data.isEmpty() 
            && keyFields !=  null && !keyFields.isEmpty()
            && dataFields !=  null && !dataFields.isEmpty()) {
            this.data = data;
        } else {
            throw new EmptyDataException('Data can not be null or empty!');
        }
        this.metadata = new DataDefinition(objectType, toFieldReferences(objectType, keyFields), toFieldReferences(objectType, dataFields));
    }

    public StaticDataSupplier(List<SObjectField> keyFields, List<SObjectField> dataFields, List<SObject> data) {
        if (data != null && !data.isEmpty() 
            && keyFields !=  null && !keyFields.isEmpty()
            && dataFields !=  null && !dataFields.isEmpty()) {
            this.data = data;
        } else {
            throw new EmptyDataException('Data can not be null or empty!');
        }
        this.metadata = new DataDefinition(data.getSObjectType(), toFieldReferences(keyFields), toFieldReferences(dataFields));
    }

    public List<SObject> supply() {
        return data;
    }

    public DataDefinition getMetadata() {
        return metadata;
    }

    private static List<FieldReference> toFieldReferences(SObjectType objectType, List<String> fields) {
        List<FieldReference> result = new List<FieldReference>();
        for (String field : fields) {
            result.add(FieldReference.build(objectType, field));
        }
        return result;
    }

    private static List<FieldReference> toFieldReferences(List<SObjectField> fields) {
        List<FieldReference> result = new List<FieldReference>();
        for (SObjectField field : fields) {
            result.add(FieldReference.build(field));
        }
        return result;
    }
}