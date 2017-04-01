public class MyDocumentsCOntroller {

    //variables Declaration
    public string unitnumber{get;set;}
    public boolean OnlysingleProject{get;set;}
    public string selectedCodenew {get; set;}
    public String selectcontry { get; set; } 
    public String headerCountry1 { get; set; } 
    public String headerCountry2 { get; set; } 
    public String seletecedCity{ get; set; } 
    public boolean ImagenewNoFeedBack{get;set;}
   //  Controlling POPup
    Public List<SelectOption> Options { get; set; } 
    public boolean displayPopup {get; set;} 
    List <String> countries {get; set;} 
    //public User usr {get; set;}
    public string flag{get;set;}
    public List<CP_Property__c> listProperty {get; set;}
    public List<CP_Property__c> listProperty1 {get; set;}
    public List<CP_Property__c> listProperty2 {get; set;}
    public List<CP_Property__c> listProperty3 {get; set;}
    public string colorCode {get; set;}{colorCode='Blue';}
    public String userStr {get; set;}
    public boolean isTrue {get; set;}
    public User user {get; set;}
    public user usr;
    public String selectedValue {get; set;}
    public String selectedCode {get; set;}
    Public List<SelectOption> projectOption { get; set; } 
    Public List<SelectOption> unitCodeOption { get; set; } 
    Public String projectValue {get;set;}
    Public Set<String> projectSet {get;set;}
    public opportunity opp;
    public Opportunity opp1;
    public String projectId{get;set;}
    public CP_Property__c oppProperty{get; set;}
    public String  unitName{get; set;}
    public String   PlantName{get; set;}
    public List<Id> oppIds {get;set;}
    public List<Project_Docs__c> projectDocList{get;set;}
    public List<Project_Docs__c> projectDoc1{get;set;}
    public List<Admin_URL__c> admUrl = new List<Admin_URL__c>(); 
    
    //wrapper class declaration
    public List<docsSection> docsSectionList {get;set;}
    public List<docsSection> docsSectionListFirst {get;set;}
    public List<docsSection> docsSectionListSecond {get;set;}
    public List<docsSection> docsSectionListThird {get;set;}
    public List<docsSection> docsSectionListFourth {get;set;}
    Public List<Attachment> attahs{get;set;}
    public list<Notification_Documents__c> notificationdocu{get;set;}
    public Brigade_Admin_Email__c briAd = new Brigade_Admin_Email__c();
    list<Plant__c> plants = new list<Plant__c>();
    Set<String> adminEmails = new Set<String>();
    
    //varibales to show contact type and contact on VF page
    public String firstApplicantName {get;set;}
    public String secondApplicantName {get;set;}
    public String thirdApplicantName {get;set;}
    public String fourthApplicantName {get;set;}
    public boolean Imagenew{get;set;}
    public List <Document_Header__c> docHead{get;set;} 
    
    
    //constructor 
    public MyDocumentsCOntroller () {
   // Imagenew=true;
        //intialize varibales
     try{
        admUrl = Admin_URL__c.getall().values();
        docHead= new List<Document_Header__c>(); 
        docHead = Document_Header__c.getall().values();    
        projectSet  = new Set<String>();
        userStr = Userinfo.getUserId();
        oppIds = new List<Id>();
       
        docsSectionList  = new List<docsSection>();
        docsSectionListFirst = new List<docsSection>();
        docsSectionListSecond = new List<docsSection>();
        docsSectionListThird = new List<docsSection>();
        docsSectionListFourth = new List<docsSection>();
        attahs = new List<Attachment>();
        
        //query for logged user records
        if(userStr!=null){
            user = [select Id,OpportunityId__c,lastname,name,firstname,Contactid,AccountId,email From User Where Id=: userStr];
        }
        
        //query for cp proeprty records for current logged user
        if(user.ContactId!= Null){
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
            
            //system.assertEquals(listproperty,null);
            if(user.OpportunityId__c==null){
                
                selectedValue=listProperty[0].Project_Name__c;
                //getUnitCodeValue();
                selectedcode=listProperty[0].Project_Unit_No__c;
                 
                list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
                selectedCodenew=ss[0];
                unitnumber=ss[3];
                OnlysingleProject=false;
                getDocumentsList();
                
                     
            }
            else{
                listProperty2 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c,Project_Unit_No__c, Project_Name__c FROM CP_Property__c Where Opportunity_Id__c =:user.OpportunityId__c AND Active__c=true];
                selectedValue=listProperty2[0].Project_Name__c;
              
                selectedcode=listProperty2[0].Project_Unit_No__c;
                getDocumentsList();
                
                
                list<string> ss=(listProperty2[0].Project_Unit_No__c).split('-');
                selectedCodenew=ss[0];
                unitnumber=ss[3];
                OnlysingleProject=true;
                
            }

        }
       
      
      else{
         
          ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No document available');
          ApexPages.addMessage(myMsg);
        }
        
             flag = Apexpages.currentpage().getparameters().get('flagvalue');
                        
             if(flag =='true'){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'Document uploaded succesfully. To be verified by Portal administration.');
                 ApexPages.addMessage(myMsg);
             }
        
        //BlinkIng
        
        if(user.OpportunityId__c !=null){         
        
          /* opp=[Select Id, AccountId from Opportunity Where Id=:user.OpportunityId__c];
           Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
          */
          
          opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId,Plant_Owner__c,Unit_Name__c from Opportunity Where Id=:user.OpportunityId__c];
         // system.assertequals(opp.id,null);
          
          notificationdocu=[SELECT Notifications__c,CreatedDate,Document_URL__c, Document_URL_link__c,Id FROM Notification_Documents__c 
                               where CategoryDocandPro__c='Cost Breakup Document' and Opportunity__c=:opp.id];
                               
          
         
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
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
              
               /* Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];*/
               
                opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,Plant_Owner__c,Unit_Name__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
               
                
                 notificationdocu=[SELECT Notifications__c,CreatedDate,Document_URL__c, Document_URL_link__c,Id FROM Notification_Documents__c 
                               where CategoryDocandPro__c='Cost Breakup Document' and Opportunity__c=:opp.id];
                
                 
            
                Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c='First Applicant'];
            
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
        catch(exception e){
             ImagenewNoFeedBack=true;
              ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No document available');
              ApexPages.addMessage(myMsg);
        }
       
    }
    
    public pageReference getDocumentsList(){         
        //variable declaration
        isTrue=true;
        unitName = selectedCode   ;
        plantName= selectedValue ;
        projectDocList = new List<Project_Docs__c>();
        
        
        
        //query for cpproperty
        listProperty3 = [SELECT Contact_User_Id__c,Id,Plant__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id and Project_Name__c=:selectedValue and Project_Unit_No__c=:selectedCode];
        //system.assertEquals(listProperty3 ,null);
        set<String> pList = new Set<String>();
        for(CP_Property__c cpProperty : listProperty3){
            pList.add(cpproperty.Plant__c);
        }
        //system.assertEquals(pList,null);
        
        //query for plants
        if(pList.size()>0){
            
            plants = [select id,ownerId,Name,Admin_Email__c,Plant__c from Plant__c where Plant__c IN:pList]; 
            
            
            for(Plant__c pl:plants){
                adminEmails.add(pl.Admin_Email__c); 
            } 
            //system.assertEquals(plants ,null);         
        }
        //system.assertEquals(pList,null);
        //system.assertEquals(adminEmails,null);
        //query for project docs
        ProjectDocList = [select id,Name,CP_Property__c,Contact_type__c,Reason_for_Reject__c,Document_Url_link__c,Contact__c,Contact__r.name,Project_Docs__c.OwnerId,Document_Url__c,Status__c from Project_Docs__c where CP_Property__r.Project_Name__c=:selectedValue  and CP_Property__r.Project_Unit_No__c=:selectedCode and Contact_type__c!=null];
        //system.assertEquals(ProjectDocList ,null);
        //clear the document lists
        docsSectionListFirst.clear();
        docsSectionListSecond.clear();
        docsSectionListThird.clear();
        docsSectionList.clear(); 
        for(Project_Docs__c pds : ProjectDocList ) {
            if(pds.Contact_type__c =='First Applicant'){
                docsSectionListFirst.add(new docsSection(pds));
                firstApplicantName  = pds.Contact__r.name;
            }
            if(pds.Contact_type__c =='Second Applicant'){
                docsSectionListSecond.add(new docsSection(pds));
                secondApplicantName  = pds.Contact__r.name;
            }
            if(pds.Contact_type__c =='Third Applicant'){
                docsSectionListThird.add(new docsSection(pds));
                thirdApplicantName = pds.Contact__r.name;
            }
            if(pds.Contact_type__c =='Fourth Applicant'){
                docsSectionListFourth.add(new docsSection(pds));
                fourthApplicantName = pds.Contact__r.name;
            }
            docsSectionList.add(new docsSection(pds));     
        }
        return null;
    }
    //wrapper class for documents display 
        Public class docsSection {
            public Project_Docs__c pdoc {get;set;}          
            public Attachment Attach {get;set;}
            //public Attachment Attach {get;set;}
            public docsSection(Project_Docs__c pd){
                pdoc = pd;
                Attach = new Attachment();   
            }      
        }
    // Upload documents
        public pageReference uploadDocuments(){
            
            projectDoc1= new List<Project_Docs__c> ();
            //first contact type list
            if(docsSectionListFirst.size()>0){
                for(docsSection docs : docsSectionListFirst){
                    //String attname = docs.Attach.name;                   
                    if(Docs.Attach.body!=null){
                        if(docs.Attach.name.endsWith('pdf')){
                            if(Docs.Attach.body.size()>1097152){
                                docs.Attach.body=null;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                            }
                            else {
                                try {
                                
                                    Attachment att = new Attachment();
                                    att.parentId = docs.pdoc.Id;
                                    att.body = docs.Attach.body;
                                    att.Name = docs.Attach.name;
                                    //att.OwnerId = docs.pdoc.OwnerId;
                                    attahs.add(att);                              
                                    docs.Attach.body =null;
                                }
                                catch(Exception e){
                                    String err = String.valueOf(e);
                                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                                    ApexPages.addMessage(myMsg);   
                                }
                            }  
                        }
                        else {
                            docs.Attach.body=null;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please upload only pdf documents'));
                        }                       
                    }
                }
            }
            //second contact type list
            if(docsSectionListSecond.size()>0){
                for(docsSection docs : docsSectionListSecond){
                    if(docs.Attach.body!=null){
                        if(docs.Attach.name.endsWith('pdf')){
                            if(docs.Attach.body.size()>1097152){
                                docs.Attach.body=null;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else {
                            try {
                                Attachment att = new Attachment();
                                att.parentId = docs.pdoc.Id;
                                att.body = docs.Attach.body;
                                att.Name = docs.Attach.name;
                                //att.OwnerId = docs.pdoc.OwnerId;
                                attahs.add(att);
                                docs.Attach.body=null;
                                }
                            catch(Exception e){
                                String err = String.valueOf(e);
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                                ApexPages.addMessage(myMsg);
                                }
                            }
                        }
                        else {
                            docs.Attach.body=null;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please upload only pdf documents'));
                            } 
                    }
                }
            } 
            //Third contact type list  
            if(docsSectionListThird.size()>0){
                for(docsSection docs : docsSectionListThird){
                    if(docs.Attach.body!=null){
                        if(docs.Attach.name.endsWith('pdf')){
                            if(docs.Attach.body.size()>1097152){
                                docs.Attach.body=null;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else {
                            try {
                                Attachment att = new Attachment();
                                att.parentId = docs.pdoc.Id;
                                att.body = docs.Attach.body;
                                att.Name = docs.Attach.name;
                                //att.OwnerId = docs.pdoc.OwnerId;
                                attahs.add(att);
                                docs.Attach.body =null;
                                }
                            catch(Exception e){
                                String err = String.valueOf(e);
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                                ApexPages.addMessage(myMsg);
                                }
                            } 
                        }
                        else {
                            docs.Attach.body=null;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please upload only pdf documents'));
                        } 
                    }
                } 
            } 
            //fourth contact type list
            if(docsSectionListFourth.size()>0){
                for(docsSection docs : docsSectionListFourth){
                    if(docs.Attach.body!=null){
                        if(docs.Attach.name.endsWith('pdf')){
                            if(docs.Attach.body.size()>1097152){
                                docs.Attach.body =null;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else {
                            try {
                                Attachment att = new Attachment();
                                att.parentId = docs.pdoc.Id;
                                att.body = docs.Attach.body;
                                att.Name = docs.Attach.name;
                                //att.OwnerId = docs.pdoc.OwnerId;
                                attahs.add(att);
                                docs.Attach.body=null;
                                }
                            catch(Exception e){
                                String err = String.valueOf(e);
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                                ApexPages.addMessage(myMsg);
                                }
                            } 
                        }
                        else {
                            docs.Attach.body=null;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please upload only pdf documents'));
                        } 
                    }
                }   
            }
           
            //upload attachments
            if(attahs.size()>0){
                try{
                    
                    insert attahs;
                }
                catch(DMLException e){
                    String err = String.valueOf(e);
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                    ApexPages.addMessage(myMsg);
                }
            }
     
            // update project docs with attachment url
            for(Project_Docs__c pdc : ProjectDocList){
                for(Attachment att:attahs){
                    if(att.parentId  == pdc.Id){
                        String dUrl = 'https://bgproduction-brigadeforce-na19.my.salesforce.com/'+att.id+'';
                        pdc.Status__c = 'Submitted';
                        pdc.Document_Url__c =dUrl;
                        pdc.AttachmentId__c = att.Id;
                        pdc.Reason_for_Reject__c = null;
                        projectDoc1.add(pdc);
                    }
                }
            }
            //update projectdocs
            if(projectDoc1.size()>0){
                try{
                    
                    update projectDoc1;
                    //
                    //query for email template
                    EmailTemplate emailtemp = [select id, name from EmailTemplate where name ='Update document email' limit 1];
                    List<Task> tasklist = new List<Task>();
                    briAd = [select Name, Email__c FROM Brigade_Admin_Email__c LIMIT 1];
                    //sending email to portal admin when portal user uploaded documents
                    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                    //system.assertEquals(listProperty3,null);
                    for(CP_Property__c cpProperty : listProperty3){
                        for(Plant__c pl:plants){
                            for(String adminmail:adminEmails){
                                if(adminmail == pl.Admin_Email__c && pl.Admin_Email__c<>Null){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    String[] ccAddresses = new String[] {briAd.Email__c};
                                    String[] toAddresses = new String[] {adminmail};
                                    
                                   // mail.setTemplateId(emailtemp.id);
                                   // mail.setTargetObjectId(user.contactId);
                                   // mail.setwhatid(Opp.id);
                                   // system.assertEquals(Usr.Name,null);
                                    string messageBody='<html><body>Dear&nbsp;'+opp.Plant_Owner__c+',<br/><br/>Portal user&nbsp;'+user.Name+'&nbsp;of&nbsp;'+opp.Unit_Name__c+'&nbsp;uploaded new documents. Please check the link below..<br/>'+'<br/>'+admUrl[0].URL_link__c+'/apex/UpdateDocuments?id='+user.Id+'&Unitname='+opp.Unit_Name__c+'<br/><br/><br/>Thanks & Regards,'+'<br/>'+'Portal Admin';
                                    mail.setSubject('Portal user uploaded new documents');
                                    mail.setToAddresses(toAddresses);
                                    mail.setCcAddresses(ccAddresses);
                                    mail.setHtmlBody(messageBody);
                                    mail.saveAsActivity=false;
                                    mails.add(mail);
                                    
                                    Task t= new task();
                                    t.OwnerId = pl.OwnerId;
                                    t.Whatid = opp.id;
                                    t.whoId = user.ContactId;
                                    t.Subject = 'Portal user uploaded new documents';
                                    t.ActivityDate = system.today()+1;
                                    tasklist.add(t);
                                }                          
                            }
                        }  
                    }
                    try {
                        Messaging.sendEmail(mails); 
                        insert tasklist; 
                    }
                    catch(Exception e){
                        String err = String.valueOf(e);
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                        ApexPages.addMessage(myMsg);
                    }
                   
                }
                catch(DMLException e){
                    String err = String.valueOf(e);
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                    ApexPages.addMessage(myMsg);
                }
                finally {
                    attahs = new List<Attachment>();                                                
                   PageReference ref = new PageReference('/apex/MyDocuments?flagvalue=true');
                   ref.setredirect(true);
                   return ref; 
                }
            }        
            return null;
        } 
        //pop section
        public pagereference countryDetails(){
        try{
            displayPopUp=false;
           
            User u =[select Id, Name, OpportunityId__c From User Where Id=: Userinfo.getUserId()];
            u.OpportunityId__c=headerCountry1;
            update u;
            Opportunity opp = [Select Id,Unit__r.Name,Plant_Owner__c,Unit_Name__c,Project_Unit_No__c From Opportunity Where Id=:headerCountry1];
            headerCountry2=opp.Project_Unit_No__c;
            
            //return null;
               }
               catch(Exception e){
                      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No document available');
                      ApexPages.addMessage(myMsg);
               } 
             
                PageReference pageRef = new PageReference('/apex/MyDocuments');
                pageRef.setRedirect(true);
                return pageRef ;
   
        }
        public List<SelectOption> getItems() {
            List<SelectOption> options = new List<SelectOption>();
        try{
            displayPopup = false;
            user = [select Id, Name, ContactId From User Where Id=: Userinfo.getUserId()];
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,Unit_Code__c,Project_Unit_No__c, Project_Name__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
                                  
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
            }
            catch(Exception e){
                      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Project available');
                      ApexPages.addMessage(myMsg);
               }
            //system.assertEquals (options,null);  
            return options;

        }               
        public String[] getCountries() {
            return countries;
        }
        public void getReopenPopup(){
            User u =[select Id, Name, OpportunityId__c From User Where Id=: Userinfo.getUserId()];
            
            if(u.OpportunityId__c !=null){
                displayPopup = true;
            }
        }    
}