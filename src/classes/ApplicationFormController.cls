public  with sharing class ApplicationFormController   {
	public Map<String, List<String>> SubCategoreyToCategorey {get;set;}
public List<Contact> contacts{get;set;}
public List<Project_Docs__c> documents{get;set;}
public Decimal serviceTaxFromProject{get;set;}
public Decimal carParkValue{get;set;}
public Opportunity opport{get;set;}
public Account Acc{get;set;}
public Application_Form__c AppForm{get;set;}
public UtilityClassForCommissionForm util{get;set;}
public Channel_Partner__c chp{get;set;}
public Commission__c com{get;set;}
public Id OpportunityId{get;set;}
public Plant__c plant {get;set;}
public List<String> projList{get;set;}
public Unit__c unit {get;set;}
public List<String> DateFields{get;set;}
public List<String> OppDateFields{get;set;}
public List<String> Salutations{get;set;}
public List<String> AllOfferCodes{get;set;}
public Map<String, List<String>> plantsToProject {get;set;}
public Map<String, List<String>> unitsToPlant {get;set;}
public String isprojectHeadExist {get;set;}
public String projectName {get;set;}
public String plantName {get;set;}
public Boolean isOtpGenrated {get;set;}
public String unitName {get;set;}
public String floorDescription {get;set;}
public String refferedByPhone {get;set;}
public String preparedBySalesperson {get;set;}
public String OfferCode {get;set;}
public String projectHeadName {get;set;}
public String ChannelPartner {get;set;}
public Date RefferdBySalesOrderDate {get;set;}
public String RefferedBy {get;set;}

public string SFDCOfferCode{get;set;}
public string TotalPayableAmount{get;set;}
public Boolean ServiceTaxApplicable{get;set;}
public string ServiceTax{get;set;}
public string AmountPayableonAggrement{get;set;}
public string ReferralCommission{get;set;}
public string CurrencyName{get;set;}
public string ReferrerTaxResidence{get;set;}
public string EmployeeId{get;set;}
public string ExistingCustomerUnitID{get;set;}
public string SiteVisitDate{get;set;}
public string FirstApplicantName{get;set;}  

public string Approved_By_HOD{get;set;}  
public DateTime  Approved_By_HOD_DateTime{get;set;}  
public string Approved_By_Project_head{get;set;}  
public DateTime Approved_By_Project_head_DateTime{get;set;}  
public string Project_Head_Comment {get;set;}  
public string Status{get;set;}
public string Hod_Comment{get;set;}  
public Boolean Channel_Partner_Registered_With_Brigade {get;set;}
public String Vendor_Number {get;set;}
public Contact genralPowerofAttorney{get;set;}

public boolean isAgent{get;set;} 

  
    public ApplicationFormController() {
    	SubCategoreyToCategorey = new Map<String, List<String>>();
        Salutations = new List<String>(); 
        AllOfferCodes = new List<String>();
        DateFields  =new List<String>();
        OppDateFields   =new List<String>();
    }
    
}