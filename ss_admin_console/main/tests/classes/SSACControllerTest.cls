@IsTest
public with sharing class SSACControllerTest {
    
    @IsTest
    static void testProductData(){
        Test.startTest();
        String result = SSACController.test(SSACConstants.PRODUCTS_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeProductData(){
        Test.startTest();
        String result = SSACController.execute(SSACConstants.PRODUCTS_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }

    @IsTest
    static void testCustomerData(){
        Test.startTest();
        String result = SSACController.test(SSACConstants.CUSTOMERS_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeCustomerData(){
        Test.startTest();
        String result = SSACController.execute(SSACConstants.CUSTOMERS_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }

    @IsTest
    static void testOpportunityData(){
        Test.startTest();
        String result = SSACController.test(SSACConstants.OPPORTUNITY_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeOpportunityData(){
        Test.startTest();
        String result = SSACController.execute(SSACConstants.OPPORTUNITY_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }
}