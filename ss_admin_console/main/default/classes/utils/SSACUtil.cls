public inherited sharing class SSACUtil {
    public static List<String> getJobClasses(String interfaceName) {
        Type interfaceType = Type.forName(interfaceName);
        List<String> result = new List<String>();
        List<ApexClass> classes = SSACUtil.getApexClasses();
        for (ApexClass aClass : classes) {
            Type classType = Type.forName(aClass.Name);
            if ((classType != null) && (interfaceType.isAssignableFrom(classType))) {
                result.add(aClass.Name);
            }
        }
        return result;
    }

    public static List<Type> getSubClasses(Type theType) {
        List<Type> result = new List<Type>();
        List<ApexClass> classes = getApexClasses();
        for (ApexClass aClass : classes) {
            try {
                Type classType = Type.forName(aClass.Name);
                if (classType != null && theType.isAssignableFrom(classType) && theType != classType) {
                    result.add(classType);
                }
            }
            catch (Exception e) {
                System.debug('Error in SSACUtil.getSubClasses: ' + e.getMessage());
            }
        }
        return result;
    }

    public static Job_Setting__mdt getJobSetting(String settingName) {
        List<Job_Setting__mdt> jobSetting = [SELECT Id, Job_Cron_Expression__c, Job_Size__c FROM Job_Setting__mdt WHERE DeveloperName = :settingName];
        if (!jobSetting.isEmpty()) {
            return jobSetting.get(0);
        }
        return null;
    }

    private static List<ApexClass> getApexClasses() {
        return [SELECT Id, Name FROM ApexClass WHERE isValid = TRUE];
    }
}
