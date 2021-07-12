public class DailyScheduleJob implements Schedulable {
    public void execute(SchedulableContext ctx) {
        DailyBatchJob job = new DailyBatchJob();
        Database.executeBatch(job, 200);
    }
}