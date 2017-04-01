/*
 Class Name : UpdateRevokePortalAcessStatus 
 Activities : 1. Query all users records where user record updated with error message or revoke portal user.
              2. Process all users and update contacts. 
              
  Author    :Siva
  */
global class UpdateRevokePortalAcessStatus implements Database.Batchable<sObject> {
    //global variables
    String query;
    
    //Batch Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        query ='select id, name,Income_Tax_PAN_GIR_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity, ReActive_Portal_user__c,Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where Portal_Access__c = false and De_Activate_Date_of_Portal_User__c!=null and Revoke_Portal_access__c = false';
        return Database.getQueryLocator(query);
    }
    
    //Batch Execute Method
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //variables declaration
        List<Id> conIds = new List<Id>();
        Map<String, contact> mapContact = new Map<String, contact>();
        List<Contact> conList = new List<Contact>();
        Map<Contact, String> errorMap = new Map<Contact, String>();
        List<Contact> UpdateContact = new List<Contact>();
        
        
        //Loop the scope variable to process list of contacts
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            conIds.add(con.Id);
        } 
        
        //query for users
        List<User> usrList = [select id,Username,Extenal_Id__c,Revoke_Portal_access__c,ReActive_Portal_user__c ,Error_Message__c,IsActive,ContactId from User where ContactId IN:conIds];
        
        //Loop all users and made deactive
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            for(User usr:usrList){
                if(usr.ContactId == con.Id){
                    con.Revoke_Portal_access__c = usr.Revoke_Portal_access__c;
                    con.Error_Message__c = usr.Error_Message__c;
                    mapContact.put(con.Id,con);
                    conList.add((contact)sobj);
                }
            }
        }
        
        List<Database.UpsertResult> results;
        try {
            //update contact records
            Schema.SobjectField externalIdField = Contact.Fields.Id;
            results = Database.Upsert(mapContact.values(),externalIdField,false);
            system.debug('the results is'+ results);        
            //Loop the success and error messages
            for(Integer i =0; i<results.size();i++){
                Database.UpsertResult conRecord = results[i];
                Sobject s = mapContact.values()[i];
                if(!conRecord.isSuccess())  {
                    Contact con = conList[i];
                    for(Database.Error err: conRecord.getErrors()){
                        errorMap.put(con, err.getMessage());    
                    }
                    system.debug('.... the error map'+errorMap) ;
                }       
            }
            for(Contact con:errorMap.keyset()){
                con.Error_Message__c = errorMap.get(con);
                UpdateContact.add(con); 
            }
            if(UpdateContact.size()>0){
                try {
                    database.update(UpdateContact);
                }
                catch(DMLException e){
                    system.debug('The dmlexception is'+e);
                }
            }
           
        }  
        catch(DMLException e){
            system.debug('The dmlexception is'+e);
        }       
    }
    //Batch Final Method
    global void finish(Database.BatchableContext BC) {      
        // Get the ID of the AsyncApexJob representing this batch job
        // from Database.BatchableContext.
        // Query the AsyncApexJob object to retrieve the current job's information.
         EmailTemplate Emailtemplate=[SELECT Description, Body, Id, Name, BrandTemplateId, Markup, NamespacePrefix, TemplateStyle, Subject, 
                                                TemplateType FROM EmailTemplate where name=:'Batch job processing results']; 
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, createdBYId,CreatedBy.Email FROM AsyncApexJob WHERE Id =
                          :BC.getJobId()];
                          
       if(a.NumberOfErrors>0){
           // Send an email to the Apex job's submitter notifying of job completion.
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           string messageBody ;
           String[] toAddresses = new String[] {'c.p.support@brigadegroup.com'};
           mail.setToAddresses(toAddresses);
           mail.setTemplateId(Emailtemplate.id);
           mail.setTargetObjectId(a.createdBYId);
           mail.setHtmlBody(messageBody);
           mail.saveAsActivity=false;       
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
       }  
    }
    
}