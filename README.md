<h1>Admin Console by SoftServe</h1>
<p>Admin Console tool is intended for Salesforce Developer</p>
<h2>Why Admin Console</h2>
<p>This tool allows you to monitor creating your test data, running scheduled and batchable jobs</p>
<h2>Features</h2>
<ul>
  <li>Creating custom test data for the organization and ability to monitor data creating</li>
  <li>Tool provides creating test data for such standard SObjects as: Accounts, Contacts, Price Books, Products, Opportunities</li>
  <li>Running batchable jobs and monitoring it results</li>
  <li>Running schedule jobs or check if it is already executed</li>
</ul>
<h2>Download and Installation</h2>
<p>$ sfdx force:source:deploy -p path/to/source</p>
<h2>UML Diagram</h2>
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/30637510/138530463-5bd61aca-f9ef-4cf4-a2cf-5b0b4b9b80bc.png" style="max-width: 100%;">
<h2>Usage</h2>
<h3>Usage of provided data</h3>
<p>Just deploy source and you already can create testing data for a lot of standart sObjects</p>
<p>You can customize this test data, for example, to add some required field</p>
<p>These classes contain provided test data: CustomerConstants, OpportunityConstants, ProductConstants</p>
<p>For example, this is peace of code from CustomerConstants, just update all accounts from this map with required field</p>
<pre> 
public static Map<String, Account> ACCOUNT_DATA = new Map<String, Account> {
            'Social Software' => new Account(Name = 'Social Software'),
            'Adept Software' => new Account(Name = 'Adept Software'),
            'Boss Software' => new Account(Name = 'Boss Software'),
            'Scope Software' => new Account(Name = 'Scope Software')};
</pre>
<h3>Creating custom data</h3>
<p>1. Create custom class: SomeSObjectDataAction and ovveride methods test() and execute() using your custom data</p>
<pre> 
public with sharing class SomeSObjectDataAction extends SSACAsyncAction {
    public override List<SSACResult> test() {
    }
    public override List<SSACResult> execute() {
    }
 }
</pre>
<p>2. Update class SSACController: to add to map 'actions' new element</p>
<pre> 
private static Map<String, ISSACAction> actions = new Map<String, ISSACAction> {
            SSACConstants.CUSTOMERS_DATA => new SSACCustomerDataAction(),
            SSACConstants.PRODUCTS_DATA => new SSACProductDataAction(),
            SSACConstants.OPPORTUNITY_DATA => new SSACOpportunityDataAction(),
            <span class="pl-v">'The custom action label' => new SomeSObjectDataAction()</span>
    };
</pre>
<p>3. Open Admin Console Tab and select The custom action label, then test or execute and enjoy the results</p>
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/30637510/138532513-a59fbf41-bba1-4800-9812-ba9238b3b22d.png" style="max-width: 100%;">
Data will be populated in order that you define in selected section
<h3>Rub batchable job</h3>
<p>1. You can customize the job size, just change Custom Metadata Types: "Job Setting.Job Size"</p>
<p>2. Select action: Run Batchable Job</p>
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/30637510/138532714-af8bba3d-3e2f-490c-9e38-c189ef0c216d.png" style="max-width: 100%;">
<h3>Rub schedule job</h3>
<p>1. You can customize the date, just change Custom Metadata Types: "Job Setting.Job Cron Expression"</p>
<p>2. Select action: Run Scheduled Job</p>
<img width="500" alt="uml_diagram" src="https://user-images.githubusercontent.com/30637510/138532777-450d6619-cd2a-408c-badc-60ad286e4972.png" style="max-width: 100%;">
