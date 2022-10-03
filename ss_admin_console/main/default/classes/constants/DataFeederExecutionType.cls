public with sharing class DataFeederExecutionType extends Enumeration {

    public static final DataFeederExecutionType TEST_ACTION_TYPE = new DataFeederExecutionType('TEST');
    public static final DataFeederExecutionType RUN_ACTION_TYPE = new DataFeederExecutionType('RUN');

    private DataFeederExecutionType(String value) {
        super(value);
     }
}
