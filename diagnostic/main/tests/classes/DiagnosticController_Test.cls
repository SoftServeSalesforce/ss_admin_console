@IsTest
public with sharing class DiagnosticController_Test {
    
    @IsTest
    static void testProductData(){
        Test.startTest();
        String result = DiagnosticController.test(Constants.PRODUCTS_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeProductData(){
        Test.startTest();
        String result = DiagnosticController.execute(Constants.PRODUCTS_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }

    @IsTest
    static void testCustomerData(){
        Test.startTest();
        String result = DiagnosticController.test(Constants.CUSTOMERS_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeCustomerData(){
        Test.startTest();
        String result = DiagnosticController.execute(Constants.CUSTOMERS_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }

    @IsTest
    static void testOpportunityData(){
        Test.startTest();
        String result = DiagnosticController.test(Constants.OPPORTUNITY_DATA);
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeOpportunityData(){
        Test.startTest();
        String result = DiagnosticController.execute(Constants.OPPORTUNITY_DATA);
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }
}