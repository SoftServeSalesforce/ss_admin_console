public with sharing class DiagnosticController {

	@AuraEnabled
	public static List<String> obtainJobClasses(String interfaceName) {
		DiagnosticService service = new DiagnosticService();
		List<String> result = new List<String>();
		try {
			result = service.obtainClasses(interfaceName);
		} catch (Exception e) {
			throw new AuraHandledException(e.getMessage());
		}
		
		return result;
	}

	@AuraEnabled
	public static String setUpScheduledJob(String className, String jobTime) {
		DiagnosticService service = new DiagnosticService();
		String result = 'Batch Schedule job setup';
		String cronExpression = service.getCronException(jobTime);
		try {
			Schedulable job = (Schedulable) (Type.forName(className).newInstance());
		 	String jobId = System.schedule('Batch Schedule job', cronExpression, job);
			result += ' started successfully.';
		} catch(Exception e) {
		 	result += '. Error while setup Batch Schedule job + ' + className + ': ' + e.getMessage();
		}

		return result;
	}

	@AuraEnabled
	public static String runBatch(String className, Integer batchSize) {
		String result = 'Run batch: ' + className;
		try {
			Database.Batchable<SObject> job = (Database.Batchable<SObject>) (Type.forName(className).newInstance());
			Database.executeBatch(job, batchSize);
			result += ' started successfully.';
		} catch(Exception e) {
			result += ' Error while setup Run Batch: ' + e.getMessage();
		}

		return result;
	}

	@AuraEnabled
	public static String runDataLoading() {
		String result = '';
		try {
			ID jobID = System.enqueueJob(new TestDataCreator());
			result += 'Run data loading...';
		} catch(Exception e) {
			result += ' Error while setup data loading: ' + e.getMessage();
		}
		
		return result;
	}
}