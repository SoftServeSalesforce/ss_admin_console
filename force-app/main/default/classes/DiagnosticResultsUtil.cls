public with sharing class DiagnosticResultsUtil {

    private static String ID_SEPARATOR = ', ';

    public List<DiagnosticResult> getResultsByStatus(List<DiagnosticResult> results, String status) {
        List<DiagnosticResult> diagnosticResults = new List<DiagnosticResult>();
        for (DiagnosticResult result : results) {
            if (result.status == status) {
                diagnosticResults.add(result);
            }
        }

        return diagnosticResults;
    }

    public List<DiagnosticResult> generateDiagnosticResults(Database.SaveResult[] saveResults, String sObjectApiName) {
        List<DiagnosticResult> results = new List<DiagnosticResult>();
        for (Database.SaveResult result : saveResults) {
            if (result.isSuccess()) {
                DiagnosticResult diagnosticResult = new DiagnosticResult()
                        .setStatus(Constants.OK_STATUS)
                        .setRecordId(result.getId())
                        .setSObjectApiName(sObjectApiName);
                results.add(diagnosticResult);
            } else {
                String errorMessage = '';
                for (Database.Error err : result.getErrors()) {
                    errorMessage += 'The following error has occurred. ' + err.getStatusCode() + ': ' + err.getMessage()
                            + sObjectApiName + ' fields that affected this error: ' + err.getFields() + '. ';
                }
                results.add(new DiagnosticResult()
                        .setStatus(Constants.FAILED_STATUS)
                        .setErrorMessage(errorMessage));
            }

        }
        return results;
    }

    public String keysToString(List<DiagnosticResult> results) {
        String message = '';
        for (DiagnosticResult result : results) {
            message += result.recordKey + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public String idsToString(List<DiagnosticResult> results) {
        String message = '';
        for (DiagnosticResult result : results) {
            message += result.recordId + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public String errorsToString(List<DiagnosticResult> results) {
        String message = '';
        for (DiagnosticResult result : results) {
            message += result.errorMessage + ID_SEPARATOR;
        }
        return message.removeEnd(ID_SEPARATOR);
    }

    public List<Id> getIds(List<DiagnosticResult> results) {
        List<Id> ids = new List<Id>();
        for (DiagnosticResult result: results) {
            ids.add(result.recordId);
        }
        return ids;
    }
}