/**
 * Atomic data feeder.
 */
public with sharing class CompositeDataFeeder implements DataFeeder {
    private DataFeeder[] feeders;
    private FeedLogger logger;

    public CompositeDataFeeder(DataFeeder[] feeders, FeedLogger logger) {
        this.feeders = feeders;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords, FeedLogger logger, String status) {
        Savepoint sp = Database.setSavepoint();
        try {
            for (DataFeeder feeder : feeders) {
                feeder.feed(updateRecords, logger, status);
            }
        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        }
    }
}