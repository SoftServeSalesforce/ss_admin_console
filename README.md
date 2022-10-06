<h1>Admin Console by SoftServe</h1>
<p>Admin Console tool is intended for Salesforce Developer</p>
<h2>Why Admin Console</h2>
<p>This tool allows to test execution capabilities of SF with prepared sample data</p>
<h2>Features</h2>
<ul>
  <li>Creating custom sample test data for the organization and ability to monitor data execution including inserting new data and updating existing ones</li>
  <li>Tool provides creating test data for such standard SObjects as: Accounts, Contacts, Price Books, Products, Opportunities</li>
</ul>
<h2>Download and Installation</h2>
<p>$ sfdx force:source:deploy -p path/to/source</p>
<h2>UML Diagram</h2>
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/51298991/194333092-330fe081-ad8c-4e14-8e72-938f6e096243.png" style="max-width: 100%;">
<h2>Usage</h2>
<h3>Usage of provided data</h3>
<p>Just deploy source and you already can create testing data for a lot of standart sObjects</p>
<p>You can customize this sample data, for example, to add some required field</p>
<p>Sample data is stored in DataFactories and consists of keyFields, dataFields, referencedFields(if a SObject has any reference fields) and sample data.</p>
<p>These classes contain provided sample data: AccountDataFeederFactory, ContactDataFeederFactory, OpportunityDataFeederFactory...</p>
<p>For example, this is peace of code from AccountDataFeederFactory, just update all accounts from this map with required field</p>
<pre> 
    public String getName() {
        return 'Sample Contacts';
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
</pre>
<h3>Creating custom data</h3>
<p>1. Create custom class: someSObjectDataFeederFactory and declate two interface methods: getName() and getDataFeeder(). getName() method must return the name of DataFeederFactory and it will be used in order to define the factory. getDataFeeder() musr return BaseDataFeeder() that consist of: </p>
<p>1) dataDefinitionBuilder with all addKeyField(), addDataField() (if any), addReferenceField() (if any) and method build()</p>
<p>2) list of SObject as a sample data;
<h3>Usage</h3>
<p>1. Open Admin Console Tab and choose any of factories you want to test</p>
<img width="938" alt="image" src="https://user-images.githubusercontent.com/57544473/194053914-9741f511-3dc5-41b8-98df-fd356cc849f7.png">
<p>2. Then click "Next" and choose factories which you need to update.</p>
<img width="935" alt="image" src="https://user-images.githubusercontent.com/57544473/194052752-e23deb55-9e96-4a33-a522-0338dec828aa.png">
<p>You can click "Execute" to insert sample data to database.</p>
<img width="942" alt="image" src="https://user-images.githubusercontent.com/57544473/194055096-fa239c6d-2520-4e7f-bbb5-f91feca7b90d.png">
<p>You can either click "Test" to insert sample data and rockback the transaction</p>
<img width="942" alt="image" src="https://user-images.githubusercontent.com/57544473/194054340-70e1291a-25bf-4f31-9fcb-fa6974cc2f47.png">
