public with sharing class OpportunityControllerForSMS {
    public Boolean disabl {get;set;}
    public boolean showHideConfirm {get; set;}
    public boolean showHideSuccess {get; set;}
    public Boolean sendSMSCon{get;set;}
    public Boolean Successfull{get;set;}
    public List<Opportunity> lstOpp {get; set;}
    //public Demand_Letter_Repository__c dlrObj {get; set;}
    public Boolean noErr {get; set;}
    public Boolean errorDisp {get; set;}

    public List<Opportunity> selectedOpportunities {get; set;}
    private ApexPages.StandardSetController standardController;
    //public Opportunity oppObj {get; set;}
    private List<Payment_Schedule__c> listPS;
    public List<OpportunityContactRole> contRole;
    public List<Contact> conList = new List<Contact>();
    
    //public List<Opportunity> lstOpp {get; set;}
    //public Boolean noErr {get; set;}
    //public List<Id> lstId {get;set;}
    public List<Id> conListId = new List<Id>();
    public List<Id> ConId = new List<Id>(); 
    public Id PSIs;
    
    public OpportunityControllerForSMS(ApexPages.StandardSetController standardController)
    {
        this.standardController = standardController;
        sendSMSCon=TRUE;
        Successfull= false;
    }
    
    public PageReference bulkOpportunity(){       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
       
        lstOpp = selectedOpportunities = (List<Opportunity>) standardController.getSelected();
        System.debug('### DemandLetterController)-Mass lstOpp: ' + lstOpp);
        if(lstOpp.size() == 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Select at least one Opportunity.'));
                noErr = false;
                sendSMSCon=false;
                disabl = true;
                errorDisp = false;
        }     
        else
        {       selectedOpportunities = (List<Opportunity>) standardController.getSelected();
                errorDisp = true;
                noErr = true;
         		updateTotalDue();
        }
      
       

          return null;        
    }
    
    public void updateTotalDue(){
        
        list<opportunity> oppList = [select Total_Due_Payment__c, (select Total__c FROM Payment_Schedules__r where Status__c =:'Due' OR Status__c =:'Overdue' ) from Opportunity where id IN : lstOpp AND Total_Due_Payment__c = null limit 50000];
   
           list<opportunity> updateList = new list<opportunity>();
           
           for(opportunity opLst : oppList){
            if(opLst.Payment_Schedules__r != null){
             decimal amt = 0 ;
             for(Payment_Schedule__c PS : opLst.Payment_Schedules__r){
             system.debug(PS.total__c); 
                                if(PS.Total__c != null){
               amt += PS.Total__c ;
                                }
             }
             opLst.Total_Due_Payment__c = amt;
             updateList.add(opLst);
            }
           }
           
           Database.update(updateList,false);
               
                /*List<aggregateResult> results = [SELECT  Opportunity__c,Sum(Total__c) sumTot FROM Payment_Schedule__c where    (Status__c =:'Due' OR Status__c =:'Overdue') and Opportunity__c =:selectedOpportunities  GROUP BY  Opportunity__c];
           
           
           map<Id,Integer> oppMap = new  map<id,integer> ();
           for(aggregateResult agg:results ){
                 Id dID = String.valueof(agg.Get('Opportunity__c'));
                 Integer sums = Integer.valueof(agg.Get('sumTot'));
                 oppMap.put(dID,sums );
             
              }
             List<Opportunity> listAllOpp = [select id,Total_Due_Payment__c from Opportunity];
            
             List<Opportunity> updateList = new List<Opportunity>();
             for(Opportunity opUpdate : listAllOpp ){
                if(oppMap.containsKey(opUpdate.id)){
                  
                   opUpdate.Total_Due_Payment__c  =  oppMap.get(opUpdate.id);
                   System.debug(opUpdate.Total_Due_Payment__c );
                   //update  opUpdate;
                   updateList.add(opUpdate);
                  // update opUpdate;
                 
                 }
             }
             update updateList;*/
             
          List<Opportunity> opportunityContactRoleList        =   new List<Opportunity>();
         opportunityContactRoleList                          =   [select id,(select id,ContactId,Contact.Name,Contact.mobilephone,Contact.Email,OpportunityId,Role from OpportunityContactRoles where role='First Applicant' )from Opportunity where id=:selectedOpportunities ];
         System.debug(':::::::::=============opportunityContactRoleList'+opportunityContactRoleList); 
         List<Opportunity> oplists = new List<Opportunity>();
         for(Opportunity rec : opportunityContactRoleList){                              
                                    
            for (OpportunityContactRole pr: rec.OpportunityContactRoles) {
            System.debug('Contact.Name'+pr.Contact.Name);
            if(pr.role=='First Applicant'){
            ConId.add(pr.ContactId);
            rec.First_Applicant_Name__c=pr.Contact.Name;
            rec.First_Applicant_Email__c=pr.Contact.Email;
            rec.First_Applicant_Number__c=pr.Contact.mobilephone;
            oplists.add(rec);
           // update rec;
                 }
                }
            
            }
            
            Database.update(oplists,false);
            System.debug('Contact Id --------'+ConId);
            //List<Contact> firstContact=[SELECT id,name,mobilephone from Contact where id=:ConId];
            
            
            //system.debug(':::::::::::=====selectedOpportunities '+selectedOpportunities );
           
        
    }
    
     public void updateOpportunities(){
            
           
            List<id> lst = new List<id>();
            for(Opportunity Ops:selectedOpportunities){
                 lst.add(Ops.id);
            }
         	
         	disabl = true;
            showHideConfirm =TRUE;
            sendSMSCon= false;
            Successfull= true;
     
    
     callEmail(selectedOpportunities);
     Call_Batch_SendDuePaymentSMSOpportunity.runBatch_SendDuePayment_SMS_Opportunity(lst);
       
     }
     public void callEmail( List<Opportunity> selectedOpportunities ){
        
       //system.debug(':::::::::::=====selectedOpportunities '+selectedOpportunities );
       list<OpportunityContactRole> lstOpportunityRole = [select id,OpportunityId,Role,Contact.Name,Opportunity.Project_Name__c,Opportunity.Unit_Name__c,Opportunity.Unit__c,Opportunity.Total_Due_Payment__c,contactid,contact.email from OpportunityContactRole where Role =:'First Applicant' AND OpportunityId in :selectedOpportunities];
      
        //System.debug('lstOpportunityRole'+lstOpportunityRole);
      //list<opportunity> opUpdate =[select id,First_Applicant_Name__c,First_Applicant_Email__c,First_Applicant_Number__c from opportunity  ];
       
     
       List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>(); 
       
       
       for(OpportunityContactRole oppContactRoleObj :lstOpportunityRole) {
		   if(oppContactRoleObj.Opportunity.Total_Due_Payment__c != null && oppContactRoleObj.Opportunity.Total_Due_Payment__c > 0 ){
				list<string> lstEmailAddresses = new list<string>();
				Messaging.SingleEmailMessage message; 
           
            if(oppContactRoleObj.Contact.Email!=null && oppContactRoleObj.Role =='First Applicant' )
				lstEmailAddresses.add(oppContactRoleObj.Contact.Email);
        //else
        //lstEmailAddresses.add('developer@extentor.com');
         string messageBody='<html><body>Dear '+oppContactRoleObj.Contact.Name+', &nbsp;<br/>'+'<br/>This has reference to our demand note, we would like to remind you that a sum of Rs&nbsp;'+oppContactRoleObj.Opportunity.Total_Due_Payment__c+' remains overdue towards your apartment &nbsp; '+oppContactRoleObj.Opportunity.Unit_Name__c+' in '+oppContactRoleObj.Opportunity.Project_Name__c+'. <br/><br/> We request you to treat this as most urgent and clear the outstanding immediately. <br/<br/><br/>Thanks & Regards,'+'<br/><br/>Team Brigade CRM';
       
         //system.debug('******messageBody****'+messageBody);
         message = new Messaging.SingleEmailMessage();
         message.setHtmlBody(messageBody);
       if(oppContactRoleObj !=null && lstEmailAddresses.size()>0) {
              message.toAddresses = lstEmailAddresses;
              message.subject = 'Due Payment';
         }
         
         
         messages.add(message);
		}
       }   
         
       if(messages!=null && messages.size()>0){
        
       Messaging.SendEmailResult[] results = Messaging.sendEmail(messages,false);
                    if (results[0].success) {
                       // System.debug('The email was sent successfully.');
                    } else {
                        System.debug('The email failed to send: '
                              + results[0].errors[0].message);
                    }   
       }
    }

}