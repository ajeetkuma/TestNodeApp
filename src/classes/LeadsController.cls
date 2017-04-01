public with sharing class LeadsController 
{
    public String smsText{get; set;}
    public List<Lead> selectedLeads{get; set;}
    private ApexPages.StandardSetController standardController;

    public LeadsController(ApexPages.StandardSetController standardController)
    {
        this.standardController = standardController;
    }

    public PageReference bumpLeads()
    {       
        // Get the selected records (optional, you can use getSelected to obtain ID's and do your own SOQL)
       selectedLeads = (List<Lead>) standardController.getSelected();
       system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+selectedLeads );

        // Update records       
       /* for(Lead selectedLead : selectedLeads)
        {
            if(selectedLead.Priority == null) 
                selectedLead.Priority = 'Low';
            else if(selectedLead.Priority == 'Low')
                selectedLead.Priority = 'Medium';
            else if(selectedLead.Priority == 'Medium')
                selectedLead.Priority = 'High';
        }      */ 

        return null;        
    }

    public PageReference updateLeads()
    {       
        // Call StandardSetController 'save' method to update (optional, you can use your own DML)
        //return standardController.save();
        system.debug('###################################3'+selectedLeads ); 
  
        for(Lead ld : selectedLeads){
            ld.SMS_Text__c = SMSText; 
            System.debug('==================:SMS'+ld.SMS_Text__c);
        }
        
        try {
            update selectedLeads;
            System.debug('==================:selectedLeads'+selectedLeads);
        }
        catch(DMLException e) {
            String err = String.valueOf(e);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
            ApexPages.addMessage(myMsg); 
        }
        
        if(smsText != '') {
            List<smagicinteract__smsMagic__c > smsObjects = new List<smagicinteract__smsMagic__c >();
            //smagicinteract__SMS_SenderId__c SMSsenderId = [select id,smagicinteract__senderId__c from smagicinteract__SMS_SenderId__c where smagicinteract__senderId__c='Brigade'];
            //String senderId = SMSsenderId.smagicinteract__senderId__c;
            //Re-render template text
            String senderId = 'sms magic';
            String extraFieldText = '';
            List<String> fields;
            List<sObject> sObjects;
            List<String> args ;
            String query = '';
            string userId = UserInfo.getUserId();
            string orgId = UserInfo.getOrganizationId();
            smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Lead SMS']; 
            String templateText = tpltext.smagicinteract__Text__c;
                  
            smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

                    // get field values for Contact/Leads/Cases/custom object
                    List<String> recordIds = new List<String>();
                    for(Lead con:selectedLeads) {
                        recordIds.add(con.Id);
                    }                   
                    String objectType = 'Lead';
                    String nameField = 'Name';
                    String mobilePhoneField = 'MobilePhone';
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
                    query ='select id, '+nameField+','+mobilePhoneField+ ' {0} from {1} where id in :recordIds';
                    system.debug('tengine'+query);
                    query = String.format(query, args);
                    system.debug('query123 '+query );
                    sObjects = Database.query(query);
                    system.debug('query456 '+sObjects  );
                    if(sObjects.size()!=0){
                    TEngine.getFieldMap(sObjects[0]);                    
                    }
                    for (sObject c :sObjects){
                        String name = String.valueOf(c.get('name'));
                        String mobilePhone = String.valueOf(c.get('Mobilephone'));
                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                        smsObject.smagicinteract__SenderId__c = senderId;
                        smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                        smsObject.smagicinteract__Name__c = name ; // records name
                        smsObject.smagicinteract__ObjectType__c = 'Lead'; // record type
                        smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObject.smagicinteract__SMSText__c = smsText ;
                        smsObjects.add(smsObject);
                        
                    }    
            
            try {
               
                
                insert smsObjects;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Confirm,'SMS send succesfully.');
                ApexPages.addMessage(myMsg);
                   
            }
            catch(Exception e){
                String err = String.valueOf(e);
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                ApexPages.addMessage(myMsg);
            }
        }
        
        
        return null;
          
    }
}