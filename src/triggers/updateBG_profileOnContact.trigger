trigger updateBG_profileOnContact on Contact (before update) {
    if(contactRecursiveHelper.isContactUpdate != true){
        try{
    system.debug('11111111111111111111111111111111111111'+contactRecursiveHelper.isContactUpdate);
      //Variable declaration
   Set<Id> ContactIds = new Set<Id>();
   Set<Id> AccIds = new Set<Id>();
   Set<Id> AcccountIds = new Set<Id>();
   List<String> contIds = new List<String>();
   list<user> usrlst=new list<user>();
    
    //Adding the contact ids
    for(Contact con : Trigger.new)
    {
        ContactIds.add(con.Id);
        AccIds.add(con.AccountId);
    }
    
    List<BG_CPprofile__c> listBGprofile =[SELECT Contact__c,CPprofile_BillingCity__c,CPprofile_BillingCountry__c,CPprofile_BillingPostcode__c,CPprofile_BillingState__c,
    CPprofile_BillingStreet__c,CPprofile_BirthDate__c,CPprofile_Company__c,CPprofile_Designation__c,CPprofile_EducationalQualification__c,
    CPprofile_EmailForCommunication__c,CPprofile_HouseNumber__c,CPprofile_IncomeTaxPANGIRNo__c,CPprofile_Industry__c,CPprofile_MailingCity__c,
    CPprofile_MailingCountry__c,CPprofile_MailingPostCode__c,CPprofile_MailingState__c,CPprofile_MailingStreet__c,CPprofile_MirrorEducationalQualification__c,
    CPprofile_MirroringCompany__c,CPprofile_MirroringDesignation__c,CPprofile_MirroringEmailForCommunication__c,CPprofile_MirroringHouseNumber__c,
    CPprofile_MirroringIndustry__c,CPprofile_MirroringMailingCountry__c,CPprofile_MirroringMailingPostCode__c,CPprofile_MirroringMailingState__c,
    CPprofile_MirroringMailingStreet__c,CPprofile_MirroringMailing_City__c,CPprofile_MirroringMobile__c,CPprofile_MirroringName__c,CPprofile_MirroringProfession__c,
    CPprofile_MirroringStreet1__c,CPprofile_MirroringStreet2__c,CPprofile_MirroringStreet3__c,CPprofile_Mobile__c,CPprofile_Name__c,
    CPprofile_Profession__c,CPprofile_ReasonforReject_del__c,CPprofile_Street1__c,CPprofile_Street2__c,CPprofile_Street3__c,CPprofile_Wedding_Anniversary__c,
    CP_Profile_External_Id__c,Id,Mailing_Address__c,Name,Portal_UserMobile__c,Portal_Username__c,User__c FROM BG_CPprofile__c WHERE Contact__c IN:ContactIds];

     
    
     list<account> Chilaccountetail=[select id,House_number__c,Street1__c,Street2__c,Street3__c,Postal_Code__c,
                                      City__c from account where id IN:AccIds];
   // Account ac=[Select Id,House_number__c,Street1__c,Street2__c,Street3__c,Postal_Code__c,City__c From Account WHERE ID IN: AccIds];
    
    
    system.debug('%%%%%%%%%%%%%%%%%'+Chilaccountetail);
    for(Contact con : Trigger.new)
    {
        for(BG_CPprofile__c CPprofile : listBGprofile){
            if(CPprofile.Contact__c == con.ID){
                if(con.MobilePhone != null){        
                CPprofile.CPprofile_Mobile__c=con.MobilePhone;
                }
                if(con.Income_Tax_PAN_GIR_No__c != null){        
                CPprofile.CPprofile_IncomeTaxPANGIRNo__c=con.Income_Tax_PAN_GIR_No__c;
                }
                if(con.Email != null){ 
                CPprofile.CPprofile_EmailForCommunication__c = con.Email ;
                }
                if(con.Company__c != null){ 
                CPprofile.CPprofile_Company__c = con.Company__c;
                }
               // if(con.Educational_Qualification__c != null){ 
              // CPprofile.CPprofile_EducationalQualification__c = con.Educational_Qualification__c;
              // }
                if(con.Designation__c != null){ 
                CPprofile.CPprofile_Designation__c = con.Designation__c;
                }
                if(con.Profession__c != null){
                CPprofile.CPprofile_Profession__c = con.Profession__c;
                }
                if(con.Industry__c != null){
                CPprofile.CPprofile_Industry__c = con.Industry__c;
                }
                if(con.Birthdate != null){
                CPprofile.CPprofile_BirthDate__c= con.Birthdate;
                }
                if(con.Wedding_Anniversary__c != null){
                CPprofile.CPprofile_Wedding_Anniversary__c= con.Wedding_Anniversary__c;
                }
                if(con.Company__c != null){
                CPprofile.CPprofile_Company__c= con.Company__c;
                }
               // if(con.Educational_Qualification__c != null){
               // CPprofile.CPprofile_EducationalQualification__c= con.Educational_Qualification__c;
              //  }
                if(con.Designation__c != null){
                CPprofile.CPprofile_Designation__c= con.Designation__c;
                }
                if(con.Profession__c != null){
                CPprofile.CPprofile_Profession__c= con.Profession__c;
                }
                if(con.Industry__c != null){
                CPprofile.CPprofile_Industry__c= con.Industry__c;
                } 
                if(con.Name != null){
                CPprofile.Name= con.Name;
                }  
               if(Chilaccountetail != Null){
               for(account ac:Chilaccountetail){
               
               if(con.id==ac.id){                             
                //Adding Values to Account
                if(ac.House_number__c != null){
                CPprofile.CPprofile_HouseNumber__c = ac.House_number__c;
                }
                if(ac.Street1__c != null){
                CPprofile.CPprofile_Street1__c = ac.Street1__c;
                }
                if(ac.Street2__c != null){
                CPprofile.CPprofile_Street2__c = ac.Street2__c;
                }
                if(ac.Street3__c != null){
                CPprofile.CPprofile_Street3__c = ac.Street3__c;
                }
                if(ac.Postal_Code__c != null){
                CPprofile.CPprofile_BillingPostcode__c = ac.Postal_Code__c;
                }
                if(ac.City__c != null){
                CPprofile.CPprofile_BillingCity__c = ac.City__c;
                }
               }
             }
               }
            
            } 
        }
    }
    contactRecursiveHelper.isContactUpdate = true;
    system.debug('11111111111111111111111111111111111111'+contactRecursiveHelper.isContactUpdate);
    update listBGprofile;   
    
        }
        Catch(Exception e){
            System.debug('Please Contact your admin '+e.getMessage());
        }
    } 
}