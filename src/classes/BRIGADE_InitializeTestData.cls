global class BRIGADE_InitializeTestData {
    
    public static User createUser(String Alias,String LName ,String FName,String UEmail ,String UName , String empCode,String profileName, Id UserId){
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        //UserRole userRMRol = [SELECT DeveloperName,Id FROM UserRole WHERE DeveloperName =: role]; 
        User userData = new User(Alias = Alias, 
                                 
                                  Email= UEmail, 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  EmployeeNumber = Alias,                                   
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  TimeZoneSidKey = 'Asia/Kolkata',
                                  ProfileId = p.Id, 
                                  ContactId = UserId,
                                  UserName= UName
                                  );
        return userData;
    }
    public static User createUserwithRole(String Alias,String LName ,String FName,String UEmail ,String UName , String empCode,String profileName, String role){
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        UserRole userRMRol = [SELECT Id FROM UserRole WHERE DeveloperName =: role]; 
        User userData = new User(Alias = Alias, 
                                 
                                  Email= UEmail, 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  EmployeeNumber = Alias,                                   
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  TimeZoneSidKey = 'Asia/Kolkata',
                                  ProfileId = p.Id, 
                                  
                                  UserRoleID = userRMRol.id,
                                  UserName= UName
                                  );
        return userData;
    }
    public static Lead createLead(String Fname,String LName,String email,String modeofen,String leadSource,String leadStatus,String MobilePhone,String Company,String salealias ){
        
        lead ld = new Lead(FirstName = Fname,
                           LastName = LName,
                           Email = email,
                           Mode_of_Enquiry__c = modeofen,
                           Lead_Source__c = leadSource,
                           Status = leadStatus,
                           MobilePhone =MobilePhone,
                           Company = Company,
                           Sales_Person_Alias__c = salealias,
                           phone = MobilePhone,
                           Phone2__c =MobilePhone,
                           Mobile_1__c = MobilePhone,
                           Follow_up_Date_text__c = '2016-03-16'
                          );
        return ld;
    }
    public static Lead createConvertedLead(String Fname,String LName,String email,String modeofen,String leadSource,String leadStatus,String MobilePhone,String Company,String salealias,String contactid,String Accountid,String Oppid ){
        
        lead ld = new Lead(FirstName = Fname,
                           LastName = LName,
                           Email = email,
                           Mode_of_Enquiry__c = modeofen,
                           Lead_Source__c = leadSource,
                           Status = leadStatus,
                           MobilePhone =MobilePhone,
                           Company = Company,
                           Sales_Person_Alias__c = salealias,
                           phone = MobilePhone,
                           //ConvertedAccountId = Accountid,
                           //ConvertedContactId = contactid,
                           //ConvertedOpportunityId = Oppid,
                           Phone2__c =MobilePhone,
                           Mobile_1__c = MobilePhone
                           //isConverted = true
                           
                          );
                          
        //insert ld;
        /*Database.LeadConvert dl = new Database.LeadConvert();
        dl.setLeadId(ld.id);
        dl.setConvertedStatus('Converted');
        Database.LeadConvertResult lcr = Database.convertLead(dl);*/
        return ld;
    }
    
    public static Lead createLeadmarkedDelete(String Fname,String LName,String email,String modeofen,String leadSource,String leadStatus,String MobilePhone,String Company,String salealias ){
        
        lead ld = new Lead(FirstName = Fname,
                           LastName = LName,
                           Email = email,
                           Mode_of_Enquiry__c = modeofen,
                           Lead_Source__c = leadSource,
                           Status = leadStatus,
                           MobilePhone =MobilePhone,
                           Company = Company,
                           Sales_Person_Alias__c = salealias,
                           phone = MobilePhone,
                           Phone2__c =MobilePhone,
                           Mobile_1__c = MobilePhone,
                           Follow_up_Date_text__c = '2016-03-16',
                           Mark_For_Deletion__c = true
                          );
        return ld;
    }
}