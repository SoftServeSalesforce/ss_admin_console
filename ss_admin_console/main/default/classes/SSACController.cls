public inherited sharing class SSACController {

    @AuraEnabled
    public static List<String> getDataTypes() {
        List<DataSupplierFactoryWrapper> factories = getDataFeederFactories();
        List<String> dataTypes = new List<String>();
        for (DataSupplierFactoryWrapper wrapper : factories) {
            dataTypes.add(wrapper.description);
        }
        return dataTypes;
    }

    @AuraEnabled
    public static List<DataSupplierFactoryWrapper> getDataFeederFactories() {
        List<Type> factoryTypes = new SSACUtil().getSubClasses(DataFeederFactory.class);
        List<DataSupplierFactoryWrapper> feederFactories = new List<DataSupplierFactoryWrapper>();
        for (Type factoryType : factoryTypes) {
            if (factoryType != DataFeederFactory.class) {
                try {
                    DataFeederFactory factory = (DataFeederFactory) factoryType.newInstance();
                    feederFactories.add(new DataSupplierFactoryWrapper(factory.getName(), factoryType.getName()));
                } catch (Exception e) {
                    // Log message properly
                }
            }
        }
        return feederFactories;
    }

    @AuraEnabled
    public static List<String> getJobClasses(String interfaceName) {
        return new SSACUtil().getJobClasses(interfaceName);
    }


    //test = checkonly
    //update if to update existent records
    @AuraEnabled
    public static String action(String actionType, Boolean updateRecords, Boolean checkOnly) {
        List<DataSupplierFactoryWrapper> factories = getDataFeederFactories();
        String factoryName;
        for (DataSupplierFactoryWrapper wrapper : factories) {
            if (wrapper.description == actionType) {
                factoryName = wrapper.factoryName;
                break;
            }
        }
        if (factoryName != null) {
            Type factoryType = Type.forName(factoryName);
            DataFeederFactory feederFactory = (DataFeederFactory) factoryType.newInstance();
            DataFeeder df = feederFactory.getDataFeeder();
            if (checkOnly) {
                Savepoint sp = Database.setSavepoint();
                try {
                    df.feed(true, checkOnly, new PlatformEventFeedLogger());
                } finally {
                    Database.rollback(sp);
                }
                new PlatformEventFeedLogger().publishResultLog(actionType, 'Test');
            } else {
                try {
                    df.feed(updateRecords, checkOnly, new PlatformEventFeedLogger());
                } finally {
                    new PlatformEventFeedLogger().publishResultLog(actionType, 'Execute');
                }
            }
        }
        /*if (TypeUtils.isBatchable(actionType)) {
            new BaseBatchableFeeder(actionType).feed(false);
            return 'Test for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new BaseSchedulableFeeder(actionType).feed(false);
            return 'Test for scheduled job ' + actionType + ' started';
        } */
        return 'Action Started';
    }










    @AuraEnabled
    public static String test(String actionType) {
        /*
        List<DataSupplierFactoryWrapper> factories = getDataFeederFactories();
        String factoryName;
        for (DataSupplierFactoryWrapper wrapper : factories) {
            if (wrapper.description == actionType) {
                factoryName = wrapper.factoryName;
                break;
            }
        }
        if (factoryName != null) {
            Type factoryType = Type.forName(factoryName);
            DataFeederFactory feederFactory = (DataFeederFactory) factoryType.newInstance();
            DataFeeder df = feederFactory.getDataFeeder();
            try {
                df.feed(false, true, new PlatformEventFeedLogger());
            } finally {
                new PlatformEventFeedLogger().publishResultLog(actionType, 'Test');
            }
            //TODO: fix the sequence of logging 'Test Started' message
            return 'Test Started';
        }
        /*if (TypeUtils.isBatchable(actionType)) {
            new BaseBatchableFeeder(actionType).feed(false);
            return 'Test for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new BaseSchedulableFeeder(actionType).feed(false);
            return 'Test for scheduled job ' + actionType + ' started';
        } */
        return 'Test Started';
    }

    @AuraEnabled
    public static String execute(String actionType, Boolean updateRecords) {
        /*
        //TODO: fix issue with updateRecords parameter (null)
        List<DataSupplierFactoryWrapper> factories = getDataFeederFactories();
        String factoryName;
        for (DataSupplierFactoryWrapper wrapper : factories) {
            if (wrapper.description == actionType) {
                factoryName = wrapper.factoryName;
                break;
            }
        }

        Type factoryType = Type.forName(factoryName);
        DataFeederFactory feederFactory = (DataFeederFactory) factoryType.newInstance();

        DataFeeder df = feederFactory.getDataFeeder();
        if (df != null) {
            try {
                df.feed(updateRecords, false, new PlatformEventFeedLogger());
            } finally {
                new PlatformEventFeedLogger().publishResultLog(actionType, 'Execute');
            }
            return 'Execution Started';
        }/*
        if (TypeUtils.isBatchable(actionType)) {
            new BaseBatchableFeeder(actionType).feed(true);
            return 'Execution for batch job ' + actionType + ' started';
        }
        if (TypeUtils.isSchedulable(actionType)) {
            new BaseSchedulableFeeder(actionType).feed(true);
            return 'Execution for scheduled job ' + actionType + ' started';
        } */
        return 'Execution Started';
    }

    public class DataSupplierFactoryWrapper {
        public String description {get; private set;}
        public String factoryName {get; private set;}

        public DataSupplierFactoryWrapper(String description, String factoryName) {
            this.description = description;
            this.factoryName = factoryName;
        }
    }
}