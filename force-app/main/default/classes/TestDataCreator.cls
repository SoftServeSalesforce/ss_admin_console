public with sharing class TestDataCreator implements Queueable {

    public void execute(QueueableContext context) {
        EntityBuilder accountsBuilder = new EntityBuilder(Constants.ACCOUNT_API_NAME, 
            Constants.NAME_API_NAME, this.getAccounts());
        List<Id> insertAccountIds = accountsBuilder.insertEntities();
        
        EntityBuilder contactBuilder = new EntityBuilder(Constants.CONTACT_API_NAME, 
            Constants.EMAIL_API_NAME, this.getContacts(insertAccountIds));
        List<Id> insertContacts = contactBuilder.insertEntities();
    }

    private List<Map<String, String>> getAccounts() {
        List<Map<String, String>> accountFields = new List<Map<String, String>>();
        for (String accountName: Constants.ACCOUNT_NAMES) {
            accountFields.add(new Map<String, String> {
                Constants.NAME_API_NAME => accountName
            });
        }
        return accountFields;
    }

    private List<Map<String, String>> getContacts(List<Id> accountIds) {
        List<Map<String, String>> contactFields = new List<Map<String, String>>();
        Integer accountCounter = 0;
        for (String contactName: Constants.CONTACTS_FULL_NAME) {
            List<String> firstAndLastName = contactName.split(',');
            if (firstAndLastName.size() == 2) {
                Map<String, String> newFieldsSet = new Map<String, String> {
                    Constants.LAST_NAME_API_NAME => firstAndLastName.get(1),
                    Constants.FIRST_NAME_API_NAME => firstAndLastName.get(0),
                    Constants.EMAIL_API_NAME => firstAndLastName.get(0).toLowerCase() 
                        + firstAndLastName.get(1).toLowerCase() + Constants.EMAIL_DOMAIN
                };
                if (!accountIds.isEmpty()) {
                    newFieldsSet.put(Constants.ACCOUNT_ID_API_NAME, accountIds.get(accountCounter));
                }
                contactFields.add(newFieldsSet);
            }
            accountCounter = accountIds.size() - 1 > accountCounter ? ++accountCounter : 0;
        }

        return contactFields;
    }
}
