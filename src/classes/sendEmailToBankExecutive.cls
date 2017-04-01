/**
* Apex Class        : sendEmailToBankExecutive
* Created by        : ETMarlabs (26-08-2016)
* Description       : This class is used to send email to bank executives tagged to plant.
*                   : Inline comments are added to get specific details.
**/
global  class sendEmailToBankExecutive{
   
   webService static String sendEmailMethod(String plantId,String Oppid,String hfiId) {
      //EmailTemplate et = [Select id from EmailTemplate where name=:'To Notify HFI' limit 1];
      
      List<Plant_Bank_exc__c> listOfexecutive = new List<Plant_Bank_exc__c>();
      List<HFI__c> hfiRec = new List<HFI__c>(); 
      List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
      String[] toEmail= new list<String>();
      //Getting the details from Opportunity which is needed for sending email 
      Opportunity opp =[SELECT id,Mail_Send_to_bank_executive__c,Project_Name__c,Unit_No__c,Area_of_Unit_Booked__c,For_ROI__c FROM Opportunity WHERE ID=:Oppid] ;
      //Getting the first applicant contact name for email template. 
      OpportunityContactRole oppcontactRole = [SELECT Id, ContactId, OpportunityId,contact.Email,contact.Name,contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =:Oppid AND IsPrimary = true LIMIT 1];
      String strbody = '';
      String strsubject = 'Customer Details for Home loan for Brigade'+ opp.Project_Name__c ;
      //Getting the list of executives which is related to opportunity's plant. 
      if(hfiId != ''){
          hfiRec = [SELECT id,Name FROM HFI__c WHERE Id =: hfiId ];
          if(hfiRec.size() > 0){
          listOfexecutive = [SELECT id,Bank_Executive__r.Email_id__c,Plant__c FROM Plant_Bank_exc__c WHERE Plant__c =: plantId AND Bank_Name__c =: hfiRec[0].Name ];
          }
      }else{
          listOfexecutive = [SELECT id,Bank_Executive__r.Email_id__c,Plant__c FROM Plant_Bank_exc__c WHERE Plant__c =: plantId ];
      }
      try{
          if(listOfexecutive.size() > 0){
            for(Plant_Bank_exc__c pbe : listOfexecutive){
                 //Getting all email ids of bank executives and store in to email id
                 toEmail.add(pbe.Bank_Executive__r.Email_id__c);     
            }
            strbody = 'Dear Executives, <br> <br> Customer is interested in a home loan for the unit booked in Brigade'+ opp.Project_Name__c + ' <br> The Details of the Property booked are as below:<br> Unit Number: '+ opp.Unit_No__c+' <br> Area of Flat : '+ opp.Area_of_Unit_Booked__c +'<br> Agreement Value :'+ opp.For_ROI__c +'<br> Customer Name:'+ oppcontactRole.contact.Name + '<br> Mobile Number :'+ oppcontactRole.contact.MobilePhone + '<br> Email ID :'+ oppcontactRole.contact.Email +'<br> <br> Request you to contact the customer for the further process. <br> <br> Thanks with regards, <br> Team Brigade CRM.';
            system.debug(toEmail+'toEmail');
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            //singleMail.setTargetObjectId(c.Id);
            
            //singleMail.setTemplateId(et.Id);
            singleMail.setSubject(strsubject);
            singleMail.setHtmlBody(strbody);
            singleMail.setSaveAsActivity(false);
            singleMail.setToAddresses(toEmail);
            singleMail.setWhatId(Oppid);
            emails.add(singleMail);
            //Savepoint sp = Database.setSavepoint();
            Messaging.sendEmail(emails);
            //Database.rollback(sp);
          }
          //Updating the checkbox to true so that it will not send the email again.
           opp.Mail_Send_to_bank_executive__c =true;
           update opp;
           // On success, return a message to the calling program.
          return 'Mail sent successfully.';
      }catch(exception e){
          return e.getMessage();
      }
      
   }
}