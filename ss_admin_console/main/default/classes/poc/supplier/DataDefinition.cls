public inherited sharing class DataDefinition {
    public SObjectType objectType {get; private set;}
    public List<FieldReference> keyFields {get; private set;}
    public List<FieldReference> dataFields {get; private set;}

    public DataDefinition(SObjectType objectType, List<FieldReference> keyFields, List<FieldReference> dataFields) {
        this.objectType = objectType;
        this.keyFields = keyFields;
        this.dataFields = dataFields;
    }
}