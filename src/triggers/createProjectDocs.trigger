/* this trigger is used to create project docs when cp property record*/
trigger createProjectDocs on CP_Property__c (after insert){
    if(contactRecursiveHelper.createProjectDocs == false) {
    //varibales declaration
    List<Id> userids = new List<Id>();
    List<Id> contactIds = new List<Id>();
    List<Id> accountIds = new List<Id>();
    List<Project_Docs__c> projectDocs = new List<Project_Docs__c>();
    Map<Id, Id> conUserMap = new Map<Id, Id>();
    Map<Id, Id> oppUserMap = new Map<Id, Id>();
    Map<Id, Id> OppPlantMap = new Map<Id,Id>();
    Map<Id,Id> conAccMap = new Map<Id,id>();
    List<Opportunity> oppList = new List<Opportunity>();
    List<contact> conList = new List<contact>();
    
    //Loop for cp property records
    for(CP_Property__c cp:Trigger.New){
        userids.add(cp.Contact_User_Id__c);
    }
    
    //query for all users records
    List<User> usrList = [select id,contactid,accountId from user where id IN: userids];
    
    //loop for contactIds 
    for(user usr:usrList){
        contactIds.add(usr.contactid);
        accountIds.add(usr.accountId);
        
    }
    
    //query for master accounts
    system.debug('%%%%%%%%%%%%%%%987654321%%%%%%%%%%%%%%%%'+accountIds.size());
    if(accountIds.size() >0){
    if(!Test.isRunningTest()){
       conList = [select id ,Contact_Type__c, accountId,account.ParentId,account.Account_Group__c from contact where account.parentId IN:accountIds];
    }
    else {
       conList = [select id ,Contact_Type__c, accountId,account.ParentId,account.Account_Group__c from contact where account.parentId IN:accountIds limit 1];
    }
    for(user usr: usrList){
        for(contact con : conList){
            if(con.account.ParentId == usr.AccountId){
                conUserMap.put(con.Id , usr.id);
            }
            if(con.account.Account_Group__c == 'Z03-NRI/Indian Citizen'){
                conAccMap.put(con.id, con.AccountId);   
            }
        }
    }
    system.debug('%%%%%%%%%%%%%%%accountIds%%%%%%%%%%%%%%%%'+accountIds);
     //query for opportunities 
     if(!Test.isRunningTest()){    
      oppList = [select id,Plant_Owner_Id__c,account.ParentId,AccountId from opportunity where account.ParentId IN:accountIds];
     system.debug('%%%%%%%%%%%%%%%oppList%%%%%%%%%%%%%%%%'+oppList);
     }
     else {
         oppList = [select id,Plant_Owner_Id__c,account.ParentId,AccountId from opportunity where account.ParentId IN:accountIds limit 1];
    
     }
     for(Opportunity opp:oppList){
         oppUserMap.put(opp.id, opp.AccountId);
         OppPlantMap.put(opp.Id, opp.Plant_Owner_Id__c);
     }
   
     
     //query for documents master records
       List<Document_Master__c> MasterDocs = [select id, name,Default__c from Document_Master__c where Default__c=true];
    
    //loop for cp property records for cretaing project docs
    for(CP_Property__c cp:Trigger.New){
        for(contact con: conList){            
            if(conUserMap.get(con.Id)== cp.Contact_User_Id__c && oppUserMap.get(cp.Opportunity_Id__c)== con.AccountId){
                for(Document_Master__c Mdoc:MasterDocs){
                    Project_Docs__c pdoc = new Project_Docs__c();
                    pdoc.Name = Mdoc.Name;
                    pdoc.Contact__c = con.Id;
                    pdoc.CP_Property__c = cp.Id;
                    pdoc.Contact_type__c = con.Contact_Type__c;
                    pdoc.OwnerId = oppPlantMap.get(cp.Opportunity_Id__c);
                    projectDocs.add(pdoc); 
                } 
                if(con.account.Account_Group__c == 'Z03-NRI/Indian Citizen'){
                    Project_Docs__c pdoc = new Project_Docs__c();
                    pdoc.Name = 'Passport';
                    pdoc.Contact__c = con.Id;
                    pdoc.CP_Property__c = cp.Id;
                    pdoc.Contact_type__c = con.Contact_Type__c;
                    pdoc.OwnerId = oppPlantMap.get(cp.Opportunity_Id__c);
                    projectDocs.add(pdoc);
                } 
            }         
        }     
    }
    //system.assertEquals(projectDocs.size(),null);
    // insert project docs
    if(projectDocs.size()>0){
        try {
            insert projectDocs;
        }
        catch(DMLException e) {
            system.debug('the DML exception is '+e);
        }
    }
    }
    
    }
}