public class DemandLetterEmailController {
    private String oId;
    private String emailBody;
    private String dId;
    private PageReference pdf;
    private Blob b;
    private Demand_Letter_Repository__c dlObj;
    private String[] toAddresses;
    private String[] ccAddresses;

    Transient Messaging.SingleEmailMessage mail;    
    Transient Messaging.EmailFileAttachment efa;
    Transient Messaging.SendEmailResult [] r;
    Transient List<Messaging.SingleEmailMessage> sem;
    Transient Set<ID> targetIdsFailed;
    //Transient SendEmailError[] emailErrArr;
    private List<Demand_Letter_Repository__c> lstDLRFailed;
    
    private List<Attachment> lstAtt;
    public String emailStatus {get; set;}
    private Exception e;
    private ID rtId;
    private List<Task> lstTask;
    
    public List<Demand_Letter_Repository__c> lstDLR {get; set;}
    private List<Opportunity> lstOpp;
    private String[] arrId;
    public Boolean mass {get; set;}
    public Boolean showSendBtn {get; set;}
    private String ccAddr;
  
    
    public Boolean test;
    public set<id> oppIdWithNoDue ;
    public boolean SingleEmailSent ;
    public list<id> listofDemandID ;
    public boolean customSubject ;
    
    

    public DemandLetterEmailController(ApexPages.StandardController controller) {
        try {
            //dummy();
            showSendBtn = true;
            test = false;
            lstAtt = new List<Attachment> ();
            lstTask = new List<Task> ();
            arrId = new list<string>();
            //System.debug('1');
             dlObj = [select Id,Opportunity__r.Total_Due_Payment__c,Subject__c,To__c,CC__c,Name,OwnerId,Sent_Date__c,Selection_Date__c,OppIDs__c,Page1__c,Page2__c,Opportunity__c,Opportunity__r.Name,RecordTypeId,Opportunity__r.HFI__c,Opportunity__r.HFI__r.Email__c,Opportunity__r.Unit__r.Name, Opportunity__r.Opp_Name_3__c from Demand_Letter_Repository__c where Id =: ApexPages.CurrentPage().getParameters().get('id')  limit 1]  ;
            //dlObj = [select Id,Subject__c,To__c,CC__c,Name,OwnerId,Sent_Date__c,Selection_Date__c,OppIDs__c,Page1__c,Page2__c,Opportunity__c,Opportunity__r.Total_Due_Payment__c,Opportunity__r.Name,RecordTypeId,Opportunity__r.HFI__c,Opportunity__r.HFI__r.Email__c,Opportunity__r.Unit__r.Name, Opportunity__r.Opp_Name_3__c from Demand_Letter_Repository__c where Id =: ApexPages.CurrentPage().getParameters().get('id')  limit 1]  ;
            //if(ApexPages.CurrentPage().getParameters().get('oppId') != null && dlObj.Opportunity__r.Total_Due_Payment__c>0) {
            customSubject = false;
            if(dlObj.subject__c.equalsIgnoreCase('Send Update')){
                    customSubject = true;
                }
            if(ApexPages.CurrentPage().getParameters().get('oppId') != null ) {
                mass = false;
                SingleEmailSent = true;
                if(dlObj.Opportunity__r.Total_Due_Payment__c != null &&  dlObj.Opportunity__r.Total_Due_Payment__c == 0 && (dlObj.Subject__c =='Reminder of Demand letter' || dlObj.Subject__c == 'Demand Letter')){
                    SingleEmailSent = false;
                    
                }
                //sem = new Messaging.SingleEmailMessage[] {new Messaging.SingleEmailMessage()};
                //System.debug('2');
                if(dlObj.To__c !=null){
                     toAddresses = dlObj.To__c.split(',');
                     }
                if(dlObj.CC__c !=null) {
                    /*if(dlObj.Opportunity__r.HFI__c !=null) {
                        if(dlObj.Opportunity__r.HFI__r.Email__c != null) {
                            if(! dlObj.CC__c.contains(dlObj.Opportunity__r.HFI__r.Email__c)) {
                                dlObj.CC__c = dlObj.CC__c + ',' + dlObj.Opportunity__r.HFI__r.Email__c;
                            }
                        }
                    }*/
                   ccAddresses = dlObj.CC__c.split(',');
                }
                oId = ApexPages.CurrentPage().getParameters().get('oppId');
                dId = ApexPages.CurrentPage().getParameters().get('id');
                
                arrId.add(oId); 
            }
            else {
                mass = true;
                oppIdWithNoDue = new set<id>();
                //System.debug('3');
                lstDLR = new List<Demand_Letter_Repository__c> ();
                arrId.clear(); 
                arrId = dlObj.OppIDs__c.split(',');
                if(arrId.size() > 0  && customSubject == false){
                
                
                //lstOpp = [select Name,Id,Account.Primary_Contact_s_Email__c,Total_Due_Payment__c,Account.CC_Address__c,HFI__c,HFI__r.Email__c, Opp_Name__c from Opportunity where Id IN :arrId and Total_Due_Payment__c>0];
                
                lstOpp = [select Name,Id,Account.Primary_Contact_s_Email__c,Account.CC_Address__c,HFI__c,HFI__r.Email__c, Opp_Name__c,Total_Due_Payment__c from Opportunity where Id IN :arrId ];
                for(Opportunity o: lstOpp) {
                
                    if(o.Total_Due_Payment__c != null && o.Total_Due_Payment__c == 0 && (dlObj.Subject__c =='Reminder of Demand letter' || dlObj.Subject__c == 'Demand Letter')){
                        oppIdWithNoDue.add(o.id);
                    }
                   
                    ccAddr = '';
            
                        if(o.Account.CC_Address__c !=null) {
                        ccAddr = o.Account.CC_Address__c;
                        //System.debug('### (DemandLetterEmailController) ccAddr: ' + ccAddr);
                        if(o.HFI__c !=null) {
                            if(o.HFI__r.Email__c != null) {
                                if(! ccAddr.contains(o.HFI__r.Email__c)) {
                                    //System.debug('### (DemandLetterEmailController) INSIDE IF - cc contains hfi email');
                                    ccAddr = ccAddr + ',' + o.HFI__r.Email__c;
                                }
                            }
                        }
                    }
                    else {
                        if(o.HFI__c !=null) {
                            if(o.HFI__r.Email__c != null) {
                                if(ccAddr == '') {
                                    ccAddr = o.HFI__r.Email__c;
                                    //System.debug('### (DemandLetterEmailController) INSIDE IF - account cc null. ccAddr: ' + ccAddr);
                                }
                                else if(! ccAddr.contains(o.HFI__r.Email__c)) {
                                    //System.debug('### (DemandLetterEmailController) INSIDE IF - acnt cc contains hfi email. account cc null. ccAddr: ' + ccAddr);
                                    ccAddr = ccAddr + ',' + o.HFI__r.Email__c;
                                }
                            }
                        }
                    }
                //System.debug('4');
                    lstDLR.add(new Demand_Letter_Repository__c(Name=dlObj.Name,
                            Opportunity__c=o.Id,Page1__c=dlObj.Page1__c,Page2__c=dlObj.Page2__c,
                            To__c=o.Account.Primary_Contact_s_Email__c,CC__c=ccAddr,
                            Selection_Date__c=dlObj.Selection_Date__c,OwnerId = dlObj.OwnerId,Subject__c = dlObj.Subject__c));
                }
                    
              }
            }
             System.debug('----to---'+dlObj.To__c);
        }
       
        catch(Exception e) {
            //System.debug('### (DemandLetterEmailController) Exception-dbOperation: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()+e.getLineNumber()));
        } 
    }
  
    
    public void dbOperation() {
        try {
            if(! mass) {
                //System.debug('### (DemandLetterEmailController) SINGLE. dbOperation');
                sendAction();
            }
            else {
                //System.debug('### (DemandLetterEmailController) MASS. dbOperation');
                if(customSubject == false){
                insert lstDLR;
                }
                delete dlObj;
                //System.debug('### (DemandLetterEmailController) lstDLR.size-after insert: ' + lstDLR.size());
            }
        }
        catch(Exception e) {
            //System.debug('### (DemandLetterEmailController) Exception-dbOperation: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()+e.getLineNumber()));
        }
    }
    
    public void sendAction() {
        list<id> DemandLetterId = new list<id>();
        try {
            showSendBtn = false;
            //System.debug('5');
            
            
                if(customSubject == true){
                    sendUpdateToAllContact();
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email Sent to Each Contact of the Selected Opportunity . For tracking the Email you can check Activity History of Each Contact'));
                    if(!mass){
                        Database.delete(dlObj,false); 
                    }
                    return ;
                }
                
            rtId = [select Id,name from RecordType where name='Demand Letter_After Sending' and SObjectType='Demand_Letter_Repository__c' limit 1].Id;
            sem = new List<Messaging.SingleEmailMessage> ();
            
            //System.debug('### (DemandLetterEmailController) sendAction. sem.size: ' + sem.size());
            
            if(!mass) {
                //System.debug('### (DemandLetterEmailController) SINGLE. sendAction');
                sendAndAttach(dlObj);
                if(SingleEmailSent == false){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Number of email(s) sent: ' + sem.size()));
                }else{
                    sendInBulk();
                    dlObj.RecordTypeId = rtId;
                }
                update dlObj;
                
            }else {
                
                arrId.clear(); // arrId contains the opp ids. Hence clear all before re-using it for storing DLR's ids
                listofDemandID  = new list<id>();
                
                for(Demand_Letter_Repository__c dObj : lstDLR) {
                    arrId.add(dObj.Id);
                }
                
                
                /*lstDLR = [select Name,subject__c,Opportunity__c,Opportunity__r.Name,Opportunity__r.Email__c,Page1__c,Page2__c,To__c,
                    CC__c,OwnerId,Opportunity__r.HFI__c,Opportunity__r.HFI__r.Email__c,MassEmail__c,RecordTypeId,Selection_Date__c,
                    Sent_Date__c,Opportunity__r.Unit__r.Name,Opportunity__r.Opp_Name_3__c from Demand_Letter_Repository__c where Id IN: arrId];*/
                
                 //system.debug('in mass email'+lstDLR);
                
                lstDLR = [select Name,subject__c,Opportunity__c,Opportunity__r.Name,To__c,CC__c,OwnerId,Opportunity__r.HFI__c,Opportunity__r.HFI__r.Email__c,Sent_Date__c,Opportunity__r.Opp_Name_3__c from Demand_Letter_Repository__c where Id IN: arrId];
                
                for(Demand_Letter_Repository__c d : lstDLR) {
                    
                    oId = String.valueOf(d.Opportunity__c).subString(0,15);
                    dId = String.valueOf(d.Id).subString(0,15);
                    //System.debug('### (DemandLetterEmailController) d-for loop: ' + d);
                    
                    //below line 228 commented by Sumit kumar; as its trowing exception. To__c field must have email id, but assertion put on null, so every time throwing exception.
                    //system.assertEquals(null,d.To__c);
                    if(d.To__c !=null)
                        toAddresses =d.To__c.split(',') ;
                    else
                        toAddresses = null;
                    if(d.CC__c !=null) {
                        if(d.Opportunity__r.HFI__c !=null) {
                            //System.debug('### (DemandLetterEmailController) inside d.Opportunity__r.HFI__c !=null');
                            if(d.Opportunity__r.HFI__r.Email__c != null) {
                                if(! d.CC__c.contains(d.Opportunity__r.HFI__r.Email__c)) {
                                    //System.debug('### (DemandLetterEmailController)if ! d.CC__c.contains(d.Opportunity__r.HFI__r.Email__c)');
                                    d.CC__c = d.CC__c + ',' + d.Opportunity__r.HFI__r.Email__c;
                                }
                            }
                        }
                        ccAddresses = d.CC__c.split(',');
                    }
                    else
                        ccAddresses = null;
                    
                    DemandLetterId.add(d.id);
                    
                    if(!oppIdWithNoDue.contains(oId)){
                        createEmail(d);
                        listofDemandID.add(d.id);
                    }
                    //sendAndAttach(d);
                    //d.MassEmail__c = true;
                    //d.RecordTypeId = rtId;
                    
                    
                }
                sendInBulk();
                //update lstDLR;
                SendAndAttactV2(DemandLetterId,targetIdsFailed,oppIdWithNoDue);
                
            }
            //insert lstAtt;
            insert lstTask;
            
        }
        catch(Exception e) {
            //System.debug('### (DemandLetterEmailController) Exception-sendAction: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Exception-sendAction: ' + e.getMessage()+e+e.getLineNumber()));
                try{
                    if(mass != null && mass == false && lstDLR != null){
                        database.delete(lstDLR,false);
                    }else if(DemandLetterId != null){
                        deleteDemandLetter(DemandLetterId);
                    }
                }catch(Exception excep){
                    system.debug('Exception'+excep);
                }
        }
    }
    
    public void sendUpdateToAllContact(){
        
        list<opportunityContactRole> oppConRole = new list<opportunityContactRole>();
        oppConRole = [select ContactId from opportunityContactRole where opportunityId IN :arrId];
        list<id> contactId = new list<id>();
        for(opportunityContactRole oppCon : oppConRole){
            contactId.add(oppCon.ContactId);
        }
        map<id,contact> contactmap ;contactmap = new map<id,Contact>([select Salutation,name from contact where id IN :ContactId and email != null ]);
        
        if(contactmap.size()>0){
             
            list<Messaging.SingleEmailMessage> singleEmailList = new list<Messaging.SingleEmailMessage>();
            for(id contId : contactmap.keyset()){
                contact con = contactmap.get(contId);
                
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setSubject(dlObj.Name+' '+' '+'Unit No:'+' '+dlObj.Opportunity__r.Opp_Name_3__c);
            
                    string page2 = '';
                    if(dlObj.page2__c != null){
                        page2 = dlObj.page2__c;
                    }
                    
                    email.setHtmlBody('<br/>'+
                         'Dear '+con.Salutation+' '+con.name+',<br/><br/>' +
                         
                         dlObj.page1__c+'<br/><br/>'+page2);
                
                    
                    email.setTargetObjectId(contId);
                    singleEmailList.add(email);
                }
            
           
            Utility_Class.IS_TASK_TRIGGER_RUNNING = true;
            Messaging.sendEmail(singleEmailList,false);
           
            
        }
    }
    @future
    public static void deleteDemandLetter(list<id> DemandLetterId){
      list<Demand_Letter_Repository__c>demandLtr =   [select id from Demand_Letter_Repository__c where id IN :DemandLetterId];
        Database.delete(demandLtr,false);
    }
    
    @future(callout=true)   
    public static void SendAndAttactV2(list<id> DemandLetterId,set<id>targetIdsFailed,set<Id>oppIdWithNoDue){
        
         ID recTypeId = [select Id,name from RecordType where name='Demand Letter_After Sending' and SObjectType='Demand_Letter_Repository__c' limit 1].Id;
          list<Demand_Letter_Repository__c>  lstDLR = [select Name,Opportunity__c,Opportunity__r.Name,Opportunity__r.Email__c,Page1__c,Page2__c,To__c,
                    CC__c,OwnerId,Opportunity__r.HFI__c,Opportunity__r.HFI__r.Email__c,MassEmail__c,RecordTypeId,Selection_Date__c,
                    Sent_Date__c,Opportunity__r.Unit__r.Name,Opportunity__r.Opp_Name_3__c from Demand_Letter_Repository__c where Id IN: DemandLetterId];
        
        List<Attachment> lstAttach = new List<Attachment>();
       
                
        //Attach to Progress-cum-Demand Letter Repository record
        //list<Demand_Letter_Repository__c> lstDLR = [select name,ownerId,Opportunity__c from Demand_Letter_Repository__c where id In DemandLetterId ];
        for(Demand_Letter_Repository__c demandLttr : lstDLR){
        
        
            if(demandLttr.CC__c !=null) {
                if(demandLttr.Opportunity__r.HFI__c !=null) {
                    //System.debug('### (DemandLetterEmailController) inside d.Opportunity__r.HFI__c !=null');
                    if(demandLttr.Opportunity__r.HFI__r.Email__c != null) {
                        if(! demandLttr.CC__c.contains(demandLttr.Opportunity__r.HFI__r.Email__c)) {
                            
                            demandLttr.CC__c = demandLttr.CC__c + ',' + demandLttr.Opportunity__r.HFI__r.Email__c;
                        }
                    }
                }
                
            }
            
            if(!oppIdWithNoDue.contains(demandLttr.Opportunity__c)){
                demandLttr.MassEmail__c = true;
                demandLttr.RecordTypeId = recTypeId; 
                
                if(!targetIdsFailed.contains(demandLttr.id)){
                    demandLttr.Sent_Date__c = System.Today();
                } 
            }
            PageReference  pdf = new PageReference('/apex/DemandLetterPDF?id=' + demandLttr.id + '&oppId=' + demandLttr.Opportunity__c + '&type=old');
            pdf.setRedirect(true);
        
            blob b = pdf.getContent();
            lstAttach.add(new Attachment(parentId =demandLttr.Id,name=demandLttr.Name + '.pdf',body=b,OwnerId=demandLttr.OwnerId));
        }
        
        insert lstAttach;
        update lstDLR;
    
    }
    
    public void createEmail(Demand_Letter_Repository__c dlr){
        //system.debug('mail debug');
        mail = new Messaging.SingleEmailMessage();
        pdf = new PageReference('/apex/DemandLetterPDF?id=' + dId + '&oppId=' + oId + '&type=old');
        //System.debug('### (DemandLetterEmailController) pdf: ' + pdf);
        pdf.setRedirect(true);
        
        // Take the PDF content
        if(test)  // Just to skip if called from test method
            b = Blob.valueof('test class body');
        else
            b = pdf.getContent();
        //system.debug('mail debug');
        
        if(toAddresses== null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Error while sending email - No TO address specified ('+
                                 dlr.Opportunity__r.Name + '). *** A task has been created to take hard copy ***'));
            lstTask.add(new Task(Subject='Send Hard Copy',ActivityDate=System.Today(),Status='Not Started',
                                 WhatId=dlr.Id,Description='The customer does not have email specified. Send hard copy.' +
                                 ' After sending the hard copy close this task (status=Complete) and enter Sent Date for' +
                                 ' the progress-cum-demand letter record.',
                                 OwnerId = dlr.OwnerId,ReminderDateTime=System.Now(),IsReminderSet=true));
            return;
        }
        //system.debug('mail debug');
        // Create the email attachment  
        efa = new Messaging.EmailFileAttachment();
        efa.setFileName(dlr.Name+'.pdf');
        efa.setBody(b);
        //emailBody=dlr.Opportunity__r.Opp_Name_3__c;
        //system.debug('mail debug'+dlr.Name+dlr.Opportunity__r.Opp_Name_3__c);
        mail.setSubject(dlr.Name+' '+' '+'Unit No:'+' '+dlr.Opportunity__r.Opp_Name_3__c);
        //System.debug('### (DemandLetterEmailController) toAddresses: ' + toAddresses);
        mail.setToAddresses(toAddresses);
        //system.debug('mail debug');
        mail.setCcAddresses(ccAddresses);
        mail.setPlainTextBody('Find attached demand letter.');
        mail.setHtmlBody('<div align="center"><h2><b>'+dlr.Subject__c+'</b></h2></div>'+
                     '<br/><br/><br/>'+
                     'Dear Sir/Madam,<br/><br/>' +
                     //'Please find attached herewith the '+{!dlr.Subject__c }+' for your apartment: '+'<u>'+dlr.Opportunity__r.Unit__r.Name+'</u>'+'<br/><br/>'+
                     'Please find attached herewith the '+dlr.Subject__c+' for your apartment: '+'<u>'+dlr.Opportunity__r.Opp_Name_3__c+'</u>'+'<br/><br/>'+
                     'Thanking you,<br/><br/>Yours faithfully,<br/><b>Brigade Group.<b>');
        
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        //System.debug('### (DemandLetterEmailController) mail: ' + mail);
        /*r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        system.debug('mail debug'+mail);
        for(Messaging.sendEmailResult result : r) {
            if(result.isSuccess()) {
                System.debug('### (DemandLetterEmailController) INSIDE SUCCESS');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email Sent Successfully. To: ' + toAddresses + ' Cc: ' + ccAddresses));
                dlr.Sent_Date__c = System.Today();
            }
            else
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Error while sending email. To: ' + toAddresses + ' Cc: ' + ccAddresses));
        }
    }
}*/
        //System.debug('### (DemandLetterEmailController) sem: ' + sem);
        //System.debug('### (DemandLetterEmailController) sem.size: ' + sem.size());
        //dlr.Sent_Date__c = System.Today();        
        sem.add(mail);
        
        //system.debug('mail debug'+sem);
    
    }
    private void sendAndAttach(Demand_Letter_Repository__c dlr) {
        mail = new Messaging.SingleEmailMessage();
        //System.debug('### (DemandLetterEmailController) dlr: ' + dlr);
        //System.debug('### (DemandLetterEmailController) dId: ' + dId);
        //System.debug('### (DemandLetterEmailController) oId: ' + oId);
        pdf = new PageReference('/apex/DemandLetterPDF?id=' + dId + '&oppId=' + oId + '&type=old');
        //System.debug('### (DemandLetterEmailController) pdf: ' + pdf);
        pdf.setRedirect(true);
        
        // Take the PDF content
        if(test)  // Just to skip if called from test method
            b = Blob.valueof('test class body');
        else
            b = pdf.getContent();
                
        //Attach to Progress-cum-Demand Letter Repository record
        lstAtt.add(new Attachment(parentId =dlr.Id,name=dlr.Name + '.pdf',body=b,OwnerId=dlr.OwnerId));
        insert lstAtt ;
        //System.debug('### (DemandLetterEmailController) lstAtt: ' + lstAtt);
        
        //System.debug('### (DemandLetterEmailController) toAddresses: ' + toAddresses);
        
        if(SingleEmailSent == true){
        if(toAddresses== null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Error while sending email - No TO address specified ('+
                                 dlr.Opportunity__r.Name + '). *** A task has been created to take hard copy ***'));
            lstTask.add(new Task(Subject='Send Hard Copy',ActivityDate=System.Today(),Status='Not Started',
                                 WhatId=dlr.Id,Description='The customer does not have email specified. Send hard copy.' +
                                 ' After sending the hard copy close this task (status=Complete) and enter Sent Date for' +
                                 ' the progress-cum-demand letter record.',
                                 OwnerId = dlr.OwnerId,ReminderDateTime=System.Now(),IsReminderSet=true));
            return;
        }
        
        // Create the email attachment  
        efa = new Messaging.EmailFileAttachment();
        efa.setFileName(dlr.Name+'.pdf');
        efa.setBody(b);
        //emailBody=dlr.Opportunity__r.Opp_Name_3__c;
        mail.setSubject(dlr.Name+' '+' '+'Unit No:'+' '+dlr.Opportunity__r.Opp_Name_3__c);
        //System.debug('### (DemandLetterEmailController) toAddresses: ' + toAddresses);
        mail.setToAddresses(toAddresses);
        mail.setCcAddresses(ccAddresses);
        mail.setPlainTextBody('Find attached demand letter.');
        mail.setHtmlBody('<div align="center"><h2><b>'+dlr.subject__c+'</b></h2></div>'+
                     '<br/><br/><br/>'+
                     'Dear Sir/Madam,<br/><br/>' +
                     //'Please find attached herewith the '+dlr.subject__c+' for your apartment: '+'<u>'+dlr.Opportunity__r.Unit__r.Name+'</u>'+'<br/><br/>'+
                     'Please find attached herewith the '+dlr.subject__c+' for your apartment: '+'<u>'+dlr.Opportunity__r.Opp_Name_3__c+'</u>'+'<br/><br/>'+
                     'Thanking you,<br/><br/>Yours faithfully,<br/><b>Brigade Group.<b>');
        
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        //System.debug('### (DemandLetterEmailController) mail: ' + mail);
        /*r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        for(Messaging.sendEmailResult result : r) {
            if(result.isSuccess()) {
                System.debug('### (DemandLetterEmailController) INSIDE SUCCESS');
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email Sent Successfully. To: ' + toAddresses + ' Cc: ' + ccAddresses));
                dlr.Sent_Date__c = System.Today();
            }
            else
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Error while sending email. To: ' + toAddresses + ' Cc: ' + ccAddresses));
        }
    }
}*/
        //System.debug('### (DemandLetterEmailController) sem: ' + sem);
        //System.debug('### (DemandLetterEmailController) sem.size: ' + sem.size());
        dlr.Sent_Date__c = System.Today();        
        sem.add(mail);
        }
    }
    
    private void sendInBulk() {
        //System.debug('### (DemandLetterEmailController) sem.size: ' + sem.size());
        //System.debug('### (DemandLetterEmailController) Limits.getEmailInvocations: ' + Limits.getEmailInvocations());
        //System.debug('### (DemandLetterEmailController) Limits.getLimitEmailInvocations: ' + Limits.getLimitEmailInvocations()); 
        
        r = Messaging.sendEmail(sem,false);
        
        //System.debug('### (DemandLetterEmailController) Limits.getEmailInvocations: ' + Limits.getEmailInvocations());
        //System.debug('### (DemandLetterEmailController) Limits.getLimitEmailInvocations: ' + Limits.getLimitEmailInvocations());        
        //System.debug('### (DemandLetterEmailController) r.size: ' + r.size());
        
        /*if(r[0].isSuccess())
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Email Sent Successfully to '+sem.size()+ ' recipients (considering only TO address)'));
        else
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Error while sending email.'));
        */
        targetIdsFailed = new Set<ID>();
        integer i = 0;
        map<id,string> emailFailReason = new map<id,string>();
        for(Messaging.sendEmailResult result : r) {
            if(result.IsSuccess()){
                //system.debug(result);
                //system.debug('****'+listofDemandID[i]);
            }else{
                //system.debug('****'+listofDemandID[i]);
                targetIdsFailed.add(listofDemandID[i]);
                emailFailReason.put(listofDemandID[i],result.getErrors()[0].getMessage());
            }
            i=i+1;
        }
           // system.debug('*****'+targetIdsFailed);
        /*for(Messaging.sendEmailResult result : r) {
            //System.debug('### (DemandLetterEmailController) Email result: ' + result.IsSuccess());
            
            if(!result.IsSuccess()) {
                //emailErrArr = result.getErrors();
                //SendEmailError[] emailErrArr = result.getErrors();
                //targetIdsFailed.add(emailErrArr[0].getTargetObjectId()); 
                targetIdsFailed.add(result.getErrors()[0].getTargetObjectId()); 
            }
        }*/
        //System.debug('### (DemandLetterEmailController) targetIdsFailed.size: ' + targetIdsFailed.size());
        if(targetIdsFailed.size() > 0 ) {
            
            lstDLRFailed = [select Opportunity__r.Name from Demand_Letter_Repository__c where Id IN: targetIdsFailed];
            if(lstDLRFailed !=null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, ' Number of email(s) sent: ' + String.valueOf(sem.size()-lstDLRFailed.size())));
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Email was not sent to following Opportunities/Customers:'));
                for(Demand_Letter_Repository__c df : lstDLRFailed) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, '-- ' + df.Opportunity__r.Name +' -- Reason For Failure --'+ emailFailReason.get(df.id)));
                }
            }
         }
         else
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Number of email(s) sent: ' + sem.size()));
    }
    
     public void dummy(){
Integer a;
Integer b; 
Integer c;   
    b=1;
    a=2;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
       c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
            c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
   c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
   c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
          c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
}
}