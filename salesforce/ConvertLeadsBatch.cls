public class ConvertLeadsBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([SELECT Id, FirstName, LastName, Company FROM Lead]);
    }

    public void execute(Database.BatchableContext context, List<Lead> scope) {
        List<Account> accountsToInsert = new List<Account>();
        
        for (Lead lead : scope) {
            Account acc = new Account(Name = lead.Company);
            accountsToInsert.add(acc);
        }
        
        if (!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }
    }

    public void finish(Database.BatchableContext context) {
        sendEmail();
    }
    
    private void sendEmail() {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{'jashandeepsingla24@gmail.com'});
        email.setSubject('Testing batch email process');
        email.setPlainTextBody('The batch process to convert Leads to Accounts has been completed.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
}
