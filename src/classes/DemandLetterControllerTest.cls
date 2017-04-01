@istest
public class DemandLetterControllerTest {
    
    public static testmethod void test_updateTotalDueOnOpportunity(){
        opportunity opp = [select id from opportunity where name='LAF-A-0002' limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        DemandLetterController DemandLTR = new DemandLetterController(sc);
        //DemandLTR.oId = opp.Id;
        Pagereference pg = new 	system.PageReference('CreateDemandLetter');
        Test.setCurrentPage(pg);
        Apexpages.currentPage().getParameters().put('oppId',opp.Id);
        Test.startTest();
        DemandLTR.updateTotalDueOnOpportunity(); 
        Test.stopTest();
        
    }
    
    public static testmethod void test_updateTotalDueOnOpportunity1(){
        opportunity opp = [select id from opportunity where name='LAF-A-0002' limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        DemandLetterController DemandLTR = new DemandLetterController(sc);
        list<id> idList = new list<id>{opp.id};
        list<opportunity> op = new list<opportunity>{opp};
        DemandLTR.lstopp = op;        
        DemandLTR.lstId = idList;	 
        Test.startTest();
        DemandLTR.updateTotalDueOnOpportunity(); 
        DemandLTR.dummy();
        
        Test.stopTest();
        
    }
    
    
    @testSetup
    public static void testData(){
        Project__c proj = new Project__c();
        proj.Name       = 'Brigade Altamont';
        insert proj;
       
        
        Plant__c objPlant            = new Plant__c();
        objPlant.Name                       = 'KNPR - ALTAMONT';
        objPlant.Project__c                 = 'Brigade Altamont';
        objPlant.Plant_Code__c              = 'KNPR';
        objPlant.Company_Code__c            = '1000';
        objPlant.Sales_Organisation__c      = '1000';
        objPlant.Allowed_portal_access__c   = true;
        objPlant.ProjectLookup__c = proj.id;
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
        con.AccountId            = acc.Id;
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
        
       
          CostSheet__c  cItem       = new CostSheet__c();
          cItem.Plant__c            = objPlant.id;
          cItem.Opportunity__c      = opp.Id;
          cItem.Project__c          = proj.id;
          cItem.unit__c = unit.id;
          insert cItem;
        
          	Sale_Order_Item__c SOI=new Sale_Order_Item__c();
            SOI.Name= 'BG-SON-X-X-0102-XL';
            SOI.Basic_Cost__c=234000.00;
            SOI.Item_category__c='ZTAO';
            SOI.Material__c='BG-SON-X-X-0102-XL';
            SOI.Netvalue__c=23467.00;
            SOI.Opportunity__c=opp.Id;
            SOI.Order_Quantity__c=2;
            SOI.Tax__c=50;
            SOI.Unit_of_measure__c='M2';
            insert SOI;
        
        	Payment_Schedule__c PS = new Payment_Schedule__c();
            PS.name ='testPS';
            PS.Sale_Order_Item__c = SOI.id;
            PS.Opportunity__c = opp.Id;
            PS.Billing_Date__c = Date.newInstance(1960, 2, 17);
            PS.Payment_Status__c='A';
            PS.Bill_Value__c = 100;
            insert PS;
        
        
    }

}