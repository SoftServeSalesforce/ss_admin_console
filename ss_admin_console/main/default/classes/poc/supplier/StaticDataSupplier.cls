public inherited sharing class StaticDataSupplier implements DataSupplier {
    private DataDefinition metadata;
    private List<SObject> data;

    public StaticDataSupplier(DataDefinition metadata, List<SObject> data) {
        if (data != null && !data.isEmpty()) {
            this.data = data;
        } else {
            throw new IllegalArgumentException('Data can not be null or empty!');
        }
        if (metadata != null) {
            this.metadata = metadata;
        } else {
            throw new IllegalArgumentException('Metadata can not be null!');
        }
    }

    public List<SObject> supply() {
        return data;
    }

    public DataDefinition getMetadata() {
        return metadata;
    }

    /*
    private static List<DataDefinition.ReferenceFieldDefinition> toReferenceDefinitions(List<SObjectField> referenceFields,
            List<List<SObjectField>> referencedSObjectKeyFields) {
        List<DataDefinition.ReferenceFieldDefinition> referenceDefinitions = new List<DataDefinition.ReferenceFieldDefinition>();
        for (Integer i = 0; i < referenceFields.size(); i++) {
            referenceDefinitions.add(new DataDefinition.ReferenceFieldDefinition(referenceFields[i],
                    toFieldReferences(referencedSObjectKeyFields[i])));
        }
        return referenceDefinitions;
    }
    */
}