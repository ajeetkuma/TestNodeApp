/**  Description     :   This class is used to send email to the contacts(First Applicant or Second Applicant Type) of opportunity,
*                        if there is no Survey response records after date of Site Visit is entered.
*    Created By      :   Anju Alexander(ET Marlabs)
*    Created Date    :   9/6/2015
*    Version         :   v1.0
     Modified By     :   Amritesh
*       
**/
public class Handler_OpportunityTrigger {
    
 
    public void AfterInsert(List<Opportunity> oppList, Map<Id,Opportunity> oppMap){
        //sendSurveyEmail(oppList,oppMap);
        // To calculate Sales Person Share
        SalesPerson_Sharing obj = new SalesPerson_Sharing();
        obj.calculateSalesSharing(oppList, oppMap);
    }
    
    
    public void AfterUpdate(List<Opportunity> oppList, Map<Id,Opportunity> oppMap,Map<Id,Opportunity> oldMap){
        
        sendSurveyEmail(oppList,oppMap,false);
        // To calculate Actuals for Opportunity
        ActualsCalculation_Cls actObj   = new ActualsCalculation_Cls();
        actObj.oppActualCalcualtion(oppList, oppMap,oldMap);
        
        // To calculate Sales Person Share
        SalesPerson_Sharing obj = new SalesPerson_Sharing();
        obj.calculateSalesSharing(oppList, oppMap);
    }
    
    /*
    * Description: Method to send email
    */
    @future
    public static void sendFeedBackSurvey(set<id> oppid){
    
    list<opportunity> oppList = [select id from opportunity where id IN :oppid];
        map<id,opportunity> oppMap = new Map<id,opportunity>();
        for(opportunity o : oppList){
            oppMap.put(o.id, o);
        }
        sendSurveyEmail(oppList,oppMap,true);

    }    


    public static void sendSurveyEmail(List<Opportunity> oppList, Map<Id,Opportunity> oppMap,boolean isInsrt){
        
        try{
            Utility_Class.IS_OPP_TRIGGER_RUNNING                =   true;
            
            Set<Id> opportunityIdSet                            =   new Set<Id>();
            List<Project_Survey__c> projectSurveyList           =   new List<Project_Survey__c>();
            List<Opportunity> opportunityContactRoleList        =   new List<Opportunity>();
            List<Id> accountId                                  =   new List<Id>();
            Map<String,Contact> contactMap                      =   new Map<String,Contact>();  
            projectSurveyList                                   =   [SELECT Id,Name,Opportunity__c from Project_Survey__c where Opportunity__c IN:oppMap.keySet()];
            opportunityContactRoleList                          =   [select id,SurveySent__c,Date_of_Site_Visit__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                                                                     X1styearHandoverFeedbackSent__c,HandoverFeedbackSent__c,ExecutionWithFeedbackSent__c,ExecutionwithoutFeedbackSent__c,
                                                                     BookingCSATSent__c,Modification_Requested__c,Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c,
                                                                     (select id,ContactId,Contact.Email,contact.Salutation,Contact.Name,Contact.Portal_Access__c,Role from OpportunityContactRoles 
                                                                      where role=:Utility_Class.CONTACTROLE_FIRST OR role=:Utility_Class.CONTACTROLE_SECOND OR role =:Utility_Class.CONTACTROLE_THIRD )from Opportunity where id=:oppMap.keySet() ];
            
            List<Messaging.SingleEmailMessage> mails            = new List<Messaging.SingleEmailMessage>();
            List<String> sendTo                                 = new List<String>();
            Map<Id,OpportunityContactRole> emailMap             = new Map<Id,OpportunityContactRole>();
            Map<String,OpportunityContactRole> firstApplicantId = new Map<String,OpportunityContactRole>();
            Map<String,String> BookingCSATformURL               = new Map<String,String>();
            Map<String,String> ExecutionFeedback1URL            = new Map<String,String>();
            Map<String,String> ExecutionFeedback2URL            = new Map<String,String>();
            Map<String,String> HandoverFeedbackformURL          = new Map<String,String>();
            Map<String,String> X1styearHandoverFeedbackURL      = new Map<String,String>();
            Map<Id,Opportunity> oppListToUpdate                 = new Map<Id,Opportunity>();
            Boolean isSurveySend                                = false;
            
            
            for(Opportunity rec : opportunityContactRoleList){                                            
                           
                for (OpportunityContactRole pr: rec.OpportunityContactRoles) {
                        
                    
                    if(isInsrt && rec.SurveySent__c == false && projectSurveyList.size() == 0 && rec.Date_of_Site_Visit__c != null && rec.Date_of_Site_Visit__c <= system.now()){
                        isSurveySend    = true;
                        if((pr.role==Utility_Class.CONTACTROLE_FIRST) && ((pr.contact.email!=null)|| (pr.contact.email!=''))  ){
                            emailMap.put(rec.id,pr);
                            
                        }
                        /*if((pr.role==Utility_Class.CONTACTROLE_SECOND) && ((pr.contact.email!=null)|| (pr.contact.email!=''))&&(sendTo.size()==0)  ){
                            emailMap.put(rec.id,pr);
                            system.debug('Second Applicant'+emailMap);
                        }
                        
                        if((pr.role==Utility_Class.CONTACTROLE_THIRD) && ((pr.contact.email!=null)|| (pr.contact.email!='')) &&(sendTo.size()==0)  ){
                            emailMap.put(rec.id,pr);
                            system.debug('Third Applicant'+emailMap);
                        }*/
                    }
                    
                    if(pr.role==Utility_Class.CONTACTROLE_FIRST){
                        firstApplicantId.put(rec.id,pr);
                    }                   
                }
               if(isSurveySend){
                    Opportunity optoUpdate      = new Opportunity(); 
                    optoUpdate.Id               = rec.Id;
                    optoUpdate.SurveySent__c    = true;
                    optoUpdate.Survey_Sent_Date__c = system.today();
                    oppListToUpdate.put(rec.Id,optoUpdate);
                }  
                
                // This Part is for Sending mail for Customer Portal feedback
                if(rec.Booking_CSAT_Feed_back_form__c == false && rec.BookingCSATSent__c == false){
                    Standard_Feedback_Form__c myCS1 = Standard_Feedback_Form__c.getValues(Utility_Class.BOOKING_CSAT_FEEDBACK);
                    BookingCSATformURL.put(rec.id,myCS1.Form_url__c);   
                }
                
                if(rec.Execution_with_Modification_Feed_back_fo__c == false && rec.Modification_Requested__c==True
                  && rec.ExecutionWithFeedbackSent__c == false){
                    Standard_Feedback_Form__c myCS1 = Standard_Feedback_Form__c.getValues(Utility_Class.EXECUTION_WITH_MODIFY);
                    ExecutionFeedback1URL.put(rec.id,myCS1.Form_url__c);    
                }
                
                if(rec.Execution_without_modification_Feed_back__c == false && rec.ExecutionwithoutFeedbackSent__c == false){
                    Standard_Feedback_Form__c myCS1 = Standard_Feedback_Form__c.getValues(Utility_Class.EXECUTION_WITHOUT_MODIFY);
                    ExecutionFeedback2URL.put(rec.id,myCS1.Form_url__c);    
                }
                
                if(rec.Handover_Feed_back_form__c == false && rec.HandoverFeedbackSent__c == false){
                    Standard_Feedback_Form__c myCS1 = Standard_Feedback_Form__c.getValues(Utility_Class.HANDOVER_FEEDBACK_FORM);
                    HandoverFeedbackformURL.put(rec.id,myCS1.Form_url__c);  
                }
                
                if(rec.X1st_year_Handover_Feedback__c == false && rec.X1styearHandoverFeedbackSent__c == false){
                    Standard_Feedback_Form__c myCS1 = Standard_Feedback_Form__c.getValues(Utility_Class.ONE_YEAR_HANDOVER);
                    X1styearHandoverFeedbackURL.put(rec.id,myCS1.Form_url__c);  
                }
            }
           

            // This is Survey Mail sent for Public Survey 
            
             if(emailMap.size() > 0){
                for(Id recId : emailMap.keySet()){
                    Messaging.SingleEmailMessage mail =   new Messaging.SingleEmailMessage();
                    
                    sendTo.add(emailMap.get(recId).Contact.Email);
                    mail.setToAddresses(sendTo);                
                    mail.setSubject('Feedback for Brigade Group');
                    string conName ='';
                    if(emailMap.get(recId).Contact.Salutation != null){
                    		conName = emailMap.get(recId).Contact.Salutation+' ' +emailMap.get(recId).Contact.name ;
                        }else{
                            conName =  emailMap.get(recId).Contact.name ;
                        }
                    String body = '<p style="text-transform:capitalize;">'+'Dear '+conName+ ',</p></br>';
                    body += 'Thank you for visiting us. Buying a home is one of the most important decisions of one\'s lifetime and we are glad you have taken one step further in that direction.<br/><br/>';
                    body += 'We hope you could get the information you wanted on our property. It will really help if you could spare a few minutes to give us your quick feedback on the Brigade Experience:<br/><br/>';
                    body += 'Please click on the below link to give feedback.<br></br>';
                    body += '<a href="http://'+System.Label.Site_domain_name+'apex/Project_Survey?oppSurveyId='+recId+'">Click Here<a>';
                    body += '<br/><br/>Did you know that you can now refer a Brigade property to your friends and earn 0.5% of the value of the property as referral bonus? Click <a href="http://www.brigadegroup.com/residential/referrals" target="brigadegroup">here<a> to refer';
                    body += '<br/><br/>Thank You,<br/>Team Brigade';
                    mail.setHtmlBody(body);
                    mails.add(mail);   
                }
            }
                      
            if(firstApplicantId.size() > 0){
                for(String opId : firstApplicantId.keySet()){
                    
                    Opportunity optoUpdate  = new Opportunity();
                    if(oppListToUpdate.ContainsKey(opId)){
                        optoUpdate  = oppListToUpdate.get(opId);
                    }else{
                        optoUpdate.Id           = opId;
                    }
                    
                    // Send Mail for 'Booking CSAT Feedback form'
                    if(BookingCSATformURL.size() > 0 && BookingCSATformURL.containsKey(opId)){
                        Messaging.SingleEmailMessage mail =   getSurveyMailDeatil(firstApplicantId.get(opId),BookingCSATformURL.get(opId));                        
                        if(mail != null)
                        mails.add(mail); 
                        optoUpdate.BookingCSATSent__c   = true;
                        
                    }
                    
                    // Send Mail for 'Execution with Modification'
                    if(ExecutionFeedback1URL.size() > 0){
                        Messaging.SingleEmailMessage mail =   getSurveyMailDeatil(firstApplicantId.get(opId),ExecutionFeedback1URL.get(opId));                        
                         if(mail != null)
                        mails.add(mail); 
                        optoUpdate.ExecutionWithFeedbackSent__c = true;
                        
                    }
                    
                    // Send Mail for 'Execution without Modification'
                    if(ExecutionFeedback2URL.size() > 0){
                        Messaging.SingleEmailMessage mail =   getSurveyMailDeatil(firstApplicantId.get(opId),ExecutionFeedback2URL.get(opId));                        
                         if(mail != null)
                        mails.add(mail);
                        optoUpdate.ExecutionwithoutFeedbackSent__c  = true;
                        
                    }
                    
                    // Send Mail for 'Handover Feedback form'
                    if(HandoverFeedbackformURL.size() > 0){
                        Messaging.SingleEmailMessage mail =   getSurveyMailDeatil(firstApplicantId.get(opId),HandoverFeedbackformURL.get(opId));                        
                         if(mail != null)
                        mails.add(mail); 
                        optoUpdate.HandoverFeedbackSent__c  = true;
                        
                    }
                    
                    // Send Mail for '1st year Handover Feedback'
                    if(X1styearHandoverFeedbackURL.size() > 0){
                        Messaging.SingleEmailMessage mail =   getSurveyMailDeatil(firstApplicantId.get(opId),X1styearHandoverFeedbackURL.get(opId));                        
                         if(mail != null)
                        mails.add(mail); 
                        optoUpdate.X1styearHandoverFeedbackSent__c  = true;
                        
                    }
                    
                    oppListToUpdate.put(opId,optoUpdate);
                }
            }
            
            Messaging.sendEmail(mails,false);// need to uncomment change once 
            if(oppListToUpdate.size() > 0){
               Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
               update oppListToUpdate.values(); 
            }
        }catch(Exception ex){
            system.debug('exception::'+ex.getMessage());
        }
    }
    
    // Return a SingleEmailMessage detail
    public static Messaging.SingleEmailMessage getSurveyMailDeatil(OpportunityContactRole opRole,String surveyUrl){
        Messaging.SingleEmailMessage mail   = new Messaging.SingleEmailMessage();
         
        
        if(opRole.Contact.Portal_Access__c){
            
            List<String> emailList              = new List<String>{opRole.Contact.Email};
            mail.setToAddresses(emailList);
            mail.setSubject('Feedback for Brigade Group');
            String fullUrl  = surveyUrl+opRole.ContactId;
            String body = '<p style="text-transform:capitalize;">'+'Dear '+opRole.Contact.Name+ ',</p>';
            body += 'Please do take some time out to fill the Survey.<br/><br/>';
            body += 'Click on the below link to give feedback.<br></br>';
            body += '<a href="'+fullUrl+'">'+fullUrl+'</a>';
            body += '<br/><br/>Thank You,<br/>Team Brigade';
            mail.setHtmlBody(body);
            return mail;
        }
        return null;
        
    }
    
}