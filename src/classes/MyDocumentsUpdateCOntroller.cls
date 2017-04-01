public class MyDocumentsUpdateCOntroller {
    //variables Declaration
    public String userId {get;set;}
    public List<CP_Property__c> cpList {get;set;}
    public List<Project_Docs__c> projectDocList{get;set;}
    public String PlantName {get;set;}
    public String Unitname {get;set;}
    public User usrId ;    
    List<smagicinteract__smsMagic__c > smsObjects = new List<smagicinteract__smsMagic__c >();
    
    //wrapper class declaration
    public List<docsSection> docsSectionList {get;set;}
    public List<docsSection> docsSectionListFirst {get;set;}
    public List<docsSection> docsSectionListSecond {get;set;}
    public List<docsSection> docsSectionListThird {get;set;}
    public List<docsSection> docsSectionListFourth {get;set;}
    
    //Project docs 
    Public List<Project_Docs__c> projDocsUpdatedAccept {get;set;} 
    Public List<Project_Docs__c> projDocsUpdated {get;set;} 
    list<Plant__c> plants = new list<Plant__c>();
    Set<String> adminEmails = new Set<String>();
    string baseURL  = ApexPages.currentPage().getURL();
    
    public MyDocumentsUpdateCOntroller(){
    try{
        docsSectionList  = new List<docsSection>();
        docsSectionListFirst = new List<docsSection>();
        docsSectionListSecond = new List<docsSection>();
        docsSectionListThird = new List<docsSection>();
        docsSectionListFourth = new List<docsSection>();
        projectDocList = new List<Project_Docs__c>();
        projDocsUpdated = new List<Project_Docs__c>();
        userId  = ApexPages.currentPage().getParameters().get('Id');      
        Unitname = ApexPages.currentPage().getParameters().get('Unitname');
        
       // system.assertEquals(y,'');
         
        
        //Current logged user information
        if(userId!=null) {
            usrId = [select id,contactId,Name,MobilePhone,email from user where Id=:userId ];            
       
            cpList = [select Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Project_Name__c from CP_Property__c where Contact_User_Id__c=:usrId.Id and Unit_Code__c=:Unitname  ];
           // system.assertEquals(cpList ,null);
        }
        
        if(cpList.size()>0){
            PlantName = cpList[0].Project_Name__c;
        }
        
        set<String> pList = new Set<String>();
        for(CP_Property__c cpProperty : cpList ){
              pList.add(cpproperty.Plant__c);
        }
          
        //query for plants
        if(pList.size()>0){
            plants = [select id,Name,Admin_Email__c,Plant__c from Plant__c where Plant__c IN:pList];
        }         
        for(Plant__c pl:plants){
            adminEmails.add(pl.Admin_Email__c); 
        }
        if(cpList.size()>0){
            projectDocList = [select id,Name,CP_Property__c,Contact_type__c,Document_Url_link__c,Reason_for_Reject__c,Contact__c,Contact__r.name,Contact_name__c,Document_Url__c,Status__c from Project_Docs__c where CP_Property__c=:cpList[0].Id];
        }
        //system.assertEquals(projectDocList ,null);
        //clear the lists
        if(ProjectDocList.size()>0){
            //system.assertEquals(ProjectDocList,null);
            for(Project_Docs__c pds : ProjectDocList ) {
                if(pds.Contact_type__c =='First Applicant'){
                    docsSectionListFirst.add(new docsSection(pds));
                }
                if(pds.Contact_type__c =='Second Applicant'){
                    docsSectionListSecond.add(new docsSection(pds));
                }
                if(pds.Contact_type__c =='Third Applicant'){
                    docsSectionListThird.add(new docsSection(pds));
                }
                if(pds.Contact_type__c =='Fourth Applicant'){
                    docsSectionListFourth.add(new docsSection(pds));
                }
                docsSectionList.add(new docsSection(pds));     
            }
            //system.assertEquals(docsSectionList,null);   
         }
     }
         Catch(Exception e){
               ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No document available');
               ApexPages.addMessage(myMsg);
         }  
     }
    //wrapper class declaration
    Public class docsSection {
        public Project_Docs__c pdoc {get;set;}
        public Boolean selected {get;set;}
        
        public docsSection(Project_Docs__c pd){
            pdoc =pd;
            selected = false;
                
        }      
    }
    //accept Dcouments
    Public pageReference acceptDocuments(){
        //system.assertEquals(docsSectionList,null);
        for(docsSection  docS:docsSectionListFirst){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true){
                docS.pdoc.Status__c = 'Submitted-Accepted';
                docS.pdoc.Reason_for_Reject__c='';
                projDocsUpdated .add(docS.pdoc);   
            }
         }
        }
        for(docsSection  docS:docsSectionListSecond){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true){
                docS.pdoc.Status__c = 'Submitted-Accepted';
                docS.pdoc.Reason_for_Reject__c='';
                projDocsUpdated .add(docS.pdoc);
            }
         }
        }
        for(docsSection  docS:docsSectionListThird){
         if(docS.Selected == False  ) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true){
                docS.pdoc.Status__c = 'Submitted-Accepted';
                docS.pdoc.Reason_for_Reject__c='';
                projDocsUpdated .add(docS.pdoc);
            }
          }
        }
        for(docsSection  docS:docsSectionListFourth){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true){
                docS.pdoc.Status__c = 'Submitted-Accepted';
                docS.pdoc.Reason_for_Reject__c='';
                projDocsUpdated.add(docS.pdoc);
            }
          }
        }
       
        if(projDocsUpdated.size()>0){
            try {
                //system.assertEquals(docsSectionListFirst[0].pdoc.Contact__c,null);
                update projDocsUpdated ;
                //query for email template
                EmailTemplate emailtemp = [select id, name from EmailTemplate where name ='Documents Accept info' limit 1];
                system.debug('########################################'+docsSectionListFirst[0].pdoc.Contact__c);
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+usrId.Id);
                system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'+[select id,Portal_Username__c,Portal_UserMobile__c,Contact__c from BG_CPprofile__c]);
                List<BG_CPprofile__c> profileList = [select id,Portal_Username__c,Portal_UserMobile__c,Contact__c from BG_CPprofile__c where user__c = :usrId.Id and Contact__c=:docsSectionListFirst[0].pdoc.Contact__c  ];
                system.Debug('*****************************'+profileList);
                //system.assertEquals(projectDocList,null);
                List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
               /* for(CP_Property__c cpProperty : cpList){
                   for(Plant__c  pl: plants){
                       if(pl.Plant__c == cpProperty.Plant__c){
                           for(String adminmail:adminEmails){
                               if(adminmail == pl.Admin_Email__c){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    String[] toAddresses = new String[] {adminmail};
                                    string messageBody ;
                                    mail.setTemplateId(emailtemp.Id);
                                    mail.setTargetObjectId(usrId.contactId);
                                    mail.setwhatid(profileList[0].id);
                                    mail.setToAddresses(toAddresses);
                                    mail.setHtmlBody(messageBody);
                                    mail.saveAsActivity=false;
                                    mails.add(mail);  
                                }  
                            }
                        }
                     }
                  }
                  */
                  for(Project_Docs__c pdoc:projDocsUpdated){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] {usrId.email};
                    string messageBody ;
                    mail.setTemplateId(emailtemp.Id);
                    mail.setTargetObjectId(usrId.contactId);
                    mail.setwhatid(pdoc.id);
                    mail.setToAddresses(toAddresses);
                    mail.setHtmlBody(messageBody);
                    mail.saveAsActivity=false;
                    mails.add(mail);    
                }
                  //Re-render template text
                  String senderId = 'sms magic';
                  String extraFieldText = '';
                  List<String> fields;
                  List<sObject> sObjects;
                  List<String> args ;
                  String query = '';
                  string userId = UserInfo.getUserId();
                  string orgId = UserInfo.getOrganizationId();
                  smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Accept Documents']; 
                  String templateText = tpltext.smagicinteract__Text__c;
                  
                  smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

                    // get field values for Contact/Leads/Cases/custom object
                    List<String> recordIds = new List<String>();
                    recordIds.add(profileList[0].Id);
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
                        query ='select id,name,'+mobilePhoneField+ ' {0} from {1} where id in :recordIds';
                    query = String.format(query, args);
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
               try {
                   insert smsObjects;
                   Messaging.sendEmail(mails); 
                    PageReference pg=new pagereference(baseURL);
                    pg.setRedirect(true);
                    return pg;
               }
               catch(Exception e){
               String err = String.valueOf(e);
                   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                   ApexPages.addMessage(myMsg);
               }
            }
            catch(DMLException e){
                system.debug('...DML Exception '+e);
            }  
        }
        projDocsUpdated.clear();
        return null;
    }
    
    //Reject documents
    Public pageReference rejectDocuments(){
      try{  
     
        List<Id> pdocsIds = new List<Id>();
        //system.assertEquals (docsSectionListFirst,null);
        for(docsSection  docS:docsSectionListFirst){ 
          if(docS.Selected == False ) {
                     
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{      
         
            if(docS.Selected == true && docS.pdoc.Reason_for_Reject__c!='' && docS.pdoc.Reason_for_Reject__c!=null ){
                docS.pdoc.Status__c = 'Pending';
                docS.pdoc.Reason_for_Reject__c = docS.pdoc.Reason_for_Reject__c;
                docS.Pdoc.Document_Url__c = null;
                docS.pdoc.AttachmentId__c =null;
                projDocsUpdated.add(docS.pdoc);
                pdocsIds.add(docS.pdoc.Id);
            }
         
             else{
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Reject Information ');
                     ApexPages.addMessage(myMsg);        
                }
           }
         
        }
        for(docsSection  docS:docsSectionListSecond){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true && docS.pdoc.Reason_for_Reject__c!='' && docS.pdoc.Reason_for_Reject__c!=null){
                docS.pdoc.Status__c = 'Pending';
                docS.pdoc.Reason_for_Reject__c = docS.pdoc.Reason_for_Reject__c;
                docS.Pdoc.Document_Url__c = null;
                docS.pdoc.AttachmentId__c =null;
                projDocsUpdated .add(docS.pdoc);
                pdocsIds.add(docS.pdoc.Id);
            }
             else{
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Reject Information ');
                        ApexPages.addMessage(myMsg);        
                 }
            }
        }
        for(docsSection  docS:docsSectionListThird){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true && docS.pdoc.Reason_for_Reject__c!='' && docS.pdoc.Reason_for_Reject__c!=null ){
                docS.pdoc.Status__c = 'Pending';
                docS.pdoc.Reason_for_Reject__c = docS.pdoc.Reason_for_Reject__c;
                docS.Pdoc.Document_Url__c = null;
                docS.pdoc.AttachmentId__c =null;
                projDocsUpdated .add(docS.pdoc);
                pdocsIds.add(docS.pdoc.Id);
            }
            else{
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Reject Information ');
                    ApexPages.addMessage(myMsg); 
            }
          }
        }
        for(docsSection  docS:docsSectionListFourth){
         if(docS.Selected == False) {
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please select atleast one record');
                     ApexPages.addMessage(myMsg);
          
         }
         else{   
            if(docS.Selected == true && docS.pdoc.Reason_for_Reject__c!='' && docS.pdoc.Reason_for_Reject__c!=null){
                docS.pdoc.Status__c = 'Pending';
                docS.pdoc.Reason_for_Reject__c = docS.pdoc.Reason_for_Reject__c;
                docS.Pdoc.Document_Url__c = null;
                docS.pdoc.AttachmentId__c =null;
                projDocsUpdated .add(docS.pdoc);
                pdocsIds.add(docS.pdoc.Id);
            }
             else{
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Reject Information ');
                 ApexPages.addMessage(myMsg);
              }
          }
        }
        
        if(projDocsUpdated.size()>0){
            try {
            
                //Reject documents
                update projDocsUpdated ;
                //query for email template
                EmailTemplate emailtemp = [select id, name from EmailTemplate where name ='Documents Reject info' limit 1];
                List<BG_CPprofile__c> profileList = [select id,User__c,Portal_Username__c,Portal_UserMobile__c,CPprofile_Mobile__c,CPprofile_EmailForCommunication__c from BG_CPprofile__c where user__c = :usrId.Id and Contact__c=:docsSectionListFirst[0].pdoc.Contact__c ];
                List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                for(Project_Docs__c pdoc:projDocsUpdated){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] {usrId.email};
                    string messageBody ;
                    mail.setTemplateId(emailtemp.Id);
                    mail.setTargetObjectId(usrId.contactId);
                    mail.setwhatid(pdoc.id);
                    mail.setToAddresses(toAddresses);
                    mail.setHtmlBody(messageBody);
                    mail.saveAsActivity=false;
                    mails.add(mail);    
                }
                /*for(CP_Property__c cpProperty : cpList){
                    for(Plant__c  pl: plants){
                        if(pl.Plant__c == cpProperty.Plant__c){
                            for(String adminmail:adminEmails){
                                if(adminmail == pl.Admin_Email__c){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    String[] toAddresses = new String[] {adminmail};
                                    string messageBody ;
                                    mail.setTemplateId(emailtemp.Id);
                                    mail.setTargetObjectId(usrId.contactId);
                                    mail.setwhatid(profileList[0].id);
                                    mail.setToAddresses(toAddresses);
                                    mail.setHtmlBody(messageBody);
                                    mail.saveAsActivity=false;
                                    mails.add(mail);  
                                }  
                            }
                        }
                     }
                  }*/
                  //Re-Render SMS template text
                  String senderId = 'sms magic';
                  String extraFieldText = '';
                  List<String> fields;
                  List<sObject> sObjects;
                  List<String> args ;
                  String query = '';
                  string userId = ProfileList[0].User__c;
                  string orgId = UserInfo.getOrganizationId();
                  smagicinteract__SMS_Template__c tpltext = [select id,smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c=:'Reject Documents']; 
                  String templateText = tpltext.smagicinteract__Text__c;
                  
                  smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

                    // get field values for Contact/Leads/Cases/custom object
                    List<String> recordIds = new List<String>();
                    for(Project_Docs__c pdoc:projDocsUpdated ){
                        recordIds.add(pdoc.Id);
                    }
                    
                    String objectType = 'Project_Docs__c';
                    //String nameField = 'Contact_name__c';
                    //String mobilePhoneField = 'CPprofile_Mobile__c';
                    String ContactNameField ='Contact_name__c';
                    String ReasonforReject = 'Reason_for_Reject__c';
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
                    query ='select id,name {0} from {1} where id in :recordIds';
                    query = String.format(query, args);                   
                    sObjects = Database.query(query);
                    //system.assertEquals(sObjects ,null);
                    TEngine.getFieldMap(sObjects[0]);
                    for (sObject c :sObjects){
                        String name = String.valueOf(c.get('Contact_name__c'));
                        String mobilePhone = profileList[0].Portal_UserMobile__c;
                        String smsText = TEngine.getReplacedTextForObject(c, 0);
                        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
                        smsObject.smagicinteract__SenderId__c = senderId;
                        smsObject.smagicinteract__PhoneNumber__c = mobilePhone ;
                        smsObject.smagicinteract__Name__c = name ; // records name
                        smsObject.smagicinteract__ObjectType__c = 'Project_Docs__c'; // record type
                        smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
                        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
                        smsObject.smagicinteract__SMSText__c = smsText ;
                        smsObjects.add(smsObject);
                        
                    }     
                    try {
                        upsert smsObjects;
                        Messaging.sendEmail(mails); 
                    }
                    catch(Exception e){
                        String err = String.valueOf(e);
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,err );
                        ApexPages.addMessage(myMsg);
                    }
              }
              catch(DMLException e){
                system.debug('...DML Exception '+e);
              }
            
        }
        
        if(pdocsIds.size()>0){
            List<Attachment> attachList = [select id, parentId from Attachment where ParentId IN:pdocsIds];
            delete attachList;
            
            PageReference pg=new pagereference(baseURL);
            pg.setRedirect(true);
            return pg;
            
        }
        
       
        }
        
        Catch(Exception e){
              ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No document available');
              ApexPages.addMessage(myMsg);
        }
       return null;
        
        
    }
    
   
    
    
    
}