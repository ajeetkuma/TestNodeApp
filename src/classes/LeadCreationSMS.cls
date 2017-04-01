public class LeadCreationSMS {
    
    @future(callout=true)
    public static void sendSMSToLead(list<id> leadList){
        
        List<smagicinteract__smsmagic__c> smsObjectsToInsert	=  SendSMStoNEWLead(leadList,'LeadCreation','LEAD','mobilephone',1);
        
        if(!Test.isRunningTest()){
        String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
        }	
         	if(smsObjectsToInsert.size() > 0){
         		Database.insert(smsObjectsToInsert,false);
         	}
    }
    
     public static List<smagicinteract__smsMagic__c> SendSMStoNEWLead(List<id> leadList,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
        List<smagicinteract__smsmagic__c> smsObjects = new List<smagicinteract__smsmagic__c> ();
        
        try{
            
            smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = :templateName limit 1];

            String templateText = tpltext.smagicinteract__Text__c;

            
            String extraFieldText   = '';
            List <String> fields;
            List <sObject> sObjects;
            List <String> args;
            String query = '';
            
            smagicinteract.TemplateEngine TEngine   = new smagicinteract.TemplateEngine(templateText);

            String objectType   = objName;
            String NameField    = conAPIName;
            
            fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
            for (string x: fields) {
                if (x.equalsIgnoreCase(conAPIName)) continue;
                if (!extraFieldText.contains(x)) extraFieldText = extraFieldText + ', ' + x;
            }
            
            extraFieldText = String.escapeSingleQuotes(extraFieldText);
            args = new List < String > {};
            args.add(extraFieldText);
            args.add(objectType);
            
            query = 'select id, ' + NameField + '{0} from {1} where id in :leadList';
            query = String.format(query, args);
            system.debug(query);
            sObjects = Database.query(query);
            system.debug(sObjects);
            if (sObjects.size() > 0) {
                TEngine.getFieldMap(sObjects[0]);
            }
            for (sObject c: sObjects) {
            	String name         = String.valueOf(c.get(conAPIName));
            	String smsText      = TEngine.getReplacedTextForObject(c, 0);                           
            	smsObjects.add(Utility_Class.getSMSMagicObj(name,c.get('mobilephone')+'',ObjName,'Brigade',smsText,singleOrBatch));
            }
            
        }catch(Exception ex){
            system.debug('Exception ::'+ex.getMessage());
        }
        
        return  smsObjects;                 
    }

}