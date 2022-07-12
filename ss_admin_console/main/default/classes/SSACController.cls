public with sharing class SSACController {

    private static Map<String, ISSACAction> actions = new Map<String, ISSACAction> {
            SSACConstants.CUSTOMERS_DATA => new SSACCustomerDataAction(),
            SSACConstants.PRODUCTS_DATA => new SSACProductDataAction(),
            SSACConstants.OPPORTUNITY_DATA => new SSACOpportunityDataAction()
    };

    @AuraEnabled
    public static List<String> getDataTypes() {
        return new List<String>(actions.keySet());
    }

    @AuraEnabled
    public static List<String> getJobClasses(String interfaceName) {
        return new SSACUtil().getJobClasses(interfaceName);
    }

    @AuraEnabled
    public static String test(String actionType) {
        ISSACAction item = actions.get(actionType);
        if (item instanceof SSACAsyncAction) {
            ((SSACAsyncAction) item).testAsync();
            return 'Test Started';
        }

        if (TypeUtils.isBatchable(actionType)) {
            new SSACBatchableAction(actionType).test();
            return 'Test for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new SSACScheduledAction(actionType).test();
            return 'Test for scheduled job ' + actionType + ' started';
        }
        item.test();
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType) {
        ISSACAction item = actions.get(actionType);
        if (item instanceof SSACAsyncAction) {
            ((SSACAsyncAction) item).executeAsync();
            return 'Execution Started';
        }
        if (TypeUtils.isBatchable(actionType)) {
            new SSACBatchableAction(actionType).execute();
            return 'Execution for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new SSACScheduledAction(actionType).execute();
            return 'Execution for scheduled job ' + actionType + ' started';
        }
        item.execute();
        return 'Execution Started';
    }

    @AuraEnabled
    public static Boolean isProductionOrg(){

        // this method for determining whether an organization is a production org 

        String orgType = [SELECT OrganizationType FROM Organization].OrganizationType;
        Boolean isSandbox = [SELECT IsSandbox FROM Organization limit 1].IsSandbox;
        Boolean blnIsProductionOrg = false; 
        Boolean blnResult = false;
        
        blnResult = ( orgType == 'Essentials Edition'
        ||orgType == 'Professional Edition' 
        ||orgType == 'Enterprise Edition' 
        ||orgType == 'Unlimited Edition' 
        );

        blnIsProductionOrg = blnResult && (!isSandbox);
        
        return blnIsProductionOrg;

    }

}