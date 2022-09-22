public interface DataFeeder {
    void feed(Boolean updateRecords, FeedLogger logger, String status);
}