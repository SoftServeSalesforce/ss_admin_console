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
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        PlatformEventFeedLogger platformLogger = (PlatformEventFeedLogger) mocks.mock(PlatformEventFeedLogger.class);
        DataFeederFactory dff = new TestDataFeederFactory();
        Test.startTest();
        String dataTypes = SSACController.action(dff.getName(), false, true);
        Test.stopTest();

        // is that correct?
        //((PlatformEventFeedLogger) mocks.verify(platformLogger, 1)).publishResultLog(dff.getName(), SSACConstants.TEST_ACTION_TYPE);

        System.assertEquals('Action Started', dataTypes);
    }

    @IsTest
    static void testActionNotCheckOnly() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        PlatformEventFeedLogger platformLogger = (PlatformEventFeedLogger) mocks.mock(PlatformEventFeedLogger.class);
        DataFeederFactory dff = new TestDataFeederFactory();
        Test.startTest();
        String dataTypes = SSACController.action(dff.getName(), false, false);
        Test.stopTest();

        // is that correct?
        //((PlatformEventFeedLogger) mocks.verify(platformLogger, 1)).publishResultLog(dff.getName(), SSACConstants.EXECUTE_ACTION_TYPE);
        
        System.assertEquals('Action Started', dataTypes);
    }
}
