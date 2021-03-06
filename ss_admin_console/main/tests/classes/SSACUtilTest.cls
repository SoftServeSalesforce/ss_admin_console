@IsTest
public with sharing class SSACUtilTest {
    @IsTest
    static void testJobSettingPositive() {
        Job_Setting__mdt testMDT = new Job_Setting__mdt();
        SSACUtil utility = new SSACUtil();
        Test.startTest();
        testMDT = utility.getJobSetting('Job_Size');
        Test.stopTest();
        System.assertNotEquals(null, testMDT, 'Job_Size setting successfully recovered.');
    }

    @IsTest
    static void testJobSettingNegative() {
        Job_Setting__mdt testMDT = new Job_Setting__mdt();
        SSACUtil utility = new SSACUtil();
        Test.startTest();
        testMDT = utility.getJobSetting('JobSize!');
        Test.stopTest();
        System.assertEquals(null, testMDT, 'Job_Size setting successfully returned as null');
    }

    @IsTest
    static void testGetJobClasses() {
        List<String> interfaces = new List<String>();
        SSACUtil utility = new SSACUtil();
        Test.startTest();
        interfaces = utility.getJobClasses('Queueable');
        Test.stopTest();
        System.assertNotEquals(null, interfaces, 'JobClasses successfully recovered.');
    }
}
