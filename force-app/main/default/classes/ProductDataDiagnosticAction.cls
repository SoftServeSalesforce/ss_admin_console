public with sharing class ProductDataDiagnosticAction extends AsyncDiagnosticAction {
    public override List<DiagnosticResult> test() {
        try {
            List<DiagnosticResult> result = new SObjectDiagnosticAction(
                    ProductConstants.PRODUCT_API_NAME, ProductConstants.PRODUCTS_DATA, ProductConstants.PRODUCT_CODE_API_NAME).test();
            result.addAll(new SObjectDiagnosticAction(
                    ProductConstants.PRICE_BOOK_API_NAME, ProductConstants.PRICE_BOOK_DATA, ProductConstants.NAME_API_NAME).test());
            for (String priceBookName : ProductConstants.PRICE_BOOK_ENTRY_DATA.keySet()) {
                List<DiagnosticResult> entryResults = new SObjectDiagnosticAction(
                        ProductConstants.PRICE_BOOK_ENTRY_API_NAME,
                        ProductConstants.PRICE_BOOK_ENTRY_DATA.get(priceBookName),
                        ProductConstants.PRODUCT_CODE_API_NAME,
                        'Pricebook2.Name = \'' + priceBookName + '\'').test();
                result.addAll(entryResults);
            }
            return result;
        } catch (Exception ex) {
            return new List<DiagnosticResult>();
        }
    }

    public override List<DiagnosticResult> execute() {
        List<DiagnosticResult> productResults = new SObjectDiagnosticAction(
                ProductConstants.PRODUCT_API_NAME, ProductConstants.PRODUCTS_DATA, ProductConstants.PRODUCT_CODE_API_NAME).execute();
        List<DiagnosticResult> priceBookResult = new SObjectDiagnosticAction(
                ProductConstants.PRICE_BOOK_API_NAME, ProductConstants.PRICE_BOOK_DATA, ProductConstants.NAME_API_NAME).execute();

        Map<String, Pricebook2> priceBookByName = this.getPriceBookByName();
        Set<String> productCodes = this.getProductCodes(ProductConstants.PRICE_BOOK_ENTRY_DATA);
        Map<String, Product2> productByProductCode = this.getProductByProductCode(productCodes);

        Map<Id, Map<String, PricebookEntry>> allEntriesByPriceBookId = this.generateEntries(
                ProductConstants.PRICE_BOOK_ENTRY_DATA, priceBookByName, productByProductCode);

        for (Id i : allEntriesByPriceBookId.keySet()) {
            List<DiagnosticResult> entryResults = new SObjectDiagnosticAction(ProductConstants.PRICE_BOOK_ENTRY_API_NAME,
                    allEntriesByPriceBookId.get(i), ProductConstants.PRODUCT_CODE_API_NAME,
                    'Pricebook2Id = \'' + i + '\'').execute();
            productResults.addAll(entryResults);
        }

        productResults.addAll(priceBookResult);
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
        List<Product2> products = [
                SELECT Id, ProductCode
                FROM Product2
                WHERE ProductCode IN :productCodes
        ];
        for (Product2 pr : products) {
            productByProductCode.put(pr.ProductCode, pr);
        }

        return productByProductCode;
    }

    @TestVisible
    private Map<String, Pricebook2> getPriceBookByName() {
        Map<String, Pricebook2> priceBookByName = new Map<String, Pricebook2>();
        List<Pricebook2> priceBooks = [
                SELECT Name, Id
                FROM Pricebook2
        ];
        for (Pricebook2 pr : priceBooks) {
            priceBookByName.put(pr.Name, pr);
        }

        return priceBookByName;
    }
}