public class AccountContactCreation {
 
    @future
    public static void createAccountsAndContacts(List<String> members) {
        List<Account> accountsToInsert = new List<Account>();
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (String member : members) {
            String[] nameParts = member.split(' ');
            if (nameParts.size() >= 2) {
                String firstName = nameParts[0];
                String lastName = nameParts[1];
                
                Account acc = new Account(Name = member + ' Account');
                accountsToInsert.add(acc);
                
                Contact con = new Contact(FirstName = firstName, LastName = lastName, AccountId = acc.Id);
                contactsToInsert.add(con);
            }
        }
        
        if (!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }
        
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
    public class AccountContactQueueable implements Queueable {
        List<String> members;
            
        public AccountContactQueueable(List<String> members) {
             this.members = members;
        }
            
        public void execute(QueueableContext context) {
                createAccountsAndContacts(members);
        }
	}
    
    public static void createAccountsAndContactsAsync(List<String> members) {
        AccountContactQueueable queueable = new AccountContactQueueable(members);
        System.enqueueJob(queueable);
    }
}