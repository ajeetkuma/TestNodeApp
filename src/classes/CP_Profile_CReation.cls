/*
 Class Name : CP Profile creation 
 Activities : 1. Query all contacts records where portal user is true and and cpprofile is false
              2. Process all records and create cpprofiles records in system.
              3. Update contact record with error message if any records fails while creating CPProfile.
  Author    :Siva
  */
global class CP_Profile_CReation implements Database.Batchable<sObject> {
    //global variables
    String query;
    
    //Batch Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        query ='select id, name,Income_Tax_PAN_GIR_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity,Account.CountryL__r.Name,Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,Account.RegionL__r.Name,Title,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where CPProfile_User__c = false and Portal_User__c = true';
        return Database.getQueryLocator(query);
    }
    //Batch Execute Method
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //variables declaration
        List<User> newUsers = new List<User>();
        List<Id> conIds = new List<Id>();
        List<Contact> conListProfile = new List<Contact>();
        Map<Contact, String> errorCPProfileMap = new Map<Contact, String>();
        Set<Contact> UpdateCPProfileContact = new set<Contact>();
        List<Contact> UpdateList = new List<Contact>();
        List<Contact> successCPProfileCreation = new List<Contact>();
        List<Contact> childcontacts = new List<Contact>();
        Map<Contact, String> ErrorchildContacts = new Map<Contact,String>();
        Map<String,BG_CPprofile__c> cpprofileList = new Map<String,BG_CPprofile__c>();
        
        List<Id> MasterAccountIds = new List<Id>();
        List<Id> childAccountIds = new List<Id>();
        Map<Id,contact> conMap = new Map<Id,contact>();
        
        for(Sobject sobj:scope){
            Contact con = (Contact)sobj;
            conIds.add(con.id);
            if(con.AccountId!=null){           
                MasterAccountIds.add(con.AccountId);
            }
        }
        
        //query for child Accounts 
        List<Account> accList = [select id, parentId from Account where ParentId IN: MasterAccountIds];
        //system.debug('Master id is '+MasterAccountIds);
        for(Account acc: accList) {
            childAccountIds.add(acc.Id);
        }
        //system.debug('child id is'+childAccountIds);
        //query for first Applicant contacts 
        List<Contact> conList = [select id,name,Income_Tax_PAN_GIR_No__c,AccountId,Account.parentId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c,Account.Postal_Code__c,
                                        Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c,LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity,Account.CountryL__r.Name,Email,Designation__c,
                                        Profession__c,Industry__c,CPProfile_User__c,Account.RegionL__r.Name,Title,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where AccountId IN: childAccountIds ];// and  Contact_Type__c= 'First Applicant'];
        
        for(sObject sobj: scope){
            Contact con = (Contact)sobj;
            for(Contact con1: conList){
                if(con1.Account.ParentId == con.AccountId){
                    conMap.put(con1.Id,con);
                }
            }
        }
        
        // CP Profile  creation
        List<User> SuccessusrList = [select id ,name,MobilePhone,ContactId from User where contactID IN:conIds];
        for(Contact con : conList){
            for(User u:SuccessusrList){
                if(u.ContactId == conMap.get(con.Id).Id){
                    String Street = con.Account.House_number__c+','+con.Account.Street1__c+','+con.Account.Street2__c+','+con.Account.Street3__c;
                    String StreetAddress = Street.remove(',null');
                    BG_CPprofile__c cpprofile = new BG_CPprofile__c();
                    cpprofile.Name = con.Name;
                    cpprofile.CPprofile_EmailForCommunication__c = con.Email;
                    cpprofile.CPprofile_BirthDate__c = con.Birthdate;
                    cpprofile.CPprofile_Wedding_Anniversary__c = con.Wedding_Anniversary__c;
                    cpprofile.CPprofile_Mobile__c = con.MobilePhone;
                    cpprofile.CPprofile_BillingStreet__c = StreetAddress;
                    cpprofile.CPprofile_BillingCity__c = con.Account.City__c;
                    cpprofile.CPprofile_BillingState__c = con.Account.RegionL__r.Name;
                    cpprofile.CPprofile_BillingCountry__c = con.Account.CountryL__r.Name;
                    cpprofile.CPprofile_BillingPostcode__c = con.Account.Postal_Code__c;
                    cpprofile.CPprofile_HouseNumber__c = con.Account.House_number__c;
                    cpprofile.CPprofile_Street1__c = con.Account.Street1__c;
                    cpprofile.CPprofile_Street2__c = con.Account.Street2__c;
                    cpprofile.CPprofile_Street3__c = con.Account.Street3__c;
                    cpprofile.CPprofile_MailingStreet__c = con.MailingStreet;
                    cpprofile.CPprofile_MailingCity__c = con.MailingCity;
                    cpprofile.CPprofile_MailingState__c = con.MailingState;
                    cpprofile.CPprofile_MailingPostCode__c = con.MailingPostalCode;
                    cpprofile.CPprofile_MailingCountry__c = con.MailingCountry;
                    cpprofile.CPprofile_IncomeTaxPANGIRNo__c = con.Income_Tax_PAN_GIR_No__c;
                    cpprofile.CPprofile_Company__c = con.Company__c;
                    cpprofile.CPprofile_EducationalQualification__c = con.Educational_Qualification__c;
                    cpprofile.CPprofile_Designation__c = con.Title;
                    cpprofile.CPprofile_Profession__c = con.Profession__c;
                    cpprofile.CPprofile_Industry__c = con.Industry__c;
                    cpprofile.Portal_Username__c = u.Name;
                    cpprofile.Portal_UserMobile__c = u.MobilePhone;
                    cpprofile.User__c = u.id;
                    cpprofile.Contact__c = con.id;
                    cpprofile.CP_Profile_External_Id__c = u.id+'-'+con.id;
                    cpprofileList.put(cpprofile.CP_Profile_External_Id__c, cpprofile);
                    conListProfile.add(conMap.get(con.Id));
                    childcontacts.add(con);
                }
            }
        }
        //system.debug(cpprofileList);
        List<Database.UpsertResult> cpProfileresults;
        try {
            
            //inserting new portal users
            Schema.SobjectField externalIdField1 = BG_CPprofile__c.Fields.CP_Profile_External_Id__c;
            cpProfileresults = Database.Upsert(cpprofileList.values(),externalIdField1,false);
           // system.debug('the results is'+cpProfileresults );
            //insert newUsers;
            //Loop the success and error messages
            for(Integer i =0; i<cpProfileresults.size();i++){
                Database.UpsertResult cpProfileRecord = cpProfileresults[i];
                Sobject s = cpprofileList.values()[i];
                if(!cpProfileRecord.isSuccess())    {
                    Contact con = conListProfile[i];
                    Contact con1 =childcontacts[i];
                    for(Database.Error err: cpProfileRecord.getErrors()){
                        errorCPProfileMap.put(con, err.getMessage()); 
                        ErrorchildContacts.put(con1, err.getMessage());
                    }   
                }
                if(cpProfileRecord.isSuccess()){
                    Contact con = conListProfile[i];
                    //Contact con = childcontacts[i];
                    successCPProfileCreation.add(con);
                }
            }
            for(Contact con:ErrorchildContacts.keyset()){
                con.Error_Message__c = errorCPProfileMap.get(con);
                UpdateCPProfileContact.add(con);
            }
            for(Contact con:successCPProfileCreation){
                //system.debug('the success value is'+con);
                con.CPProfile_User__c = true;
                con.Error_Message__c='';
                UpdateCPProfileContact.add(con);
            }
            for(Contact con:UpdateCPProfileContact) {
                UpdateList.add(con);
            }
            //system.debug('the list ids is '+UpdateList);
            try{
                Database.Update(UpdateList);
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