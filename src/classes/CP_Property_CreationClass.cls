/*
 Class Name : CP Property creation 
 Activities : 1. Query all contacts records where cpprofile user is true and and cpproperty is false
              2. Process all records and create cpproperty records in system.
              3. Update contact record with error message if any records fails while creating CPProperty.
  Author    :Siva
*/

global class CP_Property_CreationClass implements Database.Batchable<sObject>{
    //global variables
    String query;
    
    //Batch Start Method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        if(!Test.isRunningTest()){
        query ='select id, name,Income_Tax_PAN_GIR_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity, Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where CPProperty_User__c = false and CPProfile_User__c = true';
        }
        else {
            query ='select id, name,Income_Tax_PAN_GIR_No__c,AccountId,FirstName,Birthdate,Educational_Qualification__c,Company__c,Wedding_Anniversary__c,Account.Street1__c,Account.Street2__c,Account.Street3__c'+','+
        'Account.Postal_Code__c,Account.House_number__c,Account.City__c,Account.District__c,Account.RegionL__c,Account.CountryL__c'+','+
        'LastName,Salutation,MobilePhone, Phone,Alternate_Email__c,MailingCity, Email'+','+
        'Designation__c,Profession__c,Industry__c,CPProfile_User__c,MailingCountry,MailingPostalCode,MailingState,Portal_User__c,MailingStreet,Error_Message__c from Contact where CPProperty_User__c = false and CPProfile_User__c = true limit 1';
        }
        return Database.getQueryLocator(query);
        
        
    }
    
    //Batch Execute Method
    global void execute(Database.BatchableContext BC,List<sObject> scope){
        //variables Declaration
        List<Id> conIds = new List<Id>();
        List<Id> accountIds = new List<Id>();
        List<Id> childaccIds = new List<Id>();
        List<Id> PropertyOppIds = new List<Id>();
        List<Id> successSOIIds = new List<Id>();
        List<Id> opportunityIds = new List<Id>();
        List<Id> SOIIds = new List<Id>();
        Map<String,CP_Property__c> cppropertyList = new Map<String,CP_Property__c >();
        List<Contact> conListProperty = new List<Contact>();
        Map<Contact, String> errorCPPropertyMap = new Map<Contact, String>();
        List<Contact> UpdateCPPropertyContact = new List<Contact>();
        List<Contact> successCPPropertyCreation = new List<Contact>();
        Map<Id,Id> userWithAccount = new Map<Id,Id>();
        Map<Id,Contact> accountwithcontact = new Map<Id,Contact>();
        
        List<Sale_Order_Item__c>  SOIList = new List<Sale_Order_Item__c>();
        Map<String,CP_Sale_Order_Item__c> cpSOIList = new Map<String,CP_Sale_Order_Item__c>();
        Map<Contact, String> errorCPSOIMap = new Map<Contact, String>();
        List<Contact> UpdateCPSOIContact = new List<Contact>();
        List<Contact> successCPSOICreation = new List<Contact>();
        List<Contact> conListSOI = new List<Contact>();
        
        List<Payment_Schedule__c> paymentList = new List<Payment_Schedule__c>();
        Map<String,CP_Payment_Schedule__c> cpPaymentList = new Map<String,CP_Payment_Schedule__c>();
        Map<Contact, String> errorCPPaymentMap = new Map<Contact, String>();
        List<Contact> UpdateCPPaymentContact = new List<Contact>();
        set<Contact> successCPPaymentCreation = new set<Contact>();
        List<Contact> conListPayment = new List<Contact>();
        
        
        //List of parent account ids
        for(sObject sobj:scope){
            Contact con = (Contact)sobj;
            conIds.add(con.Id);
            accountIds.add(con.AccountId);
        }
        
        //List of child accounts
        List<Account> childAccList = [select id,ParentId from account where parentId IN:accountIds];
        //List of chilad account ids
        for(Account acc:childAccList){
            childaccIds.add(acc.Id);
            
        }
        
        //users of contact
        List<User> usrList = [select id,ContactId,AccountId from user where ContactId IN:conIds];
        
        // user , conatact with opportunity account ID
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@'+Scope.size());
        system.debug('#######################'+childAccList.size());
        system.debug('$$$$$$$$$$$$$$$$$$$$$$$'+childAccList.size());
       for(User usr:usrList){
            for(Account acc: childAccList){
                if(acc.ParentId == usr.AccountId){
                    userWithAccount.put(acc.Id, usr.Id);
                }
                
                for(sObject sobj: scope){
                    Contact con = (Contact)sobj;
                    if(con.AccountId == acc.ParentId){
                        accountwithcontact.put(acc.Id,con);
                    }
                }
            }   
        }
        
        //List of opportunities
        List<Opportunity> oppList = [select id,Name ,Company_Code__c,Plant__c,Project_Name__c,StageName,
                                     Sales_Organisation__c,Target__c,Unit__c,Target__r.Name,Unit__r.Name,AccountId, Unit__r.Plant__r.Allowed_portal_access__c  from opportunity where AccountId IN:childaccIds AND StageName='Allotment' AND  Unit__r.Plant__r.Allowed_portal_access__c=TRUE ];
        
        
        for(Opportunity opp:oppList){
            CP_Property__c  cpproperty = new CP_Property__c();
            cpproperty.Company_Code__c = opp.Company_Code__c;
            cpproperty.Contact_User_Id__c = userWithAccount.get(opp.AccountId);
            cpproperty.Opportunity_Id__c = opp.Id;
            cpproperty.Name = opp.Name;
            cpproperty.Plant__c = opp.Plant__c; 
            cpproperty.Project_Name__c = opp.Project_Name__c;
            cpproperty.Property_External_ID__c = opp.id+'-'+userWithAccount.get(opp.AccountId);
            cpproperty.Sales_Organisation__c = opp.Sales_Organisation__c;
            cpproperty.Target__c = Opp.Target__r.Name;
            cpproperty.Unit_Code__c = opp.Unit__r.Name;
            cppropertyList.put(cpproperty.Property_External_ID__c,cpproperty);
            conListProperty.add(accountwithcontact.get(opp.AccountId));
            opportunityIds.add(opp.Id);
        }
                
        List<Database.UpsertResult> cpPropertyresults;
        try {
            //upserting cpproperty records
            Schema.SobjectField externalIdField1 = CP_Property__c.Fields.Property_External_ID__c;
            cpPropertyresults = Database.Upsert(cppropertyList.values(),externalIdField1,false);
            
            //Loop the success and error messages
            for(Integer i =0; i<cpPropertyresults.size();i++){
                Database.UpsertResult cpPropertyRecord = cpPropertyresults[i];
                Sobject s = cppropertyList.values()[i];
                if(!cpPropertyRecord.isSuccess())   {
                    Contact con = conListProperty[i];
                    for(Database.Error err: cpPropertyRecord.getErrors()){
                        errorCPPropertyMap.put(con, err.getMessage());  
                    }   
                }
                if(cpPropertyRecord.isSuccess()){
                    //Contact con = conListProperty[i];
                    //successCPPropertyCreation.add(con);
                    PropertyOppIds.add(opportunityIds[i]);
                }
            }
            for(Contact con:errorCPPropertyMap.keyset()){
                con.Error_Message__c = errorCPPropertyMap.get(con);
                UpdateCPPropertyContact.add(con);
            }
            try{
                Database.Update(UpdateCPPropertyContact);
            }
            catch(DMlException e){
                system.debug('Dml exception is'+ e);
            }
        }  
        catch(DMLException e){
            system.debug('The dmlexception is'+e);
        }
        
        //query for sales order items
        if(PropertyOppIds.size()>0){
              SOIList = [select id,Name,Included_in_Allotment__c    ,Basic_Cost__c, Item_category__c,Material__c,Order_Quantity__c,Tax__c,
                                                  Unit_of_measure__c,Netvalue__c,Opportunity__r.AccountId,Opportunity__c from Sale_Order_Item__c where Opportunity__c IN:PropertyOppIds];
        }
        
        //query for property records
          
          List<CP_Property__c>  successCPPropertyList = [select id,Opportunity_Id__c from CP_Property__c where Opportunity_Id__c IN:PropertyOppIds];
          
        //creating sales order items
        for(Sale_Order_Item__c SOI: SOIList){
            for(CP_Property__c cpProperty: successCPPropertyList){
                if(cpProperty.Opportunity_Id__c == SOI.Opportunity__c){
                    CP_Sale_Order_Item__c cpSOI = new CP_Sale_Order_Item__c();
                    cpSOI.Name = SOI.Name;
                    cpSOI.Basic_Cost__c = SOI.Basic_Cost__c;
                    cpSOI.Included_in_Allotment_letter__c = SOI.Included_in_Allotment__c;
                    cpSOI.CP_Property__c = cpProperty.Id;
                    cpSOI.Item_category__c = SOI.Item_category__c;
                    cpSOI.Material__c = SOI.Material__c;
                    cpSOI.Netvalue__c = SOI.Netvalue__c;
                    cpSOI.Order_Quantity__c = SOI.Order_Quantity__c;
                    cpSOI.Tax__c = SOI.Tax__c;
                    cpSOI.Unit_of_measure__c = SOI.Unit_of_measure__c;
                    cpSOI.SOI_ID__c = SOI.Id;
                    cpSOIList.put(cpSOI.Material__c, cpSOI);
                    conListSOI.add(accountwithcontact.get(SOI.Opportunity__r.AccountId));
                    SOIIds.add(SOI.Id);
                }
            }
        }
        List<Database.UpsertResult> cpSalesOrderItemresults;
        try {
            //upserting cpproperty records
            Schema.SobjectField externalIdField2 = CP_Sale_Order_Item__c.Fields.Material__c;
            cpSalesOrderItemresults = Database.Upsert(cpSOIList.values(),externalIdField2,false);
            
            //Loop the success and error messages
            for(Integer i =0; i<cpSalesOrderItemresults.size();i++){
                Database.UpsertResult cpSOIRecord = cpSalesOrderItemresults[i];
                Sobject s = cpSOIList.values()[i];
                if(!cpSOIRecord.isSuccess())    {
                    Contact con = conListSOI[i];
                    for(Database.Error err: cpSOIRecord.getErrors()){
                        errorCPSOIMap.put(con, err.getMessage());   
                    }   
                }
                if(cpSOIRecord.isSuccess()){
                    //Contact con = conListProperty[i];
                    //successCPPropertyCreation.add(con);
                    successSOIIds.add(SOIIds[i]);
                }
            }
            for(Contact con:errorCPSOIMap.keyset()){
                con.Error_Message__c = errorCPSOIMap.get(con);
                UpdateCPSOIContact.add(con);
            }
            try{
                //system.debug('the list of UpdateCPSOIContact'+UpdateCPSOIContact);
                Database.Update(UpdateCPSOIContact);
            }
            catch(DMlException e){
                system.debug('Dml exception is'+ e);
            }
        }  
        catch(DMLException e){
            system.debug('The dmlexception is'+e);
        }
        
        //system.debug('the success ids'+cpSalesOrderItemresults );
        // query for payment schedules
        if(successSOIIds.size()>0){
            paymentList = [select id,Name,Billing_Date__c,Bill_Value__c,Description__c,Education_Cess__c,Payment_Received_Date__c ,
                                   Payment_Schedule_Id__c,Invoice_date__c,Invoice_No__c,Sale_Order_Item__c,Payment_Status__c,VAT__c,Secondary_Education_Cess__c,Service_Tax__c,Opportunity__r.AccountId,Courier_Doc_No__c,Courier_Sent_Date__c,Date_Base_Code__c,Mile_Stone_Base_Code__c,Mile_Stone_Block__c from Payment_Schedule__c where Sale_Order_Item__c IN:successSOIIds];  
        }
        //system.debug(' the payment list'+paymentList );
        
        // query for cp sales order items
        //List<CP_Sale_Order_Item__c>  cpSOIList2 = [select id,SOI_ID__c,CP_Property__c  from CP_Sale_Order_Item__c ];
        List<CP_Sale_Order_Item__c>  cpSOIList1 = [select id,SOI_ID__c,CP_Property__c  from CP_Sale_Order_Item__c where SOI_ID__c  IN:successSOIIds ];
        //system.debug(' the payment list'+cpSOIList1);
        //create cp payment schedules
        for(Payment_Schedule__c payment : paymentList){
            for(CP_Sale_Order_Item__c cpSOI:cpSOIList1){
                if(cpSOI.SOI_ID__c == payment.Sale_Order_Item__c){
                    CP_Payment_Schedule__c cppayment = new CP_Payment_Schedule__c();
                    cppayment.Name = payment.Name;
                    cppayment.Bill_Value__c = payment.Bill_Value__c;
                    cppayment.Billing_Date__c = payment.Billing_Date__c;
                    cppayment.CP_Property__c = cpSOI.CP_Property__c ;
                    cppayment.CP_Sale_Order_Item__c = cpSOI.Id;
                    cppayment.Description__c = payment.Description__c;
                    cppayment.Education_Cess__c = payment.Education_Cess__c;
                    cppayment.Payment_Received_Date__c = payment.Payment_Received_Date__c;
                    cppayment.Payment_Schedule_Id__c = payment.Payment_Schedule_Id__c;
                    cppayment.Payment_Status__c = payment.Payment_Status__c;
                    cppayment.Secondary_Education_Cess__c = payment.Secondary_Education_Cess__c;
                    cppayment.Service_Tax__c = payment.Service_Tax__c;
                    cppayment.VAT__c = payment.VAT__c;
                    cppayment.External_Id__c = payment.Id+'-'+cpSOI.Id;
                    cppayment.Payment_ID__c = payment.Id;
                    cppayment.Invoice_date__c = payment.Invoice_date__c;
                    cppayment.Invoice_No__c = payment.Invoice_No__c;                    
                    cppayment.Courier_Doc_No__c = payment.Courier_Doc_No__c;
                    cppayment.Courier_Sent_Date__c = payment.Courier_Sent_Date__c;
                    cppayment.Date_Base_Code__c = payment.Date_Base_Code__c;
                    cppayment.Mile_Stone_Base_Code__c = payment.Mile_Stone_Base_Code__c;
                    cppayment.Mile_Stone_Block__c = payment.Mile_Stone_Block__c;
                    cpPaymentList.put(cppayment.External_Id__c,cppayment);
                    conListPayment.add(accountwithcontact.get(payment.Opportunity__r.AccountId));
                }
            }
        }
            
        List<Database.UpsertResult> cpPaymentresults;
        try {
            //upserting cpproperty records
            Schema.SobjectField externalIdField3 = CP_Payment_Schedule__c.Fields.External_Id__c;
            cpPaymentresults = Database.Upsert(cpPaymentList.values(),externalIdField3,false);
            
            //Loop the success and error messages
            for(Integer i =0; i<cpPaymentresults.size();i++){
                Database.UpsertResult cpPaymentRecord = cpPaymentresults[i];
                Sobject s = cpPaymentList.values()[i];
                if(!cpPaymentRecord.isSuccess())    {
                    Contact con = conListPayment[i];
                    for(Database.Error err: cpPaymentRecord.getErrors()){
                        errorCPPaymentMap.put(con, err.getMessage());   
                    }   
                }
                if(cpPaymentRecord.isSuccess()){
                     Contact con = conListPayment[i];
                     successCPPaymentCreation.add(con);
                    //successSOIIds.add(SOIIds[i]);
                }
            }
            for(Contact con:errorCPPaymentMap.keyset()){
                con.Error_Message__c = errorCPPaymentMap.get(con);
                UpdateCPPaymentContact.add(con);
            }
            for(Contact con:successCPPaymentCreation){
                //system.debug('the success value is'+con);
                con.CPProperty_User__c = true;
                UpdateCPPaymentContact.add(con);
            }
            try{
                Database.Update(UpdateCPPaymentContact);
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