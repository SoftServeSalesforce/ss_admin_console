public inherited sharing class ApexActionType extends Enumeration { 

    public static final ApexActionType ACTION_TYPE_TEST = new ApexActionType('Test'); 
    public static final ApexActionType ACTION_TYPE_EXECUTE = new ApexActionType('Execute'); 

    private ApexActionType(String value) {
       super(value);
    }
 }
