public class AccountTriggerHandler {
    public static void beforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
         }
      }
    }
    public static void beforeUpdate(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            if (acc.ShippingStreet != null || acc.ShippingCity != null || acc.ShippingState != null || acc.ShippingPostalCode != null || acc.ShippingCountry != null) {
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
    } 
    public static void afterInsert(List<Account> newAccounts) {
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (Account acc : newAccounts) {
            Contact newContact = new Contact(
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = acc.Id
            );
            contactsToInsert.add(newContact);
        }
        
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}