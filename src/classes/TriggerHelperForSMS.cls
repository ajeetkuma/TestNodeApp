/**    Description    :    This class is used for creating SMS when Task is created.
 *    Created By     :    Shikha(Extentor Tquila)
 *    Created Date   :    29/1/2015
 *    Version        :    v1.0
 **/
public with sharing class TriggerHelperForSMS {
    
    /*
       Method : To Populate Lead Fields in The Task
    */
       
    public void populateFieldsOfLeadonTask(List < Task > taskList) {
        Set < Id > LeadIds = new Set < Id > ();
        for (Task t: taskList) {
            if (t.WhoId != null) {
                if (((String) t.WhoId).startsWith('00Q')) {
                    LeadIds.add(t.WhoId);
                }
            }
        }
        // Pull in Lead ids and related field to populate task record
        List < Lead > taskLeads = [Select Id, Name, Email, mobilePhone, Project__c from Lead where Id in : LeadIds];
        Map < Id, Lead > ldMap = new Map < Id, Lead > ();
        for (Lead l: taskLeads) {
            ldMap.put(l.Id, l);
        }
        // Update custom task field with custom lead field
        for (Task t: taskList) {
            String wId = t.WhoId;
            if (wId != null && wId.startswith('00Q')) {
                Lead thisLead = ldMap.get(t.WhoId);
                if (thisLead != null) {
                    t.Contact_Lead_Name__c = thisLead.Name;
                    t.Contact_Lead_Email_Id__c = thisLead.Email;
                    t.Contact_Lead_Mobile_No__c = thisLead.mobilePhone;
                    t.Lead_Contact_Project__c = thisLead.Project__c;
                }
            }
        }
    }
    
    /*
       Method : To Populate Contact Fields in The Task Object
       
    */
    
    public void populateFieldsOfContactonTask(List < Task > taskList) {
        Set < Id > ContactId = new Set < Id > ();
        for (Task t: taskList) {
            if (t.WhoId != null) {
                if (((String) t.WhoId).startsWith('003')) {
                    ContactId.add(t.WhoId);
                }
            }
        }
        
        // Pull in Contact ids and related field to populate task record
        List < Contact > taskLeads = [Select Id, Name, Email, mobilePhone from Contact where Id in : ContactId];
        Map < Id, Contact > ldMap = new Map < Id, Contact > ();
        for (Contact l: taskLeads) {
            ldMap.put(l.Id, l);
        }
        
        // Update custom task field with custom Contact field
        for (Task t: taskList) {
            String wId = t.WhoId;
            if (wId != null && wId.startswith('003')) {
                Contact thisContact = ldMap.get(t.WhoId);
                if (thisContact != null ) {
                    t.Contact_Lead_Name__c = thisContact.Name;
                    t.Contact_Lead_Email_Id__c = thisContact.Email;
                    t.Contact_Lead_Mobile_No__c = thisContact.mobilePhone;
                    t.Lead_Contact_Project__c   =   'Not Updated';
                }
            }
        }
    }

    /*
         Method : To send sms to the Owner of Task
                With Lead/Contact Information
    */

    public void sendSmsToUser(List < Task > taskList) {
        List < smagicinteract__smsmagic__c > smsObjects = new List < smagicinteract__smsmagic__c > ();
        String templateText;
        Id TaskId = null;
        
        //Sms magic template
        list<smagicinteract__SMS_Template__c> tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = : 'User Lead SMS'
        limit 1];
        
        //SMS magic starting
        if(tpltext.size() > 0){
        templateText = tpltext[0].smagicinteract__Text__c;
        
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
        List < Task > recordIds = new List < Task > ();
        if (taskList.size() > 0) {
            for (Task s: taskList) {
                recordIds.add(s);
            }
        }
    
        String objectType = 'Task';
        String NameField = 'Owner_Name__c';
        fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
        for (string x: fields) {
            if (x.equalsIgnoreCase('Owner_Name__c')) continue;
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
        for (Task ta: taskList) {
            if (ta.Owner_Role__c != 'Executive Enquiry Management' && ta.Current_User_Role__c == 'Executive Enquiry Management') {
                for (sObject c: sObjects) {
                    if (String.valueOf(c.get('Id')) == ta.Id) {
                        String name = String.valueOf(c.get('Owner_Name__c'));
                        String mobilephone = ta.Owner_Mobile_Number__c;
                        String Email = ta.Owner_Email__c;
                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                        smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
                        smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
                        smsObj.smagicinteract__Name__c = name;
                        smsObj.smagicinteract__ObjectType__c = 'Task'; // record type
                        smsObj.smagicinteract__disableSMSOnTrigger__c = 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
                        smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObj.smagicinteract__senderId__c = senderId;
                        smsObj.smagicinteract__SMSText__c = smsText;
                        smsObjects.add(smsObj);
                    }
                }
            }
        }
        insert smsObjects;
        }
    }
    
    /*
   Method : To send sms to the Lead/Contact 
             after creation of Task
       
    */
    public void sendSmsToLead_Contact(List < Task > taskList) {
        List < smagicinteract__smsmagic__c > smsObjects = new List < smagicinteract__smsmagic__c > ();
        String templateText;
        Id TaskId = null;
        
        //Sms magic template
        list<smagicinteract__SMS_Template__c> tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = : 'Customer Lead SMS'
        limit 1];
        //SMS magic starting
        if(tpltext.size() > 0){
        templateText = tpltext[0].smagicinteract__Text__c;

        //Re-render template text
        String senderId = 'sms magic';
        String extraFieldText = '';
        List < String > fields;
        List < sObject > sObjects;
        List < String > args;
        String query = '';
        string userId1 = UserInfo.getUserId();
        string orgId = UserInfo.getOrganizationId();
        smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);
        // get field values for Contact/Leads/Cases/custom object
        List < Task > recordIds = new List < Task > ();
        if (taskList.size() > 0) {
            for (Task s: taskList) {
                recordIds.add(s);
            }
        }
        System.debug('********************recordIds' + recordIds);
        String objectType = 'Task';
        String NameField = 'Contact_Lead_Name__c';
        fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
        for (string x: fields) {
            if (x.equalsIgnoreCase('Contact_Lead_Name__c')) continue;
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
        for (Task ta: taskList) {
            if (ta.Owner_Role__c != 'Executive Enquiry Management' && ta.Current_User_Role__c == 'Executive Enquiry Management') {
                for (sObject c: sObjects) {
                    if (String.valueOf(c.get('Id')) == ta.Id) {
                        String name = String.valueOf(c.get('Contact_Lead_Name__c'));
                        String mobilephone = ta.Contact_Lead_Mobile_No__c;
                        String Email = ta.Contact_Lead_Email_Id__c;
                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                        smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
                        smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
                        smsObj.smagicinteract__Name__c = name;
                        smsObj.smagicinteract__ObjectType__c = 'Task'; // record type
                        smsObj.smagicinteract__disableSMSOnTrigger__c = 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
                        smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObj.smagicinteract__senderId__c = senderId;
                        smsObj.smagicinteract__SMSText__c = smsText;
                        smsObjects.add(smsObj);
                    }
                }
            }
        }
        insert smsObjects;
    }
    }
}