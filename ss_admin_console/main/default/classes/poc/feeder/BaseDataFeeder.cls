public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;
    private FeedLogger logger;

    // TODO Replace List<String> with List<FieldReference>
    public BaseDataFeeder(DataSupplier supplier, List<String> keyFields, FeedLogger logger) {
        this.supplier = supplier;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords) {
        for (SObject obj : supplier.supply()) {

        }
    }
}