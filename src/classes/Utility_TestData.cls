/*
 Description : This class is used for getting Test Data for various test classes
 Author      : Amritesh
 */
public class Utility_TestData {
    
    static String accRecordType    = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Master Account').getRecordTypeId();
    Static String oppRecordType    = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Opportunity After SO').getRecordTypeId();
    Static String UnitRecordType   = Schema.SObjectType.Unit__c.getRecordTypeInfosByName().get('Unit').getRecordTypeId();
    
    // get dummy Test User
    public static User getTestUser(){
        Profile testProfile = [select id from profile where name='System Administrator' limit 1];        
        User testUser = new User(profileId = testProfile.id, username = 'testUser@brigadeTestuser.com', email = 'test@brigadeTestuser.com', emailencodingkey = 'UTF-8', localesidkey = 'en_US',  languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles',    alias='cspu', lastname='lastname');               
        return testUser;
    }
    
    // get dummy Test Account
    public static Account getAccountData(){
        
        Country__c country  = new Country__c();
        country.Name        = 'India';
        insert country;
        
        Account acc                 = new Account();
        acc.Name                    = 'Test Account';
        acc.RecordTypeId            = accRecordType;
        acc.Customer_Group__c       ='Z3- Proprietary';
        acc.Distribution_channel__c ='10- Residential Sale';
        acc.Street1__c              = 'ABC Street';
        acc.CountryL__c             = country.Id;
        acc.Postal_Code__c          = '176209';
        acc.Rating                  = 'Hot';
        
        return acc;
    }
    
    // get dummy Test Plant__c
    public static Plant__c getPlant(){
        
        Plant__c plant                  = new Plant__c();
        plant.Name                      = 'KNPR - ALTAMONT';
        plant.Project__c                = 'Brigade Altamont';
        plant.Plant_Code__c             = 'KNPR';
        plant.Company_Code__c           = '1000';
        plant.Sales_Organisation__c     = '1000';
        plant.Allowed_portal_access__c  = true;
        
        return plant;
    }
    
    // get dummy Test Unit__c
    public static Unit__c getUnit(String plantId,Integer i){
        Unit__c unit                = new Unit__c();
        unit.Name                   = 'BG-ALT-A-X-0109-XX';
        unit.Plant__c               = plantId;
        unit.Description__c         = 'Construction - Residential';
        unit.Unit_Status__c         = 'Available';
        unit.Area__c                = 950;
        unit.Terrace_Area__c        = 0;
        unit.Unit_of_Measurement__c = 'FT2';
        unit.Garden_Area__c         = 0;
        unit.Type__c                = 'Z01';
        unit.Type_of_Unit__c        = 'Z03';
        unit.Floor__c               = 'Z00';
        unit.Facing__c              = 'Z02';
        unit.Direction__c           = 'Z04';
        unit.RecordTypeId           = UnitRecordType;
        
        return unit;
    }
    
     // get dummy Test Opportunity
    public static Opportunity getOpportunity(String accId,String unitId,integer i){
        
        Opportunity opp                     = new Opportunity();
        opp.Name                            = 'LAF-A-0002'+i;
        opp.AccountId                       = accId;
        opp.StageName                       = 'Reserving';
        opp.CloseDate                       = system.today();
        opp.Plant__c                        = 'KP03 - Meadows-Type C';
        opp.Date_of_Enquiry__c              = system.now();
        opp.Unit__c                         = unitId;
        opp.Date_of_Site_Visit__c           = system.now();
        opp.Company_Code__c                 = '1000';
        opp.RecordTypeId                    = oppRecordType;
        opp.Type                            = 'Retail';
        opp.LeadSource                      = 'Agent';
        opp.Sales_office__c                 = '1120 - Dubai Sales Office';
        opp.Customer_pricing_procedure__c   = '1- Flats Under Constr';
        opp.Cash_Management_Group__c        = 'A3- Employee Vendor';
        opp.Recon_Account__c                = '0023000010- Debtors - Domestic';
        opp.Plant__c                        = 'KNPR - ALTAMONT';        
        opp.ZTX1__c                         = '0- No VAT';
        opp.ZTX2__c                         = '0- No ST';
        opp.ZTX3__c                         = '0- No ECS';
        opp.ZTX4__c                         = '0- No HsES';
        opp.Partner_Functions__c            = 'ZC- Customer Relations';
        opp.Payment_Received_Total__c       = 10000;
        opp.Photographs_Received__c         = true;
        opp.Provisional_Allotment_letter__c = true;
        
        opp.Received_the_Address_Proof_Copy__c      = true;
        opp.Received_the_PAN_Card_Copy__c           = true;
        opp.Received_the_Passport_Copy_for_NRI__c   = true;
        opp.Booking_Form_Duly_filled_completely__c  = true;
        opp.Booking_CSAT_Feed_back_form__c          = true;
        opp.Active__c                               = true;
        opp.Handover_Feed_back_form__c              = true;
        
        return opp;
    }
        
    // get dummy Test Contact
    public static Contact getContact(){
        Contact con                         = new Contact();
        con.FirstName                       = 'Test';
        con.LastName                        = 'Test';
        con.Email                           = 'test@gmail.com';
        con.Birthdate                       = system.today().addYears(-20);    
        con.Company__c                      = 'Test Account';
        con.Designation__c                  = 'IT';
        con.Profession__c                   = 'IT';
        con.Income_Tax_PAN_GIR_No__c        = 'ABC-XX';
        con.Industry__c                     = 'IT';
        con.Educational_Qualification__c    = 'BTECH';
        return con;   
    }
    
    // get dummy Project record
    public static Project__c getProject(){
        Project__c proj = new Project__c();
        proj.Name       = 'Brigade Altamont';
        return proj;
    }
    
    // get dummy Target__c record
    public static Target__c getTarget(String projectId,String plantId){
        
        Target__c target            = new Target__c();
        target.Project_Lookup__c    = projectId;
        target.Plant__c             = plantId;
        //target.Month__c               = datetime.now().format('MMMMM');
        target.Start_Date__c        = system.today();
        target.End_Date__c          = system.today().addMonths(3);
        target.Value_Rs__c          = 100000;
        target.Area_sq_ft__c        = 1000;
        target.Collections_Rs__c    = 100000;
        target.Units__c             = 10;
        
        return target;
    }
    
     // get dummy Sale Order record
    public static Sale_Order_Item__c getSalesOrder(String oppId){
        
        Sale_Order_Item__c sItem    = new Sale_Order_Item__c();
        sItem.Opportunity__c        = oppId;
        sItem.Material__c           = 'BG-COS-G-X-0327-XX';
        sItem.Name                  = 'BG-COS-G-X-0327-XX';
        sItem.Item_category__c      = 'ZTAO';
        sItem.Unit_of_measure__c    = 'VAL';
        sItem.Order_Quantity__c     = 3;
        sItem.Basic_Cost__c         = 10000;
        sItem.Netvalue__c           = 10000;
        sItem.Tax__c                = 2000;
        
        return sItem;
    }
    // get dummy for Cost sheet
    public static CostSheet__c getCostSheetInfo (String plantId,String oppId){
      CostSheet__c  cItem       = new CostSheet__c();
      cItem.Plant__c            = plantId;
      cItem.Opportunity__c      = oppId;
      
       return cItem;
    }


    // get Test Data for User
    public static User createUser(String lName, String fName, String uEmail, String uNickName, String team, String uAlias, String userName) {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Custom Sales User' limit 1];
        User tmpUser = new User(FirstName = fName,             
                                 LastName = lName,
                                 Email = uEmail,
                                 CommunityNickname = uNickName,
                                 Alias= uAlias,
                                 Username = userName,
                                 ProfileId = p.Id,
                                 Team__c = team,
                                 EmailEncodingKey = 'ISO-8859-1',
                                 LanguageLocaleKey = 'en_US',
                                 LocaleSidKey = 'en_IN',
                                 TimeZoneSidKey='Asia/Kolkata');
        return tmpUser;                
    }

    // get Test Date for User with Role
    public static User createUserWithRole(String lName, String fName, String uEmail, String uNickName, String team, String uAlias, String userName) {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Custom Sales User' limit 1];
        UserRole role = [SELECT DeveloperName,Id,Name FROM UserRole WHERE DeveloperName = 'ExecutiveEnquiryManagement'];
        User tmpUser = new User(FirstName = fName,             
                                 LastName = lName,
                                 Email = uEmail,
                                 CommunityNickname = uNickName,
                                 Alias= uAlias,
                                 Username = userName,
                                 ProfileId = p.Id,
                                 UserRoleId = role.Id,
                                 Team__c = team,
                                 EmailEncodingKey = 'ISO-8859-1',
                                 LanguageLocaleKey = 'en_US',
                                 LocaleSidKey = 'en_IN',
                                 TimeZoneSidKey='Asia/Kolkata');
        return tmpUser;                
    }


    // get Test Data for Lead
    public static Lead createLead(String lName) {
        Lead tmpLead = new Lead(Status = 'Open',
                                LastName = lName, 
                                Company = 'Extentor',
                                Mode_of_Enquiry__c = 'Internet',
                                Lead_Source__c = 'website',
                                Alternate_Email__c = 'developer@extentor.com',
                                Date_of_Enquiry__c = System.now());
        return tmpLead;
    }   

    // get Test Data for Task
    public static Task createTask(Id leadId, Date dueDate, Id assignedTo){
        Task tempTask = new Task(Subject = 'Subject',
                                 OwnerId = assignedTo,
                                 WhoId = leadId,
                                 ActivityDate = dueDate);
        return tempTask;
    } 
   // get dummy for Master Payment Schedule
    public static Master_Payment__c getMasterPaymentInfo (){
      Master_Payment__c  masterPayment      = new Master_Payment__c();
     // masterPayment.Name                  = 'Payment-01';
      masterPayment.Billing_Date__c         = System.today();
     // masterPayment.Billing_Date_Duration__c= 0;
     
      masterPayment.Contact_mobile__c       = '9988771234';
      masterPayment.Contact_Name__c         =   'Shikha';
      masterPayment.Don_t_Disturb__c        = false;
      masterPayment.Invoice_Date__c         = System.today();
      masterPayment.Invoice_No__c           = 'INV-01';
      masterPayment.Payment_Received_SMS__c = true;
      masterPayment.Received_Date__c        = System.today();
      
      masterPayment.Sum_Of_Money__c         = '20000000';
     
       return masterPayment;
    }   
    
    // Create Custom Setting data for Survey URL
    public static Standard_Feedback_Form__c getSurveySettings(String cusName){
            
        Standard_Feedback_Form__c fd    = new Standard_Feedback_Form__c();
        fd.Form_url__c                  = 'www.sftest.com';
        fd.Name                         = cusName;
        
        return fd;
        
    }   
    
    // Get dummy data for TaskReAssignementPeriod__c Custom setting object
    public static TaskReAssignementPeriod__c getTaskPeriodInfo(String name,String fromTime,String toTime,String escalateTime){
        
        TaskReAssignementPeriod__c taskP    = new TaskReAssignementPeriod__c();
        taskP.Name                          = name;
        taskP.IF_Task_Created_From__c       = fromTime;
        taskP.Task_Create_To__c             = toTime;
        taskP.Escalate_at__c                = escalateTime;
        
        return taskP;
    }  
    
     // Get dummy data for Plumb5APIInfo__c Custom setting object
    public static Plumb5APIInfo__c getPlumb5Info(){
        
        Plumb5APIInfo__c plumb  = new Plumb5APIInfo__c();
        plumb.Name              = 'Plumb5';
        plumb.Ads_Id__c         = '1123';
        plumb.API_Key__c        = 'qweqwe123123qsdasdas';
        plumb.EndURL__c         = 'http://test.api.com';
        
        return plumb;
    }                            
}