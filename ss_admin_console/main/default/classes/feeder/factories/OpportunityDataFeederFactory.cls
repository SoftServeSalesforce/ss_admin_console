public with sharing class OpportunityDataFeederFactory implements DataFeederFactory {

    public String getName() {
        return 'Sample Opportunity';
    }

    public DataFeeder getDataFeeder() {

        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Opportunity.SObjectType).
            addKeyField(Opportunity.Name).addDataField(Opportunity.StageName).addReferenceField(Opportunity.AccountId, new String[] {'Name'});

        return new BaseDataFeeder(
                new StaticDataSupplier(
                    dataDefinitionBuilder.build(),
                    new Opportunity [] {
                        new Opportunity(Name = 'OPP_TEST-0001', StageName = 'Prospecting', Amount = 72.1, CloseDate = Date.today() + 91, Account = new Account(Name = 'Social Software')),
                        new Opportunity(Name = 'OPP_TEST-0002', StageName = 'Prospecting', Amount = 15.24, CloseDate = Date.today() + 145, Account = new Account(Name = 'Adept Software')),
                        new Opportunity(Name = 'OPP_TEST-0003', StageName = 'Prospecting', Amount = 75.91, CloseDate = Date.today() + 131, Account = new Account(Name = 'Boss Software')),
                        new Opportunity(Name = 'OPP_TEST-0004', StageName = 'Prospecting', Amount = 39.66, CloseDate = Date.today() + 75, Account = new Account(Name = 'Scope Software')),
                        new Opportunity(Name = 'OPP_TEST-0005', StageName = 'Prospecting', Amount = 55.74, CloseDate = Date.today() + 207, Account = new Account(Name = 'Variable Software'))
                    }
                )
        );
    }
}