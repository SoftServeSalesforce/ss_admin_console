public with sharing class KeyGenerator {
    private List<FieldReference> keyFields;
    private SObject record;

    // rename to RecordKey
    public KeyGenerator(List<FieldReference> keyFields, SObject record) {
        this.keyFields = keyFields;
        this.record = record;
    }

    public Boolean equals(Object obj) {
        EqualsBuilder builder = new EqualsBuilder();
        if (obj instanceof KeyGenerator) {
            KeyGenerator p = (KeyGenerator)obj;
            for (FieldReference field : keyFields) {
                builder.append(field.getFrom(record), field.getFrom(p.record));
            }
            return builder.build();
        }
        return false;
    }

    public Integer hashCode() {
        HashCodeBuilder builder = new HashCodeBuilder();
        for (FieldReference field : keyFields) {
            builder.append(field.getFrom(record));
        }        
        return builder.build();
    }

    public String toString() {
        for (FieldReference field : keyFields) {
            
        }
    }
}
