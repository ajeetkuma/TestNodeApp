/*Created by:Uday
    Modified by: Siva
    purpose: Mergeed two triggers logic into one trigger
            In paymnet Scheduled object,wher ever paymnet receieved date update send a sms
            

*/

trigger SendSMSUpdate on Payment_Schedule__c (after insert,after update) {

    //Variable Declaration
    List<Id> paymentscheduleIds = new List<Id>();
    List<Id> salesorderitemid = new List<Id>();
    List<id> accid = new List<id>();
    List<Id> AccountIds = new List<Id>();
    List<id> paymentscheduleid= new List<id>();
    List<smagicinteract__smsMagic__c> smsObjects = new List<smagicinteract__smsMagic__c >();
    Map<id,Payment_Schedule__c >  newcpPaymentList =Trigger.newMap;    
    Map<id,Payment_Schedule__c >  oldcpPaymentList = Trigger.oldMap;
    list<contact> conList=new list<contact>();
    list<opportunity> oppList=new list<opportunity>();
    Payment_Schedule__c ps=new Payment_Schedule__c ();
    List<String> paymentIds = new List<String>();
    List<String> paymentIds1 = new List<String>();
    
    //Payment schedule opportunity records adding
     for(Payment_Schedule__c paymentschedule:Trigger.New){
        paymentscheduleIds.add(paymentschedule.Opportunity__c);
        
    }
    try{
     //checking the data in opportunity data base paymentschedules records.
     oppList=[SELECT id,accountid,account.parentId,date__c from opportunity where id=:paymentscheduleIds  ];
     
     //parent account Ids
     for(Opportunity opp:oppList){
         AccountIds.add(opp.accountId);
     }
     //system.assertEquals(AccountIds,null);
     
     
     //contact data base checking the opportunity records includeing contact records.
     conList=[SELECT id,accountid,name,lastname,Birthdate,Email,Wedding_Anniversary__c,MobilePhone,Income_Tax_PAN_GIR_No__c,Company__c,
                           Designation__c,Educational_Qualification__c,Profession__c,
                           Industry__c from contact where accountid In:AccountIds and Contact_Type__c='First Applicant'];
    
     
     //Adding the paymentschedule map data check the ids
     if(trigger.isUpdate){
         for(Payment_Schedule__c paymentschedule:Trigger.New){
             Payment_Schedule__c oldpayment = trigger.oldmap.get(paymentschedule.Id);
             if(oldpayment.Payment_Received_Date__c != paymentschedule.Payment_Received_Date__c && oldpayment.Payment_Received_Date__c==null) {
                 for(opportunity opp:oppList){
                     if(opp.Id == paymentschedule.Opportunity__c){
                         for(Contact con:conList) {
                             if(con.AccountId == opp.accountId) {                     
                                 paymentIds.add(paymentschedule.Id);
                                 system.debug('@@@@@@@@@@@@@1@@@@@@@@@@@@@@@@'+paymentIds);
                             }   
                         }
                     }
                  }
              }
          }
      }
      if(trigger.isInsert){
          for(Payment_Schedule__c paymentschedule:Trigger.New){
              if(paymentschedule.Payment_Received_Date__c!=null && paymentschedule.Payment_Status__c=='C') {
                 for(opportunity opp:oppList){
                     if(opp.Id == paymentschedule.Opportunity__c){
                         for(Contact con:conList) {
                             if(con.AccountId == opp.accountId) {                     
                                 paymentIds.add(paymentschedule.Id);
                                 system.debug('@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@'+paymentIds);
                             }   
                         }
                     }
                  }
              }
          }
      }
     //Adding the paymentschedule map data check the ids
     if(trigger.isUpdate){
         for(Payment_Schedule__c paymentschedule:Trigger.New){
             Payment_Schedule__c oldpayment = trigger.oldmap.get(paymentschedule.Id);
             if(oldpayment.SendSms__c != paymentschedule.SendSms__c && oldpayment.SendSms__c==false) {                 
                 for(opportunity opp:oppList){
                     if(opp.Id == paymentschedule.Opportunity__c){
                         for(Contact con:conList) {
                             if(con.AccountId == opp.accountId) {                     
                                 paymentIds1.add(paymentschedule.Id);
                                 system.debug('###############################'+paymentIds1);
                             }   
                         }
                     }
                  }
              }
          }
      }
      String templateText ;
      if(paymentIds.size()>0) {
     //Sms magic template
     smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c='Payment Received' limit 1]; //id ='a0rf00000006dzq'];
    //SMS magic starting
      templateText = tpltext.smagicinteract__Text__c;
     }
     else {
         //Sms magic template
         smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c='Payment Due' limit 1]; //id ='a0rf00000006dzq'];
        //SMS magic starting
          templateText = tpltext.smagicinteract__Text__c;
     }
      //Re-render template text
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';
      string userId = UserInfo.getUserId();
      string orgId = UserInfo.getOrganizationId();                         
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText); 
      // get field values for Contact/Leads/Cases/custom object
        List<String> recordIds = new List<String>();
        if(paymentIds.size()>0) {
            for(String s :paymentIds) {
                recordIds.add(s);
            }
        }
        else {
            for(String s :paymentIds1) {
                recordIds.add(s);
            }
        }       
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
        String paymentField = 'Payment_Received_Date__c';
        fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
        for(string x: fields){
            if(x.equalsIgnoreCase('Name'))
                continue;
            if(!extraFieldText.contains(x))
                extraFieldText = extraFieldText + ', '+x;
        }
        extraFieldText = String.escapeSingleQuotes(extraFieldText);
        args = new List<String>{};
        args.add(extraFieldText);
        args.add(objectType);
        query ='select id,name {0} from {1} where id in :recordIds';
        query = String.format(query, args);
        sObjects = Database.query(query);
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }

        //send sms
        for(Payment_Schedule__c paymentschedule:Trigger.New){
         for(opportunity opp:oppList){
             if(opp.Id == paymentschedule.Opportunity__c){
                 for(Contact con:conList) {
                     if(con.AccountId == opp.accountId) {                     
                          for (sObject c :sObjects){                             
                              if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                  String total = String.valueOf(c.get('Total__c'));
                                  String name = String.valueOf(c.get('name'));
                                  String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                  //String billingdate = String.valueOf(c.get('billing_date__c'));
                                  //String paymentdate = String.valueOf(c.get('Payment_Received_Date__c'));
                                  String mobilephone = con.Mobilephone;
                                  String smsText = TEngine.getReplacedTextForObject(c, 0);
                                  smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                  smsObject.smagicinteract__SenderId__c = senderId;
                                  smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                                  smsObject.smagicinteract__Name__c = name ; // records name
                                  smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c'; // record type
                                  smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                                  smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                                  smsObject.smagicinteract__SMSText__c = smsText ;
                                  smsObjects.add(smsObject);   
                              }                           
                          }    
                      }
                 }
              }
          }
      }
             }
       Catch(Exception e){
       }
      try {
          system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+smsObjects);
          insert smsObjects;                      
      }
      catch(Exception e){
           system.debug(e);             
      }     
  }