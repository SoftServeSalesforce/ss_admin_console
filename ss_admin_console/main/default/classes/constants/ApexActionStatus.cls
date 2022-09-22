public inherited sharing class ApexActionStatus extends Enumeration {

    public static final ApexActionStatus WARNING = new ApexActionStatus('WARNING');
    public static final ApexActionStatus FAILED = new ApexActionStatus('FAILED');
    public static final ApexActionStatus UPDATED = new ApexActionStatus('UPDATED');
    public static final ApexActionStatus INSERTED = new ApexActionStatus('INSERTED');
    public static final ApexActionStatus OK = new ApexActionStatus('OK');
    public static final ApexActionStatus DUPLICATED = new ApexActionStatus('DUPLICATED');
    public static final ApexActionStatus CHANGED = new ApexActionStatus('CHANGED');
    public static final ApexActionStatus TEST_ACTION_TYPE = new ApexActionStatus('Test');
    public static final ApexActionStatus EXECUTE_ACTION_TYPE = new ApexActionStatus('Execute');

    private ApexActionStatus(String value) {
        super(value);
     }
 }
