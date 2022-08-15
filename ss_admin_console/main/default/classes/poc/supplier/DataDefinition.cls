public inherited sharing class DataDefinition {
    public SObjectType objectType {get; private set;}
    public List<FieldReference> keyFields {get; private set;}
    public List<FieldReference> dataFields {get; private set;}
    public List<ReferenceFieldDefinition> referenceFields {get; private set;}

    private DataDefinition() {}

    /*
    public DataDefinition(SObjectType objectType, List<FieldReference> keyFields, List<FieldReference> dataFields) {
        this(objectType, keyFields, dataFields, null);
    }

    public DataDefinition(SObjectType objectType, List<FieldReference> keyFields, List<FieldReference> dataFields,
            List<ReferenceFieldDefinition> referenceFields) {
        this.objectType = objectType;
        this.keyFields = keyFields;
        this.dataFields = dataFields;
        this.referenceFields = referenceFields;
    }
     */

    /**
     * Describes Lookup or Master-Detail field reference.
     */
    public class ReferenceFieldDefinition {
        public SObjectField referenceField {get; private set;}
        public List<FieldReference> referencedKeyFields {get; private set;}
    }

    public class DataDefinitionBuilder {
        public DataDefinitionBuilder(SObjectType objectType) {

        }

        public DataDefinitionBuilder addKeyField(String keyField) {
            return this;
        }

        public DataDefinitionBuilder addKeyField(SObjectField keyField) {
            return this;
        }

        public DataDefinitionBuilder addDataField(String dataField) {
            return this;
        }

        public DataDefinitionBuilder addDataField(SObjectField dataField) {
            return this;
        }

        public DataDefinitionBuilder addReferenceField(SObjectField referenceField, List<SObjectField> keyFields) {
            return this;
        }

        public DataDefinition build() {
            DataDefinition dd = new DataDefinition();
            dd.objectType = Account.SObjectType;

            return dd;
        }
    }
}