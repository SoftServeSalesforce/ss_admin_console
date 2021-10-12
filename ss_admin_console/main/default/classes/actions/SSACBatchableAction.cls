public with sharing class SSACBatchableAction implements ISSACAction {

    private String className;
    private SSACLogger logger;

    public SSACBatchableAction(String className) {
        this.className = className;
        this.logger = new SSACLogger();
    }

    public List<SSACResult> test() {
        Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.SIZE_JOB_NAME);
        if (setting == null || setting.Job_Size__c == null) {
           this.generateEmptyBatchSizeLog();
        } else {
            this.logger.publishLog('Job ' + this.className + ' can be run, batch size is: ' + setting.Job_Size__c,
                    'You can change batch size Job Setting custom metadata',
                    SSACConstants.OK_STATUS);
        }
        return new List<SSACResult>();
    }

    public List<SSACResult> execute() {
        Job_Setting__mdt setting = new SSACUtil().getJobSetting(SSACConstants.SIZE_JOB_NAME);
        if (setting == null || setting.Job_Size__c == null) {
            this.generateEmptyBatchSizeLog();
        } else {
            try {
                Id batchJobId = Database.executeBatch((Database.Batchable<SObject>)(Type.forName(this.className).newInstance()),
                        Integer.valueOf(setting.Job_Size__c));
                this.logger.publishLog('Job ' + this.className + ' was successfully run',
                        'Job id: ' + batchJobId,
                        SSACConstants.OK_STATUS);
            } catch(Exception ex) {
                this.logger.publishLog('Error for run ' + this.className,
                        'Error occurred: ' + ex.getMessage(), SSACConstants.FAILED_STATUS);
            }
        }
        return new List<SSACResult>();
    }

    private void generateEmptyBatchSizeLog() {
        this.logger.publishLog('Error for batchable ' + this.className,
                'Error occurred: Job size is empty, ' +
                        'please fill in job sine in Job Setting custom metadata: Job Size', Constants.FAILED_STATUS);
    }
}