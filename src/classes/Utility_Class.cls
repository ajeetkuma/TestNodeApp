/*
 * Description      : This class is used for reusable methods and values.
 * Author           : Amritesh
 
*/

public class Utility_Class {

    public static final String CONTACTROLE_FIRST            = 'First Applicant' ;
    public static final String CONTACTROLE_SECOND           = 'Second Applicant' ;
    public static final String CONTACTROLE_THIRD            = 'Third Applicant' ;
    
    public static final String ALLOTMENT_STAGE              = 'Allotment' ;
    public static final String PAYMENT_RECIEVED             = 'Received' ;
    
    public static boolean IS_OPP_TRIGGER_RUNNING            = false;
    public static boolean IS_TASK_TRIGGER_RUNNING           = false;
    public static boolean IS_DEMAND_LETTER_RUNNING          = false;
    
    public static final String WEEKLY_EMAIL_TEMPLATE_NAME   = 'Weekly Email Template For Links';
    public static final String DAILY_EMAIL_TEMPLATE_NAME    = 'Daliy Email Template For Links';
    
    public static final String DAILY_FREQUENCY              = 'Daliy';
    public static final String WEEKLY_FREQUENCY             = 'Weekly';
    
    public static final String BOOKING_CSAT_FEEDBACK        = 'Booking CSAT Feedback form';
    public static final String EXECUTION_WITH_MODIFY        = 'Execution with Modification';
    public static final String EXECUTION_WITHOUT_MODIFY     = 'Execution without modification';
    public static final String HANDOVER_FEEDBACK_FORM       = 'Handover Feedback form';
    public static final String ONE_YEAR_HANDOVER            = '1st year Handover Feedback';
    public static final String FAKE_END_POINT_FOR_TEST      = 'http://api.salesforce.com/foo/bar';
    
    Public static final String SMS_SENDER_ID                = 'sms magic';
    Public static final String PAYMENT_DUE_TEMPLATE         = 'Payment Due New';
    Public static final String MASTER_PAYMENT_OBJECT        = 'Master_Payment__c';
    Public static final String CONTACT_NAME_API             = 'Contact_Name__c';
    
    Public static final String SMS_SENDER_IDS               = 'sms magic';
    Public static final String PAYMENT_DUE_TEMPLATES        = 'SMS Demand Due Payment';
    Public static final String DUE_PAYMENT_OBJECT           = 'Opportunity';
    Public static final String CONTACT_SMS_API              = 'First_Applicant_Number__c';
    
    /****************************************************
    Purpose     : Retrieve Plumb5 API Details from 
                  Plumb5APIInfo Custom Settings
    Return Type : string
    ***************************************************/
    Public Static String getPlumb5EndUrl(){            
        string endURL           = '';
        
        try{
            // Plumb5 End Point URL fromat has been changed now in from and to date we dont need the time , only date is required.
                //DateTime dT             = System.now();
                //Date currentDate        = date.newinstance(dT.year(), dT.month(), dT.day());
                //endURL                  = plumb5.EndURL__c+'apikey='+plumb5.API_Key__c+'&AdsId='+plumb5.Ads_Id__c+'&fromdate='+currentDate+'&todate='+system.now().addHours(5).addMinutes(30);
               //endUrl                  = endURL.replaceAll(' ', '%20');
            
            Plumb5APIInfo__c plumb5 = Plumb5APIInfo__c.getValues('Plumb5');
            endURL = plumb5.EndURL__c+'apikey='+plumb5.API_Key__c+'&AdsId='+plumb5.Ads_Id__c+'&fromdate='+String.valueOf(system.today()).split(' ')[0]+'&todate='+String.valueOf(system.today()).split(' ')[0];
            
            
            
            if(Test.isRunningTest()){
                endUrl  = FAKE_END_POINT_FOR_TEST;
            }
        }catch(Exception e){}
        
        return endURL;
    }
    
     /****************************************************
    Purpose     : Check String is Null or Blank
    Return Type : Boolean
    ***************************************************/
    public static boolean ISBlankOrEmpty(String val){
        if(val == null || val == ''){
            return true;
        }else{
            return false;
        }
    }
    
     /************************************************************
    Purpose     : Check Time lies between TaskReAssignementPeriod 
                  and return exact escalate Time in 24hour format
    Return Type : String
    **************************************************************/
    public static String getEscalationTime(DateTime datTime,List<TaskReAssignementPeriod__c> taskPeriodList){
        String escalateTime;
        try{
            for(TaskReAssignementPeriod__c t : taskPeriodList){             
                if(String.valueOf(datTime.format('HH:mm')) >= t.IF_Task_Created_From__c  
                    && String.valueOf(datTime.format('HH:mm')) < t.Task_Create_To__c ){
                    escalateTime = t.Name+'@@@'+t.Escalate_at__c;
                }
            }
        }catch(Exception ex){}
        return escalateTime;
    }
    
     /****************************************************
    Purpose     : Get smagicinteract__smsMagic__c object 
                  for Sending SMS
    Return Type : smagicinteract__smsMagic__c
    *******************************************************/
    public static smagicinteract__smsMagic__c getSMSMagicObj(String name,String mobNo,String ObjName,String senderId,String smsText,Integer singleOrBatch){
    
        smagicinteract__smsMagic__c smsObj              = new smagicinteract__smsMagic__c();
        smsObj.smagicinteract__PhoneNumber__c           = mobNo;
        smsObj.smagicinteract__Name__c                  = name;
        smsObj.smagicinteract__ObjectType__c            = ObjName;
        smsObj.smagicinteract__disableSMSOnTrigger__c   = singleOrBatch;
        smsObj.smagicinteract__external_field__c        = smagicinteract.ApexAPI.generateUniqueKey();
        smsObj.smagicinteract__senderId__c              = senderId;
        smsObj.smagicinteract__SMSText__c               = smsText;
        
        return smsObj;
    }
    
     /****************************************************
    Purpose     : Get smagicinteract__smsMagic__c object 
                  for Sending SMS
    Return Type : smagicinteract__smsMagic__c
    *******************************************************/
    public static List<smagicinteract__smsMagic__c> getMasterPaymentSMSListToSend(List<Master_Payment__c> paymentList,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
        List<smagicinteract__smsmagic__c> smsObjects = new List<smagicinteract__smsmagic__c> ();
        
        try{
            String templateText;
            smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = :templateName limit 1];

            //SMS magic starting
            templateText = tpltext.smagicinteract__Text__c;

            //Re-render template text           
            String extraFieldText   = '';
            List <String> fields;
            List <sObject> sObjects;
            List <String> args;
            String query            = '';
            
            string userId = UserInfo.getUserId();
            string orgId = UserInfo.getOrganizationId();
            
            smagicinteract.TemplateEngine TEngine   = new smagicinteract.TemplateEngine(templateText);

            // get field values for Master Payment
            List<Master_Payment__c> recordIds = new List <Master_Payment__c>();
            if (paymentList.size() > 0) {
                for (Master_Payment__c masterPayment: paymentList) {
                    recordIds.add(masterPayment);
                }
            }
            
            
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
            
            query = 'select id, ' + NameField + '{0} from {1} where id in :recordIds';
            query = String.format(query, args);
            sObjects = Database.query(query);
            
            if (sObjects.size() > 0) {
                TEngine.getFieldMap(sObjects[0]);
            }
            
            Set <Master_Payment__c> setOfIds = new Set <Master_Payment__c>();

            for (Master_Payment__c duePay: paymentList) {

                for (sObject c: sObjects) {
                    if (String.valueOf(c.get('Id')) == duePay.Id) {
                        if (duePay.Contact_mobile__c != null && duePay.Don_t_Disturb__c == False && duePay.Don_t_Disturb_Plant__c == False && duePay.Stage__c == 'Allotment') {
        
                            String name         = String.valueOf(c.get(conAPIName));
                            String smsText      = TEngine.getReplacedTextForObject(c, 0);                           
                            smsObjects.add(getSMSMagicObj(name,duePay.Contact_mobile__c,ObjName,SMS_SENDER_ID,smsText,singleOrBatch));
                        }
                    }
                }
            }           
                
        }catch(Exception ex){
            system.debug('Exception ::'+ex.getMessage());
        }
        
        return  smsObjects;                 
    }
     /****************************************************
    Purpose     : Get smagicinteract__smsMagic__c object 
                  for Sending SMS 
                  TO SEND THE SMS TO THE PRIMARY CONTACTS SAVED IN THE
                  OPPORTUNITY FOR WHICH THE PAYMENT STATUS IS DUE/ OVER DUE
    Modified By : Sukesh G
    Return Type : smagicinteract__smsMagic__c
    *******************************************************/
    public static List<smagicinteract__smsMagic__c> getOpportunityPaymentSMSListToSend(List<Opportunity> paymentList,String templateName,String objName,String conAPIName,Integer singleOrBatch){      
        
        List<smagicinteract__smsmagic__c> smsObjects = new List<smagicinteract__smsmagic__c> ();
        
        try{
            String templateText;
            smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = :templateName limit 1];

            //SMS magic starting
            templateText = tpltext.smagicinteract__Text__c;

            //Re-render template text           
            String extraFieldText   = '';
            List <String> fields;
            List <sObject> sObjects;
            List <String> args;
            String query            = '';
            
            string userId = UserInfo.getUserId();
            string orgId = UserInfo.getOrganizationId();
            
            smagicinteract.TemplateEngine TEngine   = new smagicinteract.TemplateEngine(templateText);

            // get field values for Master Payment
            List<Opportunity> recordIds = new List <Opportunity>();
            if (paymentList.size() > 0) {
                for (Opportunity masterPayment: paymentList) {
                    recordIds.add(masterPayment);
                }
            }
            System.debug('recordIds=--------------'+recordIds);
            
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
            
            query = 'select id, ' + NameField + '{0} from {1} where id in :recordIds';
            query = String.format(query, args);
            sObjects = Database.query(query);
            
            if (sObjects.size() > 0) {
                TEngine.getFieldMap(sObjects[0]);
            }
            
            Set <Opportunity> setOfIds = new Set <Opportunity>();

            for (Opportunity duePay: paymentList) {

                for (sObject c: sObjects) {
                    if (String.valueOf(c.get('Id')) == duePay.Id) {
                        if (duePay.First_Applicant_Number__c != null &&  duePay.Total_Due_Payment__c>0 && duePay.DND__c==false && duePay.First_Applicant_DND__c==false ) {
        
                            String name         = String.valueOf(c.get(conAPIName));
                            String smsText      = TEngine.getReplacedTextForObject(c, 0);                           
                            smsObjects.add(getSMSMagicObj(name,duePay.First_Applicant_Number__c,ObjName,SMS_SENDER_ID,smsText,singleOrBatch));
                        }
                    }
                }
            }           
                
        }catch(Exception ex){
            system.debug('Exception ::'+ex.getMessage());
        }
        
        return  smsObjects;                 
    }

    
    
}