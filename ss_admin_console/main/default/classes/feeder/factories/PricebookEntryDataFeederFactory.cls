public with sharing class PricebookEntryDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample PricebookEntries';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(PricebookEntry.SObjectType)
                .addKeyField('Product2.ProductCode')
                .addKeyField('Pricebook2.Name')
                .addDataField('UnitPrice')
                .addDataField('IsActive')
                .addReferenceField(PricebookEntry.Pricebook2Id, new String[] {'Name'})
                .addReferenceField(PricebookEntry.Product2Id, new String[] {'Name'});
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new PricebookEntry[] {
                        new PricebookEntry(UnitPrice = 15.14, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Standard Price Book'), Product2 = new Product2(Name = 'TEST-0001')),
                        new PricebookEntry(UnitPrice = 51.15, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Standard Price Book'), Product2 = new Product2(Name = 'TEST-0002')),
                        new PricebookEntry(UnitPrice = 29.98, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Standard Price Book'), Product2 = new Product2(Name = 'TEST-0003')),
                        new PricebookEntry(UnitPrice = 6.3, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Standard Price Book'), Product2 = new Product2(Name = 'TEST-0004')),
                        new PricebookEntry(UnitPrice = 74.84, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Standard Price Book'), Product2 = new Product2(Name = 'TEST-0005')),
                        
                        new PricebookEntry(UnitPrice = 16.01, IsActive = true, Pricebook2 = new Pricebook2(Name = 'Test PriceBook1'), Product2 = new Product2(Name = 'TEST-0001')),
                        new PricebookEntry(UnitPrice = 51.41, IsActive = true, Pricebook2 = new Pricebook2(Name = 'Test PriceBook1'), Product2 = new Product2(Name = 'TEST-0002')),
                        new PricebookEntry(UnitPrice = 30.63, IsActive = true, Pricebook2 = new Pricebook2(Name = 'Test PriceBook1'), Product2 = new Product2(Name = 'TEST-0003')),
                        new PricebookEntry(UnitPrice = 7.11, IsActive = true, Pricebook2 = new Pricebook2(Name = 'Test PriceBook1'), Product2 = new Product2(Name = 'TEST-0004')),
                        new PricebookEntry(UnitPrice = 75.43, IsActive = true, Pricebook2 = new Pricebook2(Name = 'Test PriceBook1'), Product2 = new Product2(Name = 'TEST-0005')),
                        
                        new PricebookEntry(UnitPrice = 15.6, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Test PriceBook2'), Product2 = new Product2(Name = 'TEST-0001')),
                        new PricebookEntry(UnitPrice = 51.29, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Test PriceBook2'), Product2 = new Product2(Name = 'TEST-0002')),
                        new PricebookEntry(UnitPrice = 31.14, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Test PriceBook2'), Product2 = new Product2(Name = 'TEST-0003')),
                        new PricebookEntry(UnitPrice = 7.21, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Test PriceBook2'), Product2 = new Product2(Name = 'TEST-0004')),
                        new PricebookEntry(UnitPrice = 75.38, IsActive = false, Pricebook2 = new Pricebook2(Name = 'Test PriceBook2'), Product2 = new Product2(Name = 'TEST-0005'))
                    } 
                )
        );
    }
}
