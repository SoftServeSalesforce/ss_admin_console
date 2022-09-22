public inherited sharing class AccountsDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Accounts';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name);
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Account[] {
                        new Account(Name = 'Social Software'),
                        new Account(Name = 'Adept Software'),
                        new Account(Name = 'Boss Software'),
                        new Account(Name = 'Scope Software'),
                        new Account(Name = 'Variable Software')
                    }
                )
        );
    }
}