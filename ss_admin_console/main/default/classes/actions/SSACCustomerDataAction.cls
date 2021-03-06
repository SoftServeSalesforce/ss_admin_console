public with sharing class SSACCustomerDataAction extends SSACAsyncAction {

    public override List<SSACResult> test() {
        List<SSACResult> result = new SSACSObjectAction(
                CustomerConstants.ACCOUNT_API_NAME, CustomerConstants.ACCOUNT_DATA, CustomerConstants.NAME_API_NAME).test();
        result.addAll(new SSACSObjectAction(
                CustomerConstants.CONTACT_API_NAME, CustomerConstants.CONTACT_DATA, CustomerConstants.EMAIL_API_NAME).test());
        new SSACLogger().publishResultLog(SSACConstants.CUSTOMERS_DATA, 'Test');
        return result;
    }

    public override List<SSACResult> execute() {
        List<SSACResult> results = new SSACSObjectAction(
                CustomerConstants.ACCOUNT_API_NAME, CustomerConstants.ACCOUNT_DATA, CustomerConstants.NAME_API_NAME).execute();
        Map<String, Contact> contacts = CustomerConstants.CONTACT_DATA;
        SSACResultsUtil util = new SSACResultsUtil();
        List<SSACResult> successResults = util.getResultsByStatus(results, SSACConstants.OK_STATUS);
        if (!successResults.isEmpty()) {
            contacts = this.setAccountId(contacts, successResults);
        }
        results.addAll(new SSACSObjectAction(CustomerConstants.CONTACT_API_NAME, contacts, CustomerConstants.EMAIL_API_NAME).execute());
        new SSACLogger().publishResultLog(SSACConstants.CUSTOMERS_DATA, 'Execute');
        return results;
    }

    @TestVisible
    private Map<String, Contact> setAccountId(Map<String, Contact> contacts, List<SSACResult> accountResults) {
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