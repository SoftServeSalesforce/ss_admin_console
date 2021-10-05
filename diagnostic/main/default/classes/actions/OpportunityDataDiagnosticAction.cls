public with sharing class OpportunityDataDiagnosticAction extends AsyncDiagnosticAction {

    public override List<DiagnosticResult> test() {
        DiagnosticDataHandler handler = new DiagnosticDataHandler();
        Map<String, SObject> opportunityRecords = handler.wrappersToRecords(
                OpportunityConstants.OPPORTUNITY_DATA);
        List<DiagnosticResult> result = new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_API_NAME, opportunityRecords,
                OpportunityConstants.OPPORTUNITY_KEY_FIELD_NAME).test();
        Map<String, SObject> opportunityItemRecords = handler.wrappersToRecords(
                OpportunityConstants.OPPORTUNITY_ITEM_DATA);
        result.addAll(new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_ITEM_API_NAME, opportunityItemRecords,
                OpportunityConstants.OPPORTUNITY_ITEM_KEY_FIELD_NAME).test());
        new DiagnosticLogger().generateResultLog(Constants.OPPORTUNITY_DATA, 'Test');
        return result;
    }

    public override List<DiagnosticResult> execute() {
        DiagnosticDataHandler handler = new DiagnosticDataHandler();
        Map<String, SObject> validOpportunityRecords = handler.getValidRecords(
                OpportunityConstants.OPPORTUNITY_DATA,
                OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME);

        List<DiagnosticResult> result = new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_API_NAME, validOpportunityRecords,
                OpportunityConstants.OPPORTUNITY_KEY_FIELD_NAME).execute();

        Map<String, SObject> validOpportunityItemRecords = this.addPriceBookEntry(handler.getValidRecords(OpportunityConstants.OPPORTUNITY_ITEM_DATA,
                OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME));
        this.addPriceBookEntry(validOpportunityItemRecords);
        result.addAll(new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_ITEM_API_NAME, validOpportunityItemRecords,
                OpportunityConstants.OPPORTUNITY_ITEM_KEY_FIELD_NAME).execute());
        new DiagnosticLogger().generateResultLog(Constants.OPPORTUNITY_DATA, 'Execute');
        return result;
    }

    @TestVisible
    private Map<String, SObject> addPriceBookEntry(Map<String, SObject> records) {
        Map<Id, Id> priceBookEntryIdByProductId = this.priceBookEntryIdByProductId(records.values());
        Map<String, SObject> result = new Map<String, SObject>();
        for (String recordKey : records.keySet()) {
            if (priceBookEntryIdByProductId.containsKey(String.valueOf(records.get(recordKey).get('Product2Id')))) {
                records.get(recordKey).put('PricebookEntryId',
                        priceBookEntryIdByProductId.get(String.valueOf(records.get(recordKey).get('Product2Id'))));
                result.put(recordKey, records.get(recordKey));
            }
        }
        return result;
    }

    @TestVisible
    private Map<Id, Id> priceBookEntryIdByProductId(List<SObject> records) {
        String query = 'SELECT Id, Name, IsActive, ProductCode, Pricebook2Id, Product2Id FROM PricebookEntry WHERE ';
        for (SObject sobj : records) {
            query += '(Product2Id = \'' + String.valueOf(sobj.get('Product2Id')) + '\' AND IsActive = true) OR ';
        }
        query = query.left(query.length() - 3);
        List<PricebookEntry> pricebookEntries = Database.query(query);
        Map<Id, Id> result = new Map<Id, Id>();
        for (PricebookEntry entry : pricebookEntries) {
            result.put(entry.Product2Id, entry.Id);
        }
        return result;
    }

    @TestVisible
    private void populatePriceBook(List<DiagnosticSObjectWrapper> wrappers) {
        String priceBookName = this.getActivePriceBookName();
        if (priceBookName == null) {
            return;
        }
        for (DiagnosticSObjectWrapper wrapper : wrappers) {
            wrapper.keyByReferenceFields.put('Pricebook2Id', priceBookName);
        }
    }

    @TestVisible
    private String getActivePriceBookName() {
        List<Pricebook2> priceBooks = [
                SELECT Id, Name
                FROM Pricebook2
                WHERE IsActive = TRUE
        ];
        if (!priceBooks.isEmpty()) {
            return priceBooks.get(0).Name;
        }
        return null;
    }
}