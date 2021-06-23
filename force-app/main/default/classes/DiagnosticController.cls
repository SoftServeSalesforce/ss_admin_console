public with sharing class DiagnosticController {

	public static final String WARNING_STATUS = 'WARNING';
	public static final String FAILED_STATUS = 'FAILED';
	public static final String OK_STATUS = 'OK';

	@AuraEnabled
	public static String checkData() {
		String result = '<h2>Validation started </h2>';
		result += validateQuestions();
		return result;
	}

	@AuraEnabled
	public static String populateData() {
		String result = '<h2>Population started </h2>';
		result += populateQuestions();
		return result;
	}
    
	@AuraEnabled
	public static String setUpBatch() {
		String result = '<p>FSL Nightly Batch Schedule job setup </p>';
		// try {
		// 	FslNightlyBatchScheduler sch = new FslNightlyBatchScheduler();
		// 	String jobId = System.schedule('FSL Nightly Batch Schedule job', '0 0 0 ? * * *', sch);
		// 	CronTrigger ct = [
		// 			SELECT Id, CronExpression, TimesTriggered, NextFireTime
		// 			FROM CronTrigger WHERE id = :jobId];

		// 	result += '<p>Next scheduled run at ' + ct.NextFireTime + '</p>';
		// } catch(Exception e) {
		// 	result += 'Error while setup FSL Nightly Batch Schedule job: ' + e.getMessage();
		// }
		return result;
	}

	@AuraEnabled
	public static String runCountTimeBatch() {
		String result = '<p>Run CountTimeBetweenAppointments Batch </p>';
		// try {
		// 	//String jobId = Database.executeBatch(new CountTimeBetweenAppointmentsBatchable());
		// 	AsyncApexJob a = [
		// 			SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
		// 			FROM AsyncApexJob
		// 			WHERE Id = :jobId
		// 	];

		// 	result += '<p>Service Appointments batch update (Time Between Appointments) ' + a.Status
		// 			+ '. Processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures.</p>';
		// } catch(Exception e) {
		// 	result += 'Error while setup Run Batch: ' + e.getMessage();
		// }
		return result;
	}

	private static String validateQuestions() {
		String result = '<h4>Validating Questions </h4>';
		
		return result + '<br />';
	}

    @AuraEnabled
	public static String populateQuestions() {
		String result = '<h4>Population Questions </h4>';
		
		return result + '<br />';
	}


	private static List<sObject> getMissedRecords(Map<String, sObject> expected, Map<String, sObject> actual) {
		List<sObject> result = new List<sObject>();
		for (sObject item : expected.values()) {
			String fieldName = getCorrectFieldName(item);
			if (!actual.containsKey((String)item.get(fieldName))) {
				result.add(item);
			}
		}
		return result;
	}


	private static String failedText(String name) {
		return FAILED_STATUS + ' ' + name + ' <br />';
	}

	private static String successText(String name) {
		return OK_STATUS + ' ' + name + ' <br />';
	}

	private static String warningText(String name) {
		return WARNING_STATUS + ' ' + name + ' <br />';
	}
}