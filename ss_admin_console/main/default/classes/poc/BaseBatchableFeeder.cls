// TODO What does this class do?
public with sharing class BaseBatchableFeeder {
    /*
    private String className;
    // TODO To be replaced with use of FeedLogger provided as parameter to feed() method
    private SSACLogger oldLogger;

    public BaseBatchableFeeder(String className) {
        this.className = className;
        this.oldLogger = new SSACLogger();
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
                    oldLogger.publishLog('Job ' + this.className + ' was successfully run',
                            'Job id: ' + batchJobId,
                            SSACConstants.OK_STATUS);
                } catch (Exception ex) {
                    oldLogger.publishLog('Error for run ' + className,
                            'Error occurred: ' + ex.getMessage(), SSACConstants.FAILED_STATUS);
                }
            } else {
                oldLogger.publishLog('Job ' + this.className + ' can be run, batch size is: ' + setting.Job_Size__c,
                        'You can change batch size Job Setting custom metadata',
                        SSACConstants.OK_STATUS);
            }
        }
    }

    private void generateEmptyBatchSizeLog() {
        oldLogger.publishLog('Error for batchable ' + className,
                'Error occurred: Job size is empty, ' +
                        'please fill in job sine in Job Setting custom metadata: Job Size', SSACConstants.FAILED_STATUS);
    }
     */
}
