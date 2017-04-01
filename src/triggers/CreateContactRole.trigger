/**    Description    :    Trigger on Conatct object to create Contact Role
  *
  *    Created By     :    Shikha Devi (Extentor Tquila)    
  *
  *    Created Date   :    10-June-2015
  *
  *    Version        :    V1.0 Created
  **/
trigger CreateContactRole on Contact (after insert) {

    
    //get the id of all involved accounts
    Set<ID> accountIds = new Set<ID>();
    for(Contact acc:trigger.new){
        accountIds.add(acc.AccountId);
    }
    
    //get all Opportunity for those accounts
    list<Opportunity> oppList = new list<Opportunity>();
    oppList = [select id, AccountId from Opportunity where AccountId in: accountIds];
    system.debug('Sourav'+oppList);
    
    //organize these opportunities by account
    Map<Id,List<Opportunity>> oppByContact = new Map<ID,List<Opportunity>>();
    for(Opportunity c:oppList){
    system.debug('12345679'+oppList);
        if(oppByContact.get(c.AccountId) == null){
        system.debug('*******'+oppByContact);
            oppByContact.put(c.AccountId,new List<Opportunity>());
        }
        oppByContact.get(c.AccountId).add(c);
        system.debug('*******'+oppByContact);
    }
        
       
        //create the OpportunityContactRole objects
        list<OpportunityContactRole> lstOCR = new list<OpportunityContactRole>();
        
        for(Contact contactInfo: trigger.new){
            if(oppByContact.get(contactInfo.AccountId) != null){
           
                for(Opportunity OppInfo: oppByContact.get(contactInfo.AccountId)){
                    OpportunityContactRole ocr = new OpportunityContactRole(OpportunityId=OppInfo.id, ContactId=contactInfo.id, Role = contactInfo.Contact_Type__c );
                    lstOCR.add(ocr);
                }
            }
         }
        try{
            insert lstOCR;
        }
        Catch(Exception e){
           System.debug('Contact your admin '+e.getMessage());
        }
}