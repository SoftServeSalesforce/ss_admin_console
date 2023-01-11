public with sharing class ProductsDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Products';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Product2.SObjectType)
                .addKeyField(Product2.ProductCode)
                .addDataField(Product2.Name);
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Product2[] {
                        new Product2(Name = 'The Best Product', ProductCode = 'TEST-0001'),
                        new Product2(Name = 'Organic Product', ProductCode = 'TEST-0002'),
                        new Product2(Name = 'Product for the Times', ProductCode = 'TEST-0003'),
                        new Product2(Name = 'Product for All', ProductCode = 'TEST-0004'),
                        new Product2(Name = 'Product of the People', ProductCode = 'TEST-0005')
                    } 
                )
        );
    }
}
