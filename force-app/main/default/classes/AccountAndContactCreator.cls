public with sharing class AccountAndContactCreator implements Queueable {

    public void execute(QueueableContext context) {
        List<RecordWrapper> wrappers = this.createAccounts();
        RecordsCreator creator = new RecordsCreator(wrappers);
        List<RecordWrapper> validRecords = creator.getValidRecords();
        List<RecordWrapper> invalidRecords = creator.getInvalidRecords();
        if (!invalidRecords.isEmpty()) {
            JobLogEvent__e errorEvent = new JobLogEvent__e(Message__c = 'This records: ' 
                + creator.getExternalId(invalidRecords) + ' were not created, because they already exist');
        	EventBus.publish(errorEvent);
        }
        if (!validRecords.isEmpty()) {
            List<SObject> SObjects = creator.getSObjects(validRecords);
            insert SObjects;
            JobLogEvent__e errorEvent = new JobLogEvent__e(Message__c = 'This records: ' 
                + creator.getExternalId(validRecords) + ' were created successfully');
        	EventBus.publish(errorEvent);
        }
        
    }

    private List<RecordWrapper> createAccounts() {
        List<RecordWrapper> wrappers = new List<RecordWrapper>();
        for (Integer i = 13; i < 20; i++) {
            RecordBulder record = new RecordBulder('Account', 'Name');
            record.addField('Name', 'TestName' + i);
            wrappers.add(record.createRecord());
        }
        return wrappers;
    }
}
