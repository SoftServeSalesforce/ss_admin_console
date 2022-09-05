@IsTest
public inherited sharing class ApexActionStatusTest {
    @IsTest
    static void testWARNING() {
        Test.startTest();
        String strStatus = ApexActionStatus.WARNING.value();
        Test.stopTest();

        System.assertEquals('WARNING', strStatus);
    }
}
