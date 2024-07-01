public class OpportunityTriggerHandler {
    public static void beforeUpdate(List<Opportunity> oppList) {
        for (Opportunity opp : oppList) {
            if (opp.Amount <= 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
        Set<Id> accountIds = new Set<Id>();
        
        for (Opportunity opp : oppList) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        
        if (!accountIds.isEmpty()) {
            Map<Id, Contact> accountToCeoContactMap = new Map<Id, Contact>();
            for (Contact ceoContact : [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO' AND AccountId IN :accountIds]) {
                accountToCeoContactMap.put(ceoContact.AccountId, ceoContact);
            }
            
            for (Opportunity opp : oppList) {
                if (accountToCeoContactMap.containsKey(opp.AccountId)) {
                    opp.Primary_Contact__c = accountToCeoContactMap.get(opp.AccountId).Id;
                }
            }
        }
        
    }
    public static void beforeDelete(List<Opportunity> oppList) {
        Set<Id> accountIds = new Set<Id>();
        
        for (Opportunity opp : oppList) {
            accountIds.add(opp.AccountId);
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIds]);
        
        for (Opportunity opp : oppList) {
            Account acc = accountMap.get(opp.AccountId);
            if (opp.StageName == 'Closed Won' && acc.Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}

