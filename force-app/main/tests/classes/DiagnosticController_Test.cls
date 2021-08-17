@IsTest
public with sharing class DiagnosticController_Test {
    
    @IsTest
    static void testProductData(){
        Test.startTest();
        String result = DiagnosticController.test('PRODUCTS_DATA');
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeProductData(){
        Test.startTest();
        String result = DiagnosticController.execute('PRODUCTS_DATA');
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }

    @IsTest
    static void testCustomerData(){
        Test.startTest();
        String result = DiagnosticController.test('CUSTOMERS_DATA');
        Test.stopTest();
        System.assert(result.contains('Test Started'));
    }

    @IsTest
    static void executeCustomerData(){
        Test.startTest();
        String result = DiagnosticController.execute('CUSTOMERS_DATA');
        Test.stopTest();
        System.assert(result.contains('Execution Started'));
    }
}