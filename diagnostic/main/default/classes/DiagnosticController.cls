public with sharing class DiagnosticController {

    private static Map<String, IAction> actions = new Map<String, IAction> {
            'CUSTOMERS_DATA' => new CustomerDataDiagnosticAction(),
            'PRODUCTS_DATA' => new ProductDataDiagnosticAction()
    };

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