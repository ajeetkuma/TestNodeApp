/*
Referralcon Class is written for the purrpose of Portal User
To refer anyone and send an email to the Admin  

*/

public class Referralcon {


    
    //variable Declaration
    //public static integer testDateValue;
    public string unitnumber{get;set;}
    public string selectedcodenew{get;set;}
    public list<Referral__c> referraldata{get;set;}
    public boolean ImagenewNoFeedBack{get;set;}   
    public Referral__c NewReferralInformation{get;set;}
    public boolean newsecreferral{get;set;}
    public integer total_size;
    public string soqlVar ;  
    public String selectPlant{ get; set; }
    Public List<SelectOption> projectOption { get; set; }
    public user usr{get;set;}
    public List<CP_Property__c> cpList {get;set;}
    public list<lead> DuplicateLead;
    public Plant__c plant{get;set;}
    public lead leaddatacreation;  
    public lead lead1;  
    public String refId{get; set;}
    Public Referral__c refDetail{get; set;}
    public boolean LeadSuccess {get;set;}
    public List<CP_Property__c> listProperty {get; set;}
    public List<CP_Property__c> listProperty2 {get; set;}
    public boolean errorMessage {get;set;}
    public String selectedCode {get; set;}
    public string flag{get;set;}     
    public string flag1{get;set;}
    public boolean Imagenew{get;set;}
    public BridageDynamicFields__c bc;
    public boolean displayPopUp{get; set;}{displayPopUp=FALSE;}
    
    public boolean ReferralDataallpage{get;set;}
    
    
    public Referralcon (){
        //Memory allocation 
        // testDateValue=0;
        bc=new BridageDynamicFields__c ();
        bc=[select Organisation_ID__c,Portal_Id__c,Email__c,URL__c from BridageDynamicFields__c limit 1];   
        
        
        try{
            if( Userinfo.getUserId()!=null){      
                flag = Apexpages.currentpage().getparameters().get('flagvalue');         
                if(flag =='true'){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'Thank you! New referral lead has been created.');
                    ApexPages.addMessage(myMsg);
                } 
                flag1 = Apexpages.currentpage().getparameters().get('flagvalue1');  
                if(flag1 =='true'){                
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'Thank you! New referral lead has been created.');
                    ApexPages.addMessage(myMsg);
                }
                
                
                
                cpList =new List<CP_Property__c>();   
                DuplicateLead=new list<lead>();
                NewReferralInformation=new Referral__c ();
                leaddatacreation=new lead ();
                lead1=new lead();          
                projectOption =new List<SelectOption>();
                
                //query for logged user   
                usr=[select Id, firstname,MobilePhone, lastname, name, contactId,OpportunityId__c,email From User Where Id=: Userinfo.getUserId()];
                 
                if(usr.OpportunityId__c==null){
                    //query related cp property records
                    listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                                    Plant__c,Property_External_ID__c,Sales_Organisation__c,
                                    Target__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id];
                    selectedcode=listProperty[0].Project_Unit_No__c;   
                    list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
                    selectedcodenew=ss[0];
                    unitnumber=ss[3];      
                               
                }
                else{
                    //qyery for cp property records based on selected project.
                    listProperty2 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                                     Plant__c,Property_External_ID__c,Sales_Organisation__c,
                                     Target__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Opportunity_Id__c =:usr.OpportunityId__c];                                
                    
                    selectedcode=listProperty2[0].Project_Unit_No__c;
                    
                    list<string> ss=(listProperty2[0].Project_Unit_No__c).split('-');
                    selectedcodenew=ss[0];
                    unitnumber=ss[3];
                    
                }
               
                refId = ApexPages.currentPage().getParameters().get('Id');
                
                if(refId!=Null){
                    refDetail=[select Name__c, OwnerId, Email__c,Mobile__c,Project_Information__c,Plant__c,Plant__r.Name,Status__c,Type_of_Apartment__c,Area__c,Budget__c,Location__c from Referral__c Where Id=:refId ];
                }
                
                //drop down list for projects       
                List<Plant__c> projects = [select id,Project__c,Available_Units__c from Plant__c Where Available_Units__c > 0];
                //cpList = [select id,Plant__c,Project_Name__c from CP_Property__c where Contact_User_Id__c=:usr.id ];
                set<String> pList = new Set<String>();
                for(Plant__c pl:projects){
                    pList.add(pl.Project__c);
                }
                projectOption.add(new SelectOption('','--------Select a Project--------'));
                for(String s : pList){
                    projectOption.add(new SelectOption(s,s));
                }
            }
            
           
            if(usr.OpportunityId__c != Null){
                
                  
                Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                                 Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:usr.OpportunityId__c];
                
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
                listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                                Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id AND Active__c=true];
               
                Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                                 Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
                
                /* Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
Contact con=new Contact();
con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
*/    
                
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
        catch(Exception e){
            ReferralDataallpage=true; 
            ImagenewNoFeedBack=true;                           
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No referrals available');
            ApexPages.addMessage(myMsg);   
        }         
    }        
    
    
    //List of existing referrals    
    public list<Referral__c> getreferraldataAll(){    
        return (List<Referral__c>)con.getRecords();
    }
    //Pagination logic 
    public ApexPages.StandardSetController con 
    {
        get{
            if(con == null){  
                con = new ApexPages.StandardSetController(Database.getQueryLocator([select Name__c, Project_Information__c,OwnerId, Email__c,Mobile__c,Plant__c,Plant__r.Name,Status__c,Type_of_Apartment__c,Area__c,Budget__c,Location__c, Unit_No__c, User_Cell__c, User_Email__c, User_Name__c, User_Project__c, Relation__c from Referral__c Where OwnerId =:UserInfo.getUserId()]));
                con.setPageSize(30);
            }
            return con;
        }
        set;
    }
    public void first() 
    {
        con.first();
    }
    public void previous() 
    {
        con.previous();
    }
    public void next() 
    {
        con.next();
    }
    //create new referral
    public PageReference CreateNewReferral() {
        newsecreferral=true;
        usr=[select Id, firstname, lastname,MobilePhone,name, contactId,OpportunityId__c,email From User Where Id=: Userinfo.getUserId()];
        System.debug('Debug1');
        return null;
    }
    //Save Referral Method
    public PageReference SaveReferral() {
        try{
            //Variables
            errorMessage = false;
            
          
            string name1=NewReferralInformation.Name__c;
            string email1=NewReferralInformation.Email__c; 
            string mobile1=NewReferralInformation.Mobile__c;
            System.debug('name1'+name1+'-------------email1--'+email1+'----mobile1----'+mobile1);
            if(NewReferralInformation.Email__c == null ){ 
                
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter email information'));
                 // return null;
            }
            
            if(NewReferralInformation.Name__c == null){
                
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter the name'));
                // return null;  
            }
            
            
            if(NewReferralInformation.Mobile__c == null ){
                
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Mobile Number '));
                 // return null;
            }
            if(mobile1.length()>10 || mobile1.length()<10){
                //errorMessage = true; 
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Mobile number should be 10 digits'));
                return null;
            }
            
            //page reference 
            PageReference pageRef;
            //referral process starts
            if(email1!=null && email1!='') {                    
                //Checking lead exists in brigade database 

                
                //Last activity date on lead object
                Date dt = (date.today()-90);            
                //Integer dt = (date.today()-90).day();  
                //system.assertEquals(dt,null);
                if(Test.isRunningTest() ){
                
                    // Date testDate=system.today().addDays(3);
                    // dt = (date.today()-10).day();
                    //dt = testDateValue;
                }
                //query to check duplicate leads            
                DuplicateLead=[SELECT id,email,MobilePhone,lastactivitydate,LastModifiedDate from lead where email=:email1 and MobilePhone=:mobile1];
                System.debug('---------------------------------------------------------DuplicateLead'+DuplicateLead);
                //system.assertEquals(DuplicateLead,null);
                //Found the referral in brigade lead database 
                if(DuplicateLead.size()>0){                 
                    //Checking the lead last modified date.
                    
                    for(lead le:DuplicateLead){  
                        
                      if((le.LastModifiedDate)> dt) { 
                         System.debug('-----------le------'+le);
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();                       
                            //  String[] toAddresses = new String[] {' sukesh3089@gmail.com'};
                            //System.debug('Email Id of sukesh---------'+bc.Email__c);
                            String[] toAddresses = new String[] {bc.Email__c};
                                string messageBody='<html><body>Dear Admin, &nbsp;<br/>'+'<br/>Duplicate Referral lead was created on portal<br/<br/>'+'<br/>Referred by : https://na13.salesforce.com/'+usr.id+'<br/><br/>Lead information:&nbsp; https://na13.salesforce.com/'+le.id+'<br/<br/>Thanks & Regards,'+'<br/>Portal Admin';
                            //   message.setTemplateId(emailtemp.Id);
                            //   message.setTargetObjectId(usr.Contactid);
                            //   message.setWhatId(NewReferralInformation.Id);
                            message.setSubject('Duplicate Referral Lead created on portal');
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                            try {
                                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'Regret! Lead already exists in our records')); 
                            }   
                            
                            catch(DMLException e){
                                errorMessage = true; 
                                
                            }                        
                        }
                        
                        else{
                            
                            //creating new referral                     
                            if(name1!=null&&name1!=''){                    
                                NewReferralInformation.Name__c=name1;
                            }                       
                            if(email1!=null&&email1!=''){                    
                                NewReferralInformation.Email__c=email1;            
                            }                
                            if(mobile1!=null&&mobile1!=''){                    
                                NewReferralInformation.Mobile__c=mobile1;
                            }
                            //if(description1!=null&&description1!=''){                    
                               // NewReferralInformation.Description__c=projectvalue1;      
                            //}
                            if(selectPlant!=null&&selectPlant!=''){  
                                //Plant=[SELECT id,name FROM Plant__c where Plant__c=:projectvalue1];
                                // NewReferralInformation.Plant__c=Plant.name;
                                
                                NewReferralInformation.Project_Information__c=selectPlant;   
                            }                   
                            NewReferralInformation.Status__c='Lead-Prospect';
                            //insert NewReferralInformation;                         
                            try {
                                NewReferralInformation.Lead__c=le.Id;
                                insert NewReferralInformation; 
                                 System.debug(usr.ContactId+'---------------------------------------Testing---------------------------------------'+NewReferralInformation.id);
                           
                                
                            }
                            catch(DMLException e){
                                errorMessage = true; 
                                
                                System.debug('---------c--------'+e);                           
                                String err = String.valueOf(e);
                                String errstring = 'The referral email or phone already exists in Brigade Group\'s records' ;
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,errstring  );
                                ApexPages.addMessage(myMsg);
                            } 
                            
                            //sending email to customer to say thanks for referring new lead 
                           if(usr.ContactId!=null && NewReferralInformation.Id!=null){
                                
                                //query for email template
                           
                                 
                                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();  
                                System.debug('--------usr.email---------'+usr.email);                      
                                String[] toAddresses = new String[] {usr.email};
                                    string messageBody='<html><body>Dear&nbsp;'+usr.name+'<br/>Thank you for referring your friend  to Brigade.We will update the referral status on the portal. <br/<br/>'+'<br/<br/>Thanks & Regards,'+'<br/>Portal Admin';
                              
                                message.setSubject('Brigade portal:Thank you for referring!');
                                message.setToAddresses(toAddresses);
                                message.setHtmlBody(messageBody);
                                message.saveAsActivity=false; 
                                
                                      
                                Messaging.SingleEmailMessage message2 = new Messaging.SingleEmailMessage();                       
                                // String[] toAddresses1 = new String[] {'salesenquiry@brigadegroup.com'};
                                String[] toAddresses1 = new String[] {bc.Email__c};
                                    string messageBody1='<html><body>Dear admin&nbsp;<br/>'+'<br/>New Referral lead has been submitted on portal.Please check information below.<br/'+'<br/>https://na13.salesforce.com/'+NewReferralInformation.Id+'<br/<br/>Thanks & Regards,'+'<br/>Portal Admin';
                               
                                message2 .setSubject('New Referral Lead created on portal!');
                                message2 .setToAddresses(toAddresses1);
                                message2 .setHtmlBody(messageBody1);
                                message2 .saveAsActivity=false; 
                                
                                
                                
                                try {
                                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });                        
                                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message2 });  
                                    
                                    
                                }                       
                                catch(Exception e) {
                                    String err = String.valueOf(e);
                                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                                    ApexPages.addMessage(myMsg);
                                }
                                               
                                pageRef = new PageReference('/apex/BrigadeReferralpage?flagvalue=true');
                                pageRef.setredirect(true);
                                return pageRef;
                            }  
                            
                        }
                    }
                    return pageRef;
                }
                else{
                    
                                     
                  
                    String name = NewReferralInformation.Name__c;
                    string userNameString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:userName');
                    string userMobileString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:userMobile');
                    string userEmailString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:userEmail');
                    string userProjectString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:userProject');
                    string userUnitString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:userUnit');
                    string RelationshipString=ApexPages.currentPage().getParameters().get('Page:Form:pblock:pbsction2:Relationship');
                   //new Lead & referral creation
                    if(name1!=null&&name1!=''){                    
                        NewReferralInformation.Name__c=name1;
                        leaddatacreation.LastName=name1;                    
                        leaddatacreation.Company=name1;
                        leaddatacreation.Referred_By_Name__c = usr.name;
                        leaddatacreation.Referred_By_Name2__c = usr.ContactId;
                    }                
                    if(email1!=null&&email1!=''){                    
                        NewReferralInformation.Email__c=email1;
                        leaddatacreation.email=email1;
                    }                
                    if(mobile1!=null&&mobile1!=''){                    
                        NewReferralInformation.Mobile__c=mobile1;
                        leaddatacreation.MobilePhone=mobile1;
                    }
                   
                    
                    if(userNameString!=null&&userNameString!=''){                    
                        NewReferralInformation.User_Name__c=userNameString;
                        leaddatacreation.User_Name__c=userNameString;
                    }     
                    if(userMobileString!=null&&userMobileString!=''){                    
                        NewReferralInformation.User_Cell__c =userMobileString;
                        leaddatacreation.User_Cell__c =userMobileString;
                    }
                    if(userEmailString!=null&&userEmailString!=''){                    
                        NewReferralInformation.User_Email__c =userEmailString;
                        leaddatacreation.User_Email__c =userEmailString;
                    }
                    if(userProjectString!=null && userProjectString!=''){                    
                        NewReferralInformation.User_Project__c =userProjectString;
                        leaddatacreation.User_Project__c =userProjectString;
                    }
                    if(userUnitString!=null && userUnitString!=''){                    
                        NewReferralInformation.Unit_No__c =userUnitString;
                        leaddatacreation.Unit_No__c =userUnitString;
                    }
                    if(RelationshipString!=null && RelationshipString!=''){                    
                        NewReferralInformation.Relation__c =RelationshipString;
                        leaddatacreation.Relationship__c =RelationshipString;
                    }
                    
                    if(selectPlant!=null && selectPlant!=''){  
                        //Plant=[SELECT id,name FROM Plant__c where Plant__c=:projectvalue1];
                        // NewReferralInformation.Plant__c=Plant.name;
                        //system.assertEquals(projectvalue1,'123');
                        NewReferralInformation.Project_Information__c=selectPlant;
                        leaddatacreation.Referred_By_project__c=selectPlant;
                    }  
                  
                                                                       
                    NewReferralInformation.Status__c='Lead-Prospect';
                    //insert lead and NewReferralInformation ;
                    leaddatacreation.Status='open';
                    leaddatacreation.Mode_of_Enquiry__c='Personal Contact';
                    leaddatacreation.Lead_Source__c='Referral';
                    leaddatacreation.Date_of_Enquiry__c=system.now(); 
                    leaddatacreation.Active_Validation__c=FALSE;
                    system.debug('*********leaddatacreation'+leaddatacreation);
                    try {
                        system.debug('*********leaddatacreation1'+leaddatacreation);
                        insert leaddatacreation;
                        system.debug('*********leaddatacreation2'+leaddatacreation);
                        LeadSuccess = true;  
                        
                           
                    }
                    catch(DMLException e){
                        LeadSuccess  = false;
                        errorMessage = true;
                        String err = String.valueOf(e);
                        System.debug('----errorss----'+e);
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The referral email or phone already exists in Brigade Group\'s records' );
                        ApexPages.addMessage(myMsg);         
                    }                             
                    if(leadSuccess == true) {
                        try {
                            errorMessage = false;
                            NewReferralInformation.Lead__c=leaddatacreation.Id;
                            insert NewReferralInformation; 
                            
                            
                 
                            
                        }
                        catch(DMLException e){
                            errorMessage = true;
                            String err = String.valueOf(e);
                            System.debug('------error 2 ----------'+e);
                            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The referral email or phone already exists in Brigade Group\'s records' );
                            ApexPages.addMessage(myMsg);
                        }   
                    }
                    //sending email to customer to say thanks for referring new lead 
                    if(usr.ContactId!=null && NewReferralInformation.Id!=null){
                        //query for email template
                        //Referal_Email__c referalID= [select Email__c from Referal_Email__c limit 1];
                         Referral__c getReferralInfo = [select id,Name__c,Email__c,Project_Information__c,Mobile__c from Referral__c where id =:NewReferralInformation.id];
                        //String email = referalID.Email__c;
                        try {
                        if(usr.email<>Null && bc.Email__c<>Null){
                        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                        String[] toAddresses = new String[] {usr.email};                      
                            // String[] toAddresses = new String[] {' salesenquiry@brigadegroup.com'};
                            string messageBody='<html><body>Dear&nbsp;'+usr.name+'<br/><br/>Thank you for referring your friend '+name +'  to Brigade.<br/>Referral Information is shown below.<br/><br/>Mobile Number :'+getReferralInfo.Mobile__c+'<br/>Email ID : '+getReferralInfo.Email__c+'<br/>Project : '+getReferralInfo.Project_Information__c+'<br/>.We will update the referral status on the portal. <br/<br/>'+'<br/<br/>Thanks & Regards,'+'<br/>Portal Admin';
                        //message.setTemplateId(emailtemp.Id);
                        //message.setTargetObjectId(usr.Contactid);
                        //message.setWhatId(NewReferralInformation.Id);
                        message.setSubject('Brigade portal:Thank you for referring!');
                        message.setToAddresses(toAddresses);
                        message.setHtmlBody(messageBody);
                        message.saveAsActivity=false; 
                        
                        
                        Messaging.SingleEmailMessage message2 = new Messaging.SingleEmailMessage();
                        //  system.assertEquals(bc.Email__c,null);
                        String[] toAddresses1 = new String[] {bc.Email__c};
                        //String[] toAddresses1 = new String[] {usr.email};
                            //  String[] toAddresses1 = new String[] {' salesenquiry@brigadegroup.com'};
                            string messageBody1='<html><body>Dear admin&nbsp;<br/><br/>'+'New Referral lead has been submitted on portal.Please check information below.<br/'+'<br/>https://na13.salesforce.com/'+NewReferralInformation.Id+'<br/<br/>Thanks & Regards,'+'<br/>Portal Admin';
                        //message.setTemplateId(emailtemp.Id);
                        //message.setTargetObjectId(usr.Contactid);
                        //message.setWhatId(NewReferralInformation.Id);
                        message2 .setSubject('New Referral Lead created on portal!');
                        message2 .setToAddresses(toAddresses1);
                        message2 .setHtmlBody(messageBody1);
                        message2 .saveAsActivity=false; 
                        
                        
                        
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });                        
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message2 }); 
                            }
                        }                       
                        catch(Exception e) {
                            String err = String.valueOf(e);
                            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                            ApexPages.addMessage(myMsg);
                        }
                        //sending email to support brigade group regarding new lead
                        //query for email template
                       
                            
                        pageRef = new PageReference('/apex/BrigadeReferralpage?flagvalue1=true');
                        pageRef.setredirect(true);
                        return pageRef ;
                    }
                    //return referral page
                    return pageRef;                  
                }
                
            } 
        } 
        Catch(Exception e){
            System.debug('Error 1 -------'+e);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The referral email or phone already exists in Brigade Group\'s records' );
            ApexPages.addMessage(myMsg);
        }   
        return null;
        
    }
    public PageReference CancelReferral() { 
        PageReference pageRef = new PageReference('/apex/BrigadeReferralpage');
        pageRef.setRedirect(true);
        return pageRef ;     
    }
    public void last() 
    {
        con.last();
    }
 
    public PageReference countryDetails() {
        displayPopUp=TRUE;
        return null;
    }
        public PageReference closePopup() {
        displayPopUp=FALSE;
        return null;
    }  
    


















/*





































































public void testData() {
    
    integer i=1;
    integer j=1;
   
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;i++;j++;i++;j++;i++;j++;i++;j++;
    i++;j++;
    i++;j++;i++;j++;
    i++;j++;
    i++;j++;
  
  
   
}*/
    
}