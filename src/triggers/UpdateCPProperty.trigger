/* Trigger is used to update CPProperties when opportunity updated */
trigger UpdateCPProperty on Opportunity (before update,after insert,after update) {
    
  if(contactRecursiveHelper.isUpdateCPProperty == false)  {
    if(!(Trigger.isUpdate && Trigger.isAfter)){
        //vriables  Declaration
        List<Id> oppIds = new List<Id>();
        List<Id> accIds = new List<Id>();
        List<Id> parentAccIds = new List<Id>();
        List<Id> conIds = new List<Id>();
        List<Id> leadIds = new List<Id>();
        List<CP_Property__c> newCPPropertyList = new List<CP_Property__c>();
        List<CP_Property__c> UpdateCPPropertyList = new List<CP_Property__c>();
        Map<Id,Id> accIdParentId = new Map<Id,Id>();
        List<lead> leadlist = new List<lead>();
        List<Referral__c> referraaList = new List<Referral__c>();
        List<Referral__c> updateRefList = new List<Referral__c>();
        List<Payment_Schedule__c> getPaymentList = new List<Payment_Schedule__c>();
        List<CP_Property__c>  propertyList = new List<CP_Property__c>();
        List<Account> accList = new List<Account>();
        List<contact>  conList = new List<contact>();
        List<User> usrList = new List<User>();
       
        
        //trigger.New records 
        for(Opportunity opp:Trigger.New){
            oppIds.add(opp.Id);
            accIds.add(opp.AccountId);
        }
        
        //query properties
        if(oppIds.size()>0){
         propertyList = [select id,Name,Company_Code__c,Plant__c,Project_Name__c,Sales_Organisation__c,
                                                Target__c,Unit_Code__c,Opportunity_Id__c from CP_Property__c where Opportunity_Id__c IN: oppIds];
        }
         //query for converted lead records
             if(accIds.size()>0) {
                 system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+accIds);
                leadList = [select id,ConvertedAccountId from lead where ConvertedAccountId IN:accIds];
                 system.debug('#####################################'+leadList);
                for(Lead le:leadList){
                    leadIds.add(le.Id);
                }
            }
            
            //query for referral records
            if(leadIds.size()>0){
                 referraaList = [select id,Lead__c from Referral__c where Lead__c IN:leadIds];
            }        
           
            
           
            
        
        // create for new CPProperty when new opp created.                   
        if(Trigger.isInsert){
        
            //query for documents master records
            List<Document_Master__c> MasterDocs = [select id, name from Document_Master__c];
            //query for opportunity related accounts
            if(accIds.size()>0){                                           
               accList = [select id,ParentId from account where Id IN: accIds];
            }
            
            
            for(Account acc: accList){
                parentAccIds.add(acc.ParentId);
                accIdParentId.put(acc.Id,acc.ParentId);
            }
        
            //query for master contacts
            if(parentAccIds.size()>0){
                conList= [select id from contact where accountId IN:parentAccIds];
            }
            for(Contact con:conList){
                conIds.add(con.Id);
            }
           // system.debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+conIds);
            //system.debug([select id,Name, AccountId from Contact]);
            //system.debug([select id,ContactId, AccountId from User where Lastname='Testing786']);
            //query for users
            if(conIds.size()>0){
                usrList = [select id,ContactId, AccountId from User where ContactId IN:conIds];
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+usrList);
            }
            for(Opportunity opp:Trigger.New){
                for(User usr: usrList){
                    //system.assertEquals(opp,null);
                    system.debug('the user account id'+usr.AccountId);
                    system.debug('the opp account parent id'+opp.Account.ParentId);
                    if(usr.AccountId == accIdParentId.get(opp.AccountId)){
                        CP_Property__c cp = new CP_Property__c();
                        cp.Company_Code__c = opp.Company_Code__c;
                        cp.Contact_User_Id__c = usr.Id;
                        cp.Opportunity_Id__c = opp.Id;
                        cp.Name = opp.Name;
                        cp.Plant__c = opp.Plant__c;
                        cp.Project_Name__c = opp.Project_Name__c;
                        cp.Property_External_ID__c = opp.id+'-'+usr.Id;
                        cp.Sales_Organisation__c = opp.Sales_Organisation__c;
                        cp.Target__c = Opp.Target_Name__c;
                        cp.Unit_Code__c = opp.Unit_Name__c;
                        newCPPropertyList.add(cp);
                    }
                }
            }
            system.debug('########################################'+leadlist);
            //update referral status
            for(Opportunity opp:Trigger.New) {
                for(Lead le:leadlist){
                    if(le.ConvertedAccountId  == opp.AccountId) {
                        for(Referral__c rl:referraaList ){
                            if(rl.Lead__c == le.Id) {
                                rl.Status__c = opp.StageName;
                                updateRefList.add(rl);
                            }
                        }
                    }
                }
            }
            
        }
        //update cpproperty records when opportunity updated                                       
        if(Trigger.isUpdate){
            for(Opportunity opp:Trigger.New){
                for(CP_Property__c cpProperty: propertyList){
                    if(cpProperty.Opportunity_Id__c == opp.Id){
                        cpProperty.Name = opp.Name;
                        cpProperty.Company_Code__c = opp.Company_Code__c;
                        cpProperty.Plant__c = opp.Plant__c;
                        cpProperty.Project_Name__c = opp.Project_Name__c;
                        cpProperty.Sales_Organisation__c = opp.Sales_Organisation__c;
                        cpProperty.Target__c = Opp.Target_Name__c;
                        cpProperty.Unit_Code__c = opp.Unit_Name__c;
                        UpdateCPPropertyList.add(cpProperty);
                    }
                }
            }
                //update referral status
            for(Opportunity opp:Trigger.New) {
                Opportunity oldOpp = trigger.oldmap.get(opp.id);
                if(oldOpp.StageName!= opp.Stagename){
                    for(Lead le:leadlist){
                        if(le.ConvertedAccountId  == opp.AccountId) {
                            for(Referral__c rl:referraaList ){
                                if(rl.Lead__c == le.Id) {
                                    rl.Status__c = opp.StageName;
                                    updateRefList.add(rl);
                                }
                            }
                        }
                    }
                }
            }        
    
        }
        
               /* if(Trigger.isInsert){
                for(Opportunity opp:Trigger.New) {
                
                
                    for(Lead le:leadlist){
                        if(le.ConvertedAccountId  == opp.AccountId) {
                            for(Referral__c rl:referraaList ){
                                if(rl.Lead__c == le.Id) {
                                    rl.Status__c = opp.StageName;
                                    updateRefList.add(rl);
                                }
                            }
                        }
                    }
                }
            } */
    
    
            
            
        //insert property records
        if(newCPPropertyList.size()>0){
            try{
                Upsert newCPPropertyList;
            }
            catch(DMLException e){
                system.debug('The DML Exception is'+e);
            }
        }
        //update property records
        if(UpdateCPPropertyList.size()>0){
            try{
                Update UpdateCPPropertyList;
            }
            catch(DMLException e){
                system.debug('The DML Exception is'+e);
            }
        }   
        //update referral records
        if(updateRefList.size()>0){
            try{
                Update updateRefList;
            }
            catch(DMLException e){
                system.debug('The DML Exception is'+e);
            }
        }
        /* Get feedback date */
        if(oppIds.size()>0 ){
             getPaymentList=[Select Id, Billing_Date__c From Payment_Schedule__c Where Opportunity__c IN:oppIds Order By Billing_Date__c DESC];
         }
         if(getPaymentList.size() !=0){
         //system.debug('##########################################'+getPaymentList[0].Billing_Date__c);
         for(Opportunity o : Trigger.new){
         if(o.Sale_Order_Date__c != null){
          o.Latest_Payment_Schedule_Date__c = getPaymentList[0].Billing_Date__c;
          }
         } 
        }
    }
    
    
    contactRecursiveHelper.isUpdateCPProperty = true;
    }
    
    // Used for Sending Mail and Actual Calculation 
     
    Handler_OpportunityTrigger handler = new Handler_OpportunityTrigger();
    if(trigger.isUpdate && Trigger.isAfter && Utility_Class.IS_OPP_TRIGGER_RUNNING == false){         
        handler.AfterUpdate(trigger.new,trigger.newmap,Trigger.oldMap); 
    }
    
    if(trigger.isInsert && Trigger.isAfter && Utility_Class.IS_OPP_TRIGGER_RUNNING == false){
        handler.AfterInsert(trigger.new,trigger.newmap);
        Handler_OpportunityTrigger.sendFeedBackSurvey(trigger.newmap.keyset()); 
    }
}