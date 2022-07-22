public inherited sharing class ApexActionStatus extends Enumeration {

    public static final ApexActionStatus STATUS_WARNING = new ApexActionStatus('WARNING');
    public static final ApexActionStatus STATUS_FAILED = new ApexActionStatus('FAILED');
    public static final ApexActionStatus STATUS_UPSERTED = new ApexActionStatus('UPSERTED');
    public static final ApexActionStatus STATUS_OK = new ApexActionStatus('OK');
    public static final ApexActionStatus STATUS_DUPLICATED = new ApexActionStatus('DUPLICATED');
    public static final ApexActionStatus STATUS_CHANGED = new ApexActionStatus('CHANGED');

    private ApexActionStatus(String value) {
        super(value);
     }
 }
