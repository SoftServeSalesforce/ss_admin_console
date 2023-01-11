public inherited sharing class SSACResultsUtil {
    
    public List<SSACResult> getResultsByStatus(List<SSACResult> results, String status) {
        List<SSACResult> resultsByStatus = new List<SSACResult>();
        for (SSACResult result : results) {
            if (result.status == status) {
                resultsByStatus.add(result);
            }
        }
        return resultsByStatus;
    }
}