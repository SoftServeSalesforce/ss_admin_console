@IsTest
public with sharing class SSACControllerTest {
    @IsTest
    static void testGetDataTypes() {
        Test.startTest();
        List<String> dataTypes = SSACController.getDataTypes();
        Test.stopTest();
        System.assert(dataTypes.size() > 0, 'At least one test class that implements DataFeederFactory exist');
    }

    @IsTest
    static void testActionCheckOnly() {
        DataFeederFactory dff = new AccountsDataFeederFactory();
        Test.startTest();
        String dataTypes = SSACController.action(dff.getName(), false, true);
        Test.stopTest();
        System.assertEquals('Action Started', dataTypes);
    }

    @IsTest
    static void testActionNotCheckOnly() {
        DataFeederFactory dff = new AccountsDataFeederFactory();
        Test.startTest();
        String dataTypes = SSACController.action(dff.getName(), false, false);
        Test.stopTest();  
        System.assertEquals('Action Started', dataTypes);
    }
}