public with sharing class AllAboutCustomMetadata {
    public AllAboutCustomMetadata() {

    }
    public static void fetchAllMetadata(){
        Map<String, ProductionOrgToggle__mdt>allToggles = ProductionOrgToggle__mdt.getAll();
        System.debug('allToggles Value: ' + ProductionOrgToggle__mdt);
    }
}
