public with sharing class TestBatchable implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM Account';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
    }

    public void finish(Database.BatchableContext bc) {
    }
}