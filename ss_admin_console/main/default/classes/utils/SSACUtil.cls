public inherited sharing class SSACUtil {
    public List<String> getJobClasses(String interfaceName) {
        Type interfaceType = Type.forName(interfaceName);
        List<String> result = new List<String>();
        List<ApexClass> classes = this.getApexClasses();
        for (ApexClass aClass : classes) {
            Type classType = Type.forName(aClass.Name);
            if ((classType != null) && (interfaceType.isAssignableFrom(classType))) {
                result.add(aClass.Name);
            }
        }
        return result;
    }

    public List<Type> getSubClasses(Type theType) {
        List<Type> result = new List<Type>();
        List<ApexClass> classes = getApexClasses();
        Integer i = 0;
        for (ApexClass aClass : classes) {
            i++;
            Type classType = null;
            try {
                classType = Type.forName(aClass.Name);
            }
            catch(Exception e) {
                System.debug('i = '+i+'; theType = '+theType.toString()+'; Error for Type.forName('+aClass.Name+'): ' + e.getMessage());
            }
            if (classType != null && theType.isAssignableFrom(classType) && theType.toString() != classType.toString()) {
                result.add(classType);
            }
        }
        return result;
    }

    public Job_Setting__mdt getJobSetting(String settingName) {
        List<Job_Setting__mdt> jobSetting = [SELECT Id, Job_Cron_Expression__c, Job_Size__c FROM Job_Setting__mdt WHERE DeveloperName = :settingName];
        if (!jobSetting.isEmpty()) {
            return jobSetting.get(0);
        }
        return null;
    }

    private List<ApexClass> getApexClasses() {
        return [SELECT Id, Name FROM ApexClass];
    }
}
