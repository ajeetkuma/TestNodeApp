/**  Description    :   This class is used for creating records on Master Payment Schedule Object
*    Created By     :   Shikha(Extentor Tquila)
*    Created Date   :   01/09/2015
*    Version        :   v1.0
*   
**/
public class TriggerHandlerForDemand_Letter_SMS {
        
        
    public void sendSmsToContacts(List < Demand_Letter_Repository__c > demandLetterSms) {
    
        try{
        List < smagicinteract__smsmagic__c > smsObjects = new List < smagicinteract__smsmagic__c > ();
        String templateText;
        
        //Sms magic template
        smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = : 'Demand Letter SMS'
        limit 1];
        
        //SMS magic starting
        templateText = tpltext.smagicinteract__Text__c;

        //Re-render template text
        String senderId = 'sms magic';
        String extraFieldText = '';
        List < String > fields;
        List < sObject > sObjects;
        List < String > args;
        String query = '';
        string userId = UserInfo.getUserId();
        string orgId = UserInfo.getOrganizationId();
        smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
    
        // get field values for Contact/Leads/Cases/custom object
        List < Demand_Letter_Repository__c > recordIds = new List < Demand_Letter_Repository__c > ();
        if (demandLetterSms.size() > 0) {
            for (Demand_Letter_Repository__c s: demandLetterSms) {
                recordIds.add(s);
            }
        }
    
        String objectType = 'Demand_Letter_Repository__c';
        String NameField = 'Contact_Name__c';
        fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
        for (string x: fields) {
            if (x.equalsIgnoreCase('Contact_Name__c')) continue;
            if (!extraFieldText.contains(x)) extraFieldText = extraFieldText + ', ' + x;
        }
        extraFieldText = String.escapeSingleQuotes(extraFieldText);
        args = new List < String > {};
        args.add(extraFieldText);
        args.add(objectType);
        query = 'select id, ' + NameField + '{0} from {1} where id in :recordIds';
        query = String.format(query, args);
        sObjects = Database.query(query);
        if (sObjects.size() > 0) {
            TEngine.getFieldMap(sObjects[0]);
        }
        
        //send SMS  
        integer count = 0;
        for (Demand_Letter_Repository__c deLetter: demandLetterSms) {
            
                System.debug(':::Inside loop:::::');
                for (sObject c: sObjects) {
                    if (String.valueOf(c.get('Id')) == deLetter.Id) {
                        
                        if(!deLetter.Plant_DND__c){
                        	
                            String name = String.valueOf(c.get('Contact_Name__c'));
                            String mobilephone = deLetter.Mobile_Number__c;
                            String smsText = TEngine.getReplacedTextForObject(c, 0);
                            smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
                            smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
                            smsObj.smagicinteract__Name__c = name;
                            smsObj.smagicinteract__ObjectType__c = 'Demand_Letter_Repository__c'; // record type
                            smsObj.smagicinteract__disableSMSOnTrigger__c = 1; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
                            smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                            smsObj.smagicinteract__senderId__c = senderId;
                            smsObj.smagicinteract__SMSText__c = smsText;
                            smsObjects.add(smsObj);
                        }
                }
            }
        }
        
         System.debug(':::Insert smsObjects::::::'+smsObjects);
         //insert smsObjects;
         String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjects);
         Database.insert(smsObjects,false);
         
        System.debug(response+':::After Insert smsObjects::::::'+smsObjects);   
        }
        catch(Exception e){
        System.debug(e);
    }
    }   

}