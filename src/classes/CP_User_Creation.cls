/*
 Class Name : CP User creation 
 Activities : 1. Query all contacts records where portal access is true and portal user is false
              2. Process all records and created customer portal users in system.
              3. Send an email to customer to with username and passowrd. 
              4. Update contact record with error message if any records fails while creating user.
  Author    :Siva
  */
global class CP_User_Creation implements Database.Batchable<sObject>,Database.stateful {
    //global variables
    
    Map<id, String> errorMap = new Map<id, String>();
	List<id> successUserCreation = new List<id>();
	
    //Batch Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
		String query;
        query ='select id, name,Income_Tax_PAN_GIR_No__c,Passport_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity, Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where Portal_Access__c = true and Portal_User__c = false';
        return Database.getQueryLocator(query);
    }
    
    //Batch Execute Method
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        //variables declaration
        List<User> newUsers = new List<User>();
        Map<String , User> mapusr = new Map<String, User>();
        List<Contact> conList = new List<Contact>();
        List<Contact> conListProfile = new List<Contact>();
        //Map<id, String> errorMap = new Map<id, String>();
        Map<Contact, String> errorCPProfileMap = new Map<Contact, String>();
        List<Contact> UpdateContact = new List<Contact>();
        List<Contact> UpdateCPProfileContact = new List<Contact>();
        //List<id> successUserCreation = new List<id>();
        List<Contact> successCPProfileCreation = new List<Contact>();
        List<Id> accountIds = new List<Id>();
        List<Id> conIds = new List<Id>();
        List<Id> childaccIds= new List<id>();
        Map<Id, Id> OppAccMap = new Map<Id, Id>();
        Map<String,BG_CPprofile__c> cpprofileList = new Map<String,BG_CPprofile__c>();
        
        Map<Id, List<Opportunity>> accOppMap = new Map<Id, List<Opportunity>>();
        List<Opportunity> oppList1;
        List<Opportunity> tempOppList;
        List<Opportunity> oppList2;
        //query profile Id
        Profile portalProfile = [select id from profile where name = 'Overage High Volume Customer Portal User_Custom'];
        list<id> contactids = new list<id>();
        for(sObject sobj: Scope){
            contactids.add(sobj.id);
        }
        
        list<user> userList = new list<user>();
        userList = [select contactid from user where contactid IN :contactids];
        set<id> userAllreadyExist = new set<id>();
        for(user usr : userList){
            userAllreadyExist.add(usr.ContactId);
        }
         //List of parent account ids
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            conIds.add(con.Id);
            if(con.accountid!=null){
                accountIds.add(con.AccountId);
            }          
        }
        
        List<Account> accList = [select id , parentId, (select id,accountid from opportunities where StageName='Allotment' AND  Unit__r.Plant__r.Allowed_portal_access__c=TRUE ) from account where parentId IN: accountIds];
        
        for(Id accId:accountIds){
            oppList1 = new List<Opportunity>();
            tempOppList = new List<Opportunity>();
            for(Account acc: accList){
                if(accId == acc.parentId){
                    tempOppList = acc.getsObjects('opportunities');
                    	if(tempOppList != null){
                    		oppList1.addAll(tempOppList);
                    	}
                }               
            }
            if(oppList1.size()>0){
            	accOppMap.put(accId, oppList1);
            }
            system.debug('the accOppMap is'+accOppMap);
        }
        

        //Loop the scope variable to process list of contacts
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            oppList2 = new List<Opportunity>();
            //form username , nickname unique for customer
           /* for(con.Birthdate!=null) {
                Date dt = con.Birthdate;
                String birthdd = string.valueOf(dt.day());
                String birthmm = string.valueOf(dt.month());
            } */          
            String username ='';
            String Lastname = con.Lastname;
            
            
            if(con.Income_Tax_PAN_GIR_No__c!=null){
                username = con.Income_Tax_PAN_GIR_No__c+'@brigadeportal.com'+'';
            }
            else{
                username = con.Passport_No__c+'@brigadeportal.com'+'';
            }
            
            String nickName = con.Income_Tax_PAN_GIR_No__c;
            
            User usr = new User();
            usr.FirstName = con.FirstName;
            usr.LastName  = con.Lastname;
            if(Lastname.length()>7){
                usr.Alias     = Lastname.subString(0,7);
            }
            else {
                usr.Alias     = Lastname;
            }       
            usr.Email     = con.Email;
            usr.Username  = username;
            usr.Extenal_Id__c = username;
            usr.CommunityNickname = nickName;
            usr.ProfileId = portalProfile.Id;
            usr.IsActive = true;
            usr.MobilePhone = con.MobilePhone;
            usr.Street = con.MailingStreet;
            usr.City =  con.MailingCity;
            usr.State = con.MailingState;
            usr.PostalCode = con.MailingPostalCode;
            usr.Country = con.MailingCountry;
            if(!userAllreadyExist.contains(con.Id)){
            usr.ContactId = con.Id;
        	}
            usr.TimeZoneSidKey = 'Asia/Kolkata';
            usr.EmailEncodingKey ='UTF-8';
            usr.LocaleSidKey = 'en_IN';
            usr.LanguageLocaleKey ='en_US';
            oppList2 = accOppMap.get(con.AccountId);
            system.debug('opp list is '+oppList2 );
            if(oppList2!=null && oppList2.size()>1){
                usr.OpportunityId__c = oppList2[0].id;
            }
            
            // code to send email with temporary password
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.EmailHeader.triggerUserEmail = true;
            usr.setOptions(dmo);
            //newUsers.add(usr);
            mapusr.put(usr.Extenal_Id__c, usr);
            conList.add((Contact)sobj);
            
        } 
        system.debug('...the  map values '+mapusr.values());
        List<Database.UpsertResult> results;
        try {
            //inserting new portal users
            Schema.SobjectField externalIdField = User.Fields.Extenal_Id__c;
            results = Database.Upsert(mapusr.values(),externalIdField,false);
            system.debug('the results is'+ results);        
            //insert newUsers;
            //Loop the success and error messages
            for(Integer i =0; i<results.size();i++){
                Database.UpsertResult usrRecord = results[i];
                Sobject s = mapusr.values()[i];
                if(!usrRecord.isSuccess())  {
                    Contact con = conList[i];
                    for(Database.Error err: usrRecord.getErrors()){
                        errorMap.put(con.id, err.getMessage());    
                    }
                    system.debug('.... the error map'+errorMap) ;
                }
                if(usrRecord.isSuccess()){
                    Contact con = conList[i];
                    system.debug('the success value is'+con);
                    successUserCreation.add(con.id);
                }           
            }
            
        }  
        catch(DMLException e){
            system.debug('The dmlexception is'+e);
        }       
    }
	
    //Batch Final Method
    global void finish(Database.BatchableContext BC) {
	
		list<contact> UpdateContact = new list<contact>();
			for(id con:successUserCreation){
				contact cont = new contact(id=con ,Portal_User__c = true,Error_Message__c = '' );
                UpdateContact.add(cont);
            }
			
			for(id con:errorMap.keyset()){
               contact cont = new contact(id=con ,Error_Message__c = errorMap.get(con) );
                UpdateContact.add(cont);
            }
			
			try{
                Database.Update(UpdateContact);
            }
            catch(DMlException e){
                system.debug('Dml exception is'+ e);    
            }
        
        
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