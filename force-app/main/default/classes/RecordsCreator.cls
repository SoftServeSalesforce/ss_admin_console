public with sharing class RecordsCreator {
    public class ExternalIdFieldNotFOundException extends Exception {}
    private List<RecordWrapper> records;
    private List<RecordWrapper> validRecords;
    private List<RecordWrapper> invalidRecords;
    private List<sObject> existRecords;
    public RecordsCreator(List<RecordWrapper> records) {
        this.records = records;
        this.existRecords = this.getExistRecords();
        this.validRecords = this.obtainValidRcords();
        this.invalidRecords = this.obtainInValidRcords();
    }

    public List<RecordWrapper> getValidRecords() {
        return this.validRecords;
    }

    public List<RecordWrapper> getInvalidRecords() {
        return this.invalidRecords;
    }

    private List<sObject> getExistRecords() {
        List<sObject> result = new List<sObject>();
        for (RecordWrapper wrapper: records) {
            if (wrapper.getExternalField() == null) {
                throw new ExternalIdFieldNotFOundException('Please add Externall Id field to record');
            }
        }

        Map<String, Map<String, Set<String>>> sObjectNameToExternalIds = this.sObjectNameToExternalIds();
        for (String sObjectName: sObjectNameToExternalIds.keySet()) {
            String query = this.obtainQuery(sObjectName, sObjectNameToExternalIds.get(sObjectName));
            List<sObject> sobjList = Database.query(query);
            if (sobjList.size() != 0) {
                result.addAll(sobjList);
            }
        }

        return result;
    }

    private List<RecordWrapper> obtainValidRcords() {
        List<RecordWrapper> wrappers = new List<RecordWrapper>();
        for (RecordWrapper wrapper: this.records) {
            if (this.existRecords.isEmpty()) {
                wrappers.add(wrapper);
            } else {
                if (!this.isDuplicate(wrapper, this.existRecords)) {
                        wrappers.add(wrapper);
                    }
                }
            }
    
        return wrappers;
    }

    public List<SObject> getSObjects(List<RecordWrapper> wrappers) {
        List<SObject> sObjects = new List<SObject>();
        for (RecordWrapper wrapper: wrappers) {
            sObjects.add(wrapper.getSObject());
        }
        return sObjects;
    }

    public String getExternalId(List<RecordWrapper> wrappers) {
        String result = '';
        for (RecordWrapper wrapper: wrappers) {
            result = result + wrapper.getExternalField() + ': ' + wrapper.getSObject().get(wrapper.getExternalField()) + ', ';
        }
        result = result.removeEnd(result.right(2));
        return result;
    }

    private List<RecordWrapper> obtainInValidRcords() {
        List<RecordWrapper> wrappers = new List<RecordWrapper>();
        if (this.existRecords.isEmpty()) {
            return wrappers;
        }
        for (RecordWrapper wrapper: this.records) {
            if (this.isDuplicate(wrapper, this.existRecords)) {
                wrappers.add(wrapper);
            }
        }

        return wrappers;
    }

    private Boolean isDuplicate(RecordWrapper wrapper, List<sObject> SObjects) {
        Boolean result = false;
        for (SObject soj: SObjects) {
            if (wrapper.getSObjectApiName() == soj.getSObjectType().getDescribe().getName() 
                    && wrapper.getSObject().get(wrapper.getExternalField()) == soj.get(wrapper.getExternalField())) {
                result = true;
            }
        }

        return result;
    }

    private Map<String, Map<String, Set<String>>> sObjectNameToExternalIds() {
        Map<String, Map<String, Set<String>>> result = new Map<String, Map<String, Set<String>>>();
        for (RecordWrapper wrapper: this.records) {
            if (result.containsKey(wrapper.getSObjectApiName())) {
                if (result.get(wrapper.getSObjectApiName()).containsKey(wrapper.getExternalField())) {
                    result.get(wrapper.getSObjectApiName()).get(wrapper.getExternalField())
                        .add('\'' + String.valueOf(wrapper.getSObject().get(wrapper.getExternalField())) + '\'');
                } else {
                    result.get(wrapper.getSObjectApiName()).put(wrapper.getExternalField(), 
                        new Set<String> {'\'' + String.valueOf(wrapper.getSObject().get(wrapper.getExternalField())) + '\''});
                }
            } else {
                
                result.put(wrapper.getSObjectApiName(), new Map<String, Set<String>>());
                result.get(wrapper.getSObjectApiName()).put(wrapper.getExternalField(), 
                    new Set<String>{'\'' + String.valueOf(wrapper.getSObject().get(wrapper.getExternalField())) + '\''});
            }
        }
        return result;
    }

    private String obtainQuery(String sObjectApiName, Map<String, Set<String>> externalIds) {
        String query = 'SELECT Id';
        for (String externalIdField: externalIds.keySet()) {
            query = query + ', ' + externalIdField;
        }
        query = query + ' FROM ' + sObjectApiName + ' WHERE ';
        for (String externalIdField: externalIds.keySet()) {
            String externalIdsString = String.valueOf(externalIds.get(externalIdField));
            query = query + externalIdField + ' IN (' 
                + externalIdsString.removeStart(externalIdsString.left(1)).removeEnd(externalIdsString.right(1)) + ') OR ';
        }
        query = query.removeEnd(query.right(3));
        return query;
    }
}
