public with sharing class SSACProductDataAction extends SSACAsyncAction {

    public override List<SSACResult> test() {
        List<SSACResult> result = new SSACSObjectAction(
            ProductConstants.PRODUCT_API_NAME, ProductConstants.PRODUCTS_DATA,
            ProductConstants.EXTERNAL_IDS_API_NAMES_PRODUCT,
            ProductConstants.ALL_FIELDS_API_NAMES_PRODUCT).test();
        result.addAll(new SSACSObjectAction(
            ProductConstants.PRICE_BOOK_API_NAME, ProductConstants.PRICE_BOOK_DATA,
            ProductConstants.EXTERNAL_IDS_API_NAMES_PRICE_BOOK,
            ProductConstants.ALL_FIELDS_API_NAMES_PRICE_BOOK).test());
        for (String priceBookName : ProductConstants.PRICE_BOOK_ENTRY_DATA.keySet()) {
            List<SSACResult> entryResults = new SSACSObjectAction(
                ProductConstants.PRICE_BOOK_ENTRY_API_NAME,
                this.generateTestEntries(priceBookName),
                ProductConstants.EXTERNAL_IDS_API_NAMES_PRICE_BOOK_ENTRY,
                ProductConstants.ALL_FIELDS_API_NAMES_PRICE_BOOK_ENTRY
                /*'Pricebook2.Name = \'' + priceBookName + '\''*/).test();
            result.addAll(entryResults);
        }
        new SSACLogger().publishResultLog(SSACConstants.PRODUCTS_DATA, 'Test');
        return result;
    }

    public override List<SSACResult> execute() {
        List<SSACResult> productResults = new SSACSObjectAction(
            ProductConstants.PRODUCT_API_NAME, ProductConstants.PRODUCTS_DATA,
            ProductConstants.EXTERNAL_IDS_API_NAMES_PRODUCT,
            ProductConstants.ALL_FIELDS_API_NAMES_PRODUCT).execute();
        productResults.addAll(new SSACSObjectAction(
            ProductConstants.PRICE_BOOK_API_NAME,
            ProductConstants.PRICE_BOOK_DATA,
            ProductConstants.EXTERNAL_IDS_API_NAMES_PRICE_BOOK,
            ProductConstants.ALL_FIELDS_API_NAMES_PRICE_BOOK).execute());
        Map<Id, Map<String, PricebookEntry>> allEntriesByPriceBookId = this.generateEntries(
            ProductConstants.PRICE_BOOK_ENTRY_DATA, this.getPriceBooks(), this.getProductByProductCode(
                this.getProductCodes(ProductConstants.PRICE_BOOK_ENTRY_DATA)));
        for (Id i : allEntriesByPriceBookId.keySet()) {
            List<SSACResult> entryResults = new SSACSObjectAction(ProductConstants.PRICE_BOOK_ENTRY_API_NAME,
                allEntriesByPriceBookId.get(i),
                ProductConstants.EXTERNAL_IDS_API_NAMES_PRICE_BOOK_ENTRY,
                ProductConstants.ALL_FIELDS_API_NAMES_PRICE_BOOK_ENTRY,
                'Pricebook2Id = \'' + i + '\'').execute();
            productResults.addAll(entryResults);
        }
        new SSACLogger().publishResultLog(SSACConstants.PRODUCTS_DATA, 'Execute');
        return productResults;
    }

    @TestVisible
    private Set<String> getProductCodes(Map<String, Map<String, PricebookEntry>> priceBookEntryData) {
        Set<String> productCodes = new Set<String>();
        for (Map<String, PricebookEntry> entryMap : priceBookEntryData.values()) {
            productCodes.addAll(entryMap.keySet());
        }
        return productCodes;
    }

    @TestVisible
    private Map<Id, Map<String, PricebookEntry>> generateEntries(Map<String, Map<String, PricebookEntry>> pricebookEntries,
        Map<String, Pricebook2> priceBookByName, Map<String, Product2> productByProductCode) {
        Map<Id, Map<String, PricebookEntry>> allEntries = new Map<Id, Map<String, PricebookEntry>>();
        for (String priceBookName : pricebookEntries.keySet()) {
            if (priceBookByName.containsKey(priceBookName)) {
                allEntries.put(priceBookByName.get(priceBookName).Id,
                    this.getPriceBookEntries(priceBookByName.get(priceBookName), pricebookEntries.get(priceBookName),
                    productByProductCode)
                );
            }
        }
        return allEntries;
    }

    @TestVisible
    private Map<String, PricebookEntry> getPriceBookEntries(Pricebook2 pricebook, Map<String, PricebookEntry> pricebookEntries,
            Map<String, Product2> productByProductCode) {
        Map<String, PricebookEntry> result = new Map<String, PricebookEntry>();
        for (String entryCode : pricebookEntries.keySet()) {
            if (productByProductCode.containsKey(entryCode)) {
                PricebookEntry entry = pricebookEntries.get(entryCode);
                entry.Pricebook2Id = pricebook.Id;
                entry.Product2Id = productByProductCode.get(entryCode).Id;
                result.put(entryCode, entry);
            }
        }
        return result;
    }

    @TestVisible
    private Map<String, Product2> getProductByProductCode(Set<String> productCodes) {
        Map<String, Product2> productByProductCode = new Map<String, Product2>();
        for (Product2 pr : [
                SELECT Id, ProductCode
                FROM Product2
                WHERE ProductCode IN :productCodes
        ]) {
            productByProductCode.put(pr.ProductCode, pr);
        }

        return productByProductCode;
    }

    @TestVisible
    private Map<String, Pricebook2> getPriceBooks() {
        Map<String, Pricebook2> priceBooks = new Map<String, Pricebook2>();
        for (Pricebook2 pr : [
                SELECT Name, Id
                FROM Pricebook2
        ]) {
            priceBooks.put(pr.Name, pr);
        }

        return priceBooks;
    }
    
    @TestVisible
    private Map<String, PricebookEntry> generateTestEntries(String priceBookName) {
        Map<String, PricebookEntry> entriesMap = ProductConstants.PRICE_BOOK_ENTRY_DATA.get(priceBookName);
        for(String obj: entriesMap.keySet()) {
            entriesMap.get(obj).putSObject('Product2', new Product2(ProductCode = obj));
            entriesMap.put(obj, entriesMap.get(obj));
        }
        return entriesMap;
    }
    
}