public inherited sharing class TestDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Test Account Data Factory';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name);
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Account[] {
                        new Account(Name = 'Test Account 1'),
                        new Account(Name = 'Test Account 2')
                    }
                )
        );
    }
}