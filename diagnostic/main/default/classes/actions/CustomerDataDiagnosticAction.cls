public with sharing class CustomerDataDiagnosticAction extends AsyncDiagnosticAction {

    public override List<DiagnosticResult> test() {
        List<DiagnosticResult> result = new SObjectDiagnosticAction(
                CustomerConstants.ACCOUNT_API_NAME, CustomerConstants.ACCOUNT_DATA, CustomerConstants.NAME_API_NAME).test();
        result.addAll(new SObjectDiagnosticAction(
                CustomerConstants.CONTACT_API_NAME, CustomerConstants.CONTACT_DATA, CustomerConstants.EMAIL_API_NAME).test());
        new DiagnosticLogger().publishResultLog(Constants.CUSTOMERS_DATA, 'Test');
        return result;
    }

    public override List<DiagnosticResult> execute() {
        List<DiagnosticResult> results = new SObjectDiagnosticAction(
                CustomerConstants.ACCOUNT_API_NAME, CustomerConstants.ACCOUNT_DATA, CustomerConstants.NAME_API_NAME).execute();
        Map<String, Contact> contacts = CustomerConstants.CONTACT_DATA;
        DiagnosticResultsUtil util = new DiagnosticResultsUtil();
        List<DiagnosticResult> successResults = util.getResultsByStatus(results, Constants.OK_STATUS);
        if (!successResults.isEmpty()) {
            contacts = this.setAccountId(contacts, successResults);
        }
        results.addAll(new SObjectDiagnosticAction(CustomerConstants.CONTACT_API_NAME, contacts, CustomerConstants.EMAIL_API_NAME).execute());
        new DiagnosticLogger().publishResultLog(Constants.CUSTOMERS_DATA, 'Execute');
        return results;
    }

    @TestVisible
    private Map<String, Contact> setAccountId(Map<String, Contact> contacts, List<DiagnosticResult> accountResults) {
        Map<String, Contact> result = new Map<String, Contact>();
        Integer accountCounter = 0;
        for (String cont : contacts.keySet()) {
            contacts.get(cont).put(CustomerConstants.ACCOUNT_ID_API_NAME, accountResults.get(accountCounter).recordId);
            accountCounter = accountResults.size() - 1 > accountCounter ? ++accountCounter : 0;
            result.put(cont, contacts.get(cont));
        }
        return result;
    }
}