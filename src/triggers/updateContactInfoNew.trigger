/*
        Created by:
        Modified by:
        Purpose:
             In cpprofile object records,update to contact and account object.
*/ 

trigger updateContactInfoNew on BG_CPprofile__c (after Update) {
    if(contactRecursiveHelper.isContactUpdate != true && contactRecursiveHelper.isAccountUpdate != true){
    system.debug('222222222222222222222222222222222222222222'+contactRecursiveHelper.isContactUpdate);
  //Variable declaration
   Set<Id> ContactIds = new Set<Id>();
   Set<Id> AcccountIds= new Set<Id>();
   
   List<String> accIds = new List<String>();
   List<String> contIds = new List<String>();
   list<user> usrlst=new list<user>();
   list<contact> cc=new list<contact>();
   list<account> acc=new list<account>();
    
    //Adding the bgprofile records,contain contact ids
    for(BG_CPprofile__c CPprofile : Trigger.new)
    {
        ContactIds.add(CPprofile.Contact__c);
    } 
    //Getting the contact data
     system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@'+ContactIds);
     List<Contact> ContactChildList = new List<Contact>([SELECT AccountId,Income_Tax_PAN_GIR_No__c,Age_Yrs__c,Alternate_Email__c,Anniversary_Date__c,Bank_A_c_No__c,Bank_Name__c,Birthdate,Branch__c,CC_GPA__c,Circle__c,Company__c,Contact_Type__c,
                                                          CPProfile_User__c,CPProperty_User__c,Create_Date_of_Customer_Portal__c,Date_of_Issue__c,Department,Description,Designation__c,De_Activate_Date_of_Portal_User__c,District__c,Educational_Qualification__c,
                                                          Email,Error_Message__c,Fax,FirstName,Given_Name__c,HomePhone,House_number__c,Id,Industry__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,MobilePhone,Name,Name2__c,No_of_Children__c,Passport_No__c,Phone,Phone2__c,
                                                          Place_of_Assessment__c,Place_of_Issue__c,Portal_Access__c,Portal_User__c,Profession__c,Relation_Name__c,Relation__c,ReportsToId,Residency_Status__c,Salutation,Send_Anniversary_Email__c,Send_Birthday_Email__c,
                                                          Service_Tax_No__c,Spouse_s_Name__c,Street__c,Title,Type_of_A_c__c,Uploaded__c,Ward__c,Wedding_Anniversary__c, Account.BillingCity, Account.BillingState, Account.BillingStreet, Account.BillingPostalCode, Account.BillingCountry,Account.House_number__c,Account.Street1__c, Account.Street2__c, 
                                                          Account.Street3__c,Account.Postal_Code__c,Account.City__c,Account.District__c,Account.RegionL__r.Name ,Account.CountryL__r.Name FROM Contact WHERE Id IN: ContactIds ]);
    //Getting teh account data
    system.debug('##########################################'+ContactChildList);
    for(contact contac:ContactChildList ){       
       AcccountIds.add(contac.accountid);
    }
    
    list<account> Chilaccountetail=[select id,House_number__c,Street1__c,Street2__c,Street3__c,Postal_Code__c,
                                      City__c from account where id IN:AcccountIds];
    
   // account ac=[select id from account where id=:ContactChildList[0].accountid];
    //BG_CPprofile__c bg = new BG_CPprofile__c();
    //Bgprofile new information    
    for (BG_CPprofile__c CPprofile : Trigger.new) 
    {        
        system.debug('the cpprofile record'+CPprofile);
        for(Contact con: ContactChildList){
            if(con.id == CPprofile.Contact__c) {
                if(CPprofile.CPprofile_Mobile__c != null){            
                    con.MobilePhone = CPprofile.CPprofile_Mobile__c;
                }
                if(CPprofile.CPprofile_IncomeTaxPANGIRNo__c != null){            
                    con.Income_Tax_PAN_GIR_No__c = CPprofile.CPprofile_IncomeTaxPANGIRNo__c;
                }
                if(CPprofile.CPprofile_BirthDate__c != null){            
                    con.Birthdate = CPprofile.CPprofile_BirthDate__c;
                }
                if(CPprofile.CPprofile_Wedding_Anniversary__c != null){            
                    con.Wedding_Anniversary__c = CPprofile.CPprofile_Wedding_Anniversary__c;
                }                                 
                if(CPprofile.CPprofile_EmailForCommunication__c != null){ 
                    con.Email = CPprofile.CPprofile_EmailForCommunication__c;
                }
                if(CPprofile.CPprofile_Company__c != null){ 
                    con.Company__c = CPprofile.CPprofile_Company__c;
                }
                if(CPprofile.CPprofile_EducationalQualification__c != null){ 
                    con.Educational_Qualification__c = CPprofile.CPprofile_EducationalQualification__c;
                }
                if(CPprofile.CPprofile_Designation__c != null){ 
                    con.Designation__c = CPprofile.CPprofile_Designation__c;
                }
                if(CPprofile.CPprofile_Profession__c != null){
                    con.Profession__c = CPprofile.CPprofile_Profession__c;
                }
                if(CPprofile.CPprofile_Industry__c != null){
                    con.Industry__c = CPprofile.CPprofile_Industry__c;
                }
              }
              for(account ac : Chilaccountetail){ 
                  if(ac.id == con.accountId){
                      //Adding Values to Account
                      if(CPprofile.CPprofile_HouseNumber__c != null){
                          ac.House_number__c = CPprofile.CPprofile_HouseNumber__c;
                      }
                      if(CPprofile.CPprofile_Street1__c != null){
                          ac.Street1__c      = CPprofile.CPprofile_Street1__c;
                      }
                      if(CPprofile.CPprofile_Street2__c != null){
                          ac.Street2__c      = CPprofile.CPprofile_Street2__c;
                      }
                      if(CPprofile.CPprofile_Street3__c != null){
                          ac.Street3__c      = CPprofile.CPprofile_Street3__c;
                      }
                      if(CPprofile.CPprofile_BillingPostcode__c != null){
                          ac.Postal_Code__c  = CPprofile.CPprofile_BillingPostcode__c;
                      }
                      if(CPprofile.CPprofile_BillingCity__c != null){
                          ac.City__c         = CPprofile.CPprofile_BillingCity__c;
                      }     
                  }                
             }                          
         }    
    }
    system.debug('ContactChildList'+ContactChildList);
    contactRecursiveHelper.isContactUpdate = true;
    system.debug('ContactChildList'+ContactChildList);
    Update ContactChildList;
    update Chilaccountetail;
    system.debug('the contact list'+ContactChildList);
    }
}