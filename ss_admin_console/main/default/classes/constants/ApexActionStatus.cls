public inherited sharing class ApexActionStatus extends Enumeration {

    public static final ApexActionStatus WARNING = new ApexActionStatus('WARNING');
    public static final ApexActionStatus FAILED = new ApexActionStatus('FAILED');
    public static final ApexActionStatus UPSERTED = new ApexActionStatus('UPSERTED');
    public static final ApexActionStatus INSERTED = new ApexActionStatus('INSERTED');
    public static final ApexActionStatus OK = new ApexActionStatus('OK');
    public static final ApexActionStatus DUPLICATED = new ApexActionStatus('DUPLICATED');
    public static final ApexActionStatus CHANGED = new ApexActionStatus('CHANGED');

    private ApexActionStatus(String value) {
        super(value);
     }
 }
