public with sharing class OpportunityDataDiagnosticAction extends AsyncDiagnosticAction {

    public override List<DiagnosticResult> test() {
        try {
            DiagnosticDataHandler handler = new DiagnosticDataHandler();
            Map<String, SObject> validOpportunityRecords = handler.getValidRecords(OpportunityConstants.OPPORTUNITY_DATA,
                    OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                    OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME);
            List<DiagnosticResult> result = new SObjectDiagnosticAction(
                    OpportunityConstants.OPPORTUNITY_API_NAME, validOpportunityRecords,
                    OpportunityConstants.OPPORTUNITY_KEY_FIELD_NAME).test();
            Map<String, SObject> validOpportunityItemRecords = handler.getValidRecords(OpportunityConstants.OPPORTUNITY_ITEM_DATA,
                    new Set<String>{
                            'Product2Id'
                    },
                    OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                    OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME);
            result.addAll(new SObjectDiagnosticAction(
                    OpportunityConstants.OPPORTUNITY_ITEM_API_NAME, validOpportunityItemRecords,
                    OpportunityConstants.OPPORTUNITY_ITEM_KEY_FIELD_NAME).test());
            return result;
        } catch (Exception ex) {
            return new List<DiagnosticResult>();
        }
    }

    public override List<DiagnosticResult> execute() {
        DiagnosticDataHandler handler = new DiagnosticDataHandler();
        Map<String, SObject> validOpportunityRecords = handler.getValidRecords(OpportunityConstants.OPPORTUNITY_DATA,
                OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME);
        List<DiagnosticResult> result = new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_API_NAME, validOpportunityRecords,
                OpportunityConstants.OPPORTUNITY_KEY_FIELD_NAME).execute();

        Map<String, SObject> validOpportunityItemRecords = handler.getValidRecords(OpportunityConstants.OPPORTUNITY_ITEM_DATA,
                OpportunityConstants.REFERENCE_FIELD_TO_KEY_FILED,
                OpportunityConstants.REFERENCE_FIELD_TO_SOBJECT_NAME);
        this.addPriceBookEntry(validOpportunityItemRecords);
        result.addAll(new SObjectDiagnosticAction(
                OpportunityConstants.OPPORTUNITY_ITEM_API_NAME, validOpportunityItemRecords,
                OpportunityConstants.OPPORTUNITY_ITEM_KEY_FIELD_NAME).execute());
        return result;
    }

    @TestVisible
    private void addPriceBookEntry(Map<String, SObject> records) {
        Map<Id, Id> priceBookEntryIdByProductId = this.priceBookEntryIdByProductId(records.values());
        for (String recordKey : records.keySet()) {
            records.get(recordKey).put('PricebookEntryId',
                    priceBookEntryIdByProductId.get(String.valueOf(records.get(recordKey).get('Product2Id'))));
        }
    }

    @TestVisible
    private Map<Id, Id> priceBookEntryIdByProductId(List<SObject> records) {
        String query = 'SELECT Id, Name, IsActive, ProductCode, Pricebook2Id, Product2Id FROM PricebookEntry WHERE ';
        for (SObject sobj: records) {
            query += '(Product2Id = \'' + String.valueOf(sobj.get('Product2Id')) + '\' AND IsActive = true) OR ';
        }
        query = query.left(query.length() - 3);
        List<PricebookEntry> pricebookEntries = Database.query(query);
        Map<Id, Id> result = new Map<Id, Id>();
        for (PricebookEntry entry: pricebookEntries) {
            result.put(entry.Product2Id, entry.Id);
        }
        return result;
    }
}