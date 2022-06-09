public with sharing class SSACFilter {
	private String sObjectApiName;
    private Map<String, SObject> records;
    private List<String> keyFields;
    private List<String> allFields;
    private String additionCondition;
	private List<SObject> constantSObjects;
    private Map<String, Set<Object>> constantFields;
	private List<SObject> existentSObjects;

    public SSACFilter(String sObjectApiName, Map<String, SObject> records, List<String> keyFields, List<String> allFields, String additionCondition) {
		this.sObjectApiName = sObjectApiName;
        this.records = records;
		this.keyFields = keyFields;
        this.allFields = allFields;
        this.additionCondition = additionCondition;
		this.constantSObjects = this.recordsToList();
		this.constantFields = this.getConstantFields();
		this.existentSObjects = this.getExistentSObjectsv2();
    }

	public List<SSACResult> filter() {
        List<SSACResult> result = new List<SSACResult>();
		result.addAll(this.getFilteredRecords());
        return result;
    }

	public List<SObject> recordsToList(){
		List<SObject> result = new List<SObject>();
		for(String item : this.records.keySet()){
			result.add(this.records.get(item));
		}
		return result;
	}

	@TestVisible
	private List<SSACResult> getFilteredRecords() {
		List<SSACResult> results = new List<SSACResult>();
		Set<String> nonKeyFields = new Set<String>(this.allFields.clone());
        nonKeyFields.removeAll(this.keyFields);
       
        for (SObject constSObj: this.constantSObjects){
			String recordId;
			String status = '';
            String recordKey = '';
			Integer matchedKeyFields = 0;
			Integer matchedNonKeyFields = 0;
			for (SObject existSObj : this.existentSObjects){
				for (String field: this.keyFields) {
					if (field.contains('.')){
						List<String> splittedField = field.split('\\.');
						SObject cObj = constSObj.getSObject(splittedField[0]);
						SObject eObj = existSObj.getSObject(splittedField[0]);
						String nextField = splittedField[1];
						if (cObj.get(nextField) == eObj.get(nextField)){
							matchedKeyFields += 1;
						} else {
							status = SSACConstants.OK_STATUS;
							break;
						}
					} else {
						if (constSObj.get(field) == existSObj.get(field)){
							matchedKeyFields += 1;
						} else {
							status = SSACConstants.OK_STATUS;
							break;
						}
					}
				}
				if (matchedKeyFields == this.keyFields.size()){
					for (String nonKeyField: nonKeyFields){
						if (constSObj.get(nonKeyField) == existSObj.get(nonKeyField)){
							matchedNonKeyFields += 1;
						}
					}
					if (matchedNonKeyFields == nonKeyFields.size()){
						status = SSACConstants.DUPLICATED_STATUS;
						break;
					} else {
						status = SSACConstants.CHANGED_STATUS;
						recordId = existSObj.Id;
						break;
					}
				}
			}
			for (String keyField: this.keyFields){
				if (keyField.contains('.')){
					List<String> splittedField = keyField.split('\\.');
					constSObj = constSObj.getSObject(splittedField[0]);
					keyField = splittedField[1];
				}
				recordKey += String.valueOf(constSObj.get(keyField));
				break;
			}
			if (recordId != null){
				results.add(new SSACResult()
						.setStatus(status)
						.setRecordId(recordId)
						.setRecordKey(recordKey) 
						.setSObjectApiName(this.sObjectApiName));
			} else {
				results.add(new SSACResult()
						.setStatus(status)
						.setRecordKey(recordKey)
						.setSObjectApiName(this.sObjectApiName));
			}
		}
	return results;
	}

	@TestVisible
	private List<SObject> getExistentSObjectsv2(){
        String query = this.buildQuery();
		Map<String, SObject> result = new Map<String, SObject>();
        List<SObject> existentRecords = Database.query(query);
        return existentRecords;
    }

	@TestVisible
    private Map<String, Set<Object>> getConstantFields(){
        Map<String, Set<Object>> constantValues = new Map<String, Set<Object>>();
        for(String field: this.allFields){
            Set<Object> values = new Set<Object>();
            for(SObject obj: this.constantSObjects){
				if(field.contains('.')){
					System.debug(obj);
					List<String> splittedField = field.split('\\.');
					values.add(obj.getSObject(splittedField[0]).get(splittedField[1]));
					System.debug(obj.getSObject(splittedField[0]).get(splittedField[1]));
				}else {
					values.add(obj.get(field));
				}
              
            }
            constantValues.put(field, values);
        }
        return constantValues;
    }

    @TestVisible
    private String buildQuery() {
        String result = 'SELECT Id,';
        if (this.allFields != null){
            for (String item : this.allFields) {
				result += item + ',';
            }
        }
        result = result.removeEnd(result.right(1));         
        result += ' FROM '+ this.sObjectApiName + ' WHERE ';
        for (String field: this.keyFields){
				result += field + ' IN (';
			for (Object value : this.constantFields.get(field)) {
				result += (value instanceof String) ? '\'' + value + '\',' :  value + ',';
			}
        result = result.removeEnd(result.right(1)) + ') AND ';
        } result = result.removeEnd(result.right(4));
        if (this.additionCondition != null) {
            result += 'AND (' + this.additionCondition + ')';
        }
        return result;
    }
}