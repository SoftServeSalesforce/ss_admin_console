public interface DataSupplier {
    List<SObject> supply();

    SObjectType getListType();
    List<FieldReference> getKeyFields();
    List<FieldReference> getDataFields();

}