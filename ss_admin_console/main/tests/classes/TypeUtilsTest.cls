@IsTest
public with sharing class TypeUtilsTest {

    @IsTest
    public static void isBatchableTestPositive() {
        Test.startTest();
        Boolean actual = TypeUtils.isBatchable('TestBatchable');
        Test.stopTest();
        System.assertEquals(true, actual);
    }
    
    @IsTest
    public static void isBatchableTestNegative() {
        Test.startTest();
        Boolean actual = TypeUtils.isBatchable('TestScheduable');
        Test.stopTest();
        System.assertEquals(false, actual);
    }
    
    @IsTest
    public static void isScheduableTestPositive() {
        Test.startTest();
        Boolean actual = TypeUtils.isSchedulable('TestScheduable');
        Test.stopTest();
        System.assertEquals(true, actual);
    }
    
    @IsTest
    public static void isScheduableTestNegative() {
        Test.startTest();
        Boolean actual = TypeUtils.isSchedulable('TestBatchable');
        Test.stopTest();
        System.assertEquals(false, actual);
    }
}