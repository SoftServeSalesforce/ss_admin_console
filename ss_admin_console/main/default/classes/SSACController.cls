public inherited sharing class SSACController {

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
    public static List<DataSupplierFactoryWrapper> getDataSupplierFactories() {
        List<Type> factoryTypes = new SSACUtil().getSubClasses(DataSupplierFactory.class);
        List<DataSupplierFactoryWrapper> supplierFactories = new List<DataSupplierFactoryWrapper>();
        for (Type factoryType : factoryTypes) {
            if (factoryType != DataSupplierFactory.class) {
                try {
                    DataSupplierFactory factory = (DataSupplierFactory) factoryType.newInstance();
                    supplierFactories.add(new DataSupplierFactoryWrapper(factory.getName(), factoryType.getName()));
                } catch (Exception e) {
                    // Log message properly
                }
            }
        }

        return supplierFactories;
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

    public class DataSupplierFactoryWrapper {
        public String supplierName {get; private set;}
        public String factoryName {get; private set;}

        public DataSupplierFactoryWrapper(String supplierName, String factoryName) {
            this.supplierName = supplierName;
            this.factoryName = factoryName;
        }
    }
}