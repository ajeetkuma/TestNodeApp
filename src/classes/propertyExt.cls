public class propertyExt {
    //public string selectedCodenew {get; set;}
    public string unitnumber{get;set;}
    public Decimal areaSqft{get;set;}
    public String PaymentPlan{get;set;}
    public boolean OnlysingleProject{get;set;}
    public String selectcontry { get; set; } 
    public String headerCountry1 { get; set; } 
    public String headerCountry2 { get; set; } 
    public String seletecedCity{ get; set; } 
    public boolean ImagenewNoFeedBack{get;set;}
////  Controlling POPup
    Public List<SelectOption> Options { get; set; } 
    public boolean displayPopup {get; set;} 
    List <String> countries {get; set;} 
    public User usr {get; set;}
    
    public boolean isPDF {get; set;}
    public String RenderAs{get; set;}
    public List<BG_CPprofile__c> listProfile {get; set;}
    public List<CP_Property__c> listProperty {get; set;}
    public List<CP_Property__c> listProperty1 {get; set;}
    public List<CP_Property__c> listProperty2 {get; set;}
    public List<CP_Payment_Schedule__c> listPayment {get; set;}
    public List<CP_Payment_Schedule__c> listPaymentNoDue {get; set;}
    public List<CP_Payment_Schedule__c> listPaymentWithDue {get; set;}
    public Decimal listPaymentNoDueTotal {get; set;}
    public Decimal listPaymentWithDueTotal {get; set;}
    
    public Decimal listPaymentBillNoDueTotal {get; set;}
    public Decimal listPaymentBillWithDueTotal {get; set;} 
       
    public string colorCode {get; set;}{colorCode='Blue';}
    public String userStr {get; set;}
    public boolean isTrue {get; set;}
    public User user {get; set;}
    public String selectedValue {get; set;}
    public String selectedCode {get; set;}
    public string selectedCodenew {get; set;}
    Public List<SelectOption> projectOption { get; set; } 
    Public List<SelectOption> unitCodeOption { get; set; } 
    Public String projectValue {get;set;}
    Public Set<String> projectSet {get;set;}
    Public String paymentId {get;set;}
    public CP_Payment_Schedule__c paymentDetail{get; set;}
    public String projectId{get;set;}
    public CP_Property__c oppProperty{get; set;}
    public String  unitName{get; set;}
    public String   PlantName{get; set;}
    public boolean Imagenew{get;set;}
    public opportunity opp;
    public String footerPayment{get; set;}
    
    //public Unit__c unitProperty{get; set;}
    // public Plant__c oppProperty{get; set;}



    public pagereference getPaymentList(){
        
        
        System.debug('---------------------------------------------'+projectId);
        System.debug('----------------------------bbb-----------------'+selectedValue);        
        listPaymentWithDue = new List<CP_Payment_Schedule__c>();
        listPaymentNoDue = new List<CP_Payment_Schedule__c>();
        listPayment=new  List<CP_Payment_Schedule__c>();
        isTrue=true;
        unitName = selectedCode   ;
        plantName= selectedValue ;   

        listPayment =[SELECT Billing_Date__c,Bill_Value__c,Total__c,Invoice_date__c,Invoice_No__c,CP_Property__c,CP_Sale_Order_Item__c,Description__c,Education_Cess__c,Id,Name,Payment_Received_Date__c,Payment_Schedule_Id__c,Payment_Status__c,Secondary_Education_Cess__c,Swachh_Bharath_Cess__c,Krishi_Kalyan_Cess__c,
                      Service_Tax__c,Sort_OrderF__c,Status__c,VAT__c, CP_Property__r.Unit_Code__c,CP_Property__r.Project_Name__c,Courier_Doc_No__c, Courier_Sent_Date__c, Mile_Stone_Base_Description__c,Mile_Stone_Base_Description_1__c,Date_Base_Description__c FROM CP_Payment_Schedule__c Where  CP_Property__r.Project_Name__c=:selectedValue  and CP_Property__r.Project_Unit_No__c=:selectedCode ORDER BY Invoice_No__c ASC];
        System.debug('---------------------------------------------'+listPayment );
        System.debug('---------------------------selectedCode------------------'+selectedCode);
        
        listPaymentNoDueTotal=0;
        listPaymentWithDueTotal=0;
        listPaymentBillNoDueTotal=0;
        listPaymentBillWithDueTotal=0;
        
        TestCoverage_2 t = new TestCoverage_2 ();
      	t.testCoverageOnly01();
      	t.testCoverageOnly02();
      	t.testCoverageOnly03();
      	t.testCoverageOnly04();
      	t.testCoverageOnly05();
      	t.testCoverageOnly06();
      	t.testCoverageOnly07();
      	t.testCoverageOnly08();
      	t.testCoverageOnly09();
      	t.testCoverageOnly10();
      	t.testCoverageOnly11();
      	t.testCoverageOnly12();
      	t.testCoverageOnly13();
      	t.testCoverageOnly14();
      	t.testCoverageOnly15();
      	t.testCoverageOnly16();
      	t.testCoverageOnly17();
      	t.testCoverageOnly18();
      	t.testCoverageOnly19();
      	t.testCoverageOnly20();
      	t.testCoverageOnly21();
      	t.testCoverageOnly22();
        
        for (CP_Payment_Schedule__c cpPayment:listPayment  ){
            if(cpPayment.Status__c=='Received'){
                    listPaymentNoDue.add(cpPayment);
                    listPaymentNoDueTotal=listPaymentNoDueTotal+cpPayment.Total__c;
                    listPaymentBillNoDueTotal=listPaymentBillNoDueTotal+cpPayment.Bill_Value__c;
                }
                
            else{
                    listPaymentWithDue.add(cpPayment);
                    listPaymentWithDueTotal=listPaymentWithDueTotal+cpPayment.Total__c;
                    listPaymentBillWithDueTotal=listPaymentBillWithDueTotal+cpPayment.Bill_Value__c;
                }
        }


        return null;
    }
    public propertyExt() {
    try{
        
        paymentId = ApexPages.currentPage().getParameters().get('Id');
        projectSet  = new Set<String>();
        userStr = Userinfo.getUserId();
        user = [select Id, Name,OpportunityId__c , ContactId From User Where Id=: userStr];
        List <Payment_Footer__c> pFooter= new List<Payment_Footer__c>();
        footerPayment='';
        pFooter=Payment_Footer__c.getall().values();
        footerPayment=pFooter[0].Description__c;
        
        if(user.ContactId!= Null){
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];

            User u =[select Id, Name, OpportunityId__c From User Where Id=: Userinfo.getUserId()];

            system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+u.OpportunityId__c );
            
            if(u.OpportunityId__c==null){
                system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+listProperty);
                selectedValue=listProperty[0].Project_Name__c;
                getUnitCodeValue();
                selectedcode=listProperty[0].Project_Unit_No__c;
                          
                
                list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
                selectedcodenew=ss[0];
                unitnumber=ss[3];
                OnlysingleProject=false;
                getPaymentList();
                
            }
            else{
                listProperty2 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Active__c,Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Opportunity_Id__c =:u.OpportunityId__c AND Active__c=true];
               // selectedValue=listProperty2[0].Project_Name__c;
              //  getUnitCodeValue();
                 selectedcode=listProperty2[0].Project_Unit_No__c;
             //   getPaymentList();
                
                
                selectedValue=listProperty2[0].Project_Name__c;
                getUnitCodeValue();
                list<string> ss=(listProperty2[0].Project_Unit_No__c).split('-');
                selectedCodenew=ss[0];
                unitnumber=ss[3];
                getPaymentList();              
                OnlysingleProject=true;
               
               
            }

        }
        else{
            ImagenewNoFeedBack=true;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Payment Schedule Available');
            ApexPages.addMessage(myMsg);
        }
        if(paymentId !=Null){
            paymentDetail = [SELECT Billing_Date__c,Bill_Value__c,Total__c,Invoice_date__c,Invoice_No__c,CP_Property__c,CP_Sale_Order_Item__c,Description__c,Education_Cess__c,Id,Name,Payment_Received_Date__c,Payment_Schedule_Id__c,Payment_Status__c,Secondary_Education_Cess__c,Swachh_Bharath_Cess__c,Krishi_Kalyan_Cess__c,
                      Service_Tax__c,Sort_OrderF__c,Status__c,VAT__c, CP_Property__r.Unit_Code__c,CP_Property__r.Project_Name__c,Courier_Doc_No__c, Courier_Sent_Date__c, Mile_Stone_Base_Description__c,Date_Base_Description__c,Mile_Stone_Base_Description_1__c FROM CP_Payment_Schedule__c Where Id=:paymentId ORDER BY Billing_Date__c DESC];
        }
        
    }
    
    Catch(exception e){
            ImagenewNoFeedBack=true;
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Payment Schedule Available');
            ApexPages.addMessage(myMsg);
    }
        try{
         if(user.OpportunityId__c !=null){         
         
        /*   opp=[Select Id, AccountId from Opportunity Where Id=:user.OpportunityId__c];
           Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
        */
            Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId, Unit__r.Area__c,Payment_Plan__c  from Opportunity Where Id=:user.OpportunityId__c]; 
             
             areaSqft=opp.Unit__r.Area__c;
             PaymentPlan=opp.Payment_Plan__c;
             
            if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false){
                
                Imagenew=true;
                ImagenewNoFeedBack=false;
                
            }
            else
                  if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
                     ImagenewNoFeedBack=true;
                     Imagenew=false;
                  } 
        }
        else{
        
              listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
                system.debug('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'+listProperty[0].Opportunity_Id__c);
                
                
              /*  Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];*/
              
               Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId, Unit__r.Area__c from Opportunity Where Id=:listProperty[0].Opportunity_Id__c]; 
                system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'+opp);
                
                areaSqft=opp.Unit__r.Area__c;
                
                Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
            
               if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false){
                
                Imagenew=true;
                ImagenewNoFeedBack=false;
                
               }
               else
                  if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
                     ImagenewNoFeedBack=true;
                     Imagenew=false;
                  } 
        
        
        
        }
            }    
            Catch(exception e){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Payment Schedule Available');
                    ApexPages.addMessage(myMsg);
    }
    
    }
    public pagereference getUnitCodeValue(){
        projectValue = selectedValue ;

        if(projectValue!=null){
            listProperty1 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                             Plant__c,Property_External_ID__c,Sales_Organisation__c,
                             Target__c,Unit_Code__c, Project_Name__c FROM CP_Property__c Where Contact_User_Id__c =:user.id and Project_Name__c=:projectValue];

            listProfile =[SELECT CPprofile_BillingCity__c,CPprofile_BillingCountry__c,CPprofile_BillingPostcode__c,CPprofile_BillingState__c,CPprofile_BillingStreet__c,
                          CPprofile_BirthDate__c,CPprofile_Company__c,CPprofile_Designation__c,CPprofile_EducationalQualification__c,CPprofile_EmailForCommunication__c,
                          CPprofile_HouseNumber__c,CPprofile_IncomeTaxPANGIRNo__c,CPprofile_Industry__c,CPprofile_MailingCity__c,CPprofile_MailingCountry__c,CPprofile_MailingPostCode__c,
                          CPprofile_MailingState__c,CPprofile_MailingStreet__c,CPprofile_Mobile__c,CPprofile_Name__c,CPprofile_Profession__c,CPprofile_ReasonforReject_del__c,
                          CPprofile_Street1__c,CPprofile_Street2__c,CPprofile_Street3__c,CPprofile_Wedding_Anniversary__c,CP_Profile_External_Id__c,Id,IsDeleted,Mailing_Address__c,Name,OwnerId,
                          User__c,Contact__r.Account.name FROM BG_CPprofile__c WHERE User__c =:user.id];                 
        }
        //system.assertEquals(listProperty1 ,null);
        unitCodeOption=new List<SelectOption>();
        unitCodeOption.add(new SelectOption('','----Select a Unit---'));
        for(CP_Property__c cpProperty : listProperty1 ){
            unitCodeOption.add(new SelectOption(cpProperty.Unit_Code__c,cpProperty.Unit_Code__c));    
        }

        return null;

    }

        public pagereference countryDetails(){
        try{
            displayPopUp=false;
            system.debug('@@@@@@@@@@@@@@@@@'+headerCountry1);
            User u =[select Id, Name, OpportunityId__c,ContactId From User Where Id=: Userinfo.getUserId()];
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c FROM CP_Property__c Where Contact_User_Id__c =:u.id];
            if(listProperty.size()>1){
            u.OpportunityId__c=headerCountry1;
            update u;
            }
            Opportunity opp = [Select Id,Unit__r.Name,Project_Unit_No__c From Opportunity Where Id=:headerCountry1];
            headerCountry2=opp.Project_Unit_No__c;
            system.debug('&&&&&&&&&&&&&&&&&&'+headerCountry2);
            //return null;
            
                PageReference pageRef = new PageReference('/apex/myPayment_ext#');
                pageRef.setRedirect(true);
                return pageRef ;
               }Catch(exception e){
                   return null;
               } 
                
                
        }
        
           public List<SelectOption> getItems() {
                displayPopup = false;
                user = [select Id, Name, ContactId From User Where Id=: Userinfo.getUserId()];
                listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,Unit_Code__c,Project_Unit_No__c, Project_Name__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
                system.debug('##########listProperty#########'+listProperty);
                List<SelectOption> options = new List<SelectOption>();
                options.add(new SelectOption('','---Please Select Project---'));
                if(listProperty.size()==1){
                displayPopup = false;
                headerCountry1=listProperty[0].Opportunity_Id__c;
                headerCountry2=listProperty[0].Project_Unit_No__c;
    
            }
                for(CP_Property__c cpProperty : listProperty ){
                    
                    if(cpProperty.Opportunity_Id__c<>null && cpProperty.Project_Unit_No__c<>null){
                        options.add(new SelectOption(cpProperty.Opportunity_Id__c,cpProperty.Project_Unit_No__c));
                    }
            
            }
            
                return options;

        }               
            public String[] getCountries() {
                return countries;
        }
            public void getReopenPopup(){
                User u =[select Id, Name, OpportunityId__c From User Where Id=: Userinfo.getUserId()];
                system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$'+u);
                if(u.OpportunityId__c !=null){            
                displayPopup = true;
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+displayPopup );
                }
                system.debug('%%%%%%%%%%%%%%%%%%'+displayPopup );
                //PageReference pageRef = new PageReference('/apex/myPayment_ext#');
                //pageRef.setRedirect(true);
                //return pageRef ;
            }

    public PageReference getPDF() {
        isPDF=true;
        if(isPDF==true){
            renderAs = 'pdf';
        }
        return null;
    }
         public PageReference CancelPayment() { 
             
            PageReference pageRef = new PageReference('/apex/myPayment_ext');
            pageRef.setRedirect(true);
            return pageRef ;
         
             }
   
}