public class DailyBatchJob implements Database.Batchable<SObject> {
    public class DailyBatchJobException extends Exception {}
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Database.QueryLocator query = Database.getQueryLocator('SELECT Id FROM Product2 LIMIT 800');
        return query;
    }

    public void execute(Database.BatchableContext BC, List<Product2> products) {
        JobLogEvent__e startEvent = new JobLogEvent__e(Message__c = 'Batch started for next ' + products.size() + ' products');
        EventBus.publish(startEvent);
        try {
            update products;
        } catch (DailyBatchJobException ex) {
            String ids = '';
            for (Product2 pr: products) {
                ids = ids + pr.Id + '; ';
            }
            JobLogEvent__e errorEvent = new JobLogEvent__e(Message__c = 'This batch was not complited throw exeption: ' + 
                                                           ex.getMessage() + './n Product ids: ' + ids.right(ids.length() - 2));
        	EventBus.publish(errorEvent);
        }
        JobLogEvent__e finishEvent = new JobLogEvent__e(Message__c = 'Batch finish successfully');
        EventBus.publish(finishEvent);
        
    }

    public void finish(Database.BatchableContext BC) {

    }

}