public with sharing class DataWrapper {
    public String key;
    public SObject sobj;
    public Map<String, String> keyByReferenceField {get; set;}

    public DataWrapper(String key, SObject sobj, Map<String, String> keyByReferenceField) {
        this.key = key;
        this.sobj = sobj;
        this.keyByReferenceField = keyByReferenceField;
    }

    public String getFieldType(String field) {
        return this.sobj.getSObjectType().getDescribe().fields.getMap().get(field).getDescribe().relationshipName;
    }
}