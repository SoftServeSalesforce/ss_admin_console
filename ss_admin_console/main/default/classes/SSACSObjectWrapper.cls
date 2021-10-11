public with sharing class SSACSObjectWrapper {
    public String key;
    public SObject sobj;
    public Map<String, String> keyByReferenceFields {get; set;}

    public SSACSObjectWrapper(String key, SObject sobj, Map<String, String> keyByReferenceFields) {
        this.key = key;
        this.sobj = sobj;
        this.keyByReferenceFields = keyByReferenceFields;
    }

    public String getFieldType(String field) {
        return this.sobj.getSObjectType().getDescribe().fields.getMap().get(field).getDescribe().relationshipName;
    }
}