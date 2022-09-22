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
        List<Type> factoryTypes = SSACUtil.getSubClasses(DataFeederFactory.class);
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
        return SSACUtil.getJobClasses(interfaceName);
    }

    @AuraEnabled
    public static String action(String actionType, Boolean updateRecords, Boolean checkOnly) {
        FeedLogger logger = new CompositeFeedLogger(new List<FeedLogger>{PlatformEventFeedLogger.getInstance(), SystemFeedLogger.getInstance()});
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
                    df.feed(true, logger);
                } finally {
                    Database.rollback(sp);
                }
                PlatformEventFeedLogger.getInstance().publishResultLog(actionType, ApexActionStatus.TEST_ACTION_TYPE.value());
            } else {
                try {
                    df.feed(updateRecords, logger);
                } finally {
                    PlatformEventFeedLogger.getInstance().publishResultLog(actionType, ApexActionStatus.EXECUTE_ACTION_TYPE.value());
                }
            }
        }
        return 'Action Started';
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