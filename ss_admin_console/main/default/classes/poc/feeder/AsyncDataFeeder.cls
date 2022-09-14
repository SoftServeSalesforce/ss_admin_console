public inherited sharing class AsyncDataFeeder implements DataFeeder {

    private DataFeeder originalFeeder;
    private FeedLogger logger;

    public AsyncDataFeeder(DataFeeder originalFeeder) {
        this.originalFeeder = originalFeeder;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords, FeedLogger logger, String status) {
        if (originalFeeder instanceof AsyncDataFeeder) {
            originalFeeder.feed(updateRecords, logger, status);
        } else {
            System.enqueueJob(new AsyncExecutor(originalFeeder, updateRecords, logger, status));
        }
    }

    private class AsyncExecutor implements Queueable {
        private DataFeeder feeder;
        private Boolean updateRecords;
        private FeedLogger logger;
        private String status;

        private AsyncExecutor(DataFeeder feeder, Boolean updateRecords, FeedLogger logger, String status) {
            this.feeder = feeder;
            this.updateRecords = updateRecords;
            this.logger = logger;
            this.status = status;
        }

        public void execute(QueueableContext qc) {
            feeder.feed(updateRecords, logger, status);
        }
    }
}