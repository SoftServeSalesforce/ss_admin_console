public with sharing class RecordBulder {
    public class FieldNotFOundException extends Exception {}
    private String sObjectApiName;
    private String externalIdField;
    private Map<String, String> fieldApiNameToValues;

    public RecordBulder (String sObjectApiName, String externalIdField) {
        this.sObjectApiName = sObjectApiName;
        this.externalIdField = externalIdField;
        this.fieldApiNameToValues = new Map<String, String>();
    }

    public void addField(String apiFieldName, String fieldValue) {
        this.fieldApiNameToValues.put(apiFieldName, fieldValue);
    }

    public RecordWrapper createRecord() {
        Type sObjectType = Type.forName(sObjectApiName);
        SObject sObj = (SObject) (sObjectType.newInstance());
        for (String apiField: this.fieldApiNameToValues.keySet()) {
            sObj.put(apiField, this.convertFieldValue(this.getFieldType(apiField), this.fieldApiNameToValues.get(apiField)));
        }
        return new RecordWrapper(this.sObjectApiName, this.externalIdField, sObj);
    }

    private Object convertFieldValue(Schema.DisplayType fieldType, String fieldValue) {
        if (fieldType == Schema.DisplayType.REFERENCE || fieldType == Schema.DisplayType.ID) {
            return Id.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DOUBLE || fieldType == Schema.DisplayType.PERCENT) {
            return Double.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.CURRENCY) {
            return Decimal.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.BOOLEAN) {
            return Boolean.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.INTEGER) {
            return Integer.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DATE) {
            return Date.valueOf(fieldValue);
        } else if (fieldType == Schema.DisplayType.DATETIME) {
            return Datetime.valueOf(fieldValue);
        } else {
            return fieldValue;
        }
    }

    private Schema.DisplayType getFieldType(STring fieldApiName) {
        if (!Schema.getGlobalDescribe().get(this.sObjectApiName).getDescribe().fields.getMap().containsKey(fieldApiName)) {
            throw new FieldNotFOundException(this.sObjectApiName + ' does not have such field: ' + fieldApiName);
        }
        Schema.DisplayType fieldType = Schema.getGlobalDescribe().get(this.sObjectApiName).getDescribe().fields
            .getMap().get(fieldApiName).getDescribe().getType();
        return fieldType;
    }
}