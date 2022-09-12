@IsTest
public with sharing class TestClassTest {
    @IsTest
    static void testClass() {
        System.assertEquals(2, TestClass.calculate(2));
    }

    @IsTest
    static void testClassSub1() {
        System.assertEquals(4, TestClassSub1.calculate(2));
    }

    @IsTest
    static void testClassSub2() {
        System.assertEquals(8, TestClassSub2.calculate(2));
    }
}
