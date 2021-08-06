public with sharing class DiagnosticService {
    @TestVisible
    private ApexSelector apexSelector;

    public DiagnosticService() {
        this.apexSelector = new ApexSelector();
    }

    public List<String> obtainClasses(String interfaceName) {
        List<ApexClass> apexClasses = this.apexSelector.getApexClasses();

        return this.obtainApexClasses(apexClasses, interfaceName);
    }

    public String getCronException(String jobTime) {
        List<String> timeSplit = jobTime.split(':');
        String hour = (timeSplit.get(0).startsWith('0')) ? timeSplit.get(0).replaceFirst('0', '') : timeSplit.get(0);
        String minute = (timeSplit.get(1).startsWith('0')) ? timeSplit.get(1).replaceFirst('0', '') : timeSplit.get(1);
        String cronExpression = '0 ' + minute + ' ' + hour + ' ? * * *';

        return cronExpression;
    }

    @TestVisible
    private List<String> obtainApexClasses(List<ApexClass> apexClasses, String interfaceName) {
        List<String> result = new List<String>();
        for (ApexClass aClass : apexClasses) {
            if (this.isImplementInterface(aClass, interfaceName)) {
                result.add(aClass.Name);
            }
        }

        return result;
    }

    @TestVisible
    private Boolean isImplementInterface(ApexClass apexClass, String interfaceName) {
        Type apexClassType = Type.forName(apexClass.Name);
        Type interfaceType = Type.forName(interfaceName);

        return interfaceType.isAssignableFrom(apexClassType);
    }
}
