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
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/51298991/194048474-5d1e5304-47af-46f8-8a4c-7eff44c1d460.png" style="max-width: 100%;">
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
<img width="932" alt="image" src="https://user-images.githubusercontent.com/57544473/194052659-b4bff1a0-15ee-494a-a04f-ce63ede9a8e5.png">
<p>2. Then click "Next" and choose factories which you need to update.</p>
<img width="935" alt="image" src="https://user-images.githubusercontent.com/57544473/194052752-e23deb55-9e96-4a33-a522-0338dec828aa.png">
<p>You can click "Execute" to insert sample data to database.</p>
<img width="943" alt="image" src="https://user-images.githubusercontent.com/57544473/194053556-b9033d88-8cec-42c3-bdd8-a0f8c29a2bbd.png">
<p>You can either click "Test" to insert sample data and rockback the transaction</p>
<img width="918" alt="image" src="https://user-images.githubusercontent.com/57544473/194052961-d87ae9dc-7d97-47b1-8805-ff7321d086b0.png">
