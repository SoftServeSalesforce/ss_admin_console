public with sharing class TestSubClass3 implements TestInterface {
    public void calculate (double x) {
        System.debug('cube of ='+x*x*x);
    }
}
