public with sharing class KeyGenerator {
    List<FieldReference> keyFields;
    String recordFingerprint;

    public KeyGenerator(List<FieldReference> keyFields, SObject record) {
        String keys;
        for (FieldReference field : keyFields) {
            keys += String.valueOf(field.getFrom(record));
        }
        this.recordFingerprint = keys;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof KeyGenerator) {
            KeyGenerator p = (KeyGenerator)obj;
            return (recordFingerprint == p.recordFingerprint);
        }
        return false;
    }

    public Integer hashCode() {
        return (31 * recordFingerprint.hashCode());
    }
}
