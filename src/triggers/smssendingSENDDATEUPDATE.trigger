/*

               Created by:
               modified by:
               purpose:
                       In Demand letter repository object,send date field update send a sms to contact user

*/

trigger smssendingSENDDATEUPDATE on Demand_Letter_Repository__c (before update){
   
    if(contactRecursiveHelper.smssendingSENDDATEUPDATE  == false){
    //varibale Declaration   
    List<Id> DemandletterIds = new List<Id>();
    List<Id> salesorderitemid = new List<Id>();
    List<id> accid = new List<id>();
    List<Id> AccountIds = new List<Id>();
    List<id> paymentscheduleid= new List<id>();
    List<smagicinteract__smsMagic__c> smsObjects = new List<smagicinteract__smsMagic__c >();
    list<contact> conList=new list<contact>();
    list<opportunity> oppList=new list<opportunity>();
    Demand_Letter_Repository__c ps=new Demand_Letter_Repository__c ();
    List<String> ContactIds = new List<String>();
    
    //Adding the records opportunity records to dlrositary object
     for(Demand_Letter_Repository__c lrepostry:Trigger.new){
         DemandletterIds.add(lrepostry.Opportunity__c);
     }
    
     if(DemandletterIds.size()>0){ 
      //checking the data in opportunity data base paymentschedules records.
      oppList=[SELECT id,accountid,account.parentId,date__c from opportunity where id=:DemandletterIds];
      }
     
     //parent account Ids
     for(Opportunity opp:oppList){
         AccountIds.add(opp.accountId);
     }
     
    
    if(AccountIds.size()>0){ 
     //contact data base checking the opportunity records includeing contact records.
     conList=[SELECT id,accountid,name,lastname,Birthdate,Email,Wedding_Anniversary__c,MobilePhone,Income_Tax_PAN_GIR_No__c,Company__c,
                           Designation__c,Educational_Qualification__c,Profession__c,
                           Industry__c from contact where accountid In:AccountIds and Contact_Type__c='First Applicant'];
      } 
                           
      //Adding the paymentschedule map data check the ids
     for(Demand_Letter_Repository__c lrepostry:Trigger.new){
         Demand_Letter_Repository__c oldDemand = trigger.oldmap.get(lrepostry.Id);                         
         if(oldDemand.Sent_Date__c != lrepostry.Sent_Date__c && oldDemand.Sent_Date__c==null) {          
             for(opportunity opp:oppList){
                 if(opp.Id == lrepostry.Opportunity__c){
                     for(Contact con:conList) {
                         if(con.AccountId == opp.accountId) {                     
                             ContactIds.add(con.Id);
                         }   
                     }
                 }
              }
          }
      }                     
      
      String templateText ;
     
     //Sms magic template
     smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Demand letter' limit 1]; //id ='a0rf00000006dzq'];
    //SMS magic starting
      templateText = tpltext.smagicinteract__Text__c;
     

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
        if(ContactIds.size()>0) {
            for(String s :ContactIds) {
                recordIds.add(s);
            }
        }
        String objectType = 'Contact';
        String NameField = 'Name';
        String MobilePhoneFiled = 'MobilePhone';
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
        query ='select id, '+NameField +','+MobilePhoneFiled+'{0} from {1} where id in :recordIds';
        query = String.format(query, args);
        sObjects = Database.query(query);
                if(sObjects.size()>0) {
            TEngine.getFieldMap(sObjects[0]);
        }

        //send SMS
        for(Demand_Letter_Repository__c lrepostry:Trigger.new){
             for(opportunity opp:oppList){
                 if(opp.Id == lrepostry.Opportunity__c){
                     for(Contact con:conList) {
                         if(con.AccountId == opp.accountId) {                     
                             for (sObject c :sObjects){                             
                              if(String.valueOf(c.get('Id')) == con.Id) {
                                  String name = String.valueOf(c.get('name'));                                                                    
                                  String mobilephone = con.Mobilephone;
                                  String smsText = TEngine.getReplacedTextForObject(c, 0);
                                  smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                                  smsObject.smagicinteract__SenderId__c = senderId;
                                  smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                                  smsObject.smagicinteract__Name__c = name ; // records name
                                  smsObject.smagicinteract__ObjectType__c = 'contact'; // record type
                                  smsObject.smagicinteract__disableSMSOnTrigger__c = 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
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
      try {
          if(!Test.isRunningTest()) {
            insert smsObjects; 
          }
      }
      catch(Exception e){
           system.debug(e);             
      }
      contactRecursiveHelper.smssendingSENDDATEUPDATE  =true; 
      }       
 }