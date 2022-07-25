public inherited sharing class SampleDataSuppliers {

    public static DataSupplier getAccountSampleData() {
        return new StaticDataSupplier(new Account[] {
                new Account(Name = 'Social Software'),
                new Account(Name = 'Adept Software'),
                new Account(Name = 'Boss Software'),
                new Account(Name = 'Scope Software'),
                new Account(Name = 'Variable Software')
        });
    }
}