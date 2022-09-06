@IsTest
public with sharing class TestInterfaceTest {
    @IsTest
    static void testInterfaceSub1() {
        System.assertEquals(4, TestInterfaceSub1.calculate(2));
    }

    @IsTest
    static void testInterfaceSub2() {
        System.assertEquals(8, TestInterfaceSub2.calculate(2));
    }
}
