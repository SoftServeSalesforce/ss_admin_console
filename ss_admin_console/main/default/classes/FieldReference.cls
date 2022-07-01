public abstract class FieldReference{
    // FieldReference interface
    public abstract Object getFrom(SObject record);

    // factory methods
    public static FieldReference build(Schema.SObjectField field) {
        return new SchemaFieldReference(field);
    }

    public static FieldReference build(String field) {
        Integer index = field.indexOf('.');
        if (index == -1) {
            return new SimpleFieldReference(field);
        }
        return new ChainedFieldReference(field.substring(0, index), build(field.substring(index + 1)));
    }

    // concrete implementations
    public virtual class SchemaFieldReference extends FieldReference {
        @TestVisible Schema.SObjectField field;

        public SchemaFieldReference(Schema.SObjectField field) {
            this.field = field;
        }

        public override Object getFrom(SObject record) {
            return record.get(field);
        }

        public override String toString() {
            return '' + field;
        }
    }

    public virtual class SimpleFieldReference extends FieldReference {
        @TestVisible String field;

        public SimpleFieldReference(String field) {
            this.field = field;
        }

        public override Object getFrom(SObject record) {
            return record.get(field);
        }

        public override String toString() {
            return field;
        }
    }

    public virtual class ChainedFieldReference extends FieldReference {
        @TestVisible String field;
        @TestVisible FieldReference next;

        public ChainedFieldReference(String field, FieldReference next) {
            this.field = field;
            this.next = next;
        }

        public override Object getFrom(SObject record) {
            SObject parent = record.getSObject(field);
            return parent == null ? null : next.getFrom(parent);
        }

        public override String toString() {
            return field + '.' + next.toString();
        }
    }
}