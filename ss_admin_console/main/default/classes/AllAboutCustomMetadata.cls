public with sharing class AllAboutCustomMetadata {
    public AllAboutCustomMetadata() {

    }
    public static void fetchAllMetadata(){
        Map<String, Toggle__mdt>allToggles = Toggle__mdt.getAll();
        System.debug('allToggles Value: ' + allToggles.size());
    }

    public static void fetchProductionOrgToggle(){
        Toggle__mdt productionOrgToggle = Toggle__mdt.getInstance('ProductionOrgToggle');
        System.debug('Production Org Toggle value: ' + productionOrgToggle.ProductionOrgToggle__c);
    }

    public static Boolean getProductionOrgToggle(){
        Toggle__mdt productionOrgToggle = Toggle__mdt.getInstance('ProductionOrgToggle');
        return productionOrgToggle.ProductionOrgToggle__c;
    }

}
