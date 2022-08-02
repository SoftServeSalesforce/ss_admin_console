public inherited sharing class AccountsDataSupplierFactory implements DataSupplierFactory {
    public String getName() {
        return 'Sample Accounts';
    }

    public DataSupplier getDataSupplier() {
        return new StaticDataSupplier(new Account[] {
                new Account(Name = 'Social Software'),
                new Account(Name = 'Adept Software'),
                new Account(Name = 'Boss Software'),
                new Account(Name = 'Scope Software'),
                new Account(Name = 'Variable Software')
        });
    }
}