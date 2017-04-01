/**
* Handler Class     : commissionTriggerHandler 
* Created by        : ETMarlabs (07-07-2016)
* Description       : Trigger Hanndler contains all the logic for storeapprovalcomment trigger.
*                   : Inline comments are added to get specific details.
**/
public  class commissionTriggerHandler {
   
    public void storingApprovalComment(List<Commission__c> listOfCommission){
        set<id> setOfids = new set<ID>();
        List<Id> processInstanceIds = new List<Id>{};
        list<Commission__c> commissionToUpdate = new list<Commission__c>();
        List<Commission__c> Commissiones = new list<Commission__c>();
        
        Map<id,Commission__c> mapOFProcessInsAndCom = new Map<id,Commission__c>();
        for(Commission__c com : listOfCommission){
            setOfids.add(com.id);
        }
        
        system.debug(setOfids+'setOfids');
        ToGenerateRandomOTP.storeApprovalcomment(setOfids);
        system.debug('QQQQQQQQQ');
        updateComStatusinOpp(listOfCommission);
    }
    public void updateComStatusinOpp(List<Commission__c> listOfCommission){
        Set<id> oppId = new Set<Id>();
        List<opportunity> oppList = new list<opportunity>();
        List<opportunity> oppToUpdate = new list<opportunity>();
        Map<id,Opportunity> mapOfOppidAndOpp = new Map<Id,Opportunity>();
        opportunity opp ;
        for(Commission__c com : listOfCommission){
            oppId.add(com.opportunity__c);
            
        }
        oppList = [SELECT id,Commission_Status__c FROM Opportunity WHERE ID IN: oppId];
        if(oppList.size() > 0){
            for(Opportunity tempOpp : oppList ){
                mapOfOppidAndOpp.put(tempOpp.id,tempOpp );
            }
        }
        for(Commission__c com1 : listOfCommission){
            opp = new opportunity();
            opp = mapOfOppidAndOpp.get(com1.opportunity__c);
            system.debug(com1.Status__c+'SSSSSSSS');
            opp.Commission_Status__c  = com1.Status__c ;
            oppToUpdate.add(opp);
        }
        if(oppToUpdate.size() > 0){
            update oppToUpdate;
        }
    }
}