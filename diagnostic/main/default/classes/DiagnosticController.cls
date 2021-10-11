public with sharing class DiagnosticController {

    private static Map<String, IAction> actions = new Map<String, IAction> {
            Constants.CUSTOMERS_DATA => new CustomerDataDiagnosticAction(),
            Constants.PRODUCTS_DATA => new ProductDataDiagnosticAction(),
            Constants.OPPORTUNITY_DATA => new OpportunityDataDiagnosticAction()
    };

    @AuraEnabled
    public static List<String> getDataTypes() {
        return new List<String>(actions.keySet());
    }

    @AuraEnabled
    public static List<String> getJobClasses(String interfaceName) {
        return new DiagnosticUtil().getJobClasses(interfaceName);
    }

    @AuraEnabled
    public static String test(String actionType) {
        IAction item = actions.get(actionType);
        if (item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).testAsync();
            return 'Test Started';
        }

        if (TypeUtils.isBatchable(actionType)) {
            new BatchableJobAction(actionType).test();
            return 'Test for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new ScheduledJobAction(actionType).test();
            return 'Test for scheduled job ' + actionType + ' started';
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
        if (TypeUtils.isBatchable(actionType)) {
            new BatchableJobAction(actionType).execute();
            return 'Execution for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new ScheduledJobAction(actionType).execute();
            return 'Execution for scheduled job ' + actionType + ' started';
        }
        item.execute();
        return 'Execution Started';
    }
}