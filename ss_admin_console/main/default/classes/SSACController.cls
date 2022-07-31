public inherited sharing class SSACController {

    private static Map<String, DataSupplier> actions = new Map<String, DataSupplier> {
            SSACConstants.ACCOUNTS_DATA => SampleDataSuppliers.getAccountSampleData(),
            SSACConstants.CONTACTS_DATA => SampleDataSuppliers.getContactSampleData()
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
        DataSupplier ds = actions.get(actionType);
        if (ds != null) {
            BaseDataFeeder bdf = new BaseDataFeeder(ds, ds.getKeyFields(), ds.getDataFields(), new SystemFeedLogger());
            AsyncDataFeeder adf = new AsyncDataFeeder(bdf, new SystemFeedLogger());
            ((AsyncDataFeeder) adf).feed(false);
            new SystemFeedLogger().publishResultLog(actionType, 'Test');
            return 'Test Started';
        }
        if (TypeUtils.isBatchable(actionType)) {
            new BaseBatchableFeeder(actionType).feed(false);
            return 'Test for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new BaseSchedulableFeeder(actionType).feed(false);
            return 'Test for scheduled job ' + actionType + ' started';
        } 
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType) {
        DataSupplier ds = actions.get(actionType);
        if (ds != null) {
            BaseDataFeeder bdf = new BaseDataFeeder(ds, ds.getKeyFields(), ds.getDataFields(), new SystemFeedLogger());
            AsyncDataFeeder adf = new AsyncDataFeeder(bdf, new SystemFeedLogger());
            ((AsyncDataFeeder) adf).feed(true);
            new SystemFeedLogger().publishResultLog(actionType, 'Execute');
            return 'Execution Started';
        }
        if (TypeUtils.isBatchable(actionType)) {
            new BaseBatchableFeeder(actionType).feed(true);
            return 'Execution for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new BaseSchedulableFeeder(actionType).feed(true);
            return 'Execution for scheduled job ' + actionType + ' started';
        } 
        return 'Execution Started';
    }
}