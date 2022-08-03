public inherited sharing class AccountsDataFeederFactory implements DataFeederFactory {
    public String getName() {
        return 'Sample Accounts';
    }

    public DataFeeder getDataFeeder() {
        return new BaseDataFeeder(
                new StaticDataSupplier(
                    new List<SObjectField>{Account.Name},
                    new List<SObjectField>{Account.Name},
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