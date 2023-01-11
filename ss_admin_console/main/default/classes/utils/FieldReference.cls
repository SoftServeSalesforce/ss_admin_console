/*
    Copyright (C) 2013 Bluewolf

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without restriction,
    including without limitation the rights to use, copy, modify, merge,
    publish, distribute, sublicense, and/or sell copies of the Software,
    and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    Except as contained in this notice, the name(s) of the above
    copyright holders shall not be used in advertising or otherwise to
    promote the sale, use or other dealings in this Software without
    prior written authorization.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
    BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
    ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

    https://github.com/bluewolf-beyond/selector
*/

/**
 * Represents a reference to an sObject field. 
 */
public abstract class FieldReference {
    
    /**
     * Returns value of the referenced field on the given sObject.
     * @param record describes sObject 
     * @return value of the field
     */
    public abstract Object getFrom(SObject record);

    /**
     * Return referenced field as SObjectField
     */
    public abstract SObjectField getField();

    /**
     * Returns a FieldReference of the given SObjectField.
     * @param field represents field for which FieldReference is created
     * @return FieldReference of the given field
     */
    public static FieldReference build(SObjectField field) {
        return new SchemaFieldReference(field);
    }

    /**
     * Returns a FieldReference of the given String field and SObjectType. 
     * If there is no '.' character, the reference behaves as it would with the equivalent Schema reference. 
     * If the string contains '.', the reference will traverse sObject relationships.
     * @param sobjType represents SObjectType of sobject for which FieldReference is created
     * @param field represents field for which FieldReference is created
     * @return FieldReference of the given field
     */
    public static FieldReference build(SObjectType sobjType, String field) {
        Integer index = field.indexOf('.'); 
        if (index == -1) {
            return new SchemaFieldReference(sobjType.getDescribe().fields.getMap().get(field));
        }
        String referenceName = field.substring(0, index);
        String fieldName = null;
        if (referenceName.endsWith('__r')) {
            // Custom object
            fieldName = referenceName.left(referenceName.length() - 1) + 'c';
        } else {
            // Standard object
            fieldName = referenceName + 'Id';
        }
        SObjectField sobjField = sobjType.getDescribe().fields.getMap().get(fieldName);
        if (sobjField == null) {
            throw new IllegalArgumentException(String.format('{0} does not belong to SObject type {1}',
                    new Object[] { referenceName, sobjType }));
        }
        return new ChainedFieldReference(referenceName, build(sobjField.getDescribe().getReferenceTo()[0], field.substring(index + 1)));
    }

    // concrete implementations
    public virtual class SchemaFieldReference extends FieldReference {
        @TestVisible 
        private SObjectField field;

        public SchemaFieldReference(SObjectField field) {
            if (field == null) {
                throw new IllegalArgumentException('Field is invalid');
            }
            this.field = field;
        }

        public override Object getFrom(SObject record) {
            return record.get(field);
        }    

        public override SObjectField getField() {
            return field;
        }

        public override String toString() {
            return '' + field;
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

        public override SObjectField getField() {
            return next.getField();
        }

        public override String toString() {
            return field + '.' + next.toString();
        }
    }
}