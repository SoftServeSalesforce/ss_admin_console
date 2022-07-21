public inherited sharing abstract class Enumeration { 
    private final String value;
    private final Integer valueInt;

    protected Enumeration(String value) {
        this.value = value;
    }
    public String value() {
        return value;
    }

    protected Enumeration(Integer value) {
        this.valueInt = value;
    }
    public Integer valueInt() {
        return valueInt;
    }
}