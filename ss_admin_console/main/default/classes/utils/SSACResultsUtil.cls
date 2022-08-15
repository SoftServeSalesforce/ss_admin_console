public inherited sharing class SSACResultsUtil {

    private static String ID_SEPARATOR = ', ';

    public List<SSACResult> getResultsByStatus(List<SSACResult> results, String status) {
        List<SSACResult> resultsByStatus = new List<SSACResult>();
        for (SSACResult result : results) {
            if (result.status == status) {
                resultsByStatus.add(result);
            }
        }
        return resultsByStatus;
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
}