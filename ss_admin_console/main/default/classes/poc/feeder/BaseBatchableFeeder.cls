public with sharing class BaseBatchableFeeder implements DataFeeder {
    private String className;
    private SSACLogger logger;

    public BaseBatchableFeeder(String className) {
        this.className = className;
        this.logger = new SSACLogger();
    }

    public void feed(Boolean updateRecords) {
        Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.SIZE_JOB_NAME);
        if (setting == null || setting.Job_Size__c == null) {
           this.generateEmptyBatchSizeLog();
        } else {
            if (updateRecords) {
                try {
                    Id batchJobId = Database.executeBatch((Database.Batchable<SObject>)(Type.forName(className).newInstance()),
                            Integer.valueOf(setting.Job_Size__c));
                    logger.publishLog('Job ' + this.className + ' was successfully run',
                            'Job id: ' + batchJobId,
                            SSACConstants.OK_STATUS);
                } catch (Exception ex) {
                    logger.publishLog('Error for run ' + className,
                            'Error occurred: ' + ex.getMessage(), SSACConstants.FAILED_STATUS);
                }
            } else {
                logger.publishLog('Job ' + this.className + ' can be run, batch size is: ' + setting.Job_Size__c,
                        'You can change batch size Job Setting custom metadata',
                        SSACConstants.OK_STATUS);
            }
        }
    }

    private void generateEmptyBatchSizeLog() {
        logger.publishLog('Error for batchable ' + className,
                'Error occurred: Job size is empty, ' +
                        'please fill in job sine in Job Setting custom metadata: Job Size', SSACConstants.FAILED_STATUS);
    }
}
