public with sharing class TestSubClass2 implements TestInterface {
    public void calculate (double x) {
        System.debug('SquareRoot of = ' + Math.sqrt(x));
    }
}
