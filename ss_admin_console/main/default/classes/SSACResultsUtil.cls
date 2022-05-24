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

    public List<SSACResult> generateDiagnosticResultsInsert(Database.SaveResult[] saveResults, String sObjectApiName) {
        List<SSACResult> results = new List<SSACResult>();
        for (Database.SaveResult result : saveResults) {
            if (result.isSuccess()) {
                results.add(new SSACResult()
                        .setStatus(SSACConstants.OK_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectApiName));
            } else {
                results = this.generateDiagnosticError(result, sObjectApiName);
            }
        }
        return results;
    }

    public List<SSACResult> generateDiagnosticResultsUpdated(Database.SaveResult[] saveResults, String sObjectApiName) {
        List<SSACResult> results = new List<SSACResult>();
        for (Database.SaveResult result : saveResults) {
            if (result.isSuccess()) {
                results.add(new SSACResult()
                        .setStatus(SSACConstants.UPDATED_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectApiName));
            } else {
                results = this.generateDiagnosticError(result, sObjectApiName);
            }
        }
        return results;
    }
    public List<SSACResult> generateDiagnosticError(Database.SaveResult result, String sObjectApiName) {
        List<SSACResult> results = new List<SSACResult>();
            String errorMessage = '';
            for (Database.Error err : result.getErrors()) {
                errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                        + sObjectApiName + ' fields that affected this error: ' + err.getFields() + '. ';
            }
            results.add(new SSACResult()
                    .setStatus(SSACConstants.FAILED_STATUS)
                    .setErrorMessage(errorMessage)
                    .setSObjectApiName(sObjectApiName));
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