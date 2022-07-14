@IsTest
public inherited sharing class SetUtilsTest {

    @IsTest
    static void testSetOfStrings(){
        FieldReference field = FieldReference.build(Account.Name);
        Set<Object> objs = new Set<Object>{'Test1', 'Test2'};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<String>, true, 'Method must return set of strings');
    }

    @IsTest
    static void testNegativeSetOfStrings(){
        FieldReference field = FieldReference.build(Account.Name);
        Set<Object> objs = new Set<Object>{'Test1', 2};

        Test.startTest();
        try{
            Object result = new SetUtils().toSetOfType(field,objs);
        } catch (TypeException ex) {
            System.assertEquals('Invalid conversion from runtime type Integer to String', ex.getMessage());
        }  
        Test.stopTest();

        // System.assertEquals(result instanceof Set<String>, true, 'Method must return set of strings');
    }

    @IsTest
    static void testSetOfDoubles(){
        FieldReference field = FieldReference.build(Opportunity.Amount);
        Set<Object> objs = new Set<Object>{1.2, 2.3};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<Double>, true, 'Method must return set of doubles');
    }

    @IsTest
    static void testSetOfIntegers(){
        FieldReference field = FieldReference.build(Campaign.NumberOfContacts);
        Set<Object> objs = new Set<Object>{1, 2, 3};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<Integer>, true, 'Method must return set of integers');
    }

    @IsTest
    static void testSetOfDate(){
        FieldReference field = FieldReference.build(Opportunity.CloseDate);
        Set<Object> objs = new Set<Object>{Date.newInstance(1960, 2, 17)};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<Date>, true, 'Method must return set of dates');
    }

    @IsTest
    static void testSetOfDateTime(){
        FieldReference field = FieldReference.build(Case.ClosedDate);
        Set<Object> objs = new Set<Object>{Datetime.newInstance(2020, 2, 17)};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<Datetime>, true, 'Method must return set of datetimes');
    }

    @IsTest
    static void testSetOfBooleans(){
        FieldReference field = FieldReference.build(User.IsActive);
        Set<Object> objs = new Set<Object>{true};

        Test.startTest();
        Object result = new SetUtils().toSetOfType(field,objs);
        Test.stopTest();

        System.assertEquals(result instanceof Set<Boolean>, true, 'Method must return set of booleans');
    }
}
