@IsTest
public with sharing class TypeUtilsTest {

    @IsTest
    public static void isBatchableTestPositive() {
        Boolean expected = true;

        Test.startTest();
        Boolean actual = TypeUtils.isBatchable('TestBatchable');
        Test.stopTest();

        System.assertEquals(expected, actual, 'Actual value is not True');
    }
    
    @IsTest
    public static void isBatchableTestNegative() {

        Boolean expected = false;

        Test.startTest();
        Boolean actual = TypeUtils.isBatchable('TestScheduable');
        Test.stopTest();

        System.assertEquals(expected, actual, 'Actual value is not False');
    }

    @IsTest
    public static void isScheduableTestPositive() {

        Boolean expected = true;

        Test.startTest();
        Boolean actual = TypeUtils.isSchedulable('TestScheduable');
        Test.stopTest();

        System.assertEquals(expected, actual, 'Actual value is not True');
    }
    
    @IsTest
    public static void isScheduableTestNegative() {

        Boolean expected = false;

        Test.startTest();
        Boolean actual = TypeUtils.isSchedulable('TestBatchable');
        Test.stopTest();

        System.assertEquals(expected, actual, 'Actual value is not False');
    }

}
