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
        private SObjectType objectType;
        private List<FieldReference> keyFields = new List<FieldReference>();
        private List<FieldReference> dataFields = new List<FieldReference>();
        private List<ReferenceFieldDefinition> referenceFields = new List<ReferenceFieldDefinition>();

        public DataDefinitionBuilder(SObjectType objectType) {
            if (objectType == null) {
                throw new IllegalArgumentException('\'objectType\' parameter can not be null.');
            }
            this.objectType = objectType;
        }

        public DataDefinitionBuilder addKeyField(String keyField) {
            if (String.isEmpty(keyField)) {
                throw new IllegalArgumentException('\'keyField\' parameter can not be null or empty.');
            }
            keyFields.add(FieldReference.build(objectType, keyField));
            return this;
        }

        public DataDefinitionBuilder addKeyField(SObjectField keyField) {
            if (keyField == null) {
                throw new IllegalArgumentException('\'keyField\' parameter can not be null.');
            }
            keyFields.add(FieldReference.build(keyField));
            return this;
        }

        public DataDefinitionBuilder addDataField(String dataField) {
            if (String.isEmpty(dataField)) {
                throw new IllegalArgumentException('\'dataField\' parameter can not be null or empty.');
            }
            dataFields.add(FieldReference.build(objectType, dataField));
            return this;
        }

        public DataDefinitionBuilder addDataField(SObjectField dataField) {
            if (dataField == null) {
                throw new IllegalArgumentException('\'dataField\' parameter can not be null.');
            }
            dataFields.add(FieldReference.build(dataField));
            return this;
        }

        public DataDefinitionBuilder addReferenceField(SObjectField referenceField, List<SObjectField> referencedKeyFields) {
            if (referenceField == null) {
                throw new IllegalArgumentException('\'referenceField\' parameter can not be null.');
            }
            if (referencedKeyFields == null || referencedKeyFields.isEmpty()) {
                throw new IllegalArgumentException('\'referencedKeyFields\' parameter can not be null or empty.');
            }
            ReferenceFieldDefinition rfd = new ReferenceFieldDefinition();
            rfd.referenceField = referenceField;
            rfd.referencedKeyFields = toFieldReferences(referencedKeyFields);
            referenceFields.add(rfd);
            return this;
        }

        public DataDefinitionBuilder addReferenceField(SObjectField referenceField, List<String> referencedKeyFields) {
            if (referenceField == null) {
                throw new IllegalArgumentException('\'referenceField\' parameter can not be null.');
            }
            if (referencedKeyFields == null || referencedKeyFields.isEmpty()) {
                throw new IllegalArgumentException('\'referencedKeyFields\' parameter can not be null or empty.');
            }
            ReferenceFieldDefinition rfd = new ReferenceFieldDefinition();
            rfd.referenceField = referenceField;
            rfd.referencedKeyFields = toFieldReferences(objectType, referencedKeyFields);
            referenceFields.add(rfd);
            return this;
        }

        public DataDefinition build() {
            DataDefinition dd = new DataDefinition();
            if (keyFields == null || keyFields.isEmpty()) {
                throw new IllegalArgumentException('\'keyFields\' parameter can not be null or empty.');
            }
            dd.objectType = objectType;
            dd.keyFields = keyFields;
            dd.dataFields = dataFields;
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