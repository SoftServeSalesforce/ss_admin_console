public with sharing class DiagnosticController {
	private static DiagnosticService service = new DiagnosticService();

	@AuraEnabled
	public static List<String> obtainBatchClasses() {
		List<String> result = new List<String>();
		try {
			result = service.obtainClasses('Database.Batchable');
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
		return result;
	}

	@AuraEnabled
	public static List<String> obtainScheduledClasses() {
		List<String> result = new List<String>();
		try {
			result = service.obtainClasses('Schedulable');
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
		return result;
	}

	@AuraEnabled
	public static String setUpScheduledJob(String className, String jobTime) {
		String result = '<p>FSL Nightly Batch Schedule job setup </p>';
		String cronExpression = service.getCronException(jobTime);
		 try {
			Schedulable job = (Schedulable) (Type.forName(className).newInstance());
		 	String jobId = System.schedule('FSL Nightly Batch Schedule job', cronExpression, job);
		 } catch(Exception e) {
		 	result += 'Error while setup FSL Nightly Batch Schedule job: ' + e.getMessage();
		 }
		return result;
	}

	@AuraEnabled
	public static String runBatch(String className, Integer batchSize) {
		String result = 'Run batch: ' + className;
		 try {
			Database.Batchable<SObject> job = (Database.Batchable<SObject>) (Type.forName(className).newInstance());
			Database.executeBatch(job, batchSize);
		 } catch(Exception e) {
			 result += 'Error while setup Run Batch: ' + e.getMessage();
			}
		return result;
	}

	@AuraEnabled
	public static String runDataLoading() {
		String result = 'Run Data Loading: ';
		ID jobID = System.enqueueJob(new AccountAndContactCreator());
		return result;
	}
}