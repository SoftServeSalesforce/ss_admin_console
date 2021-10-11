public with sharing class DiagnosticUtil {

    public List<String> getJobClasses(String interfaceName) {
        Type interfaceType = Type.forName(interfaceName);
        List<String> result = new List<String>();
        for (ApexClass aClass : this.getApexClasses()) {
            if (interfaceType.isAssignableFrom(Type.forName(aClass.Name))) {
                result.add(aClass.Name);
            }
        }
        return result;
    }

    public Job_Setting__mdt getJobSetting(String settingName) {
        List<Job_Setting__mdt> jobSetting = [
                SELECT Id, Job_Cron_Expression__c, Job_Size__c
                FROM Job_Setting__mdt
                WHERE DeveloperName = :settingName
        ];
        if (!jobSetting.isEmpty()) {
            return jobSetting.get(0);
        }
        return null;
    }

    private List<ApexClass> getApexClasses() {
        return [
                SELECT Id, Name
                FROM ApexClass
        ];
    }
}