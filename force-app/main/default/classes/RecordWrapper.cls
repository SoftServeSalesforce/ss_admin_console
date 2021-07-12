public with sharing class RecordWrapper {
    private String sObjectApiName;
    private String externalIdField;
    private SObject sObj;
    public RecordWrapper (String sObjectApiName, String externalIdField, SObject sObj) {
        this.sObjectApiName = sObjectApiName;
        this.externalIdField = externalIdField;
        this.sObj = sObj;
    }

    public String getExternalField() {
        return this.externalIdField;
    }
    
    public String getSObjectApiName() {
        return this.sObjectApiName;
    }

    public SObject getSObject() {
        return this.sObj;
    }
}
