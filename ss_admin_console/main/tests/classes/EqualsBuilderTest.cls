@IsTest
public with sharing class EqualsBuilderTest {

    @IsTest
    private static void testEquals() {
        Account a1 = new Account(
            Name = 'Test Company',
            ShippingLatitude = 15.1,
            NumberOfEmployees = 4
        );

        Account a2 = new Account(
            Name = 'Test Company',
            ShippingLatitude = 15.1,
            NumberOfEmployees = 4
        );

        Account a3 = new Account(
            Name = 'Test Company 1',
            ShippingLatitude = 15.1,
            NumberOfEmployees = 4
        );

        EqualsBuilder eb1; 
        EqualsBuilder eb2; 
        Test.startTest();
            eb1 = new EqualsBuilder()
                                .append(a1.Name, a2.Name)
                                .append(a1.ShippingLatitude, a2.ShippingLatitude)
                                .append(a1.NumberOfEmployees, a2.NumberOfEmployees);

            eb2 = new EqualsBuilder()
                                .append(a2.Name, a3.Name)
                                .append(a2.ShippingLatitude, a3.ShippingLatitude)
                                .append(a2.NumberOfEmployees, a3.NumberOfEmployees);
        Test.stopTest();

        System.assertEquals(true, eb1.build(), 'Accounts should be equal');
        System.assertEquals(false, eb2.build(), 'Accounts should not be equal');
    }

    @IsTest
    private static void testListsEqual() {
        List<String> str1 = new List<String> { 'one', 'two', 'three'};
        List<String> str2 = new List<String> { 'one', 'two', 'three'};
        List<String> str3 = new List<String> { 'one', 'two', 'five', 'six'};

        EqualsBuilder eb1; 
        EqualsBuilder eb2; 

        Test.startTest();
            eb1 = new EqualsBuilder()
                            .append(str1, str2);

            eb2 = new EqualsBuilder()
                            .append(str2, str3);
        Test.stopTest();

        System.assertEquals(true, eb1.build(), 'Lists should be equal');
        System.assertEquals(false, eb2.build(), 'Lists should not be equal');

    }
}
