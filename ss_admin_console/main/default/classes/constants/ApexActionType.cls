public inherited sharing class ApexActionType extends Enumeration { 

    public static final ApexActionType TEST = new ApexActionType('Test'); 
    public static final ApexActionType EXECUTE = new ApexActionType('Execute'); 

    private ApexActionType(String value) {
       super(value);
    }
 }
