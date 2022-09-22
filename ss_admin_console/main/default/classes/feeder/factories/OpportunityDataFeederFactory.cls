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
                        new Opportunity(Name = 'OPP_TEST-0005', StageName = 'Prospecting', Amount = 55.74, CloseDate = Date.today() + 207, Account = new Account(Name = 'Variable Software')),
                        new Opportunity(Name = 'OPP_TEST-0006', StageName = 'Prospecting', Amount = 77.63, CloseDate = Date.today() + 42, Account = new Account(Name = 'Cornerstone Software')),
                        new Opportunity(Name = 'OPP_TEST-0007', StageName = 'Prospecting', Amount = 7.95, CloseDate = Date.today() + 214, Account = new Account(Name = 'Ascend Software')),
                        new Opportunity(Name = 'OPP_TEST-0008', StageName = 'Prospecting', Amount = 53.75, CloseDate = Date.today() + 73, Account = new Account(Name = 'Consumer Software')),
                        new Opportunity(Name = 'OPP_TEST-0009', StageName = 'Prospecting', Amount = 30.87, CloseDate = Date.today() + 185, Account = new Account(Name = 'Velocity Software')),
                        new Opportunity(Name = 'OPP_TEST-0010', StageName = 'Prospecting', Amount = 9.23, CloseDate = Date.today() + 207, Account = new Account(Name = 'Urge Software')),
                        new Opportunity(Name = 'OPP_TEST-0011', StageName = 'Prospecting', Amount = 71.94, CloseDate = Date.today() + 161, Account = new Account(Name = 'Access Software')),
                        new Opportunity(Name = 'OPP_TEST-0012', StageName = 'Prospecting', Amount = 12.57, CloseDate = Date.today() + 194, Account = new Account(Name = 'Fiber Software')),
                        new Opportunity(Name = 'OPP_TEST-0013', StageName = 'Prospecting', Amount = 45.64, CloseDate = Date.today() + 217, Account = new Account(Name = 'Ideal Software')),
                        new Opportunity(Name = 'OPP_TEST-0014', StageName = 'Prospecting', Amount = 80.28, CloseDate = Date.today() + 180, Account = new Account(Name = 'Marine Software')),
                        new Opportunity(Name = 'OPP_TEST-0015', StageName = 'Prospecting', Amount = 82.81, CloseDate = Date.today() + 55, Account = new Account(Name = 'Intellect Software')),
                        new Opportunity(Name = 'OPP_TEST-0016', StageName = 'Prospecting', Amount = 71.92, CloseDate = Date.today() + 157, Account = new Account(Name = 'Softwaregenics')),
                        new Opportunity(Name = 'OPP_TEST-0017', StageName = 'Prospecting', Amount = 27.77, CloseDate = Date.today() + 208, Account = new Account(Name = 'Point Software')),
                        new Opportunity(Name = 'OPP_TEST-0018', StageName = 'Prospecting', Amount = 66.44, CloseDate = Date.today() + 154, Account = new Account(Name = 'Vision Software')),
                        new Opportunity(Name = 'OPP_TEST-0019', StageName = 'Prospecting', Amount = 99.83, CloseDate = Date.today() + 60, Account = new Account(Name = 'Softserve')),
                        new Opportunity(Name = 'OPP_TEST-0020', StageName = 'Prospecting', Amount = 68.83, CloseDate = Date.today() + 99, Account = new Account(Name = 'Clever Software')),
                        new Opportunity(Name = 'OPP_TEST-0021', StageName = 'Prospecting', Amount = 46.88, CloseDate = Date.today() + 58, Account = new Account(Name = 'Softwareya')),
                        new Opportunity(Name = 'OPP_TEST-0022', StageName = 'Prospecting', Amount = 24.22, CloseDate = Date.today() + 62, Account = new Account(Name = 'Measured Software')),
                        new Opportunity(Name = 'OPP_TEST-0023', StageName = 'Prospecting', Amount = 33.81, CloseDate = Date.today() + 206, Account = new Account(Name = 'Task Software')),
                        new Opportunity(Name = 'OPP_TEST-0024', StageName = 'Prospecting', Amount = 93.4, CloseDate = Date.today() + 100, Account = new Account(Name = 'Progress Software')),
                        new Opportunity(Name = 'OPP_TEST-0025', StageName = 'Prospecting', Amount = 69.25, CloseDate = Date.today() + 145, Account = new Account(Name = 'Touch Software')),
                        new Opportunity(Name = 'OPP_TEST-0026', StageName = 'Prospecting', Amount = 34.87, CloseDate = Date.today() + 118, Account = new Account(Name = 'Up Software')),
                        new Opportunity(Name = 'OPP_TEST-0027', StageName = 'Prospecting', Amount = 31.99, CloseDate = Date.today() + 191, Account = new Account(Name = 'Mega Software')),
                        new Opportunity(Name = 'OPP_TEST-0028', StageName = 'Prospecting', Amount = 63.38, CloseDate = Date.today() + 51, Account = new Account(Name = 'Super Software')),
                        new Opportunity(Name = 'OPP_TEST-0029', StageName = 'Prospecting', Amount = 0.96, CloseDate = Date.today() + 107, Account = new Account(Name = 'SuperPuper Software')),
                        new Opportunity(Name = 'OPP_TEST-0030', StageName = 'Prospecting', Amount = 90.82, CloseDate = Date.today() + 133, Account = new Account(Name = 'SuperNice Software')),
                        new Opportunity(Name = 'OPP_TEST-0031', StageName = 'Prospecting', Amount = 98.34, CloseDate = Date.today() + 127, Account = new Account(Name = 'Weight Software')),
                        new Opportunity(Name = 'OPP_TEST-0032', StageName = 'Prospecting', Amount = 97.05, CloseDate = Date.today() + 149, Account = new Account(Name = 'Wild Software'))
                    }
                )
        );
    }
}