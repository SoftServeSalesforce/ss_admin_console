public inherited sharing class ApexActionType extends Enumeration { 

    public static final ApexActionType STATUS_WARNING = new ApexActionType('WARNING');
    public static final ApexActionType STATUS_FAILED = new ApexActionType('FAILED');
    public static final ApexActionType STATUS_UPSERTED = new ApexActionType('UPSERTED');
    public static final ApexActionType STATUS_OK = new ApexActionType('OK');
    public static final ApexActionType STATUS_DUPLICATED = new ApexActionType('DUPLICATED');
    public static final ApexActionType STATUS_CHANGED = new ApexActionType('CHANGED');

    public static final ApexActionType ACTION_TYPE_TEST = new ApexActionType('Test'); 
    public static final ApexActionType ACTION_TYPE_EXECUTE = new ApexActionType('Execute'); 

    public static final ApexActionType DATA_CUSTOMERS = new ApexActionType('CUSTOMERS DATA');
    public static final ApexActionType DATA_PRODUCTS = new ApexActionType('PRODUCTS DATA');
    public static final ApexActionType DATA_OPPORTUNITY = new ApexActionType('OPPORTUNITY DATA');

    public static final ApexActionType NAME_CRON_EXPRESSION = new ApexActionType('Job_Cron_Expression');
    public static final ApexActionType NAME_SIZE_JOB = new ApexActionType('Job_Size');
    public static final ApexActionType NAME_REFERENCE = new ApexActionType('REFERENCE');
    
    public static final ApexActionType MAX_RECORDS_PER_PAGE = new ApexActionType(50);

    private ApexActionType(String value) {
       super(value);
    }

    private ApexActionType(Integer valueInt) {
        super(valueInt);
     }
 }
