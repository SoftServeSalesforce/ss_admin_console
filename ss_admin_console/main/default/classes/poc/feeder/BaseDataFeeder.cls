public inherited sharing class BaseDataFeeder implements DataFeeder {
    private DataSupplier supplier;

    public BaseDataFeeder(DataSupplier supplier) {
        this.supplier = supplier;
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {

    }
}