public inherited sharing class DataDefinition {
    public SObjectType objectType {get; private set;}
    public List<FieldReference> keyFields {get; private set;}
    public List<FieldReference> dataFields {get; private set;}
    public List<ReferenceFieldDefinition> referenceFields {get; private set;}

    private DataDefinition() {}

    /**
     * Describes Lookup or Master-Detail field reference.
     */
    public class ReferenceFieldDefinition {
        public SObjectField referenceField {get; private set;}
        public List<FieldReference> referencedKeyFields {get; private set;}
    }

    public class DataDefinitionBuilder {
        public SObjectType objectType;
        public List<FieldReference> keyFields = new List<FieldReference>();
        public List<FieldReference> dataFields = new List<FieldReference>();
        public List<ReferenceFieldDefinition> referenceFields = new List<ReferenceFieldDefinition>();

        public DataDefinitionBuilder(SObjectType objectType) {
            this.objectType = objectType;
        }

        public DataDefinitionBuilder addKeyField(String keyField) {
            keyFields.add(FieldReference.build(objectType, keyField));
            return this;
        }

        public DataDefinitionBuilder addKeyField(SObjectField keyField) {
            keyFields.add(FieldReference.build(keyField));
            return this;
        }

        public DataDefinitionBuilder addDataField(String dataField) {
            dataFields.add(FieldReference.build(objectType, dataField));
            return this;
        }

        public DataDefinitionBuilder addDataField(SObjectField dataField) {
            dataFields.add(FieldReference.build(dataField));
            return this;
        }

        public DataDefinitionBuilder addReferenceField(SObjectField referenceField, List<SObjectField> referencedKeyFields) {
            ReferenceFieldDefinition rfd = new ReferenceFieldDefinition();
            rfd.referenceField = referenceField;
            rfd.referencedKeyFields = toFieldReferences(referencedKeyFields);
            referenceFields.add(rfd);
            return this;
        }

        public DataDefinitionBuilder addReferenceField(SObjectField referenceField, List<String> referencedKeyFields) {
            ReferenceFieldDefinition rfd = new ReferenceFieldDefinition();
            if (referenceField != null) {
                rfd.referenceField = referenceField;
            } else {
                throw new IllegalArgumentException('ReferenceField parameter can not be null.');
            }
            if (referencedKeyFields != null && !referencedKeyFields.isEmpty()) {
                rfd.referencedKeyFields = toFieldReferences(objectType, referencedKeyFields);
            } else {
                throw new IllegalArgumentException('ReferenceKeyFields parameter can not be null or empty.');
            }
            referenceFields.add(rfd);
            return this;
        }

        public DataDefinition build() {
            DataDefinition dd = new DataDefinition();
            if (objectType != null) {
                dd.objectType = objectType;
            } else {
                throw new IllegalArgumentException('Objectype parameter can not be null.');
            }
            if (keyFields != null && !keyFields.isEmpty()) {
                dd.keyFields = keyFields;
            } else {
                throw new IllegalArgumentException('Keyfields parameter can not be null or empty.');
            }
            if (dataFields != null && !dataFields.isEmpty()) {
                dd.dataFields = dataFields;
            } else {
                throw new IllegalArgumentException('Datafields parameter can not be null or empty.');
            }
            dd.referenceFields = referenceFields;
            return dd;
        }
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