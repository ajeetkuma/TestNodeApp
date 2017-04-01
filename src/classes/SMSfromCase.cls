public with sharing class SMSfromCase {
    
    @invocableMethod(label='send SMS to case owner' Description ='SMS will be send to the case owner')
    public static void sendSMStoCaseOwner(List<id> caseIds){
        
        list<case> caseList = new list<case>();
        caseList = [select Opportunity_Name__c , casenumber , createddate, ownerid from case where id IN :caseIds and owner.type ='User' ];
        
        list<id>ownerIDs = new list<id>();
        for(case cs : caseList){
            ownerIDs.add(cs.ownerid);
        }
        map<id,user> caseOwnerDetailMap = new map<id,user>([select MobilePhone from user where id IN :ownerIDs and MobilePhone != null]);
       
        list<SMS_Sending_Object__c> SMSObjList = new list<SMS_Sending_Object__c>();
        string uniqueID = system.now()+'--caseownerSMS';
        for(case cs : caseList){
            user userDetail = caseOwnerDetailMap.get(cs.ownerId);
           
            string mobileNo ;
            if(userDetail != null){
                mobileNo = userDetail.MobilePhone ;
            
            SMS_Sending_Object__c SMSObj = new SMS_Sending_Object__c();
            SMSObj.Mobile_No__c = mobileNo;
            SMSObj.Record_ID__c = cs.id ;
            SMSObj.Related_To__c = userDetail.id ;
            SMSObj.Record_Type__c = 'case';
            SMSObj.Unique_Identifier__c = uniqueID ;
            SMSObj.SMS_Merge_Field_1__c = cs.Opportunity_Name__c;
            SMSObj.SMS_Merge_Field_2__c = cs.CaseNumber ;
            SMSObj.SMS_Merge_Field_3__c = string.valueOf((cs.CreatedDate).addDays(2).date());
            SMSObjList.add(SMSObj);
            }
        }
        
        Database.insert(SMSObjList,false); 
        SMSfromCase.sendSMS(uniqueID,'case','SendSMStoCaseOwner','SMS_Sending_Object__c','Mobile_No__c');
        
    }
    
    @future(callout = true)
    public static void sendSMS(string uniqueID ,string recordType ,string SMSTemplate,string objType,string MobileField  ){
    
     List<smagicinteract__smsmagic__c> smsObjectsToInsert    =  SendSMStoNEWLead(uniqueID,recordType,SMSTemplate,objType,MobileField,1);
        
        if(!Test.isRunningTest()){
        String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
        }   
        
        if(smsObjectsToInsert.size() > 0){
            Database.insert(smsObjectsToInsert,false);
        }
    
  }
    
     public static List<smagicinteract__smsMagic__c> SendSMStoNEWLead(string uniqueID,string recordType ,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
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