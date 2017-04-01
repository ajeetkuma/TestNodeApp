/**
* Handler Class     : applicationTriggerHandler
* Created by        : ETMarlabs (22-08-2016)
* Description       : Trigger Hanndler contains all the logic for ApplicationSubmitForApproval trigger.
*                   : Inline comments are added to get specific details.
**/
public  class applicationTriggerHandler {
   
    public void updateLeadSource(List<Application_Form__c> listOfAppForm){
        Set<ID> setOppID = new Set<id>();
        Set<ID> setAppID = new Set<id>();
        List<Opportunity> listOFOpp = new list<Opportunity>();
        List<Opportunity> updateOppList = new list<Opportunity>();
        List<Application_Form__c> appList = new list<Application_Form__c>();
        List<Application_Form__c> updateAppList = new list<Application_Form__c>();
        List<OpportunityContactRole> oppContactRole = new list<OpportunityContactRole>();
        Map<id,Opportunity> mapOfOppIDAndOpp = new map<id,Opportunity>();
        Map<id,Application_Form__c> mapOfAppIDAndApp = new map<id,Application_Form__c>();
        Map<id,String> mapOfOppIDAndContact = new map<id,String>();
        for(Application_Form__c  app: listOfAppForm){
            setOppID.add(app.Opportunity__c);
            setAppID.add(app.id);
        }
        try{
            //Getting the first applicant contact name for email template. 
            oppcontactRole = [SELECT Id, ContactId, OpportunityId,contact.Email,contact.Name,contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId IN:setOppID AND IsPrimary = true ];
            
            listOFOpp = [SELECT id,Referred_By_Name_Text__c,Lead_Source__c,Channel_Partner__c,Referred_by_Name2__c FROM Opportunity WHERE ID IN:setOppID];
            // Getting the list of all application which is there in after update to perform dml operation
            appList  =[SELECT id,Requested_Lead_source__c,Contact_Name__c,Previous_Lead_Source__c FROM Application_Form__c WHERE ID IN:setAppID];
            if(oppcontactRole.size() > 0){
                for(OpportunityContactRole oppcon : oppcontactRole ){
                    mapOfOppIDAndContact.put(oppcon.OpportunityId,oppcon.contact.Name);
                }
            }
            if(listOFOpp.size() > 0){
                for(Opportunity opp : listOFOpp ){
                    mapOfOppIDAndOpp.put(opp.id,opp);
                }
            }
            if(appList.size() > 0){
                for(Application_Form__c appform : appList){
                    mapOfAppIDAndApp.put(appform.id,appform );
                }
            }
            for(Application_Form__c  app: listOfAppForm){
                if(mapOfOppIDAndOpp.get(app.Opportunity__c).Lead_Source__c != app.Requested_Lead_source__c ){
                    Application_Form__c  appRecord = mapOfAppIDAndApp.get(app.id);
                    //Update the application lead source and primary contact name.Updating the lead source with requested lead source.
                    appRecord.Lead_Source__c = app.Requested_Lead_source__c;
                    appRecord.Contact_Name__c = mapOfOppIDAndContact.get(app.Opportunity__c);
                    //If lead source is agent update the channel partner in opportunity.
                    if(app.Requested_Lead_source__c == 'Agents'){
                        Opportunity oppRecord = mapOfOppIDAndOpp.get(app.Opportunity__c);
                        oppRecord.Lead_Source__c = app.Requested_Lead_source__c ;
                        oppRecord.Channel_Partner__c = app.Channel_Partner__c;
                        
                        oppRecord.Referred_by_Name2__c = null;
                        updateOppList.add(oppRecord);
                    }
                    //If lead source is Referral update the reffered by name in opportunity.
                    if(app.Requested_Lead_source__c == 'Referral'){
                        Opportunity oppRecord = mapOfOppIDAndOpp.get(app.Opportunity__c);
                        oppRecord.Lead_Source__c = app.Requested_Lead_source__c ;
                        oppRecord.Referred_by_Name2__c = app.Referred_by_Name__c;
                        oppRecord.Referred_By_Name_Text__c = app.Referred_By_Name_Text__c;
                        oppRecord.Referrer_is_a__c = 'Customer';
                        oppRecord.Channel_Partner__c = null;
                        updateOppList.add(oppRecord);
                    }
                    // Make requested lead source to blank , after updating actual lead source.
                    appRecord.Requested_Lead_source__c = '';
                    updateAppList.add(appRecord);
                }
            }
            //updating the Opportunity list 
            if(updateOppList.size() > 0){
                update updateOppList;
            }
            //updating the Application list 
            if(updateAppList.size() > 0){
                update updateAppList;
            }
        }catch(exception e){
          system.debug(e.getMessage());
      }
    }
    
    public void updateApplicationStatus(List<Application_Form__c> listOfAppForm){
        Set<id> oppId = new Set<Id>();
        List<opportunity> oppList = new list<opportunity>();
        List<opportunity> oppToUpdate = new list<opportunity>();
        Map<id,Opportunity> mapOfOppidAndOpp = new Map<Id,Opportunity>();
        opportunity opp ;
        for(Application_Form__c app : listOfAppForm){
            oppId.add(app.opportunity__c);
            
        }
        oppList = [SELECT id,Application_status__c FROM Opportunity WHERE ID IN: oppId];
        if(oppList.size() > 0){
            for(Opportunity tempOpp : oppList ){
                mapOfOppidAndOpp.put(tempOpp.id,tempOpp );
            }
        }
        for(Application_Form__c app1 : listOfAppForm){
            opp = new opportunity();
            opp = mapOfOppidAndOpp.get(app1.opportunity__c);
            system.debug(app1.Application_Status__c +'SSSSSSSS');
            opp.Application_status__c = app1.Application_Status__c ;
            oppToUpdate.add(opp);
        }
        if(oppToUpdate.size() > 0){
            update oppToUpdate;
        }
    }
}