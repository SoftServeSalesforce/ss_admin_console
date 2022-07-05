public with sharing class SSACResultsUtil {

    private static String ID_SEPARATOR = ', ';

    public List<SSACResult> getResultsByStatus(List<SSACResult> results, String status) {
        List<SSACResult> diagnosticResults = new List<SSACResult>();
        for (SSACResult result : results) {
            if (result.status == status) {
                diagnosticResults.add(result);
            }
        }

        return diagnosticResults;
    }

    public List<SSACResult> generateDiagnosticResultsUpsert(Database.UpsertResult[] upsertResults, Schema.SObjectType sObjectApiName) {
        List<SSACResult> results = new List<SSACResult>();
        for (Database.UpsertResult result : upsertResults) {
            if (result.isSuccess()) {
                results.add(new SSACResult()
                        .setStatus(SSACConstants.UPSERTED_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectApiName.getDescribe().getName()));
            } else {
                results = this.generateDiagnosticError(result, sObjectApiName);
            }
        }
        return results;
    }

    public List<SSACResult> generateDiagnosticError(Database.UpsertResult result, Schema.SObjectType sObjectApiName) {
        List<SSACResult> results = new List<SSACResult>();
            String errorMessage = '';
            for (Database.Error err : result.getErrors()) {
                errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage() + '; '
                        + String.valueOf(sObjectApiName) + ' fields that affected this error: ' + err.getFields() + '. ';
            }
            results.add(new SSACResult()
                    .setStatus(SSACConstants.FAILED_STATUS)
                    .setErrorMessage(errorMessage)
                    .setSObjectApiName(sObjectApiName.getDescribe().getName()));
        return results;
    }

    public String keysToString(List<SSACResult> results) {
        String message = '';
        for (SSACResult result : results) {
            message += result.recordKey + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public String idsToString(List<SSACResult> results) {
        String message = '';
        for (SSACResult result : results) {
            message += result.recordId + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public String errorsToString(List<SSACResult> results) {
        String message = '';
        for (SSACResult result : results) {
            message += result.errorMessage + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public List<Id> getIds(List<SSACResult> results) {
        List<Id> ids = new List<Id>();
        for (SSACResult result: results) {
            ids.add(result.recordId);
        }
        return ids;
    }
}