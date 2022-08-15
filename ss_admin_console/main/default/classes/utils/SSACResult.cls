public inherited sharing class SSACResult {
    public String status;
    public String recordKey;
    public String recordId;
    public String errorMessage;
    public String description;
    public String sObjectApiName;

    public SSACResult setStatus(String status) {
        this.status = status;
        return this;
    }
    public SSACResult setRecordKey(String recordKey) {
        this.recordKey = recordKey;
        return this;
    }
    public SSACResult setRecordId(String recordId) {
        this.recordId = recordId;
        return this;
    }
    public SSACResult setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
        return this;
    }
    public SSACResult setDescription(String description) {
        this.description = description;
        return this;
    }
    public SSACResult setSObjectApiName(String sObjectApiName) {
        this.sObjectApiName = sObjectApiName;
        return this;
    }
}