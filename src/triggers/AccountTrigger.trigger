trigger AccountTrigger on Account (after update) {
    if(contactRecursiveHelper.AccountTrigger  == false){
    System.debug('### (AccountTrigger) Trigger.newMap.keySet(): ' + Trigger.newMap.keySet());
    List<Opportunity> lstOpp = new List<Opportunity>();
    if(Trigger.newMap.keySet().size()>0){
     lstOpp = [select Update_Flag__c,AccountId,Customer_ID__c from Opportunity
                    where AccountId =: Trigger.newMap.keySet() and Active__c =: True];
                    }
    Map<Id,String> mapAcnt = new Map<Id,String> ();
    for(Account a : Trigger.New) {
        mapAcnt.put(a.Id,a.Primary_Contact_s_Email__c);
    }
    System.debug('### (AccountTrigger) mapAcnt: ' + mapAcnt);
    try {
    if(lstOpp.size()>0){
        for(Opportunity o : lstOpp) {
            // *** Update the 'Opportunity Flag' of Opportunity ***
            if(o.Customer_ID__c != null)
                o.Update_Flag__c = 'U';
            // *** Update the 'Email__c' of Opportunity ***                
            if(mapAcnt.get(o.AccountId) != null)
                o.Email__c = mapAcnt.get(o.AccountId);
        }
        System.debug('### (AccountTrigger) lstOpp: ' + lstOpp);
        contactRecursiveHelper.isopportunity= true;       
        update lstOpp;
        System.debug('### INSIDE AccountTrigger');
    }
    }
    catch(Exception e) {
        Trigger.New[0].addError(e.getMessage());
    }
    contactRecursiveHelper.AccountTrigger  = true;
    }
}