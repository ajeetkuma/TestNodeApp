//-----------------------------------------------------------------------------------------------
// Visualforce Custom Controller: Updatepagecon
// Purpose:Override the mirror information,send a mail to admin, accept and reject information 
// Requires Sending mailing messages accept or reject information
// Portals user logged details
// Overrideing the mirror information     
// -----------------------------------------------------------------------------------------------

public with sharing class Updatepagecon{

    // variable Declaration  
    public boolean CPupdatepage2{get;set;}
    public boolean reject1{get;set;}
    public boolean reject{get;set;}   
    public BG_CPprofile__c CPprofileObj{get;set;}    
    public BG_CPprofile__c CPprofileObj2{get;set;}    
    public BG_CPprofile__c CPprofileObj3{get;set;} 
    public user usr;   
    public boolean CPupdatepage{get;set;}
    public boolean CPupdatepage1{get;set;}
    public BG_CPprofile__c CPprofileObj1{get;set;}
    public boolean fieldvalues{get;set;}
    public boolean fieldvalues1{get;set;}
    public boolean ErrormessageHomepage{get;set;}
    public BG_CPprofile__c fieldvalues2{get;set;}
    public boolean test{get;set;}
    public account acc;
    public contact con;
    public opportunity opp;    
    public Plant__c plant;
    List<Plant__c> plants = new  List<Plant__c>();
    List<Id> accIds = new List<Id>();
    List<smagicinteract__smsMagic__c > smsObjects = new List<smagicinteract__smsMagic__c >();
    String tplText = null;
    
    string id= ApexPages.currentPage().getParameters().get('id') ;
     // Constructor
        public Updatepagecon(){
         try{
            CPprofileObj2=new BG_CPprofile__c ();
            CPprofileObj=new BG_CPprofile__c ();
            CPprofileObj1=new BG_CPprofile__c ();
            CPprofileObj3=new BG_CPprofile__c ();
            
            CPprofileObj= [SELECT id,CPprofile_Name__c,CPprofile_Street3__c ,name,CPprofile_BirthDate__c,CPprofile_BillingStreet__c,User__c,Contact__c,
                               CPprofile_Wedding_Anniversary__c,Portal_UserMobile__c,CPprofile_MailingPostCode__c,CPprofile_BillingState__c ,
                               CPprofile_BillingPostcode__c,CPprofile_BillingCountry__c,CPprofile_Designation__c ,CPprofile_IncomeTaxPANGIRNo__c ,CPprofile_Company__c,
                               CPprofile_HouseNumber__c,CPprofile_Street1__c,CPprofile_Street2__c,CPprofile_MirroringName__c , CPprofile_Industry__c ,CPprofile_ReasonforReject_del__c ,
                               CPprofile_EducationalQualification__c,CPprofile_Profession__c ,CPprofile_BillingCity__c ,
                               CPprofile_EmailForCommunication__c,CPprofile_Mobile__c,CPprofile_MailingStreet__c,
                                CPprofile_MirroringHouseNumber__c,CPprofile_MirroringStreet1__c,                                
                                CPprofile_MirroringStreet2__c,CPprofile_MirroringStreet3__c,CPprofile_MirroringMailing_City__c,
                                CPprofile_MirroringCompany__c,CPprofile_MirroringDesignation__c,CPprofile_MirroringIndustry__c,CPprofile_MirrorEducationalQualification__c,
                                CPprofile_MirroringProfession__c,CPprofile_MirroringEmailForCommunication__c,CPprofile_MirroringMobile__c,CPprofile_MirroringMailingStreet__c,
                                CPprofile_MirroringMailingState__c,CPprofile_MirroringMailingPostCode__c,CPprofile_MirroringMailingCountry__c,
                               CPprofile_MailingState__c,CPprofile_MailingCity__c,CPprofile_MailingCountry__c, Portal_Username__c,CP_profile_MirrorBirthdate__c,CP_Profile_MirrorWedding_Anniversary__c from BG_CPprofile__c 
                               where Contact__c=:Id limit 1 ];     
                               
          //  system.assertEquals(CPprofileObj1.CPprofile_MirroringProfession__c,null);    
                                      
            //Url id Is there come here otherwise,don't comeing                    
            system.debug('$$$$$$$$$$$$$$'+id);                     
            if(id!=null && id!=''){
                usr=[select lastname,firstname,name,Contactid,AccountId,MobilePhone,email from user where id=:CPprofileObj.User__c];
                system.debug('$$$$$$$$$$$$$$'+usr);
                List<CP_Property__c> cpList = [select id,Plant__c from CP_Property__c where Contact_User_Id__c=:usr.Id Order By LastModifiedDate DESC ];
                system.debug('$$$$$$$$$$$$$$'+cpList );
                plants = [select id,Name,Admin_Email__c from Plant__c where  Name=:cpList[0].Plant__c]; 
                system.debug('$$$$$$$$$$$$$$'+plants );
            } 
            }Catch(Exception e){
            }   
        }                
        //Accept Information              
        public PageReference acceptpage() {   
           
                
              if(CPprofileObj.CPprofile_MirroringEmailForCommunication__c!=null) 
                   CPprofileObj.CPprofile_EmailForCommunication__c=CPprofileObj.CPprofile_MirroringEmailForCommunication__c;
                   CPprofileObj.CPprofile_MirroringEmailForCommunication__c='';
              if(CPprofileObj.CPprofile_MirroringMobile__c!=null)
                   CPprofileObj.CPprofile_Mobile__c=CPprofileObj.CPprofile_MirroringMobile__c;
                  // CPprofileObj.Portal_UserMobile__c=CPprofileObj.CPprofile_MirroringMobile__c;                   
                   CPprofileObj.CPprofile_MirroringMobile__c='';
              if(CPprofileObj.CPprofile_MirroringHouseNumber__c!=null)
                   CPprofileObj.CPprofile_HouseNumber__c=CPprofileObj.CPprofile_MirroringHouseNumber__c;
                   CPprofileObj.CPprofile_MirroringHouseNumber__c='';
              if(CPprofileObj.CPprofile_MirroringStreet1__c!=null)
                   CPprofileObj.CPprofile_Street1__c=CPprofileObj.CPprofile_MirroringStreet1__c;  
                   CPprofileObj.CPprofile_MirroringStreet1__c='';
              if(CPprofileObj.CPprofile_MirroringStreet2__c!=null)          
                   CPprofileObj.CPprofile_Street2__c=CPprofileObj.CPprofile_MirroringStreet2__c;
                   CPprofileObj.CPprofile_MirroringStreet2__c='';
              if(CPprofileObj.CPprofile_MirroringStreet3__c!=null)
                   CPprofileObj.CPprofile_Street3__c=CPprofileObj.CPprofile_MirroringStreet3__c;
                   CPprofileObj.CPprofile_MirroringStreet3__c='';
              if(CPprofileObj.CPprofile_MirroringMailing_City__c!=null)
                   CPprofileObj.CPprofile_BillingCity__c=CPprofileObj.CPprofile_MirroringMailing_City__c;
                   CPprofileObj.CPprofile_MirroringMailing_City__c='';
              if(CPprofileObj.CPprofile_MirroringMailingPostCode__c!=null)
                   CPprofileObj.CPprofile_BillingPostCode__c=CPprofileObj.CPprofile_MirroringMailingPostCode__c;
                   CPprofileObj.CPprofile_MirroringMailingPostCode__c='';
              if(CPprofileObj.CPprofile_MirroringCompany__c!=null)               
                   CPprofileObj.CPprofile_Company__c=CPprofileObj.CPprofile_MirroringCompany__c;
                   CPprofileObj.CPprofile_MirroringCompany__c='';
              if(CPprofileObj.CPprofile_MirroringDesignation__c!=null)
                   CPprofileObj.CPprofile_Designation__c=CPprofileObj.CPprofile_MirroringDesignation__c;
                   CPprofileObj.CPprofile_MirroringDesignation__c='';
              if(CPprofileObj.CPprofile_MirroringIndustry__c!=null)
                   CPprofileObj.CPprofile_Industry__c=CPprofileObj.CPprofile_MirroringIndustry__c;
                   CPprofileObj.CPprofile_MirroringIndustry__c='';
              if(CPprofileObj.CPprofile_MirrorEducationalQualification__c!=null)
                   CPprofileObj.CPprofile_EducationalQualification__c=CPprofileObj.CPprofile_MirrorEducationalQualification__c;
                   CPprofileObj.CPprofile_MirrorEducationalQualification__c='';
              if(CPprofileObj.CPprofile_MirroringProfession__c!=null)
                   CPprofileObj.CPprofile_Profession__c=CPprofileObj.CPprofile_MirroringProfession__c; 
                   CPprofileObj.CPprofile_MirroringProfession__c='';                   
                   CPprofileObj.CPprofile_ReasonforReject_del__c='';
               
              if(CPprofileObj.CP_profile_MirrorBirthdate__c!=null)
                   CPprofileObj.CPprofile_BirthDate__c=CPprofileObj.CP_profile_MirrorBirthdate__c; 
                   CPprofileObj.CP_profile_MirrorBirthdate__c=null; 
              if(CPprofileObj.CP_Profile_MirrorWedding_Anniversary__c!=null)
                   CPprofileObj.CPprofile_Wedding_Anniversary__c=CPprofileObj.CP_Profile_MirrorWedding_Anniversary__c; 
                   CPprofileObj.CP_Profile_MirrorWedding_Anniversary__c=null;                                       
   
                   update CPprofileObj; 
                 //  update CPprofileObj1;                  
                   
                             
                  
                  String senderId = 'sms magic';                  
                  String extraFieldText = '';
                  List<String> fields;
                  List<sObject> sObjects;
                  List<String> args ;
                  String query = '';
                  string userId = UserInfo.getUserId();
                  string orgId = UserInfo.getOrganizationId();
                  smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Accept Personal Information']; //id ='a0rf00000006dzq'];
                  String templateText = tpltext.smagicinteract__Text__c;
                  system.debug('$$$$$$$$$$$$$$$$'+tpltext );                   
                  
                  smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

                    // get field values for Contact/Leads/Cases/custom object
                    List<String> recordIds = new List<String>();
                    recordIds.add(CPprofileObj.Id);
                    system.debug('$$$$$$$$$$$$$$$$'+CPprofileObj);
                    String objectType = 'BG_CPprofile__c';
                    String nameField = 'Portal_Username__c';
                    String mobilePhoneField = 'Portal_UserMobile__c';  
                   //  system.assertEquals(1,mobilePhoneField );                  
                    system.debug('$$$$$$$$$$$$$$$$'+user.MobilePhone);
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
                    //query ='select id,'+mobilePhoneField+ ' {0} from {1} where id in :recordIds';
                    query ='select id,name,'+mobilePhoneField+ ' {0} from {1} where id in :recordIds';
                    //query ='select id,'+mobilePhoneField+','+nameField+' {0} from {1} where id in :recordIds';                     
                    query = String.format(query, args);
                    sObjects = Database.query(query);
                    TEngine.getFieldMap(sObjects[0]);
                    for (sObject c :sObjects){
                        String name = String.valueOf(c.get('Portal_Username__c'));
                        String mobilePhone = String.valueOf(c.get('Portal_UserMobile__c'));
                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                        smsObject.smagicinteract__SenderId__c = senderId;                       
                        system.debug('$$$$$$$$$$$$$$$$'+mobilePhone);                      
                       // system.assertEquals(1,2);                                                
                        smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                        smsObject.smagicinteract__Name__c = name ; // records name
                        smsObject.smagicinteract__ObjectType__c = 'BG_CPprofile__c'; // record type
                        smsObject.smagicinteract__disableSMSOnTrigger__c =  System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObject.smagicinteract__SMSText__c = smsText ;
                        smsObjects.add(smsObject);                        
                    }
                    system.debug('$$$$$$$$$$$$$$$$$$$'+smsObjects);                          
                    insert smsObjects;
                    
                        EmailTemplate Emailtemplate=[SELECT Description, Body, Id, Name, BrandTemplateId, Markup, NamespacePrefix, TemplateStyle, Subject, 
                                TemplateType FROM EmailTemplate where name=:'Brigade CPprofile Email AcceptInfo'];
                       //  system.assertEquals(null,Emailtemplate.id);                       
                        system.debug('$$$$$$$$$$$$$$$$'+Emailtemplate.id); 
                    
                       Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage(); 
                     // system.debug('$$$$$$$$$$$$$$$$'+usr.email);        
                       String[] toAddresses = new String[] {usr.email };
                     // Blob messageBody ;
                     //  message.setTemplateId('00Xf0000000QJVe');
                       message.setTemplateId(Emailtemplate.id);
                       message.setTargetObjectId(usr.ContactId);
                       message.setWhatId(CPprofileObj.Id);
                       message.setToAddresses(toAddresses);
                       message.saveAsActivity=false;
                       //if(!Test.isRunningTest()){
                           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                       //}    
                       CPupdatepage=true;
                       CPupdatepage1=true;
                       CPupdatepage2=true;
                       reject=true;
                       
              return null;
        }
        
        //Reject Information
        public PageReference rejectpage() { 
            try{
                //system.assertEquals(CPprofileObj3.CPprofile_ReasonforReject_del__c, 'test');
                if(CPprofileObj3.CPprofile_ReasonforReject_del__c!=null && CPprofileObj3.CPprofile_ReasonforReject_del__c!='')
                {
                   CPprofileObj.CPprofile_MirroringName__c='';
                   CPprofileObj.CPprofile_MirroringEmailForCommunication__c='';
                   CPprofileObj.CPprofile_MirroringMobile__c='';
                   CPprofileObj.CPprofile_MirroringHouseNumber__c='';
                   CPprofileObj.CPprofile_MirroringStreet1__c='';
                   CPprofileObj.CPprofile_MirroringStreet2__c='';
                   CPprofileObj.CPprofile_MirroringStreet3__c='';
                   CPprofileObj.CPprofile_MirroringMailing_City__c=''; 
                   CPprofileObj.CPprofile_MirroringMailingState__c='';
                   CPprofileObj.CPprofile_MirroringEmailForCommunication__c='';
                   CPprofileObj.CPprofile_MirroringMailingPostCode__c='';
                   CPprofileObj.CPprofile_MirroringMailingCountry__c='';
                   CPprofileObj.CPprofile_MirroringCompany__c='';
                   CPprofileObj.CPprofile_MirroringDesignation__c='';
                   CPprofileObj.CPprofile_MirroringIndustry__c='';
                   CPprofileObj.CPprofile_MirrorEducationalQualification__c='';           
                   CPprofileObj.CPprofile_MirroringProfession__c=''; 
                   CPprofileObj.CPprofile_ReasonforReject_del__c=CPprofileObj3.CPprofile_ReasonforReject_del__c;
                   update CPprofileObj;               
                   String senderId = 'sms magic';
                   
                   /*smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Reject Personal Information']; //id ='a0rf00000006dzq'];
                   String templateText = tpltext.smagicinteract__Text__c;               
                   if(usr.MobilePhone!=null && usr.MobilePhone!=null )
                    {
                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                        smsObject.smagicinteract__SenderId__c = senderId;
                        smsObject.smagicinteract__PhoneNumber__c = usr.MobilePhone;
                        smsObject.smagicinteract__Name__c = usr.Name; // records name
                        smsObject.smagicinteract__ObjectType__c = 'BG_CPprofile__c'; // record type
                        smsObject.smagicinteract__disableSMSOnTrigger__c = 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObject.smagicinteract__SMSText__c = templateText;
                        smsObjects.add(smsObject);
                    }                          
                    insert smsObjects;                   
                    */                    
                      String extraFieldText = '';
                      List<String> fields;
                      List<sObject> sObjects;
                      List<String> args ;
                      String query = '';
                      string userId = UserInfo.getUserId();
                      string orgId = UserInfo.getOrganizationId();
                      smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Reject Personal Information']; //id ='a0rf00000006dzq'];
                      String templateText = tpltext.smagicinteract__Text__c;                  
                      smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

                    // get field values for Contact/Leads/Cases/custom object
                        List<String> recordIds = new List<String>();
                        recordIds.add(CPprofileObj.Id);
                        String objectType = 'BG_CPprofile__c';
                        String nameField = 'Portal_Username__c';
                        String mobilePhoneField = 'Portal_UserMobile__c';
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
                        query ='select id,'+mobilePhoneField+ ' {0} from {1} where id in :recordIds';
                        //query ='select id,'+mobilePhoneField+ ','+nameField+' {0} from {1} where id in :recordIds'; 
                        query = String.format(query, args);
                       // system.assertEquals(query,null);
                        sObjects = Database.query(query);
                        TEngine.getFieldMap(sObjects[0]);
                        for (sObject c :sObjects){
                            String name = String.valueOf(c.get('Portal_Username__c'));
                            String mobilePhone = String.valueOf(c.get('Portal_UserMobile__c'));
                            String smsText = TEngine.getReplacedTextForObject(c, 0);
                            smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                            smsObject.smagicinteract__SenderId__c = senderId;
                            smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                            smsObject.smagicinteract__Name__c = name ; // records name
                            smsObject.smagicinteract__ObjectType__c = 'BG_CPprofile__c'; // record type
                            smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                            smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                            smsObject.smagicinteract__SMSText__c = smsText ;
                            smsObjects.add(smsObject);
                        
                        }                          
                    insert smsObjects;                     
                    //Email templates                    
                    EmailTemplate Emailtemplate=[SELECT Description, Body, Id, Name, BrandTemplateId, Markup, NamespacePrefix, TemplateStyle, Subject, 
                                                TemplateType FROM EmailTemplate where name=:'Brigade CPprofile Email RejectInfo'];           
                           system.debug('$$$$$$$$$$$$$$$$'+Emailtemplate.id);            
                           Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                           String[] toAddresses = new String[] {usr.email};
                           string messageBody ;
                           message.setTemplateId(Emailtemplate.id);           
                          // message.setTemplateId('00Xf0000000QJCi');
                           message.setTargetObjectId(usr.ContactId);
                           message.setWhatId(CPprofileObj.Id);
                           message.saveAsActivity=false;
                           message.setToAddresses(toAddresses);
                           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message }); 
                           CPupdatepage=true;
                           reject1=true;
                           reject=true; 
                }
              else{
                  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Reject information ');
                        ApexPages.addMessage(myMsg);
                }
            }
                  catch(DMLException e){ 
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter valid information ');
                        ApexPages.addMessage(myMsg);       
                        return null;
             }
            return null;
    }
        // Click the cancel button going to home page
        public PageReference Homepage()  {
             pagereference homepage=new pagereference('/home/home.jsp');
             homepage.setredirect(true);
         return homepage;
       }

   
 }