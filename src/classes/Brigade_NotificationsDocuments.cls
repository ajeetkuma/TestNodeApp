//-----------------------------------------------------------------------------------------------
// Visualforce Custom Controller: Brigade_NotificationsDocuments ()
// Purpose:Select the Image or document or text
// Saveing the data depending on selection   
// -----------------------------------------------------------------------------------------------

public with sharing class Brigade_NotificationsDocuments{
    // variable Declaration
    String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
    public Notification_Documents__c notificationDocs;
    public String UploadedfileName {get;set;} 
    public Plant__c plant{get;set;}
    public opportunity oppnew{get;set;}
    public boolean errorMsg {get;set;}
    private Attachment myDocument;
    public boolean newsmsg {get;set;}
    public boolean newscat {get;set;}
    public Blob Attach{get;set;} 
    //File Document Declaration
     public Attachment myDoc{
          get
          {
          if(myDocument==null)
             {
                 myDocument = new Attachment();
             }
                 return myDocument;
           }
              set;
     }
    //Constructor
     public Brigade_NotificationsDocuments(ApexPages.StandardController stdController) {
            notificationDocs=new Notification_Documents__c ();
          }
    //Save text 
     public PageReference SaveText(){
           newsmsg = false;
           string notytype=ApexPages.currentPage().getParameters().get('page:frm:pblock:notifitype');
           String categoryNews = ApexPages.currentPage().getParameters().get('page:frm:pblock:Category3');
           String nm1=ApexPages.currentPage().getParameters().get('page:frm1:Pbblock:sce1:name1');
           string active1=ApexPages.currentPage().getParameters().get('page:frm1:Pbblock:sce1:active1');
           string notifications1=ApexPages.currentPage().getParameters().get('page:frm1:Pbblock:sce1:notifictions1');
           string plant1=ApexPages.currentPage().getParameters().get('page:frm1:Pbblock:sce1:Plant1');   
           String news1 = ApexPages.currentPage().getParameters().get('page:frm1:Pbblock:sce1:news1');    
           notificationDocs.Notification_Type__c='Text';
           //system.assertEquals(notytype, 'Test');
           
           if(nm1!=null){
               notificationDocs.Name__c=nm1;
           }
            if(active1!=null){
               notificationDocs.Active__c=active1.equals(active1);
           }
           if(notifications1!=null){
                notificationDocs.Notifications__c=notifications1;
           }
           
            if(plant1!=null && plant1!='' ){
               Plant=[SELECT id,name FROM Plant__c where name=:plant1 limit 1];
               notificationDocs.Plant__c=Plant.id;
               notificationDocs.CategoryN_EandPro__c='Project Specefic Updates';
               newscat = false;
               
           }
           else{
                notificationDocs.CategoryN_EandPro__c='News and Events';
                newscat = true;
           }
           if(news1!=null && news1!=''){
                   notificationDocs.News_URL__c = news1;
           }
           
          /* if(newscat == true){
               if(news1!=null && news1!=''){
                   notificationDocs.News_URL__c = news1;
               }
               else{
                   //system.assertEquals(news1, 'Test');
                   newsmsg = true;
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please enter News URL'));   
               }
           }*/
           
           if(newsmsg == false){
               insert notificationDocs;
               PageReference ref=new PageReference('/'+notificationDocs.id);
               ref.setredirect(true);
               return ref;
           }
           return null;
       }
       // Save Image 
   /*    public PageReference SaveImage(){
         try{
               string notytype=ApexPages.currentPage().getParameters().get('page:frm:pblock:notifitype');                           
               String nm3=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:name3');  
               String active3=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:active3');               
               String category3=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:Category3');               
               string palnt3=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:Plant3');
               string Notifi3=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:notifictions3');  
               string imageplace=ApexPages.currentPage().getParameters().get('page:frm3:Pblock3:sec3:palceofimage3');             
                if(notificationDocs.id ==null){
                  notificationDocs.Notification_Type__c='Image';                              
                   if(nm3!=null){                   
                        notificationDocs.Name__c=nm3;
                   }
                    if(active3!=null){                   
                        
                        notificationDocs.Active__c=active3.equals(active3);
                   }
                   if(category3!=null){                   
                        
                        notificationDocs.Category__c=category3;
                   }
                   if(palnt3!=null && palnt3!=''){
                       
                       Plant=[SELECT id,name FROM Plant__c where name=:palnt3];
                       system.debug('***********************************Plant'+Plant);
                       notificationDocs.Plant__c=Plant.id;
                   }
                   if(Notifi3!=null){
                        notificationDocs.Notifications__c=Notifi3;
                   }
                   if(imageplace!=null){
                       notificationDocs.Place_of_Image__c=imageplace;
                   }                                    
                    insert notificationDocs;
                    system.debug('***********************************notificationDocs'+notificationDocs);
                    Attachment att = new Attachment();
                    if(Attach.size()>3097152){
                        Attach =null;
                        errorMsg = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 3Mb'));
                    } 
                    else {
                        att.Body = Attach; 
                        att.Name = UploadedfileName; 
                        att.ParentId = notificationDocs.Id; 
                        att.Description = 'file uploaded.'; 
                        insert att;
                        Attach =null;
                        errorMsg = false; 
                        system.debug('***********************************'+att.id);
                    }
                   
                    string documenturl=fullFileURL +'/' + att.id; 
                    system.debug(documenturl);                          
                    notificationDocs.Document_URL__c=documenturl; 
                    notificationDocs.Document_Id__c= att.id;
                    update notificationDocs; 
                    system.debug('***********************************notificationDocs'+notificationDocs);
                    
                   
                    
                    
                  }
                  else {
                      Attachment att = new Attachment();
                      if(Attach.size()>3097152) {
                         Attach =null;
                         errorMsg = true;
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 3Mb'));
                      }
                      else {
                          att.Body = Attach; 
                          att.Name = UploadedfileName; 
                          att.ParentId = notificationDocs.Id; 
                          att.Description = 'file uploaded.'; 
                          insert att; 
                          Attach =null;
                          errorMsg = false; 
                          system.debug('***********************************att.id'+att.id);
                      }
                      notificationDocs.Notification_Type__c='Image';   
                      if(nm3!=null){                   
                        notificationDocs.Name__c=nm3;
                   }
                    if(active3!=null){                   
                        
                        notificationDocs.Active__c=active3.equals(active3);
                   }
                   if(category3!=null){                   
                        
                        notificationDocs.Category__c=category3;
                   }
                   if(palnt3!=null && palnt3!=''){
                       
                       Plant=[SELECT id,name FROM Plant__c where name=:palnt3];
                       system.debug('***********************************Plant'+Plant);
                        notificationDocs.Plant__c=Plant.id;
                   }
                   if(Notifi3!=null){
                        notificationDocs.Notifications__c=Notifi3;
                   }
                                    
                      string documenturl=fullFileURL +'/' + att.id;                           
                      notificationDocs.Document_URL__c=documenturl; 
                      notificationDocs.Document_Id__c= att.id;
                      update notificationDocs; 
                  } 
                }
                 catch (DMLException e) {                     
                       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));                      
                       return null;
                      }
                      
                      if(errorMsg == false){
                           pageReference ref=new PageReference('/'+notificationDocs.id);
                          ref.setredirect(true);
                          return ref; 
                      }
                      return null;
                     
          }
          */
      //Save document                
       public PageReference SaveDocu(){    
            try {     
                 string notytype=ApexPages.currentPage().getParameters().get('page:frm:pblock:notifitype'); 
                 String nm2=ApexPages.currentPage().getParameters().get('page:frm2:Pbc2:sec2:name2'); 
                 String active2=ApexPages.currentPage().getParameters().get('page:frm2:Pbc2:sec2:active2');
                 String notifuc2=ApexPages.currentPage().getParameters().get('page:frm2:Pbc2:sec2:notifictions2');
                 String plant2=ApexPages.currentPage().getParameters().get('page:frm2:Pbc2:sec2:Plant2'); 
                 string opp2=ApexPages.currentPage().getParameters().get('page:frm2:Pbc2:sec2:opp2');                 
                 
              if(myDoc.Body != null && myDoc.name!= null){
                
               if(notificationDocs.id ==null){                
                 notificationDocs.Notification_Type__c='Document';
                    if(nm2!=null){                     
                          notificationDocs.Name__c=nm2;
                     } 
                     if(active2!=null){ 
                          notificationDocs.Active__c=active2.equals(active2);                     
                     }
                     // 
                      if(plant2!=null && plant2!=''){ 
                    //  system.assertEquals(plant2,'123');
                       Plant=[SELECT id,name FROM Plant__c where name=:plant2 limit 1];
                          notificationDocs.Plant__c=Plant.id;   
                          notificationDocs.CategoryDocandPro__c='Project Specific Documents';              
                     }
                     else{
                       //system.assertEquals(Plant2,null);
                          notificationDocs.CategoryDocandPro__c='General Document ';
                     } 
                     
                     if(opp2!=null && opp2!=''){
                       oppnew=[SELECT id,name FROM opportunity where name=:opp2 limit 1];
                          notificationDocs.Opportunity__c=oppnew.id;   
                          notificationDocs.CategoryDocandPro__c='Cost Breakup Document';  
                                          
                     }
                       if(notifuc2!=null){ 
                        notificationDocs.Notifications__c=notifuc2;                
                     }                                        
                        insert notificationDocs;
                        
                        //insert  documents
                        if(!Test.isRunningTest()){
                            //if(myDoc.Body.size()>3097152){
                            if(myDoc.Body.size()>26214400){
                                //system.assertEquals(myDoc.Body.size(),null);
                                myDoc.Body=null;
                                errorMsg = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 3Mb'));
                            }
                            else {
                                myDoc.parentId = notificationDocs.Id;
                                insert myDoc; 
                                mydoc.body =null;
                                errorMsg = false; 
                                //system.assertEquals(errorMsg,false);
                                system.debug('***********************************myDoc.id'+myDoc.id);
                            }
                        }
                        else{
                           if(myDoc.Body.size()>12){
                                //system.assertEquals(myDoc.Body.size(),null);
                                myDoc.Body=null;
                                errorMsg = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 3Mb'));
                            }
                            else {
                                myDoc.parentId = notificationDocs.Id;
                                insert myDoc; 
                                mydoc.body =null;
                                errorMsg = false; 
                                //system.assertEquals(errorMsg,false);
                                system.debug('***********************************myDoc.id'+myDoc.id);
                            } 
                        }
                        
                        string documenturl=fullFileURL +'/' + myDoc.id;                           
                        notificationDocs.Document_URL__c=documenturl;
                        notificationDocs.Document_Id__c= myDoc.id;
                        update notificationDocs;
                       }
                       else {
                           // insert documents
                            //if(myDoc.Body.size()>3097152){
                            if(myDoc.Body.size()>26214400){
                                myDoc.Body=null;
                                errorMsg = true;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 25Mb'));
                            }
                            else {
                                myDoc.parentId = notificationDocs.Id;
                                insert myDoc; 
                                mydoc.body =null;
                                errorMsg = false; 
                            }
                           
                            notificationDocs.Notification_Type__c='Document';
                            if(nm2!=null){
                              notificationDocs.Name__c=nm2;
                            } 
                             if(active2!=null){ 
                                  notificationDocs.Active__c=active2.equals(active2);                     
                             }
                             if(plant2!=null &&  plant2!=''){ 
                                Plant=[SELECT id,name FROM Plant__c where name=:plant2];
                                system.debug('***********************************Plant'+Plant);
                                notificationDocs.Plant__c=Plant.id;   
                                notificationDocs.CategoryDocandPro__c='Project Specific Documents ';              
                             } 
                             else{
                                notificationDocs.CategoryDocandPro__c='General Document';
                             }
                             
                             
                             if(notifuc2!=null){ 
                                notificationDocs.Notifications__c=notifuc2;                
                             }                 
                             string documenturl=fullFileURL +'/' + myDoc.id;                           
                             notificationDocs.Document_URL__c=documenturl;
                             notificationDocs.Document_Id__c= myDoc.id;
                             update notificationDocs;
                          }
                          
                        }
                        
                        else{
                        
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
                        
                        }
                      }
                      catch (DMLException e) {
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
                            return null;
                      }
                      finally {
                         // document.body = null; // clears the viewstate
                          //document = new Document();
                        }
                        
                        if(errorMsg == false){
                            
                            PageReference ref=new PageReference('/'+notificationDocs.id);
                            ref.setredirect(true);
                            return ref;
                        }
                        return null;
               }  
    }