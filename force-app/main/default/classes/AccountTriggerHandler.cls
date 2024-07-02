public class AccountTriggerHandler {
    public static void beforeInsert(List<Account> accList) {
        for (Account acc : accList) {
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                acc.Rating = 'Hot';
            }
        }
        for (Account acc : accList) {
            // Check if the shipping fields are not empty before copying
            if (String.isNotBlank(acc.ShippingStreet) || 
                String.isNotBlank(acc.ShippingCity) || 
                String.isNotBlank(acc.ShippingState) || 
                String.isNotBlank(acc.ShippingPostalCode) || 
                String.isNotBlank(acc.ShippingCountry)) {
                
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
        for (Account acc : accList) {
            if (acc.Type == null || acc.Type.trim() == '') {
                acc.Type = 'Prospect';
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