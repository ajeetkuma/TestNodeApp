/*
 Class Name : ReactivatePortalAccess 
 Activities : 1. Query all contacts records where portal access is true,deactivation is not null and reactive portal user is false.
              2. Process all records to reactive all users 
              3. Update contact record with error message if any records fails while reactivating user.
  Author    :Siva
  */
global class ReactivatePortalAccess implements Database.Batchable<sObject> {
    //global variables
    String query;
    
    //Batch Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        query ='select id, name,Income_Tax_PAN_GIR_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity, ReActive_Portal_user__c,Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where Portal_Access__c = true and De_Activate_Date_of_Portal_User__c!=null and ReActive_Portal_user__c = false';
        return Database.getQueryLocator(query);
    }
    
    //Batch Execute Method
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //variables declaration
        List<User> UpdatedUsers = new List<User>();
        List<Id> conIds = new List<Id>();
        List<Error_log__c> errList = new List<Error_log__c>();
        Map<String , User> mapusr = new Map<String, User>();
        List<Contact> conList = new List<Contact>();
        Map<Contact, String> errorMap = new Map<Contact, String>();
        List<Contact> UpdateContact = new List<Contact>();
        List<Contact> successUserUpdation = new List<Contact>();
        List<Id> contactIds = new List<Id>();
        
        //User u = [select id from user where id ='005300000051xlU'];
        //query profile Id
        Profile portalProfile = [select id from profile where name = 'Overage High Volume Customer Portal User_Custom'];
        //Loop the scope variable to process list of contacts
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            conIds.add(con.Id);
        } 
        
        //query for users
        List<User> usrList = [select id,Username,Extenal_Id__c,IsActive,ContactId from User where ContactId IN:conIds];
        
        //Loop all users and made deactive
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            for(User usr:usrList){
                if(usr.ContactId == con.Id){
                    usr.IsActive = true;
                    usr.Extenal_Id__c = usr.Username;
                    mapusr.put(usr.Extenal_Id__c,usr);
                    conList.add((contact)sobj);
                }
            }
        }
        
        List<Database.UpsertResult> results;
        try {
            //inserting new portal users
            Schema.SobjectField externalIdField = User.Fields.Extenal_Id__c;
            results = Database.Upsert(mapusr.values(),externalIdField,false);
            system.debug('the results is'+ results);        
            //Loop the success and error messages
            for(Integer i =0; i<results.size();i++){
                Database.UpsertResult usrRecord = results[i];
                Sobject s = mapusr.values()[i];
                if(!usrRecord.isSuccess())  {
                    Contact con = conList[i];
                    for(Database.Error err: usrRecord.getErrors()){
                        errorMap.put(con, err.getMessage());    
                    }
                    system.debug('.... the error map'+errorMap) ;
                }
                if(usrRecord.isSuccess()){
                    Contact con = conList[i];
                    system.debug('the success value is'+con);
                    successUserUpdation.add(con);
                }           
            }
            for(Contact con:errorMap.keyset()){
                con.Error_Message__c = errorMap.get(con);
                UpdateContact.add(con);
                contactIds.add(con.Id);
                
            }
             for(Contact con:successUserUpdation){
                system.debug('the success value is'+con);
                UpdateContact.add(con);
                contactIds.add(con.Id);             
            }
            List<user> usrList1= [select id,ContactId,ReActive_Portal_user__c from user where contactId IN:contactIds];
            
            for(User usr:usrList1){
                for(Contact con:UpdateContact){
                    if(usr.ContactId == con.Id){
                        if(con.Error_Message__c==null){
                            usr.ReActive_Portal_user__c  = true;
                            usr.Revoke_Portal_access__c = false;
                        
                        }
                        else{
                            usr.Error_Message__c = errorMap.get(con);
                        }
                    }
                }
            }
            
            try{
                    Database.update(usrList1);
            }
            catch(DMlException e){
                system.debug('Dml exception is'+ e);    
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