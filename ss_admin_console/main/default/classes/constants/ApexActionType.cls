public with sharing class ApexActionType extends Enumeration {

    public static final ApexActionType TEST_ACTION_TYPE = new ApexActionType('Test');
    public static final ApexActionType EXECUTE_ACTION_TYPE = new ApexActionType('Execute');

    private ApexActionType(String value) {
        super(value);
     }
}
