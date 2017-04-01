public class CommissionPDF{
public static String oppId{get;set;} 

  public static  ApplicationFormController afc{get;set;}
   public CommissionPDF(ApexPages.StandardController controller) {
    oppId = ApexPages.currentPage().getParameters().get('Id');

          afc = new ApplicationFormController();
        afc.contacts = New List<Contact>();
        Opportunity opport1=[SELECT AccountId,Sales_Person_1__r.Name,Offer_Selected__r.Name,Referred_by_Name2__r.Name,Plant2__r.Project_Head__r.Name,Referrer_is_a__c,Sale_Order_Date__c,For_ROI__c,Referred_by_Name2__r.MobilePhone,Commission_Rate__c,Sale_agreement_done__c,Agreement_Date__c,Reffered_Agent__c,Bill_Value__c,of_Amount_Received__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Terrace_Area__c,Unit__r.Name,  Lead_Source__c, Offer_Code__c,Date_of_Site_Visit__c FROM Opportunity where Id=:oppId Limit 1];
        System.debug(opport1);
        afc.opport=opport1;
        afc.projectName = opport1.Plant2__r.ProjectLookup__r.Name;
        afc.plantName   = opport1.Plant2__r.Name;
        try{
            Channel_Partner__c c=[Select Id,Mobile__c,Channel_Partner_Registered_With_Brigade__c,Vendor_Number__c from Channel_Partner__c where Name=:opport1.Reffered_Agent__c];
            afc.refferedByPhone=c.Mobile__c;
            afc.Channel_Partner_Registered_With_Brigade=  c.Channel_Partner_Registered_With_Brigade__c;
            afc.Vendor_Number= c.Vendor_Number__c;
        }catch(Exception c){

        }
        if(opport1.Referred_by_Name2__r.MobilePhone != null ||  opport1.Referred_by_Name2__r.MobilePhone == '')
        afc.refferedByPhone=opport1.Referred_by_Name2__r.MobilePhone;


        afc.preparedBySalesperson=opport1.Sales_Person_1__r.Name;
        afc.projectHeadName=opport1.Plant2__r.Project_Head__r.Name;
        
        
        if(opport1.Lead_Source__c== 'Agents')
         afc.isAgent= true;
        else
        afc.isAgent= false;
        
        //===============================code for Contact record======================================
        List<OpportunityContactRole> ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId=:oppId order by createddate];
        Set<Id> contactids = new set<id>();
        if(ConId.size() > 0){
        for(OpportunityContactRole opp : ConId) {
         contactids.add(opp.ContactId);
        }
        }
        List<Contact> con=[SELECT Id,AccountId,Name,District__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Designation__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName,Salutation,Middle_Name__c,Relation__c,Industry__c,Profession__c,Residency_Status__c,Nationality__c,Passport_No__c,Spouse_s_Name__c FROM Contact where Id In:contactids LIMIT 1];
        //=========================================================================
        
        afc.SFDCOfferCode= opport1.Offer_Selected__r.Name;
        
        List<Commission__c> lstComm = [SELECT Employee_Id__c,Status__c,Sercive_Tax_Applicable__c,Project_Head_Comment__c,Hod_Comment__c,Approved_By_HOD__c,Approved_By_HOD_DateTime__c,Approved_By_Project_head__c,Approved_By_Project_head_DateTime__c,Service_Tax__c,Agreement_Value__c,Country__c,Existing_Customer_Unit_Id__c,Total_Amount_Payble__c,Commission_percentage__c,Currency__c FROM Commission__c where Opportunity__c= :oppId LIMIT 1];
        system.debug('commission size:' + lstComm.size());
        Commission__c comm;
        if(lstComm.size() > 0)
        {
        comm= new Commission__c();
        comm= lstComm[0];
        }
        else 
        comm = new Commission__c();
        
        afc.TotalPayableAmount= String.ValueOf( comm.Total_Amount_Payble__c);
        afc.ServiceTaxApplicable= comm.Sercive_Tax_Applicable__c;
        afc.ServiceTax= String.ValueOf(comm.Service_Tax__c);
        afc.ReferralCommission= String.ValueOf(opport1.Commission_Rate__c);
        if(comm.Agreement_Value__c  != null && opport1.Commission_Rate__c != null)
        afc.AmountPayableonAggrement=String.ValueOf((comm.Agreement_Value__c * opport1.Commission_Rate__c)/100);
        afc.CurrencyName= comm.Currency__c;
        afc.ReferrerTaxResidence= comm.Country__c;
        afc.EmployeeId= comm.Employee_Id__c;
        afc.ExistingCustomerUnitID= comm.Existing_Customer_Unit_Id__c;
        
        afc.Approved_By_HOD= comm.Approved_By_HOD__c;
        afc.Approved_By_HOD_DateTime= comm.Approved_By_HOD_DateTime__c;
        afc.Approved_By_Project_head= comm.Approved_By_Project_head__c;
        afc.Approved_By_Project_head_DateTime= comm.Approved_By_Project_head_DateTime__c;
        afc.Project_Head_Comment= comm.Project_Head_Comment__c;
        afc.Hod_Comment= comm.Hod_Comment__c;
        afc.Status= comm.Status__c;
        afc.FirstApplicantName=con[0].Salutation +' '+con[0].FirstName+' '+con[0].LastName;
     
     
    }
    
    
    


}