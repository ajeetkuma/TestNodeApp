@istest
public class Utility_TestClass {
    
    public static Account accRec = createAccount();
    public static Contact conRec =createContact();
    public static Plant__c planrec=createPlant();
    public static Unit__c unirec=createUnit();
    public static  Opportunity opprec=createOpportunity();
    public static OpportunityContactRole oppr=oppcontrole();  
    
    public static Account createAccount(){
        
        Country__c cnt = new Country__c();
        cnt.Name = 'IN - India';
        cnt.Code__c = 'IN';
        insert cnt;
        
        Account acc=new Account();
        acc.name='TestAccount1';
        acc.Street1__c='WTC Bangalore Updated';
        acc.postal_code__c='560055';
        //acc.CountryL__r.Code__c = cnt.Code__c;
        acc.countryl__c = cnt.Id;
        acc.customer_group__c='Z1- Individual';
        acc.distribution_channel__c='10- Residential Sale';
        
        insert acc;
        return acc;
        
    }
    
     public static Contact createContact(){
      
        double i = math.random();
        Contact conn=new Contact(AccountId = accRec.Id,Birthdate=system.Date.today(),LastName='Test contact'+i,Company__c='ETmarlabs',Designation__c='Devloper',Industry__c='IT',Profession__c='sales',Income_Tax_PAN_GIR_No__c='abcxyz',MobilePhone='9916819953',Email='sanjuna@extentor.com',SMS_Text__c ='text',LeadSource='EDM');
        insert conn;
        return conn;
    }
    
    public static Plant__c  createPlant(){
        Plant__c pla=new Plant__c();
        pla.Admin_Email__c='Testemail@gmail.com';
        pla.Project__c='test project';
        insert pla;
        return pla;
    }
    public static Unit__c createUnit(){
   
        Unit__c uni=new Unit__c();
        uni.Name='Test unit';
        uni.Plant__c=planrec.Id;
        uni.Area__c=50;
        insert uni;
        return uni;
    }
    public static Opportunity createOpportunity(){
     
        Opportunity  opp=new Opportunity();
        opp.AccountId =  accRec.Id;
        opp.Name='Test opportunity';
        opp.CloseDate=system.Date.today().addDays(1);
        opp.Plant2__c=planrec.Id;
        opp.Unit__c=unirec.Id;
        opp.Recon_Account__c = '0023000010- Debtors - Domestic';
        opp.Plant__c = '7GAR - 7 Gardens';
        opp.Cash_Management_Group__c = 'E1- Customer Sales Domestic';
        opp.StageName='Allotment';
        opp.E_Khatha_Received__c =true;
        
        opp.Photographs_Received__c=true;
        opp.Received_the_Address_Proof_Copy__c=true;
        opp.Received_the_PAN_Card_Copy__c=true;
        opp.Received_the_Passport_Copy_for_NRI__c=true;
        
        opp.Date_of_Enquiry__c              = system.now();
        
        opp.Date_of_Site_Visit__c           = system.now();
        opp.Company_Code__c                 = '1000';
        opp.Type                            = '100 - Residential Sales';
        opp.LeadSource                      = 'Agent';
        opp.Sales_office__c                 = '1010- HO Sales Office';
        opp.Customer_pricing_procedure__c   = '1- Flats Under Constr';
        
        
        opp.ZTX1__c                         = '1- Res - Full VAT';
        opp.ZTX2__c                         = '1- Residential ST';
        opp.ZTX3__c                         = '1- Residential ECS';
        opp.ZTX4__c                         = '1- Residential HES';
        opp.Partner_Functions__c            = 'ZC- Customer Relations';
        opp.Payment_Received_Total__c       = 10000;
       
        opp.Provisional_Allotment_letter__c = true;
        
        opp.Booking_Form_Duly_filled_completely__c  = true;
        opp.Booking_CSAT_Feed_back_form__c          = true;
        opp.Active__c                               = true;
        opp.Handover_Feed_back_form__c              = true;
        
        opp.match_field_validation__c = true;

        insert opp;
        
        return opp;
        
    }
    public static OpportunityContactRole oppcontrole(){

        OpportunityContactRole ocr=new  OpportunityContactRole();
        ocr.contactid=conRec.id;
        ocr.opportunityid=opprec.id;
        
        insert ocr;
        
        return ocr;
  
    }
    
    public static void createSMSTemplate(string templateName,string objectName){
        smagicinteract__SMS_Template__c SMSTemplate = new smagicinteract__SMS_Template__c(smagicinteract__Name__c=templateName, smagicinteract__ObjectName__c = objectName,smagicinteract__Text__c='XYZ');
        insert SMSTemplate ;
    }
}