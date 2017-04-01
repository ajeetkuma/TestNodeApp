trigger AfterInsertTriger on Lead (after insert,after Update) {
   
    if(Trigger.isAfter && Trigger.isinsert){
        
        if(checkRecursive.runOnce()){
            enquiryTriggerHandler ins = new enquiryTriggerHandler ();
            ins.checkingForExistingLead(Trigger.New);
        }
        list<id> leadid = new list<id>();
        for(lead l : Trigger.new){
            if(l.mobilephone != null && l.mobilephone != '' && l.ownerid == label.WebToLeadOwnerID){
                leadid.add(l.id);
            }
        }
        if(leadid.size()>0){
            LeadCreationSMS.sendSMSToLead(leadid);
        }
        
    }
    
    // To create Referral record if Lead Source is Referral
    if(Trigger.isAfter && Trigger.isInsert){
       List<Referral__c> createRef = new List<Referral__c>();
       Set<Id> contactIds = new Set<Id>();
       for(Lead leadObj : Trigger.New){
           contactIds.add(leadObj.Referred_by_Name2__c);
       }
       
       Map<id,Contact> mapOfContactIdandContactRecord = new Map<id,Contact>([select id,name,Email from Contact where Id in :contactIds]);
       
           for(Lead l : Trigger.New){
        
           Referral__c ref = new Referral__c();
               if(l.Lead_Source__c == 'Referral'){
                   ref.Name__c= l.LastName+' '+l.FirstName;
                   ref.Mobile__c = l.MobilePhone;
                   ref.Email__c = l.Email;
                   if(mapOfContactIdandContactRecord.get(l.Referred_by_Name2__c) != null){
                       ref.User_Name__c = mapOfContactIdandContactRecord.get(l.Referred_by_Name2__c).name;
                       ref.User_Email__c = mapOfContactIdandContactRecord.get(l.Referred_by_Name2__c).email; 
                   } 
                   ref.Project_Information__c = l.Project__c;
                   createRef.add(ref);
                   
               }
             
       
           }
      try{
        insert createRef;
      }catch(DMLException e){
          System.debug(e);
       }
    
    }
    // To create WebToLead record if lead source is LivPop to capture if the Lead got created
    //This record is used to send Lead details to LivProp through Workflow.
     if(Trigger.isAfter && Trigger.isInsert){
        List<Web_to_Lead_Capture__c> createWTLRecord = new List<Web_to_Lead_Capture__c>();
       // Database.SaveResult[] srList = Database.insert(createWTLRecord, false);
        
      
           for(Lead l : Trigger.New){
        
            Web_to_Lead_Capture__c wtl = new Web_to_Lead_Capture__c();
               if(l.Lead_Source__c == 'LivProp'){
                   if(l.FirstName != null && l.LastName != null)
                       wtl.Name= l.FirstName+''+l.LastName;
                   if(l.MobilePhone != null)
                       wtl.Lead_Mobile__c = l.MobilePhone;
                   if(l.Email != null)
                       wtl.Lead_Email_ID__c = l.Email;
                   wtl.LivProp_Email_ID__c = 'brigadeleads.livserv@gmail.com';
                   wtl.Success_Error_Msg__c = 'Success';
                   } 
                createWTLRecord.add(wtl);
                   
               }
             
      try{
        insert createWTLRecord;
      }catch(DMLException e){
            Web_to_Lead_Capture__c wtle= new Web_to_Lead_Capture__c();
            Lead le = new Lead();
                if(le.Lead_Source__c == 'LivProp'){
                    wtle.Success_Error_Msg__c = 'Failure';
                    wtle.Error_Message__c=e.getMessage();
                    System.debug(e);
                }
                
                createWTLRecord.add(wtle); 
                insert createWTLRecord;       
            }
           
            
 
    }   
    /*
    if(Trigger.isAfter && Trigger.isUpdate){
        if(checkRecursive.runOnce()){
            enquiryTriggerHandler ins = new enquiryTriggerHandler ();
            ins.checkingForExistingLead(Trigger.New);
        }
        
    }*/

}