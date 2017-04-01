public class FeedbackCon {

    //public list<user> usr{get;set;}
    public string selectedCodenew {get; set;}
    public string unitnumber{get;set;}
    public boolean OnlysingleProject{get;set;}
    public User usr{get;set;}
    public List<CP_Property__c> listProperty {get; set;}
    public boolean ImagenewNoFeedBack{get;set;}
    public boolean pendingfeedback{get;set;}
    public List<CP_Property__c> listProperty2 {get; set;}
    public boolean Imagenew{get;set;}
    public contact con{get;set;}
    public boolean a {get; set;}
    public boolean b {get; set;}
    public boolean ca {get; set;}
    public boolean d {get; set;}
    public boolean e {get; set;}
    public boolean f {get; set;}
    public String selectedValue {get; set;}
    public String selectedCode {get; set;}    
    public String selectcontry { get; set; } 
    public String headerCountry1 { get; set; } 
    public String headerCountry2 { get; set; } 
    public String seletecedCity{ get; set; } 
////  Controlling POPup
    Public List<SelectOption> Options { get; set; } 
    public boolean displayPopup {get; set;} 
    List <String> countries {get; set;} 
    
    public boolean feedbackalldata{get;set;}
    public List<custom_feedback_form__c> CustFeedback{get;set;}
    public list<string> CustFeedbackstring{get;set;}
    public boolean thecustlink{get;set;}{thecustlink=false;}
    
    public String X1st_year_Handover_Feedback{get; set;}
    public String Booking_CSAT_Feedback_form{get; set;}
    public String Execution_Feedback1{get; set;}
    public String Execution_Feedback2{get; set;}
    public String Handover_Feedback_form{get; set;}
    public String CustomFeedbackName{get; set;}
    
    public String X1st_year_Handover_FeedbackURL{get; set;}
    public String Booking_CSAT_Feedback_formURL{get; set;}
    public String Execution_Feedback1URL{get; set;}
    public String Execution_Feedback2URL{get; set;}
    public String Handover_Feedback_formURL{get; set;}
    public String CustomFeedbackLink{get; set;}
    
    public String X1st_year_Handover_FeedbackDec{get; set;}
    public String Booking_CSAT_Feedback_formDec{get; set;}
    public String Execution_Feedback1Dec{get; set;}
    public String Execution_Feedback2Dec{get; set;}
    public String Handover_Feedback_formDec{get; set;}        
    
    public List<Standard_Feedback_Form__c> stdFeedback = new List<Standard_Feedback_Form__c>();
    
    public FeedbackCon (){
    
    try{
        
        feedbackalldata=false;
        
        stdFeedback = Standard_Feedback_Form__c.getall().values();
        usr=[select id,ContactId,Name,OpportunityId__c from User where id=:UserInfo.getUserId()];
        //CustFeedback=[SELECT id,name, Active__c,CSAT_form__c,Feedback_Form_Link__c,Project__c FROM custom_feedback_form__c limit 1]; 
        CustFeedback=custom_feedback_form__c.getall().values();

        
       // system.assertEquals(CustFeedbackstring,null);
        system.debug('usr info '+usr);
        listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id AND Active__c=true];
        system.debug('list of property'+listProperty);  
        if(usr.OpportunityId__c==null){
        
                
                selectedValue=listProperty[0].Project_Name__c;
                //getUnitCodeValue();
            
                selectedcode=listProperty[0].Project_Unit_No__c;
                //getPaymentList();  
                
                list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
                selectedCodenew=ss[0];
                unitnumber=ss[3];               

                
               
                
                
                 
                
                                          
                OnlysingleProject=false;        
            }
            else{
                listProperty2 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Active__c,Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Opportunity_Id__c =:usr.OpportunityId__c AND Active__c=true];
                system.debug('Project Name'+listProperty2[0].Project_Name__c);
                system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+listProperty2[0].Project_Unit_No__c);
                
                selectedValue=listProperty2[0].Project_Name__c;                 
                //getUnitCodeValue();
                
                selectedcode=listProperty2[0].Project_Unit_No__c;
                //getPaymentList();                
                
                list<string> ss=(listProperty2[0].Project_Unit_No__c).split('-');
                selectedCodenew=ss[0];
                unitnumber=ss[3];
                
                 /**if(CustFeedback[0].Active__c==true){
                 for(string cusfeed:CustFeedbackstring){
                 {                                  
                      if(cusfeed == selectedValue){
                                                  
                        thecustlink=true;                      
                      }
                  }
                }
               } **/
                                          
                OnlysingleProject=true;
                
                
            }
        if(CustFeedback.size()>0){
            if(CustFeedback[0].Project__c<>null){
                CustFeedbackstring=(CustFeedback[0].Project__c).split(';');
                CustomFeedbackLink=CustFeedback[0].Feedback_Form_Link__c;
                CustomFeedbackName=CustFeedback[0].name;
               if(CustFeedback[0].Active__c==true){
               
                 for(string cusfeed:CustFeedbackstring){
                 {                                  
                      if(cusfeed == selectedValue ){
                                                  
                        thecustlink=true;                      
                      }
                  }
                 }
                }                
            }
        }else{
            thecustlink=false;
        }
        
        if(usr.OpportunityId__c != Null){
         
            Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Unit__c,Booking_CSAT_Feed_back_form__c,Plant__c,Execution_with_Modification_Feed_back_fo__c,
                           Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId,Modification_Requested__c from Opportunity Where Id=:usr.OpportunityId__c];
            con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                       Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
           
          
        if(opp.Booking_CSAT_Feed_back_form__c==false){
            a=true;
            pendingfeedback=true;
            for(Standard_Feedback_Form__c st: stdFeedback ){
                if(st.Name=='Booking CSAT Feedback form'){
                    Booking_CSAT_Feedback_form = st.Name;
                    Booking_CSAT_Feedback_formDec = st.Description__c;
                    Booking_CSAT_Feedback_formURL =  st.Form_url__c;
                }
            }            
        }
        if(opp.Execution_with_Modification_Feed_back_fo__c==false && opp.Modification_Requested__c==True){
          //system.assertEquals(opp.Unit__c,null);
            b=true;
            pendingfeedback=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Execution with Modification'){
                    Execution_Feedback1 = st2.Name;
                    Execution_Feedback1Dec = st2.Description__c;
                    Execution_Feedback1URL = st2.Form_url__c;
                }               
            
            }            
            }
            
        
        if(opp.Execution_without_modification_Feed_back__c==false ){
            ca=true;
            pendingfeedback=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Execution without modification'){
                    Execution_Feedback2 = st2.Name;
                    Execution_Feedback2Dec = st2.Description__c;
                    Execution_Feedback2URL = st2.Form_url__c;
                }
            
            }           
            }
        
        if(opp.Handover_Feed_back_form__c==false){
            d=true;
            pendingfeedback=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Handover Feedback form'){
                    Handover_Feedback_form = st2.Name;
                    Handover_Feedback_formDec = st2.Description__c;
                    Handover_Feedback_formURL = st2.Form_url__c;
                }
            
            }            
            
        }
        if(opp.X1st_year_Handover_Feedback__c==false){
            e=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='1st year Handover Feedback'){
                    X1st_year_Handover_Feedback = st2.Name;
                    X1st_year_Handover_FeedbackDec = st2.Description__c;
                    X1st_year_Handover_FeedbackURL = st2.Form_url__c;
                }
            
            }              
        }
        if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            f=true;
            pendingfeedback=true;
           // Imagenew=true;
        } 
        
            if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false){
                
                Imagenew=true;
                ImagenewNoFeedBack=false;
               
            } 
            else{
                 if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
                     ImagenewNoFeedBack=true;
                     Imagenew=false;
                
                }
            
            
            }
                
        }
        else{
         //system.assertEquals(1,2);
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id AND Active__c=true];
                            
            Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Unit__c,Plant__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId,Modification_Requested__c from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
            
            con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                           Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];                
              
        if(opp.Booking_CSAT_Feed_back_form__c==false){
            
            a=true;
            for(Standard_Feedback_Form__c st: stdFeedback ){
                if(st.Name=='Booking CSAT Feedback form'){
                    Booking_CSAT_Feedback_form = st.Name;
                    Booking_CSAT_Feedback_formDec = st.Description__c;
                    Booking_CSAT_Feedback_formURL =  st.Form_url__c;
                }
            }           
        }
       //system.assertEquals(opp.Execution_with_Modification_Feed_back_fo__c,null);
        if(opp.Execution_with_Modification_Feed_back_fo__c==false && opp.Modification_Requested__c==True){
            b=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Execution with modification'){
                    Execution_Feedback1 = st2.Name;
                    Execution_Feedback1Dec = st2.Description__c;
                    Execution_Feedback1URL = st2.Form_url__c;
                }
            
            }           
        }
        if(opp.Execution_without_modification_Feed_back__c==false){
           ca=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Execution without modification'){
                    Execution_Feedback2 = st2.Name;
                    Execution_Feedback2Dec = st2.Description__c;
                    Execution_Feedback2URL = st2.Form_url__c;
                }
            
            }          
        }
        if(opp.Handover_Feed_back_form__c==false){
             
            d=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='Handover Feedback form'){
                    Handover_Feedback_form = st2.Name;
                    Handover_Feedback_formDec = st2.Description__c;
                    Handover_Feedback_formURL = st2.Form_url__c;
                }
            
            }           
        }
        if(opp.X1st_year_Handover_Feedback__c==false){
            
            e=true;
            for(Standard_Feedback_Form__c st2: stdFeedback ){
                if(st2.Name=='1st year Handover Feedback'){
                    X1st_year_Handover_Feedback = st2.Name;
                    X1st_year_Handover_FeedbackDec = st2.Description__c;
                    X1st_year_Handover_FeedbackURL = st2.Form_url__c;
                }
            
            }           
            
        }
        if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
            f=true;
            }
            if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false){
                
                Imagenew=true;
                ImagenewNoFeedBack=false;
            } 
            else{
               if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
                     ImagenewNoFeedBack=true;
                     Imagenew=false;
                
                }
                 
            }
            
            
            
            }
            
         }
      
     
     catch(Exception e) {
         String err = String.valueOf(e);
               ImagenewNoFeedBack=true;
         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No FeedBack Available');
         ApexPages.addMessage(myMsg);
         }
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
            PageReference pageRef = new PageReference('/apex/FeedBack');
            pageRef.setRedirect(true);
            return pageRef ;
            }catch(Exception e){
                return null;
            }
        }
        
                public List<SelectOption> getItems() {
                displayPopup = false;
                User user = [select Id, Name, ContactId From User Where Id=: Userinfo.getUserId()];
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
}