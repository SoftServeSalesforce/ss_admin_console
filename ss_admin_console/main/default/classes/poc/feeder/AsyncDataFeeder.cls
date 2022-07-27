public inherited sharing class AsyncDataFeeder implements DataFeeder {

    private DataFeeder originalFeeder;
    private FeedLogger logger;

    public AsyncDataFeeder(DataFeeder originalFeeder, FeedLogger logger) {
        this.originalFeeder = originalFeeder;
        this.logger = logger;
    }

    public void feed(Boolean updateRecords) {
        if (originalFeeder instanceof AsyncDataFeeder) {
            originalFeeder.feed(updateRecords);
        } else {
            System.enqueueJob(new AsyncExecutor(originalFeeder, updateRecords));
        }
    }

    private class AsyncExecutor implements Queueable {
        private DataFeeder feeder;
        private Boolean updateRecords;

        private AsyncExecutor(DataFeeder feeder, Boolean updateRecords) {
            this.feeder = feeder;
            this.updateRecords = updateRecords;
        }

        public void execute(QueueableContext qc) {
            feeder.feed(updateRecords);
        }
    }
}
