public inherited sharing class StaticDataSupplier implements DataSupplier {

    private List<SObject> data;

    public StaticDataSupplier(List<SObject> data) {
        this.data = data;
    }

    public List<SObject> supply() {
        return data;
    }
}