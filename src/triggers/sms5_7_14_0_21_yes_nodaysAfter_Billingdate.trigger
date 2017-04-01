trigger sms5_7_14_0_21_yes_nodaysAfter_Billingdate on Payment_Schedule__c (after update) {


     set<ID> PaymentScheduledata=new set<ID>();
     set<ID> OpportunityDetals=new set<ID>();
     
     set<ID> Accdetails=new Set<Id>();
     list<contact> conList=new list<contact>();
     list<BG_CPprofile__c> Bgprofile=new list<BG_CPprofile__c>();
     set<ID> contactId=new set<ID>();
     set<ID> userInfo=new set<ID>();
     list<user> usr=new List<User>();
     set<ID> paymentIds7=new set<Id>();
     set<ID> paymentIds14=new set<Id>();
     set<ID> paymentIds5=new set<Id>();
     set<ID> paymentIds0=new set<Id>();
     set<ID> paymentIdsYES=new set<Id>();
     set<ID> paymentIdsNO=new set<Id>();
     set<id> oppidsonpay=new set<id>();
     // map<id,opportunity> opprecs=new map<id,opportunity>([select name from opportunity where id IN:trigger.new[0].opportunity__c]);
     List<smagicinteract__smsMagic__c> smsObjects = new List<smagicinteract__smsMagic__c >();
     
    for(Payment_Schedule__c paymentschedule:Trigger.New){
       // system.assertEquals(paymentschedule.X7_days_sms__c,null);
        PaymentScheduledata.add(paymentschedule.Opportunity__c);   
           
    }
    Map<Id,opportunity> oppList;
    if(PaymentScheduledata.size() > 0) {
    oppList=new Map<Id,opportunity>([SELECT id,name,accountid,PDC_details__c,plant__c,Plant2__r.name,account.parentId,date__c from opportunity where id IN :PaymentScheduledata]);
    }
    
    try{           
       
       for(opportunity opp:oppList.values()){                  
         Accdetails.add(opp.AccountID);      
       }   
       conList=[SELECT id,accountid,name,lastname,Birthdate,Email,Wedding_Anniversary__c,MobilePhone,Income_Tax_PAN_GIR_No__c,Company__c,
                    Designation__c,Educational_Qualification__c,Profession__c,
                    Industry__c from contact where accountid In:Accdetails and Contact_Type__c='First Applicant'];           
       for(contact cc:conList) {        
         contactId.add(cc.ID);          
       }                 
       Bgprofile=[SELECT Id,User__c,Contact__c  from BG_CPprofile__c where Contact__c IN:contactId];
       for(BG_CPprofile__c bgpro:Bgprofile){       
         userInfo.add(bgpro.User__c ); 
       }       
     usr=[SELECT Email,mobilephone,name FROM User where id IN :userInfo];
      
  for(Payment_Schedule__c paymentschedule:Trigger.New){    
    
   Payment_Schedule__c oldDemand = trigger.oldmap.get(paymentschedule.Id);           
    if(paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A' ) {        
        if(oldDemand.X7_days_sms__c!=paymentschedule.X7_days_sms__c && paymentschedule.Billing_Date__c !=null &&  paymentschedule.X7_days_sms__c ==true && paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A'){
          for(opportunity opp:oppList.values()){
           if(opp.Id == paymentschedule.Opportunity__c){
             for(Contact con:conList) {
               if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){                           
                            paymentIds7.add(paymentschedule.Id);                            
                            system.debug('payment ids'+paymentIds7);
                            system.debug('77777777777777777777777777777');   
                                         
                          }
                        }                                    
                    }
                  }                                     
                }                                     
              }
            }
          }
       }   
        
       
      if(oldDemand.X14_days_sms__c!=paymentschedule.X14_days_sms__c&& paymentschedule.Billing_Date__c !=null && paymentschedule.X14_days_sms__c==true && paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A'){
          for(opportunity opp:oppList.values()){
           if(opp.Id == paymentschedule.Opportunity__c){
             for(Contact con:conList) {
               if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){                          
                            paymentIds14.add(paymentschedule.Id);                              
                        }
                      }                   
                    }
                  }                                     
                }                                     
              }
            }
          }
        }   
                
     if(oldDemand.SendSms__c !=paymentschedule.SendSms__c && paymentschedule.Billing_Date__c !=null && paymentschedule.SendSms__c ==true && paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A'){
        for(opportunity opp:oppList.values()){
           if(opp.Id == paymentschedule.Opportunity__c){
             for(Contact con:conList) {
               if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){ 
                             paymentIds5.add(paymentschedule.Id); 
                            system.debug('55555555555555555');
                            
                           }
                         }                   
                       }
                     }                                     
                   }                                     
                }
              }
            }
          }   
      
          
      if( paymentschedule.Billing_Date__c !=null && paymentschedule.On_the_day_sms__c==true && oldDemand.On_the_day_sms__c!=paymentschedule.On_the_day_sms__c && paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A'){
         for(opportunity opp:oppList.values()){
           if(opp.Id == paymentschedule.Opportunity__c){
             for(Contact con:conList) {
               if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){ 
                            paymentIds0.add(paymentschedule.Id);
                            system.debug('000000000000000000000000000000');
                            
                           
                                                            
                         }
                      }                   
                    }
                  }                                     
                }                                     
              }
            }
          }
        }   
                       
        
     if(oldDemand.X21_Days_sms__c!=paymentschedule.X21_Days_sms__c && paymentschedule.X21_Days_sms__c==true && paymentschedule.Billing_Date__c !=null  && paymentschedule.Payment_Received_Date__c==null && paymentschedule.Payment_Status__c=='A'){
      system.debug('YYYYYYYYYYYYYYYYYYYYY1');
       for(opportunity opp:oppList.values()){
        if(opp.Id == paymentschedule.Opportunity__c){
         system.debug('Pdc Details'+opp.PDC_details__c);
           if(opp.PDC_details__c=='YES'){           
             for(Contact con:conList) {
               if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){ 
                           paymentIdsYES.add(paymentschedule.Id); 
                            system.debug('YYYYYYYYYYYYYYYYYYYYY2');                            
                           
                         }
                      }                   
                    }
                  }                                     
                }                                     
              }
          }
            
          else{
             if(opp.PDC_details__c=='NO'){
               system.debug('Pdc Details no'+opp.PDC_details__c);
                for(Contact con:conList) {
                 if(con.AccountId == opp.accountId) {
                  for(BG_CPprofile__c ngpro:Bgprofile ){ 
                    if(ngpro.Contact__c == con.ID){
                       for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){ 
                            paymentIdsNO.add(paymentschedule.Id); 
                            system.debug('NNNNNNNNNNNNNNN');
                       }
                     }
                    }
                  } 
                }  
              }  
            }
           }
           
           
          }
        }
      }   
        
        
        /* Receveing Date Not Null if condition */               
      }     
    }     
    
    
    
    if( paymentIds7.size()>0){     
     system.debug('sms magiccccccccccccccccccc7');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='7 days after billing date' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIds7.size()>0) {
            for(String s :paymentIds7) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
    
    
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            system.debug('size7777777777777777777777777777777777777');                         
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);                            
                            String[] toAddresses = new String[] {uu.email};                            
                            //String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};                            
                            system.debug('paymnet Schedlue Opp'+paymentschedule.Opportunity__c);
                            system.debug('Opportunity Plant name'+opplist.get(paymentschedule.Opportunity__c).Plant__c);                        
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+' is over-due by 7 days.Kindly facilitate payment to avoid penalties.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+
                                                +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                         
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment over-due by 7 days!');
                              
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;                                                       
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });  
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c = mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
       
      /* 7days   Close */  
      
      
    if(paymentIds14.size()>0){    
     system.debug('sms magiccccccccccccccccccc14');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='14 days after billing date' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIds14.size()>0) {
            for(String s :paymentIds14) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
    
    
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            system.debug('1111111111144444444444');
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);
                            //  String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};
                            String[] toAddresses = new String[] {uu.email}; 
                                                        
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+' is  over-due by 14 days.The delay accrues interest at 18% p.a. Kindly facilitate payment to avoid penalties.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+
                                                +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                          
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment over-due by 14 days!');
                                                        
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c =mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
      
      
      /* 14 Days close */
      
    if(paymentIds5.size()>0){    
     system.debug('sms magiccccccccccccccccccc 5 days');     
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);
                            //  String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};      
                            String[] toAddresses = new String[] {uu.email};                     
                         
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+'  is due on &nbsp;'+paymentschedule.billing_date__c+'&nbsp;'+'Kindly facilitate payment to avoid penalties.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+                                              
                                                 +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                                                                          
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment date approaching');
                                                    
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message }); 
                                                                                 
                            
                                 }
                               
                              }
                            
                           }                         
                         
                        }
                       
                       
                     }
                      
                   }
                    
                }
                 
             }             
              
          }
          
       }      
     
      /* 5 days close send sms */
      
  /*    
       if(paymentIds5.size()>0){    
     system.debug('sms magiccccccccccccccccccc 5 days');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='5 days before billing date' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIds5.size()>0) {
            for(String s :paymentIds5) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
    
    
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);
                            //  String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};      
                            String[] toAddresses = new String[] {uu.email};                     
                         
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+'  is due on &nbsp;'+paymentschedule.billing_date__c+'&nbsp;'+'Kindly facilitate payment to avoid penalties.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+                                              
                                                 +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                                                                          
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment date approaching');
                                                    
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message }); 
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c = mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
      
     */ 
      /* 5 days close */   
      
      
    if(paymentIds0.size()>0){    
     system.debug('sms magicccccccccccccccccccOn the days sms');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='Same day on billing date' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIds0.size()>0) {
            for(String s :paymentIds0) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
    
    
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);
                            //String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};
                            String[] toAddresses = new String[] {uu.email}; 
                            system.debug('Payment oppId'+paymentschedule.Opportunity__c);
                            system.debug('opppppppppppppppppppplant name'+opplist.get(paymentschedule.Opportunity__c).Plant__c);                        
                          
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+'  is due today.Kindly facilitate payment to avoid penalties.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+                                                +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+': Payment date today!'); 
     
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });                                                       
                           
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c = mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
      
            
      /* on the days sms */
      
      
   if(paymentIdsYES.size()>0){    
     system.debug('sms magiccccccccccccccccccc21yes');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='21 days after billing date YES' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIdsYES.size()>0) {
            for(String s :paymentIdsYES) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
    
    
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                           Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                           system.debug('email user'+uu.email);
                          // String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};
                           String[] toAddresses = new String[] {uu.email}; 
                          
                           string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+' is  over-due by 21 days.The delay accrues interest at 18% p.a. Kindly facilitate payment to avoid penalties and encashment of the PDC for the installment given by you at the time of booking.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+
                                                +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                         
                           message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment over-due by 21 days!');
 
                           
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false;
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c = mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
      
      
      
      /* 21 days yes */
      
      
    if(paymentIdsNO.size()>0){    
     system.debug('sms magiccccccccccccccccccc21no');        
      String templateText ;
      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c 
                   where smagicinteract__Name__c='21 days after billing date NO' limit 1]; //id ='a0rf00000006dzq'];   
                     
      system.debug('tpltext '+tpltext.Id);     
      templateText = tpltext.smagicinteract__Text__c;      
      String senderId = 'sms magic';
      String extraFieldText = '';
      List<String> fields;
      List<sObject> sObjects;
      List<String> args ;
      String query = '';                             
      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
       List<String> recordIds = new List<String>();
        if(paymentIdsNO.size()>0) {
            for(String s :paymentIdsNO) {
                recordIds.add(s);
            }
        }       
        
        String objectType = 'Payment_Schedule__c';
        String TotalField = 'Total__c';
        String unitnumberField = 'Unit_Number__c';
        String billingField = 'billing_date__c';
       //  String paymentField = 'Payment_Received_Date__c';
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
        system.debug('query Result'+query );       
        query = String.format(query, args);
        sObjects = Database.query(query);        
         system.debug('sObjects '+sObjects );
        if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }        
        
    for(Payment_Schedule__c paymentschedule:Trigger.New){ 
     for(opportunity opp:oppList.values()){
       if(opp.Id == paymentschedule.Opportunity__c){
         for(Contact con:conList) {
           if(con.AccountId == opp.accountId) {
               for(BG_CPprofile__c ngpro:Bgprofile ){ 
                  if(ngpro.Contact__c == con.ID){
                     for(user uu:usr){  
                         if(uu.ID==ngpro.User__c){    
                         
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            system.debug('email user'+uu.email);
                            //String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};   
                            String[] toAddresses = new String[] {uu.email};                         
                           
                           //  string messageBody='<html><body>Dear Admin, &nbsp;<br/><br/> Billing Date:&nbsp;'+paymentschedule.Billing_Date__c+'<br/><br/>Opportunity:&nbsp;'+opplist.get(paymentschedule.Opportunity__c).name+'<br/><br/>Amount:'+paymentschedule.Bill_Value__c+'<br/><br/>Thanks & Regards,'+'<br/>Portal Admin';
                           //  message.setSubject('NO on the 21 Days SMS');
                            
                            string messageBody='<html><body>Dear&nbsp;'+paymentschedule.First_Applicant_name__c+','+'<br/><br/>Greetings from Brigade Group!'+'<br/><br/>This is to inform you that your payment of installment for:&nbsp;'+paymentschedule.unit_number__c+'&nbsp;Rs.&nbsp;'+paymentschedule.Total__c+' is  over-due by 21 days.The delay accrues interest at 18% p.a. Kindly facilitate payment to avoid penalties and a notice of cancellation as per Agreement.'+'<br/><br/>You would have also received a Demand-cum-Progress letter from our Customer Support representative. For any payment related queries, please get in touch with our Customer Support representative.'+'<br/><br/>Thanks & Regards,'+'<br/>-Team Brigade'+
                                                +'<br/><br/><br/>Disclaimer: This is an auto-generated email. Please do not reply. A payment takes 3-4 working days to get reflected in our records. Please ignore if already paid.';
                                          
                            message.setSubject(opplist.get(paymentschedule.Opportunity__c).Plant__c+':Payment over-due by 21 days!');
 
                            message.setToAddresses(toAddresses);
                            message.setHtmlBody(messageBody);
                            message.saveAsActivity=false; 
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message }); 
                                                                                 
                            for (sObject c :sObjects){                             
                                    if(String.valueOf(c.get('Id')) == paymentschedule.Id) {
                                        system.debug('trueeeeeeeeeeeeeeeeeee');
                                        String total = String.valueOf(c.get('Total__c'));                                       
                                        system.debug('total'+total);
                                        String name = String.valueOf(c.get('name'));
                                        system.debug('Name------'+Name);
                                        String unitnumber = String.valueOf(c.get('Unit_Number__c'));
                                        system.debug('unitnumber '+unitnumber );
                                        //String billingdate = String.valueOf(c.get('billing_date__c'));
                                        //system.debug('billingdate'+billingdate );
                                        String mobilephone = uu.mobilePhone;
                                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                        smsObject.smagicinteract__SenderId__c = senderId;
                                        system.debug('Mobile Number'+uu.mobilePhone);
                                        smsObject.smagicinteract__PhoneNumber__c = mobilephone  ;
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
                    
                }
                 
             }             
              
          }
          
       }
      
      
      
      
      
      /* 21 days NO */
      
        
   }
        
     
    catch(Exception e){
           system.debug(e);             
      }  
      try {
          system.debug('************************'+smsObjects);
          insert smsObjects;   
          
         // system.debug('smsObjectssmsObjects..................'+smsObjects.id);                   
      }
      catch(Exception e){
           system.debug(e);             
      }     

}