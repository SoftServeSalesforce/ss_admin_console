public with sharing class DiagnosticController {

    private static Map<String, IAction> actions = new Map<String, IAction> {
            'CUSTOMERS_DATA' => new CustomerDataDiagnosticAction(),
            'PRODUCTS_DATA' => new ProductDataDiagnosticAction()
    };

    @AuraEnabled
    public static String test(String[] actionTypes) {
        System.debug('!!!' + actionTypes);
        IAction item = actions.get(actionTypes[0]);
        if (item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).testAsync();
            return 'Test Started';
        }
        item.test();
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String[] actionTypes) {
        /*IAction item = actions.get(actionTypes);
        if (item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).executeAsync();
            return 'Execution Started';
        }
        item.execute();*/
        return 'Execution Started';
    }
}