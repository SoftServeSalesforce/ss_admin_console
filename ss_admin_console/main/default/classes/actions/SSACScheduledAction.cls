public with sharing class SSACScheduledAction implements ISSACAction {

    private String className;
    private SSACLogger logger;

    public SSACScheduledAction(String className) {
        this.className = className;
        this.logger = new SSACLogger();
    }

    public List<SSACResult> test() {
        CronTrigger cronTrigger = this.getCronTriggers();
        if (cronTrigger == null) {
            Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.CRON_EXPRESSION_NAME);
            if (setting == null || setting.Job_Cron_Expression__c == null
                    || String.isBlank(setting.Job_Cron_Expression__c)) {
                this.generateEmptyCronLog();
            }
            this.logger.publishLog('Job ' + this.className + ' is not scheduled yet',
                    'You can run job by this schedule: ' + setting.Job_Cron_Expression__c
                            + '. Or you can change scheduled time in Job Setting custom metadata',
                    SSACConstants.OK_STATUS);
        } else {
            this.logger.publishLog('Job ' + this.className + ' is already scheduled',
                    'Next fire time is ' + cronTrigger.NextFireTime, SSACConstants.FAILED_STATUS);
        }

        return new List<SSACResult>();
    }

    public List<SSACResult> execute() {
        CronTrigger cronTrigger = this.getCronTriggers();
        if (cronTrigger == null) {
            Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.CRON_EXPRESSION_NAME);
            if (String.isBlank(setting?.Job_Cron_Expression__c)) {
                this.generateEmptyCronLog();
            }
            try {
                System.schedule(this.className + ' run ' + System.today(),
                        setting.Job_Cron_Expression__c,
                        (Schedulable) Type.forName(this.className).newInstance());
                this.logger.publishLog('Job ' + this.className + ' was successfully scheduled',
                        null,
                        SSACConstants.OK_STATUS);
            } catch (Exception ex) {
                this.logger.publishLog('Error for scheduled ' + this.className,
                        'Error occurred: ' + ex.getMessage(), SSACConstants.FAILED_STATUS);
            }
        } else {
            this.logger.publishLog('Job ' + this.className + ' is already scheduled',
                    'Next fire time is ' + cronTrigger.NextFireTime, SSACConstants.FAILED_STATUS);
        }

        return new List<SSACResult>();
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
        this.logger.publishLog('Error for scheduled ' + this.className,
                'Error occurred: Cron Expression is empty, ' +
                        'please fill in cron expression in Job Setting custom metadata', SSACConstants.FAILED_STATUS);
    }
}