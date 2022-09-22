public interface DataSupplier {
    DataDefinition getMetadata();
    List<SObject> supply();
}