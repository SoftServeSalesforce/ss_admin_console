public with sharing class DiagnosticController {

    private static Map<String, IAction> actions = new Map<String, IAction> {
            Constants.CUSTOMERS_DATA => new CustomerDataDiagnosticAction(),
            Constants.PRODUCTS_DATA => new ProductDataDiagnosticAction(),
            Constants.OPPORTUNITY_DATA => new OpportunityDataDiagnosticAction()
    };

    @AuraEnabled
    public static List<String> getDataTypes() {
        List<String> types = new List<String>();
        for (String str: actions.keySet()) {
            types.add(str);
        }
        return types;
    }

    @AuraEnabled
    public static String test(String actionType) {
        IAction item = actions.get(actionType);
        if (item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).testAsync();
            return 'Test Started';
        }
        item.test();
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType) {
        IAction item = actions.get(actionType);
        if (item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).executeAsync();
            return 'Execution Started';
        }
        item.execute();
        return 'Execution Started';
    }
}