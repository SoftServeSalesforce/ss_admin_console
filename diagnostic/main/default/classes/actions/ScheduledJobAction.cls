public with sharing class ScheduledJobAction implements IAction {

    private String className;
    private DiagnosticLogger logger;

    public ScheduledJobAction(String className) {
        this.className = className;
        this.logger = new DiagnosticLogger();
    }

    public List<DiagnosticResult> test() {
        CronTrigger cronTrigger = this.getCronTriggers();
        if (cronTrigger == null) {
            Job_Setting__mdt setting = new DiagnosticUtil().getJobSetting(Constants.CRON_EXPRESSION_NAME);
            if (setting == null || setting.Job_Cron_Expression__c == null
                    || String.isBlank(setting.Job_Cron_Expression__c)) {
                this.generateEmptyCronLog();
            }
            this.logger.generateLog('Job ' + this.className + ' is not scheduled yet',
                    'You can run job by this schedule: ' + setting.Job_Cron_Expression__c
                            + '. Or you can change scheduled time in Job Setting custom metadata',
                    Constants.OK_STATUS);
        } else {
            this.logger.generateLog('Job ' + this.className + ' is already scheduled',
                    'Next fire time is ' + cronTrigger.NextFireTime, Constants.FAILED_STATUS);
        }

        return new List<DiagnosticResult>();
    }

    public List<DiagnosticResult> execute() {
        CronTrigger cronTrigger = this.getCronTriggers();
        if (cronTrigger == null) {
            Job_Setting__mdt setting = new DiagnosticUtil().getJobSetting(Constants.CRON_EXPRESSION_NAME);
            if (setting == null || setting.Job_Cron_Expression__c == null || String.isBlank(setting.Job_Cron_Expression__c)) {
                this.generateEmptyCronLog();
            }
            try {
                System.schedule(this.className + ' run ' + System.today(),
                        setting.Job_Cron_Expression__c,
                        (Schedulable)(Type.forName(this.className).newInstance()));
                this.logger.generateLog('Job ' + this.className + ' was successfully scheduled',
                        null,
                        Constants.OK_STATUS);
            } catch (Exception ex) {
                this.logger.generateLog('Error for scheduled ' + this.className,
                        'Error occurred: ' + ex.getMessage(), Constants.FAILED_STATUS);
            }
        } else {
            this.logger.generateLog('Job ' + this.className + ' is already scheduled',
                    'Next fire time is ' + cronTrigger.NextFireTime, Constants.FAILED_STATUS);
        }

        return new List<DiagnosticResult>();
    }

    private CronTrigger getCronTriggers() {
        List<CronTrigger> cronTriggers = [
                SELECT Id,
                        CronJobDetail.Name,
                        CronJobDetail.Id,
                        NextFireTime,
                        State
                FROM CronTrigger
                WHERE CronJobDetail.Name LIKE :this.className + '%'
        ];
        if (!cronTriggers.isEmpty()) {
            return cronTriggers.get(0);
        }
        return null;
    }

    private void generateEmptyCronLog() {
        this.logger.generateLog('Error for scheduled ' + this.className,
                'Error occurred: Cron Expression is empty, ' +
                        'please fill in cron expression in Job Setting custom metadata', Constants.FAILED_STATUS);
    }
}