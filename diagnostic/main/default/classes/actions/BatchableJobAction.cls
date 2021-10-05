public with sharing class BatchableJobAction implements IAction {

    private String className;
    private DiagnosticLogger logger;

    public BatchableJobAction(String className) {
        this.className = className;
        this.logger = new DiagnosticLogger();
    }

    public List<DiagnosticResult> test() {
        Job_Setting__mdt setting = new DiagnosticUtil().getJobSetting(Constants.SIZE_JOB_NAME);
        if (setting == null || setting.Job_Size__c == null) {
           this.generateEmptyBatchSizeLog();
        } else {
            this.logger.generateJobLog('Job ' + this.className + ' can be run, batch size is: ' + setting.Job_Size__c,
                    'You can change batch size Job Setting custom metadata',
                    Constants.OK_STATUS);
        }
        return new List<DiagnosticResult>();
    }

    public List<DiagnosticResult> execute() {
        Job_Setting__mdt setting = new DiagnosticUtil().getJobSetting(Constants.SIZE_JOB_NAME);
        if (setting == null || setting.Job_Size__c == null) {
            this.generateEmptyBatchSizeLog();
        } else {
            try {
                Id batchJobId = Database.executeBatch((Database.Batchable<SObject>)(Type.forName(this.className).newInstance()),
                        Integer.valueOf(setting.Job_Size__c));
                this.logger.generateJobLog('Job ' + this.className + ' was successfully run',
                        'Job id: ' + batchJobId,
                        Constants.OK_STATUS);
            } catch(Exception ex) {
                this.logger.generateJobLog('Error for run ' + this.className,
                        'Error occurred: ' + ex.getMessage(), Constants.FAILED_STATUS);
            }
        }
        return new List<DiagnosticResult>();
    }

    private void generateEmptyBatchSizeLog() {
        this.logger.generateJobLog('Error for batchable ' + this.className,
                'Error occurred: Job size is empty, ' +
                        'please fill in job sine in Job Setting custom metadata: Job Size', Constants.FAILED_STATUS);
    }
}