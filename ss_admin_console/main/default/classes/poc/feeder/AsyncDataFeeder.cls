public inherited sharing class AsyncDataFeeder implements DataFeeder {

    private DataFeeder originalFeeder;
    private FeedLogger logger;

    public AsyncDataFeeder(DataFeeder originalFeeder) {
        this.originalFeeder = originalFeeder;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords, FeedLogger logger) {
        if (originalFeeder instanceof AsyncDataFeeder) {
            originalFeeder.feed(updateRecords, logger);
        } else {
            System.enqueueJob(new AsyncExecutor(originalFeeder, updateRecords, logger));
        }
    }

    private class AsyncExecutor implements Queueable {
        private DataFeeder feeder;
        private Boolean updateRecords;
        private FeedLogger logger;

        private AsyncExecutor(DataFeeder feeder, Boolean updateRecords, FeedLogger logger) {
            this.feeder = feeder;
            this.updateRecords = updateRecords;
            this.logger = logger;
        }

        public void execute(QueueableContext qc) {
            feeder.feed(updateRecords, logger);
        }
    }
}