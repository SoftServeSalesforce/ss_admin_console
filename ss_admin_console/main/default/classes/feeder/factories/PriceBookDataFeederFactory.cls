public with sharing class PriceBookDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Pricebooks';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Pricebook2.SObjectType)
                .addKeyField(Pricebook2.Name)
                .addDataField(Pricebook2.IsActive);
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Pricebook2[] {
                        new Pricebook2(Name = 'Test PriceBook1', IsActive = true),
                        new Pricebook2(Name = 'Test PriceBook2', IsActive = false)
                    } 
                )
        );
    }
}
