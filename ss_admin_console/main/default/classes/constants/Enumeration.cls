public inherited sharing abstract class Enumeration { 
    private final String value;

    protected Enumeration(String value) {
        this.value = value;
    }
    public String value() {
        return value;
    }
}