public with sharing class ApexSelector {
    
    public List<ApexClass> getApexClasses() {
        return [
            SELECT Id, Name 
            FROM ApexClass
        ];
    }
}
