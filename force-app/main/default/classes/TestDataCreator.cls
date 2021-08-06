public with sharing class TestDataCreator implements Queueable {
    Boolean isInsert;
    public TestDataCreator(Boolean isInsert) {
        this.isInsert = isInsert;
    }

    public void execute(QueueableContext context) {
        EntityBuilder accountsBuilder = new EntityBuilder(Constants.ACCOUNT_API_NAME,
                Constants.NAME_API_NAME, this.createAccounts());
        accountsBuilder.handleDuplication();
        List<Id> insertAccountIds;
        if (isInsert) {
            insertAccountIds = accountsBuilder.insertEntities();
        }

        EntityBuilder contactBuilder = new EntityBuilder(Constants.CONTACT_API_NAME,
                Constants.EMAIL_API_NAME, this.createContacts(insertAccountIds));
        contactBuilder.handleDuplication();
        if (isInsert) {
            List<Id> insertContacts = contactBuilder.insertEntities();
        }
    }

    private List<SObject> createAccounts() {
        return Constants.ACCOUNT_DATA;
    }

    private List<Contact> createContacts(List<Id> accountIds) {
        List<Contact> result = new List<Contact>();
        Integer accountCounter = 0;
        for (Contact cont : Constants.CONTACT_DATA) {
            if (accountIds != null && !accountIds.isEmpty()) {
                cont.put(Constants.ACCOUNT_ID_API_NAME, accountIds.get(accountCounter));
                accountCounter = accountIds.size() - 1 > accountCounter ? ++accountCounter : 0;
            }
            result.add(cont);

        }
        return result;
    }
}
