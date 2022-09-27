@IsTest
public with sharing class ConstantsTest {
    @IsTest
    static void testConstant() {
        Test.startTest();
        Integer intValue = Constants.MAX_RECORDS_PER_PAGE;
        Test.stopTest();
    }
}
