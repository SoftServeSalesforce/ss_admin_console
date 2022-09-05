@IsTest
public inherited sharing class SSACUtilTest {
    @IsTest
    static void testJobSettingPositive() {
        Job_Setting__mdt testMDT = new Job_Setting__mdt();
        Test.startTest();
        testMDT = SSACUtil.getJobSetting('Job_Size');
        Test.stopTest();
        System.assertNotEquals(null, testMDT, 'Job_Size setting successfully recovered.');
    }

    @IsTest
    static void testJobSettingNegative() {
        Job_Setting__mdt testMDT = new Job_Setting__mdt();
        Test.startTest();
        testMDT = SSACUtil.getJobSetting('JobSize!');
        Test.stopTest();
        System.assertEquals(null, testMDT, 'Job_Size setting successfully returned as null');
    }

    @IsTest
    static void testGetJobClasses() {
        List<String> interfaces = new List<String>();
        Test.startTest();
        interfaces = SSACUtil.getJobClasses('Queueable');
        Test.stopTest();
        System.assertNotEquals(null, interfaces, 'JobClasses successfully recovered.');
    }

    @isTest
    static void testGetSubClassesForTestClass() {
        Test.startTest();
        List<Type> subClasses = SSACUtil.getSubClasses(TestClass.class);
        Test.stopTest();

        System.assertEquals(2, subClasses.size());
    }

    @isTest
    static void testGetSubClassesForTestInterface() {
        Test.startTest();
        List<Type> subClasses = SSACUtil.getSubClasses(TestInterface.class);
        Test.stopTest();

        System.assertEquals(2, subClasses.size());
    }
}
