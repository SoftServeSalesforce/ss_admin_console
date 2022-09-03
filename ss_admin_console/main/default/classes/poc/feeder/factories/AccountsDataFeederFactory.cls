public inherited sharing class AccountsDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Accounts';
    }

    public DataFeeder getDataFeeder() {
        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Account.SObjectType).
                addKeyField(Account.Name).addDataField(Account.Name).addIsChild(false);
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Account[] {
                        new Account(Name = 'Social Software'),
                        new Account(Name = 'Adept Software'),
                        new Account(Name = 'Boss Software'),
                        new Account(Name = 'Scope Software'),
                        new Account(Name = 'Variable Software'),
                        new Account(Name = 'Cornerstone Software'),
                        new Account(Name = 'Ascend Software'),
                        new Account(Name = 'Consumer Software'),
                        new Account(Name = 'Velocity Software'),
                        new Account(Name = 'Urge Software'),
                        new Account(Name = 'Access Software'),
                        new Account(Name = 'Fiber Software'),
                        new Account(Name = 'Ideal Software'),
                        new Account(Name = 'Marine Software'),
                        new Account(Name = 'Intellect Software'),
                        new Account(Name = 'Softwaregenics'),
                        new Account(Name = 'Point Software'),
                        new Account(Name = 'Vision Software'),
                        new Account(Name = 'Softserve'),
                        new Account(Name = 'Clever Software'),
                        new Account(Name = 'Softwareya'),
                        new Account(Name = 'Measured Software'),
                        new Account(Name = 'Task Software'),
                        new Account(Name = 'Progress Software'),
                        new Account(Name = 'Touch Software'),
                        new Account(Name = 'Up Software'),
                        new Account(Name = 'Mega Software'),
                        new Account(Name = 'Super Software'),
                        new Account(Name = 'SuperPuper Software'),
                        new Account(Name = 'SuperNice Software'),
                        new Account(Name = 'Weight Software'),
                        new Account(Name = 'Wild Software')
                    }
                )
        );
    }
}