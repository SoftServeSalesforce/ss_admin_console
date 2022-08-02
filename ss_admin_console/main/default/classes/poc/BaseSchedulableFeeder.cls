// TODO What does this class do?
public with sharing class BaseSchedulableFeeder {
    private String className;
    private SSACLogger logger;

    public BaseSchedulableFeeder(String className) {
        this.className = className;
        this.logger = new SSACLogger();
    }

    public void feed(Boolean updateRecords) {
        CronTrigger cronTrigger = this.getCronTriggers();
        if (cronTrigger == null) {
            Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.CRON_EXPRESSION_NAME);
            if (setting == null || setting.Job_Cron_Expression__c == null
                    || String.isBlank(setting.Job_Cron_Expression__c)) {
                this.generateEmptyCronLog();
            }
            if (updateRecords) {
                try {
                    System.schedule(className + ' run ' + System.today(),
                            setting.Job_Cron_Expression__c,
                            (Schedulable) Type.forName(className).newInstance());
                    logger.publishLog('Job ' + className + ' was successfully scheduled',
                            null,
                            SSACConstants.OK_STATUS);
                } catch (Exception ex) {
                    logger.publishLog('Error for scheduled ' + className,
                            'Error occurred: ' + ex.getMessage(), SSACConstants.FAILED_STATUS);
                }
            } else {
                logger.publishLog('Job ' + className + ' is not scheduled yet',
                        'You can run job by this schedule: ' + setting.Job_Cron_Expression__c
                                + '. Or you can change scheduled time in Job Setting custom metadata',
                        SSACConstants.OK_STATUS);
            }
        } else {
            logger.publishLog('Job ' + className + ' is already scheduled',
                    'Next fire time is ' + cronTrigger.NextFireTime, SSACConstants.FAILED_STATUS);
        }
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
