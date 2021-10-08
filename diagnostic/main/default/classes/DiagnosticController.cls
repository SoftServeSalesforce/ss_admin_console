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
    public static List<String> getJobClasses(String interfaceName) {
        return new DiagnosticUtil().getJobClasses(interfaceName);
    }

    @AuraEnabled
    public static String test(String actionType) {
        if (actionType == null) {
            return 'Please try to refresh the page, the session is expired';
        }
        IAction item = actions.get(actionType);
        if (item != null && item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).testAsync();
            return 'Test Started';
        }
        if (Type.forName(actionType).newInstance() instanceof Database.Batchable<SObject>) {
            new BatchableJobAction(actionType).test();
            return 'Test for batch job ' + actionType + ' started';
        }
        if (Type.forName(actionType).newInstance() instanceof Schedulable) {
            new ScheduledJobAction(actionType).test();
            return 'Test for scheduled job ' + actionType + ' started';
        }
        item.test();
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType) {
        if (actionType == null) {
            return 'Please try to refresh the page, the session is expired';
        }
        IAction item = actions.get(actionType);
        if (item != null && item instanceof AsyncDiagnosticAction) {
            ((AsyncDiagnosticAction) item).executeAsync();
            return 'Execution Started';
        }
        if (Type.forName(actionType).newInstance() instanceof Database.Batchable<SObject>) {
            new BatchableJobAction(actionType).execute();
            return 'Execution for batch job ' + actionType + ' started';
        }
        if (Type.forName(actionType).newInstance() instanceof Schedulable) {
            new ScheduledJobAction(actionType).execute();
            return 'Execution for scheduled job ' + actionType + ' started';
        }
        item.execute();
        return 'Execution Started';
    }
}