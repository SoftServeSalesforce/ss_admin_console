public inherited sharing class AsyncDataFeeder implements DataFeeder {

    private DataFeeder originalFeeder;
    private FeedLogger logger;

    public AsyncDataFeeder(DataFeeder originalFeeder) {
        this.originalFeeder = originalFeeder;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords, Boolean checkOnly, FeedLogger logger) {
        if (originalFeeder instanceof AsyncDataFeeder) {
            originalFeeder.feed(updateRecords, checkOnly, logger);
        } else {
            System.enqueueJob(new AsyncExecutor(originalFeeder, updateRecords, checkOnly, logger));
        }
    }

    private class AsyncExecutor implements Queueable {
        private DataFeeder feeder;
        private Boolean updateRecords;
        private FeedLogger logger;
        private Boolean checkOnly;

        private AsyncExecutor(DataFeeder feeder, Boolean updateRecords, Boolean checkOnly, FeedLogger logger) {
            this.feeder = feeder;
            this.updateRecords = updateRecords;
            this.checkOnly = checkOnly;
            this.logger = logger;
        }

        public void execute(QueueableContext qc) {
            feeder.feed(updateRecords, checkOnly, logger);
        }
    }
}