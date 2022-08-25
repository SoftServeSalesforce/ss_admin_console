@IsTest
public inherited sharing class SSACUtilTest {
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

    @isTest
    static void testGetSubClasses() {
        List<Type> subClasses = new List<Type>();
        SSACUtil utility = new SSACUtil();

        TestSubClass1 obj1 = new TestSubClass1();
        TestSubClass2 obj2 = new TestSubClass2();
        TestSubClass3 obj3 = new TestSubClass3();

        obj1.calculate(3);
        obj2.calculate(4);
        obj3.calculate(5);

        System.debug('Hello World!');

        Test.startTest();
        subClasses = utility.getSubClasses(TestInterfaceClass.class);
        System.debug('subClasses[0]:'+subClasses[0]);
        System.debug('subClasses[1]:'+subClasses[1]);
        System.debug('subClasses[2]:'+subClasses[2]);
        System.debug('subClasses[3]:'+subClasses[3]);
        Test.stopTest();

        System.assertEquals(4, subClasses.size());
    }
}
