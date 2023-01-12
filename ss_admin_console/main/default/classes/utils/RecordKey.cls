public with sharing class RecordKey {
    private final List<FieldReference> keyFields;
    private final SObject record;

    public RecordKey(List<FieldReference> keyFields, SObject record) {
        this.keyFields = keyFields;
        this.record = record;
    }

    public Boolean equals(Object obj) {
        EqualsBuilder builder = new EqualsBuilder();
        if (obj instanceof RecordKey) {
            RecordKey p = (RecordKey)obj;
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
    
    public override String toString() {
        String recordFingerprint = '';
        for (FieldReference field : keyFields) {
            recordFingerprint += field.getFrom(record);
        }
        return recordFingerprint.toLowerCase();
    }
}