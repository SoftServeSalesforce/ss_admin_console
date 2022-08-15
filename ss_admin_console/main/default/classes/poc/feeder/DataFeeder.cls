public interface DataFeeder {
    void feed(Boolean updateRecords, Boolean checkOnly, FeedLogger logger);
}