public class sendEKhathaSMS {
    
    public boolean firstPaneldisplay {get;set;}
    public string sectionHeader {get;set;}
    public string smsTemplate {get;set;}
    public boolean isforEkhata {get;set;}
    public sendEKhathaSMS(){
        firstPaneldisplay =true ;
        isforEkhata = false;
        string sendSMSfor = Apexpages.currentPage().getParameters().get('for');
         if(sendSMSfor.equalsIgnoreCase('Ekhatha')){
             sectionHeader = 'Send SMS';
             isforEkhata = true ;
         }else{
             sectionHeader = 'Send Krishi Kalyan Cess SMS';
             smsTemplate = 'KrishiKalyanSMS';
         }
    }
    
    public system.PageReference populateUnitName(){
        
        if(smsTemplate == 'none'){
            ApexPages.Message ErrorMsg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Please Select a SMS Template');
            Apexpages.addMessage(ErrorMsg);
        }else{
        firstPaneldisplay =false ;
        id plantId = Apexpages.currentPage().getParameters().get('id');
        string sendSMSfor = Apexpages.currentPage().getParameters().get('for');
        list<id> contIDList = new list<id>();
        
        if(plantId != null){
            
            if(sendSMSfor.equalsIgnoreCase('Ekhatha')){
            Map<id,opportunity> oppMap = new Map<id,opportunity>([select id,unit__r.name from opportunity where Unit__r.Plant__c = :plantId and StageName = 'Allotment' and E_Khatha_Received__c =true  ]);
            
            list<opportunityContactRole> oppConList = new list<opportunityContactRole>();
            oppConList = [select opportunityid , contactid from opportunityContactRole where opportunityid IN :oppMap.keySet()];
            
            Map<id,id> oppConMap = new Map<id,id>();
            Map<id,string> conUnitMap = new Map<id,string>();
             
            for(opportunitycontactrole opp: oppConList){
                id contID = opp.contactid;
                oppConMap.put(contID, opp.opportunityid);
                
                if(conUnitMap.containsKey(contID)){
                    string unitName = conUnitMap.get(contID);
                    unitName = unitName +','+ oppMap.get(opp.opportunityid).unit__r.name ;
                    conUnitMap.put(contID, oppMap.get(opp.opportunityid).unit__r.name);
                }else{
                    conUnitMap.put(contID, oppMap.get(opp.opportunityid).unit__r.name);
                }
            }
            
            list<contact> contactList = new list<contact>();
            for(id cont : conUnitMap.keySet()){
                contact con = new contact(id=cont ,opportunity_unit_name__c = conUnitMap.get(cont));
                contactList.add(con);
            }
            
            update contactList ;
            
            contIDList.addAll(conUnitMap.keySet());
             if(contIDList.size()>0){
                 sendSMSToContact(contIDList,smsTemplate,'CONTACT','MobilePhone');
              }
           
            }else if(sendSMSfor.equalsIgnoreCase('KrishiKalyan')){
                list<opportunitycontactrole> oppConRoleList = new list<opportunitycontactrole>();
                oppConRoleList = [select contactid from opportunitycontactrole where Opportunity.StageName ='Allotment' and Opportunity.Unit__r.Plant__c =:plantId] ;
                
                
                for(opportunitycontactrole oppCont : oppConRoleList){
                    contIDList.add(oppCont.contactid);
                }
                
                if(contIDList.size()>0){
                    sendSMSToContact(contIDList,smsTemplate,'CONTACT','MobilePhone');
                }
            }
        }
        
    }  
        return null;
    }
    
    @future(callout=true)
     public static void sendSMSToContact(list<id> ContactList,string SMSTemplate,string objectAPIName,string MobileField){
        
        List<smagicinteract__smsmagic__c> smsObjectsToInsert    =  SendSMStoNEWLead(ContactList,SMSTemplate,objectAPIName,MobileField,1);
        
        if(!Test.isRunningTest()){
        String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
        }   
            if(smsObjectsToInsert.size() > 0){
                Database.insert(smsObjectsToInsert,false);
            }
    }
    
    
     public static List<smagicinteract__smsMagic__c> SendSMStoNEWLead(List<id> ContactList,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
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
             
            if(objName == 'CONTACT'){
                query = 'select id, ' + MobileNo + '{0} from {1} where id in :ContactList and smagicinteract__SMSOptOut__c = false and '+MobileNo+' != null';
            }else if(objName == 'CASE'){
                query = 'select id, ' + MobileNo + '{0} from {1} where id in :ContactList and contact.smagicinteract__SMSOptOut__c = false and '+MobileNo+' != null';
                 
            }
            query = String.format(query, args);
            
            sObjects = Database.query(query);
            
            if (sObjects.size() > 0) {
                TEngine.getFieldMap(sObjects[0]);
            }
            for (sObject c: sObjects) {
                String name         = String.valueOf(c.get('id'));
                String smsText      = TEngine.getReplacedTextForObject(c, 0);                           
                smsObjects.add(Utility_Class.getSMSMagicObj(name,c.get(conAPIName)+'',ObjName,'Brigade',smsText,singleOrBatch));
            
            }
               
        }catch(Exception ex){
            system.debug('Exception ::'+ex.getMessage());
        }
        return  smsObjects;                 
    }


}