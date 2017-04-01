public without sharing class ComFormController {
    public static String oppId{get;set;} 
    public static String jsonstring{get;set;} 
    
    public static  ApplicationFormController afc{get;set;}
    public ComFormController(ApexPages.StandardController controller) {
        oppId = ApexPages.currentPage().getParameters().get('Id');
        afc = new ApplicationFormController();
        afc.contacts = New List<Contact>();
        afc.chp=new Channel_Partner__c();
        afc.com=new Commission__c();
        afc.util=new UtilityClassForCommissionForm();
        try{
            afc.com =[SELECT Employee_Id__c,Sercive_Tax_Applicable__c,Commission_percentage__c,Existing_Customer_Unit_Id__c,Country__c,Currency__c,Amount_Payble_on_Agreement_Value__c,Service_Tax__c,Total_Amount_Payble__c,Service_Tax_Value__c from Commission__c WHERE Opportunity__c= :oppId LIMIT 1];
        }catch(Exception e){
            
        }
        Opportunity opport1=[SELECT AccountId,Commission_Percentage__c,Commission_Rate__c,Offer_Selected__r.Name,Offer_Code_for_Commission__c,Sales_Person_1__r.Name,Offer_Code__c,Referred_by_Name2__r.Name,Plant2__r.Project_Head__r.Name,Referrer_is_a__c,Sale_Order_Date__c,For_ROI__c,Referred_by_Name2__r.MobilePhone,Sale_agreement_done__c,Agreement_Date__c,Reffered_Agent__c,Bill_Value__c,of_Amount_Received__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.ProjectLookup__r.Service_Tax__c,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Terrace_Area__c,Unit__r.Name,  Lead_Source__c FROM Opportunity where Id=:oppId Limit 1];
        afc.OfferCode= (opport1.Offer_Selected__r.Name != null) ? opport1.Offer_Selected__r.Name:'';
        System.debug('offer Code' +opport1.Offer_Selected__r.Name);
        try{
            afc.chp =[SELECT Channel_Partner_Registered_With_Brigade__c,Registration_Number__c,Vendor_Number__c from Channel_Partner__c WHERE Name=:opport1.Reffered_Agent__c Limit 1];
        }catch(Exception e){

        }System.debug('AAaaaa'+opport1.Sales_Person_1__r.Name); 
        afc.opport=opport1;
        afc.projectName = opport1.Plant2__r.ProjectLookup__r.Name;
        afc.serviceTaxFromProject = opport1.Plant2__r.ProjectLookup__r.Service_Tax__c;
        afc.plantName   = opport1.Plant2__r.Name;
        try{
            Channel_Partner__c c=[Select Id,Mobile__c from Channel_Partner__c where Name=:opport1.Reffered_Agent__c];
            afc.refferedByPhone=c.Mobile__c;
        }catch(Exception c){

        }
        if(opport1.Referred_by_Name2__r.MobilePhone != null ||  opport1.Referred_by_Name2__r.MobilePhone == '')
        afc.refferedByPhone=opport1.Referred_by_Name2__r.MobilePhone;


        afc.preparedBySalesperson=opport1.Sales_Person_1__r.Name;
        afc.projectHeadName=opport1.Plant2__r.Project_Head__r.Name;
        Id contactId;
        System.debug('Reffered By'+opport1.Referred_by_Name2__r.Name ); 
        if(opport1.Referred_by_Name2__r.Name != null || opport1.Referred_by_Name2__r.Name != ''){
            //contactId=[SELECT Id from contact where name=:opport1.Referred_by_Name2__r.Name Limit 1].Id;
        }
        
        //================================================================================================================
           //================================================================================================================
        List<String> SalutationTypes = new List<String>();
        for(Schema.PicklistEntry pe : Contact.getSObjectType().getDescribe().fields.getMap().get('Salutation').getDescribe().getPickListValues()) {
            SalutationTypes.add(pe.getValue());
        }
        
        afc.Salutations.addAll(SalutationTypes);
        //================================================================================================================
        list<project__c> prr = [select name, (select name from Plants__r) from project__c] ;
        afc.plantsToProject = new Map<String, List<String>>();
        for(Project__c pr : prr) {
            for(Plant__c plantObj : pr.Plants__r){
                if(afc.plantsToProject.containsKey(pr.name)) {
                afc.plantsToProject.get(pr.name).add(plantObj.Name);
                } else {
                afc.plantsToProject.put(pr.name, new List<String> { plantObj.Name });
            }
           
            }
        }
        //================================================================================================================
        List<OpportunityContactRole> ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId=:oppId order by createddate];
        Set<Id> contactids = new set<id>();
        if(ConId.size() > 0){
        for(OpportunityContactRole opp : ConId) {
         contactids.add(opp.ContactId);
        }
        }
        List<Contact> con=[SELECT Id,AccountId,Name,District__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Designation__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName,Salutation,Middle_Name__c,Relation__c,Industry__c,Profession__c,Residency_Status__c,Nationality__c,Passport_No__c,Spouse_s_Name__c FROM Contact where Id In:contactids LIMIT 1];
        afc.contacts.addAll(con);
        if(contactId != null){
          Opportunity some=[SELECT ID, Name ,Sale_Order_Date__c FROM Opportunity WHERE Id IN (SELECT OpportunityId FROM OpportunityContactRole WHERE ContactId =:contactId) Order by CreatedDate DESC Limit 1];
        System.debug('@@@@'+some.Sale_Order_Date__c);
        afc.RefferdBySalesOrderDate=some.Sale_Order_Date__c;  
        }
        
        //================================================================================================================
        
        List<String> OfferCodes = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Offer_Code__c').getDescribe().getPickListValues()) {
            OfferCodes.add(pe.getValue());
        }
        afc.AllOfferCodes.addAll(OfferCodes);
        
        //========================================================================================================================
        jsonstring=JSON.serialize(afc);
        
        
    }
    public ComFormController() {
        
    }
    public static Date calculateDate(string aDate){
        string[] newDate;
        string[] tempstrtdate;
        tempstrtdate =aDate.split('T');
        newDate=tempstrtdate[0].split('-'); 
        Date valueDate = Date.newInstance(Integer.valueOf(newDate[0]),Integer.valueOf(newDate[1]),Integer.valueOf(newDate[2]));
        return valueDate ;
    }
    @RemoteAction
    public static string saveCommisions(String oppIdd,UtilityClassForCommissionForm util,Boolean flag){ 
        System.debug('@@@@@@@@@' +util);
        List<Commission__c> lstCommission= new List<Commission__c>();
        Commission__c c;
        Channel_Partner__c chPartner;
        Opportunity oppRec=[Select Id,Channel_Partner__c,Offer_Code__c from Opportunity where Id=:oppIdd];
        try{
           chPartner = [Select Id,Channel_Partner_Registered_With_Brigade__c,Registration_Number__c,Vendor_Number__c from Channel_Partner__c where Id=:oppRec.Channel_Partner__c];
 
        }catch(Exception e){
           
        }

        //=======================================Query for con name===================================================
         List<OpportunityContactRole> ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId=:oppIdd order by createddate];
        Set<Id> contactids = new set<id>();
        if(ConId.size() > 0){
        for(OpportunityContactRole opp : ConId) {
         contactids.add(opp.ContactId);
        }
        }
        List<Contact> con=[SELECT Id,AccountId,Name,District__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Designation__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName,Salutation,Middle_Name__c,Relation__c,Industry__c,Profession__c,Residency_Status__c,Nationality__c,Passport_No__c,Spouse_s_Name__c FROM Contact where Id In:contactids LIMIT 1];
        

        //============================================================================================================
        
       
            lstCommission=[Select Id,Commission_percentage__c,Service_Tax__c,Total_Amount_Payble__c,Amount_Payble_on_Agreement_Value__c,Country__c,Currency__c,Existing_Customer_Unit_Id__c,Employee_Id__c from Commission__c where Opportunity__c=:oppIdd LIMIT 1];
        if(lstCommission.size() > 0)
        c= lstCommission[0];
        else
        c= new Commission__c();

       
       
        chPartner =(chPartner == null) ? new Channel_Partner__c() :chPartner;
        c.Contact_Name__c                                 = con[0].Name;
        c.Opportunity__c                                  = oppIdd;
        c.Employee_Id__c                                  = util.EmployeeId;
        c.Existing_Customer_Unit_Id__c                    = util.ExistingCustomerUnitId;
        c.Currency__c                                     = util.BrokerageCurrency;
        c.Country__c                                      = util.BrokerageCountry;

        c.Amount_Payble_on_Agreement_Value__c             = (util.AmountPaybleOnAgreementValue != '' && util.AmountPaybleOnAgreementValue != null) ? Decimal.valueOf(util.AmountPaybleOnAgreementValue) :0 ;
        c.Total_Amount_Payble__c                          = (util.TotalPaybleAmount != '' && util.TotalPaybleAmount != null) ? Decimal.valueOf(util.TotalPaybleAmount) :0 ;
        c.Service_Tax__c                                  = (util.ServiceTax != '' && util.ServiceTax != null) ? Decimal.valueOf(util.ServiceTax) : 0;
        c.Commission_percentage__c                        = (util.BrokerageCommisionpayble != '' && util.BrokerageCommisionpayble != null) ? Decimal.valueOf(util.BrokerageCommisionpayble) : 0;
        

        chPartner.Channel_Partner_Registered_With_Brigade__c = Boolean.valueOf(util.ChannelPartnerRegistered);//true/false
        chPartner.Registration_Number__c                  = util.RegistrationNumber;
        chPartner.Vendor_Number__c                        = util.VendorNumber;

        oppRec.Offer_Code_for_Commission__c                              = util.SfdcOfferCode;


        System.debug('@@@@'+c+'####'+oppRec+'$$$$$'+chPartner);

        Id projectHeadId;
        Opportunity opport=[SELECT AccountId,Plant2__r.Project_Head__c from Opportunity where Id=:oppIdd LIMIT 1]; 
        
        projectHeadId=opport.Plant2__r.Project_Head__c;
        System.debug('projectHead' +projectHeadId);
        System.debug('cid1' +c.Id);
        if(c.Id != null)
        update c;
        else{   System.debug('@@@@ Inser inside else '+c);
                insert c;
        }
        System.debug('cid2' +c.Id);
        if(flag==true){
                c.Status__c='Submitted';
                update c;
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                System.debug('GGGGGGGGGGGG1');
                req1.setComments('Submitting request for approval1...');
                req1.setObjectId(c.id);
                
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                req1.setNextApproverIds(new Id[] {projectHeadId});
                Approval.ProcessResult result1 = Approval.process(req1);
                ComFormController.savePdf(oppIdd);
        }else{
            update c;
               }

        System.debug('cid2222'+oppRec);
        update oppRec;

        if(chPartner.Id != null)
        update chPartner;
        else{
            insert chPartner;
        }

return 'sucess'+flag;
}
@RemoteAction
public static void savePdf(String oppIdd){
    
         PageReference pdfPage = Page.CommissionFormPdf; //create a page reference to our pdfDemo Visualforce page, which was created from the post http://www.interactiveties.com/blog/2015/render-visualforce-pdf.php
         pdfPage.getParameters().put('id',oppIdd);
        //Blob pdfBlob = pdfPage.getContent(); //get the output of the page, as displayed to a user in a browser
        Blob pdfBlob;
        pdfBlob= Blob.valueOf('TestData');
        if (!Test.IsRunningTest())
                     {
                          pdfBlob = pdfPage.getContent();
                           
                     }else{
                        
                     }
        
        Attachment attach = new Attachment(ParentId = oppIdd, Name = 'CommisionPdf.pdf', body = pdfBlob,ContentType='application/pdf'); //create the attachment object
        
        insert attach; 


}
}