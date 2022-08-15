public with sharing class OpportunityDataFeederFactory implements DataFeederFactory {

    public String getName() {
        return 'Opportunity Data';
    }

    public DataFeeder getDataFeeder() {

        DataDefinition.DataDefinitionBuilder dataDefinitionBuilder = new DataDefinition.DataDefinitionBuilder(Opportunity.SObjectType).
            addKeyField(Opportunity.Name);

        // TODO: initialize builder

        return new BaseDataFeeder(
                new StaticDataSupplier(dataDefinitionBuilder.build(),
                        new Opportunity[] {
                                new Opportunity(Amount = 10,
                                        Account = new Account(Name = 'Google')//,
                                        //Contact = new Contact(LastName = 'Pupkin', Email = 'vp@gmail.com')
                                )
                        }
                )
        );
    }
}