trigger OpportunityTrigger on Opportunity (before insert, before update) {

  
      // *** Set 'Unit Status' of Unit__c ***
    public List<ID> oppId=new List<ID>();
    public List<ID> oppAccountId=new List<ID>();
    public List<Contact> conList = new List<Contact>();
    public List<OpportunityContactRole> conRoleList = new List<OpportunityContactRole>();
    OpptyUtil ouClass = new OpptyUtil();
    
    Map<Id,String> unitDetails = new Map<Id,String> ();
      if(contactRecursiveHelper.isopportunity == false){  
    //if(contactRecursiveHelper.isContactUpdate == false){
    try {
        for(Opportunity O : Trigger.New) {
            if(O.StageName=='Allotment'){
                oppId.add(O.Id);
                oppAccountId.add(O.AccountId);
            }
            
            System.debug('### (OpportunityTrigger) O.Set_the_Unit_Status__c: ' + O.Set_the_Unit_Status__c);
            if(O.Set_the_Unit_Status__c != null) {
                if(O.Set_the_Unit_Status__c.equals('Reserved')) {
                    unitDetails.put(O.Unit__c,'Reserved');
                    O.Set_the_Unit_Status__c = null;
                }
                else if(O.Set_the_Unit_Status__c.equals('Available')) {
                    unitDetails.put(O.Unit__c,'Available');
                    O.Unit__c = null;
                    O.Set_the_Unit_Status__c = null;
                }
            }
            else if(O.Unit_s_prior_id__c !=null) {
                unitDetails.put(O.Unit_s_prior_id__c,'Available');
                O.Unit_s_prior_id__c = null;
            }
        }
        System.debug('### (OpportunityTrigger) unitDetails: ' + unitDetails);
        if(unitDetails.size()>0){
        ouClass.setUnitStatus(unitDetails);
        }
        
        conList=[select Id,Birthdate,Company__c,Designation__c,Educational_Qualification__c,Income_Tax_PAN_GIR_No__c,Industry__c,Profession__c FROM Contact WHERE AccountId IN:oppAccountId limit 50000];
        conRoleList=[select Id FROM OpportunityContactRole WHERE OpportunityId IN:oppId];
        
        for(Opportunity O: Trigger.new){
        if(oppId.size()!=0){                        
            if(conList.size() > conRoleList.size()){
                if(conList.size()!=0){
                    if(contactRecursiveHelper.isContactUpdate == false){
                    if(contactRecursiveHelper.isupdateMasterPayment == false){
                    O.addError('Please create Contact Role below');
                         contactRecursiveHelper.isContactUpdate = true;
                         contactRecursiveHelper.isupdateMasterPayment = true;}
                      }
                }
            }
            
                //added to make contact field mandatory
                for(Contact cont : conList){
                    system.debug('#############cont################'+cont);
                    if(cont.Birthdate == Null || cont.Company__c == Null || cont.Designation__c == Null /*|| cont.Educational_Qualification__c == Null*/ || cont.Income_Tax_PAN_GIR_No__c == Null || cont.Industry__c == Null || cont.Profession__c == Null )
                    {
                        O.addError('To change stage to Allotment, following Contact fields are mandatory: Birthdate, Company, Designation,  Income Tax Pan Gir No, Industry and Profession');
                    }
                }
                //end of mandatory of contact field
            
        }
       } 
        // *** Set the CC Address of Account by including HFI's email ID ***
        /*List<Id> actIds = new List<Id> ();
        List<Account> lstAct;
        Map<Id,Account> mapAcnt = new Map<Id,Account> ();
        for(Opportunity o: Trigger.New) {
            if(o.Active__c)
                actIds.add(o.AccountId);
        }
        lstAct = [select CC_Address__c from Account where Id IN:actIds];
        System.debug('### (OpportunityTrigger) lstAct: ' + lstAct);
        for(Account a : lstAct) {
            mapAcnt.put(a.Id,a);
        }
        for(Opportunity o: Trigger.New) {
            if(o.HFI__c !=null) {
                if(o.HFI__r.Email__c !=null) {
                    if(! mapAcnt.get(o.AccountId).CC_Address__c.contains(o.HFI__r.Email__c)) {
                        mapAcnt.get(o.AccountId).CC_Address__c = mapAcnt.get(o.AccountId).CC_Address__c + ',' + o.HFI__r.Email__c;
                    }
                }
            }                
        }
        */
    }    
    catch(Exception e) {
        System.debug('### (OpportunityTrigger) Exception : ' + e.getMessage());
    }
     //contactRecursiveHelper.isContactUpdate = true;
 // } 
 }
 
}