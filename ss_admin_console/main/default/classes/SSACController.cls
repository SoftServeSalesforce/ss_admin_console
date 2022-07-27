public inherited sharing class SSACController {

    private static Map<String, DataSupplier> actions = new Map<String, DataSupplier> {
            SSACConstants.ACCOUNTS_DATA => SampleDataSuppliers.getAccountSampleData(),
            SSACConstants.CONTACTS_DATA => SampleDataSuppliers.getContactSampleData()
    };

    // private static Map<String, DataSupplier> prikol = new Map<String, DataSupplier>{
    //     'ACCOUNTS DATA' => new BaseDataFeeder(SampleDataSuppliers.getAccountSampleData(), CustomerConstants.ACCOUNT_KEYFIELDS, CustomerConstants.ACCOUNT_KEYFIELDS, new SystemFeedLogger())
    // };

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
        BaseDataFeeder bdf = new BaseDataFeeder(ds, ds.getKeyFields(), ds.getDataFields(), new SystemFeedLogger());
        AsyncDataFeeder adf = new AsyncDataFeeder(bdf, new SystemFeedLogger());
        adf.feed(false);
        // if (TypeUtils.isBatchable(actionType)) {
        //     new SSACBatchableAction(actionType).test();
        //     return 'Test for batch job ' + actionType + ' started';
        // }
        // if (TypeUtils.isSchedulable(actionType)) {
        //     new SSACScheduledAction(actionType).test();
        //     return 'Test for scheduled job ' + actionType + ' started';
        // }
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType) {
        DataSupplier ds = actions.get(actionType);
        BaseDataFeeder bdf = new BaseDataFeeder(ds, ds.getKeyFields(), ds.getDataFields(), new SystemFeedLogger());
        bdf.feed(true);
        // if (TypeUtils.isBatchable(actionType)) {
        //     new SSACBatchableAction(actionType).execute();
        //     return 'Execution for batch job ' + actionType + ' started';
        // }
        // if (TypeUtils.isSchedulable(actionType)) {
        //     new SSACScheduledAction(actionType).execute();
        //     return 'Execution for scheduled job ' + actionType + ' started';
        // }
        // item.execute();
        return 'Execution Started';
    }
}