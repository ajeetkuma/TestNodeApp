public class SendSMStoALLContact implements Database.Batchable<Sobject>,database.stateful,database.allowsCallouts{
    
    public string plantId ;
    public string uniqueID ;
    public SendSMStoALLContact(string plantId){
        this.plantId = plantId ;
        uniqueID = string.valueof(system.now())+'--paymentSMS' ;
    }
    public Database.QueryLocator start(Database.BatchableContext bc ){
        
        string query = 'select Unit_Name__c , (select Total__c from Payment_Schedules__r where Status__c = \'Due\' or Status__c = \'Overdue\') from opportunity where StageName = \'Allotment\' and Sale_Order_Date__c != null and Unit__c != null and Sale_Order_No__c != null and	Unit__r.Plant__c = :plantId ' ;
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc , list<opportunity> oppr){
        
        map<id,decimal> opportunityID_totalMap = new map<id,decimal>();
        map<id,string> opportunityID_UnitMap = new map<id,string>();
        for(opportunity opp : oppr){
            decimal total = 0;
            for(Payment_Schedule__c paySch : opp.Payment_Schedules__r ){
                total += paySch.Total__c ;
            }
            if(total > 0){
                opportunityID_totalMap.put(opp.id,total);
                opportunityID_UnitMap.put(opp.id,opp.Unit_Name__c);
            }
        }
        
        List<OpportunityContactRole> oppConRoleList = new list<OpportunityContactRole>();
        oppConRoleList = [select ContactId , OpportunityId from OpportunityContactRole where OpportunityId IN : opportunityID_totalMap.keySet()];
        
        map<id,id> oppConMap = new map<id,id>();
        for(OpportunityContactRole oppCon : oppConRoleList){
            oppConMap.put(oppCon.ContactId, oppCon.OpportunityId);
        }
        
        list<contact> contactList = new list<contact>();
        contactList = [select  MobilePhone from contact where id IN : oppConMap.keySet() and smagicinteract__SMSOptOut__c = false];
        
        list<SMS_Sending_Object__c> SMSObjList = new list<SMS_Sending_Object__c>();
        for(contact con : contactList){
            string oppID = oppConMap.get(con.id) ;
            SMS_Sending_Object__c SMSObj = new SMS_Sending_Object__c();
            SMSObj.Mobile_No__c = con.MobilePhone ;
            SMSObj.Record_ID__c = con.id ;
            SMSObj.Related_To__c = oppID ;
            SMSObj.Record_Type__c = 'contact';
            SMSObj.Unique_Identifier__c = uniqueID ;
            SMSObj.SMS_Merge_Field_1__c = opportunityID_UnitMap.get(oppID);
            SMSObj.SMS_Merge_Field_2__c = string.valueof(opportunityID_totalMap.get(oppID));
            SMSObjList.add(SMSObj);
        }
        
        if(SMSObjList.size() > 0){
            database.insert(SMSObjList,false);
        }
    }
    
    public void finish(Database.BatchableContext bc){
        
         List<smagicinteract__smsmagic__c> smsObjectsToInsert    =  SendSMStoNEWLead(uniqueID,'contact','PaymentSMSToContact','SMS_Sending_Object__c','Mobile_No__c',1);
        
        if(!Test.isRunningTest()){
        String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
        }   
        
        if(smsObjectsToInsert.size() > 0){
            Database.insert(smsObjectsToInsert,false);
        }
        
    }
    
    
    public List<smagicinteract__smsMagic__c> SendSMStoNEWLead(string uniqueID,string recordType ,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
        List<smagicinteract__smsmagic__c> smsObjects = new List<smagicinteract__smsmagic__c> ();
        
        try{
            
            smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = :templateName limit 1];

            //SMS magic starting
            String templateText = tpltext.smagicinteract__Text__c;

            //Re-render template text           
            String extraFieldText   = '';
            List <String> fields;
            List <sObject> sObjects;
            List <String> args;
            String query = '';
            
            smagicinteract.TemplateEngine TEngine   = new smagicinteract.TemplateEngine(templateText);
            
            String objectType   = objName;
            String MobileNo    = conAPIName;
            
            fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
            for (string x: fields) {
                if (x.equalsIgnoreCase(conAPIName)) continue;
                if (!extraFieldText.contains(x)) extraFieldText = extraFieldText + ', ' + x;
            }
            
            extraFieldText = String.escapeSingleQuotes(extraFieldText);
            args = new List < String > {};
            args.add(extraFieldText);
            args.add(objectType);
            
            query = 'select id, ' + MobileNo + '{0} from {1} where Unique_Identifier__c = :uniqueID and Record_Type__c = :recordType and '+MobileNo+' != null';
            query = String.format(query, args);
            system.debug(query);
            sObjects = Database.query(query);
            system.debug(sObjects);
            if (sObjects.size() > 0) {
                TEngine.getFieldMap(sObjects[0]);
            }
            for (sObject c: sObjects) {
                String name         = String.valueOf(c.get('id'));
                String smsText      = TEngine.getReplacedTextForObject(c, 0);                           
                smsObjects.add(Utility_Class.getSMSMagicObj(name,c.get('Mobile_No__c')+'',ObjName,'Brigade',smsText,singleOrBatch));
            
            }
               
        }catch(Exception ex){
            system.debug('Exception ::'+ex.getMessage());
        }
        return  smsObjects;                 
    }



}