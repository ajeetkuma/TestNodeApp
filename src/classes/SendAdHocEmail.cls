/*
 Class Name : Ad-hoc Email 
 Activities : 1. Query all contacts records based on list ids received from ad-hoc sms/email page.
              2. Process all records and send email to all contacts
  Author    :Siva
  */
global class SendAdHocEmail implements Database.Batchable<sObject> {
    //global variables 
    set<String> contactIds = new set<String>();
    String query;
    //constructor
    global SendAdHocEmail(set<String> selectedContactIds){
        contactIds =  selectedContactIds;
        query ='select id,name,Email_text__c,Email_Subject__c,Email from contact where id in ';
        query= query+ convertSetOfIdToString(selectedContactIds);
        //system.assertEquals(query,null);  
          
    } 
    //Batch Start method
    global Database.queryLocator start(Database.BatchableContext BC) {
        try{
        return Database.getQueryLocator(query);
       }
       Catch(Exception e){
           return null;
       }
    }
    
    //Batch execute method
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        EmailTemplate emailtemp = [select id, name from EmailTemplate where name ='Ad-Hoc Email template' limit 1]; 
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        for(sObject stg:scope){
            contact con = (contact)stg;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {con.Email};
            string messageBody ;
            //String emailSub =emailSubject;
            mail.setTemplateId(emailtemp.Id);
            //mail.setSubject(emailSub);
            mail.setTargetObjectId(con.Id);
            mail.setToAddresses(toAddresses);
            mail.setHtmlBody(messageBody);
            mail.saveAsActivity=false;
            mails.add(mail);  
         }
         try {
             Messaging.sendEmail(mails); 
         }
         catch(Exception e){
             String err = String.valueOf(e);
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
             ApexPages.addMessage(myMsg);
         }
    
    }
    
    //Batch finish method
    global void finish(Database.BatchableContext BC) {
    
    }
    private String convertSetOfIdToString(Set<String> selectedRecordsId){
        String newSetStr = '' ;
        for(String str : selectedRecordsId) {
            newSetStr += '\'' + str + '\',';
        }
        newSetStr = newSetStr.lastIndexOf(',') > 0 ? '(' + newSetStr.substring(0,newSetStr.lastIndexOf(',')) + ')' : newSetStr;
        System.debug('***** convertSetOfIdToString()- newSetStr: ' + newSetStr);   
        return newSetStr;
    }
}