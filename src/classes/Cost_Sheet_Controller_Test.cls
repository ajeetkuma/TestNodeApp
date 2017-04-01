/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData=false)
public class Cost_Sheet_Controller_Test {
      static testMethod void myUnitTest(){
        test.startTest();
        
        Plant__c objPlant            = new Plant__c();
        objPlant.Name                       = 'KNPR - ALTAMONT';
        objPlant.Project__c                 = 'Brigade Altamont';
        objPlant.Plant_Code__c              = 'KNPR';
        objPlant.Company_Code__c            = '1000';
        objPlant.Sales_Organisation__c      = '1000';
        objPlant.Allowed_portal_access__c   = true;
        insert objPlant;
        
       
        Unit__c unit                = new Unit__c();
        unit.Name                   = 'BG-ALT-A-X-0109-XX';
        unit.Plant__c               = objPlant.id;
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
         insert unit;
        
       
        Country__c country  = new Country__c();
        country.Name        = 'India';
        insert country;
        
        Account acc                 = new Account();
        acc.Name                    = 'Test Account';
    //    acc.RecordTypeId          = accRecordType;
        acc.Customer_Group__c       ='Z3- Proprietary';
        acc.Distribution_channel__c ='10- Residential Sale';
        acc.Street1__c              = 'ABC Street';
        acc.CountryL__c             = country.Id;
        acc.Postal_Code__c          = '176209';
        acc.Rating                   = 'Hot'; 
        insert acc;
       
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
        insert con;    
        
          Opportunity opp                   = new Opportunity();
        opp.Name                            = 'LAF-A-0002';
        opp.AccountId                       = acc.Id;
        opp.StageName                       = 'Reserving';
        opp.CloseDate                       = system.today();
        opp.Plant__c                        = 'KP03 - Meadows-Type C';
        opp.Date_of_Enquiry__c              = system.now();
        opp.Unit__c                         = unit.Id;
        opp.Date_of_Site_Visit__c           = system.now();
        opp.Company_Code__c                 = '1000';
       // opp.RecordTypeId                  = oppRecordType;
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
       // opp.Payment_Received_Total__c     = 10000;
        opp.Photographs_Received__c         = true;
        opp.Provisional_Allotment_letter__c = true;
        
        opp.Received_the_Address_Proof_Copy__c      = true;
        opp.Received_the_PAN_Card_Copy__c           = true;
        opp.Received_the_Passport_Copy_for_NRI__c   = true;
        opp.Booking_Form_Duly_filled_completely__c  = true;
        opp.Booking_CSAT_Feed_back_form__c          = true;
        opp.Active__c                               = true;
        opp.Handover_Feed_back_form__c              = true;
        insert opp;
        
        Project__c proj = new Project__c();
        proj.Name       = 'Brigade Altamont';
        insert proj;
       
      CostSheet__c  cItem       = new CostSheet__c();
      cItem.Plant__c            = objPlant.id;
      cItem.Opportunity__c      = opp.Id;
      cItem.Project__c          = proj.id;
      insert cItem;
      
      PageReference pgRef = Page.Generate_Cost_Sheet; //Create Page Reference - 'Generate_Cost_Sheet' is the name of Page
        Test.setCurrentPage(pgRef); //Set the page for Test Method
           //Cost_Sheet_Controller cntrlr = new Cost_Sheet_Controller(stdController);
          ApexPages.currentPage().getParameters().put('id', cItem.id);//Pass Id to page
          }   
static testMethod void myUnitTest1(){
        test.startTest();
    try{
        Plant__c objPlant            = new Plant__c();
        objPlant.Name                       = 'KNPR - ALTAMONT';
        objPlant.Project__c                 = 'Brigade Altamont';
        objPlant.Plant_Code__c              = 'KNPR';
        objPlant.Company_Code__c            = '1000';
        objPlant.Sales_Organisation__c      = '1000';
        objPlant.Allowed_portal_access__c   = true;
        insert objPlant;
        
       
        Unit__c unit                = new Unit__c();
        unit.Name                   = 'BG-ALT-A-X-0109-XX';
        unit.Plant__c               = objPlant.id;
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
         insert unit;
        
       
        Country__c country  = new Country__c();
        country.Name        = 'India';
        insert country;
        
        Account acc                 = new Account();
        acc.Name                    = 'Test Account';
    //    acc.RecordTypeId          = accRecordType;
        acc.Customer_Group__c       ='Z3- Proprietary';
        acc.Distribution_channel__c ='10- Residential Sale';
        acc.Street1__c              = 'ABC Street';
        acc.CountryL__c             = country.Id;
        acc.Postal_Code__c          = '176209';
        acc.Rating                   = 'Hot'; 
        insert acc;
       
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
        insert con;    
        
          Opportunity opp                   = new Opportunity();
        opp.Name                            = 'LAF-A-0002';
        opp.AccountId                       = acc.Id;
        opp.StageName                       = 'Reserving';
        opp.CloseDate                       = system.today();
        opp.Plant__c                        = 'KP03 - Meadows-Type C';
        opp.Date_of_Enquiry__c              = system.now();
        opp.Unit__c                         = unit.Id;
        opp.Date_of_Site_Visit__c           = system.now();
        opp.Company_Code__c                 = '1000';
       // opp.RecordTypeId                  = oppRecordType;
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
       // opp.Payment_Received_Total__c     = 10000;
        opp.Photographs_Received__c         = true;
        opp.Provisional_Allotment_letter__c = true;
        
        opp.Received_the_Address_Proof_Copy__c      = true;
        opp.Received_the_PAN_Card_Copy__c           = true;
        opp.Received_the_Passport_Copy_for_NRI__c   = true;
        opp.Booking_Form_Duly_filled_completely__c  = true;
        opp.Booking_CSAT_Feed_back_form__c          = true;
        opp.Active__c                               = true;
        opp.Handover_Feed_back_form__c              = true;
        insert opp;
        
        Project__c proj = new Project__c();
        proj.Name       = 'Brigade Altamont';
        insert proj;
       
      CostSheet__c  cItem       = new CostSheet__c();
      cItem.Plant__c            = objPlant.id;
      cItem.Opportunity__c      = opp.Id;
      cItem.Project__c          = proj.id;
      insert cItem;
        Cost_Sheet_Controller cntrlr = new Cost_Sheet_Controller();
    }
    catch(Exception e)
    {
      system.debug('Exception ' + e);  
    }
    }
}