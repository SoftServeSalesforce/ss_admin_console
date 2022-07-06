public inherited sharing class SSACDataHandler {

    public Map<String, SObject> wrappersToRecords(List<SSACSObjectWrapper> wrappers) {
        Map<String, SObject> records = new Map<String, SObject>();
        for (SSACSObjectWrapper wrapper : wrappers) {
            records.put(wrapper.key, wrapper.sobj);
        }
        return records;
    }

	public Map<String, SObject> wrappersToRecordsItem(List<SSACSObjectWrapper> wrappers) {
        Map<String, SObject> records = this.wrappersToRecords(wrappers);
		Integer counter = 0;
		for(String obj: records.keySet()) {
			records.get(obj).putSObject('Product2', new Product2(ProductCode = wrappers.get(counter).keyByReferenceFields.get('Product2Id')));
			counter = wrappers.size() - 1 > counter ? ++counter : 0;
			records.put(obj, records.get(obj));
		}
		return records;
    }

    public Map<String, SObject> getInvalidRecords(List<SSACSObjectWrapper> wrappers,
            Map<String, String> referenceFieldToKeyFields, Map<String, String> referenceFieldToSObjectName) {
        Set<String> parentFields = this.getParentFields(wrappers);
        Map<String, Map<String, Id>> parentFieldToParentId = this.getParentIds(wrappers, parentFields,
                referenceFieldToKeyFields, referenceFieldToSObjectName);
        Map<String, SObject> result = this.getInvalidSObjects(wrappers, parentFieldToParentId);
        return result;
    }

    @TestVisible
    private Map<String, Id> getIdByKey(Set<String> keys, String sObjectName, String keyFieldName) {
        List<String> listKeys = new List<String>();
        for (String str : keys) {
            listKeys.add(str);
        }
        String query = 'SELECT Id, ' + keyFieldName + ' FROM ' + sObjectName + ' WHERE ' +
                keyFieldName + ' IN (\'' + String.join(listKeys, '\',\'') + '\')';
        List<SObject> sObjects = Database.query(query);
        Map<String, Id> result = new Map<String, Id>();
        for (SObject sobj : sObjects) {
            result.put(String.valueOf(sobj.get(keyFieldName)), sobj.Id);
        }
        return result;
    }

    @TestVisible
    private Map<String, Map<String, Id>> getParentIds(List<SSACSObjectWrapper> wrappers, Set<String> parentFields,
            Map<String, String> referenceFieldToKeyFields, Map<String, String> referenceFieldToSObjectName) {
        Map<String, Map<String, Id>> result = new Map<String, Map<String, Id>>();
        for (String parentField : parentFields) {
            Set<String> keys = this.getParentKeys(wrappers, parentField);
            Map<String, Id> idByKey = this.getIdByKey(keys, referenceFieldToSObjectName.get(parentField),
                    referenceFieldToKeyFields.get(parentField));
            result.put(parentField, idByKey);
        }
        return result;
    }

    @TestVisible
    private Set<String> getParentKeys(List<SSACSObjectWrapper> wrappers, String parentField) {
        Set<String> result = new Set<String>();
        for (SSACSObjectWrapper wrapper : wrappers) {
            if (wrapper.keyByReferenceFields != null && wrapper.keyByReferenceFields.containsKey(parentField)) {
                result.add(wrapper.keyByReferenceFields.get(parentField));
            }
        }
        return result;
    }

    @TestVisible
    private Set<String> getParentFields(List<SSACSObjectWrapper> wrappers) {
        Set<String> result = new Set<String>();
        for (SSACSObjectWrapper wrapper : wrappers) {
            if (wrapper.keyByReferenceFields != null) {
                result.addAll(wrapper.keyByReferenceFields.keySet());
            }
        }
        return result;
    }

    @TestVisible
    private Map<String, SObject> getValidSObjects(List<SSACSObjectWrapper> wrappers, Map<String, Map<String, Id>> parentIds) {
        Map<String, SObject> result = new Map<String, SObject>();
        for (SSACSObjectWrapper wrapper : wrappers) {
            if (wrapper.keyByReferenceFields == null || wrapper.keyByReferenceFields.isEmpty()) {
                result.put(wrapper.key, wrapper.sobj);
            } else {
                if (this.allParentsExist(wrapper, parentIds)) {
                    SObject sobj = wrapper.sobj;
                    for (String parentFieldName : parentIds.keySet()) {
                        sobj.put(parentFieldName, parentIds.get(parentFieldName).get(wrapper.keyByReferenceFields.get(parentFieldName)));
                    }
                    result.put(wrapper.key, sobj);
                }
            }
        }
        return result;
    }

    public Map<String, SObject> getValidRecords(List<SSACSObjectWrapper> wrappers,
    Map<String, String> referenceFieldToKeyFields, Map<String, String> referenceFieldToSObjectName) {

        Map<String, Map<String, Id>> parentIds = this.getParentIds(wrappers, this.getParentFields(wrappers),
        referenceFieldToKeyFields, referenceFieldToSObjectName);

        Map<String, SObject> result = new Map<String, SObject>();
        Integer counter = 0;
        for (SSACSObjectWrapper wrapper : wrappers) {
            if (wrapper.keyByReferenceFields == null || wrapper.keyByReferenceFields.isEmpty()) {
                result.put(wrapper.key, wrapper.sobj);
            } else {
                if (this.allParentsExist(wrapper, parentIds)) {
                    SObject sobj = wrapper.sobj;
                    for (String parentFieldName : parentIds.keySet()) {
                        sobj.put(parentFieldName, parentIds.get(parentFieldName).get(wrapper.keyByReferenceFields.get(parentFieldName)));
                        Schema.SObjectType sobjType  = Schema.getGlobalDescribe().get(referenceFieldToSObjectName.get(parentFieldName));
                        SObject newSObj = sobjType.newSObject();
                        newSObj.put(referenceFieldToKeyFields.get(parentFieldName), wrappers.get(counter).keyByReferenceFields.get(parentFieldName));
                        newSObj.put('Id', parentIds.get(parentFieldName).get(wrapper.keyByReferenceFields.get(parentFieldName)));
                        sobj.putSObject(referenceFieldToSObjectName.get(parentFieldName), newSObj);

                    }
			        counter = wrappers.size() - 1 > counter ? ++counter : 0;
                    result.put(wrapper.key, sobj);
                }
            }
        }
        return result;
    }

    @TestVisible
    private Map<String, SObject> getInvalidSObjects(List<SSACSObjectWrapper> wrappers, Map<String, Map<String, Id>> parentIds) {
        Map<String, SObject> result = new Map<String, SObject>();
        for (SSACSObjectWrapper wrapper : wrappers) {
            if (wrapper.keyByReferenceFields != null && !wrapper.keyByReferenceFields.isEmpty()
                    && !this.allParentsExist(wrapper, parentIds)) {
                result.put(wrapper.key, wrapper.sobj);
            }
        }
        return result;
    }

    @TestVisible
    private Boolean allParentsExist(SSACSObjectWrapper wrapper, Map<String, Map<String, Id>> parentIds) {
        Boolean result = true;
        for (String parentFieldName : parentIds.keySet()) {
            if (!parentIds.containsKey(parentFieldName)
                    || !parentIds.get(parentFieldName).containsKey(wrapper.keyByReferenceFields.get(parentFieldName))) {
                return false;
            }
        }
        return result;
    }
}