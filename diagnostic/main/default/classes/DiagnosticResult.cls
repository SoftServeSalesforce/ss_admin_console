public with sharing class DiagnosticResult {
    public String status;
    public String recordKey;
    public String recordId;
    public String errorMessage;
    public String description;
    public String sObjectApiName;

    public DiagnosticResult setStatus(String status) {
        this.status = status;
        return this;
    }
    public DiagnosticResult setRecordKey(String recordKey) {
        this.recordKey = recordKey;
        return this;
    }
    public DiagnosticResult setRecordId(String recordId) {
        this.recordId = recordId;
        return this;
    }
    public DiagnosticResult setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }
    public DiagnosticResult setDescription(String description) {
        this.description = description;
        return this;
    }
    public DiagnosticResult setSObjectApiName(String sObjectApiName) {
        this.sObjectApiName = sObjectApiName;
        return this;
    }
}