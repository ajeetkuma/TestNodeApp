/*  Testclass Created by:                           Pupose:
        
                       Depending controller: Brigade_NotificationsDocuments
       
        */


    @isTest(SeeAllData =true)   
    //Test class
    private class testBrigade_NotificationsDocuments {    
    //Test method
    
    //Depending on the drop down selection Display the text data
        public static testmethod void textNewsEventmethod(){       
        //Plant object some dummy data 
                 
             
             Test.startTest(); 
             //Form running information
                              
             Test.setCurrentPageReference(new PageReference('Page.Brigaden_Notificationdocumentspage'));         
             Notification_Documents__c notidocu=new Notification_Documents__c (); 
                  
             //Dummy data on Notification_Documents__c 
             Plant__c pl=new Plant__c();
             pl.Name='MeadowsExt';   
             pl.Project__c='cosmolis';  
             insert pl; 
                 
             notidocu.Notification_Type__c='Text';
             notidocu.Active__c=true;
             notidocu.Name__c='test';
             notidocu.Notifications__c='Test for text';
             notidocu.CategoryN_EandPro__c='News and Events';
             insert notidocu;              
             
             //Javascript data getting on the controller,That data passing  here
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:name1','test');             
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:active1','true');              
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:notifictions1','General');
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:Plant1','MeadowsExt');       
                                        
             //Calling the standard controller extension controller
             ApexPages.StandardController controller = new ApexPages.StandardController(notidocu);
             Brigade_NotificationsDocuments bridgenotidocu=new Brigade_NotificationsDocuments(controller );     
             
            //class,text method calling          
             bridgenotidocu.SaveText();
              
             Test.stopTest();
              
        }
        
        
        
         public static testmethod void textprojspecificationmethod(){       
        //Plant object some dummy data 
                  
             
             Test.startTest(); 
             //Form running information
                              
             Test.setCurrentPageReference(new PageReference('Page.Brigaden_Notificationdocumentspage'));         
             Notification_Documents__c notidocu1=new Notification_Documents__c (); 
                  
             //Dummy data on Notification_Documents__c 
             
                 Plant__c pl=new Plant__c();
                 pl.Name='MeadowsExt';   
                 pl.Project__c='cosmolis';  
                 insert pl;
             
             notidocu1.Notification_Type__c='Text';
             notidocu1.Active__c=true;
             notidocu1.Name__c='test';
             notidocu1.Notifications__c='Test for text';
             notidocu1.CategoryN_EandPro__c='Project Specefic Updates';
             insert notidocu1;              
             
             //Javascript data getting on the controller,That data passing  here
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:name1','test');             
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:active1','true');              
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:notifictions1','General');
             ApexPages.currentPage().getParameters().put('page:frm1:Pbblock:sce1:Plant1','MeadowsExt');       
                                        
             //Calling the standard controller extension controller
             ApexPages.StandardController controller = new ApexPages.StandardController(notidocu1);
             Brigade_NotificationsDocuments bridgenotidocu=new Brigade_NotificationsDocuments(controller );     
             
            //class,text method calling          
             bridgenotidocu.SaveText();
              
             Test.stopTest();
              
        }
        
        
        
        //Depending on drop down selection Display the image data        
         public static testmethod void DocumentGenarelmethod(){
         //Urldata getting here         
             String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
             String UploadedfileName ;
             Blob attach;
                 
             Notification_Documents__c notidocu1=new Notification_Documents__c (); 
             
             account a=new account();
             a.name='tets';
             insert a;
             
             opportunity opp=new opportunity();
             opp.name='test2';
             opp.accountid=a.id;
             opp.StageName='Discussion';
             opp.CloseDate=system.today();
             insert opp;
                  
             //Dummy data on Notification_Documents__c              
             notidocu1.Notification_Type__c='Document';
             notidocu1.Active__c=true;
             notidocu1.Name__c='test';
             notidocu1.Notifications__c='Test for text';
             notidocu1.CategoryDocandPro__c='General Document';
             notidocu1.Opportunity__c=opp.id;
             notidocu1.CategoryDocandPro__c='Cost Breakup Document'; 
             insert notidocu1; 
                 
                //Plant object dummy data
                 Plant__c pl=new Plant__c();
                 pl.Name='MeadowsExt';   
                 pl.Project__c='cosmolis';  
                 insert pl;                 
         
                     Test.startTest();
                     //Form running information
                         Test.setCurrentPageReference(new PageReference('Page.Brigaden_Notificationdocumentspage'));     
                         
                      //Javascript data getting on the controller,That data passing  here                                      
                         Notification_Documents__c notidocu=new Notification_Documents__c (); 
                          ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:name2','testname'); 
                          ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:active2','testname');
                          ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:notifictions2','okperfect');
                          ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:Plant2','MeadowsExt');  
                        //  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:opp2','BG Meadows-Type C');  
                            
                      //Calling the standard controller extension controller                                   
                         ApexPages.StandardController controller = new ApexPages.StandardController(notidocu);
                         Brigade_NotificationsDocuments bridgenotidocu=new Brigade_NotificationsDocuments(controller ); 
                          
                 //  bridgenotidocu.SaveDocu(); 
                   Blob b = Blob.valueOf('Test Data forasfccadddfd');
                   bridgenotidocu.mydoc.Body =  b;
                   bridgenotidocu.mydoc.Name = 'test';
                  // bridgenotidocu.myDoc.Body.size() =309711;
                   bridgenotidocu.SaveDocu();    
                   
                   
                 
                   bridgenotidocu.mydoc.Name = 'test';  
         
            Test.stopTest();     
         
         }
         
         //Depending on drop down selection Display the Document data
          public static testmethod void docuprojecctspecificdocumnetmethod(){
          //Create document data
          Attachment mydoc = new Attachment();
          //Url information
           String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
           
           //Notification_Documents__c notidocu1=new Notification_Documents__c (); 
                  
             //Dummy data on Notification_Documents__c 
                 Plant__c pl=new Plant__c();
                 pl.Name='MeadowsExt';   
                 pl.Project__c='cosmolis';  
                 insert pl;             
             
             account a=new account();
             a.name='tets';
             insert a;
             
             opportunity opp=new opportunity();
             opp.name='test2';
             opp.accountid=a.id;
             opp.StageName='Discussion';
             opp.CloseDate=system.today();
             insert opp;
           
                 Test.startTest();
                 //Form running information
                  Test.setCurrentPageReference(new PageReference('Page.Brigaden_Notificationdocumentspage'));
                  
                 Notification_Documents__c notidocu1=new Notification_Documents__c ();
                 notidocu1.Notification_Type__c='Document';
                 notidocu1.Active__c=true;
                 notidocu1.Name__c='test';
                 notidocu1.Notifications__c='Test for text';
                 notidocu1.CategoryDocandPro__c='Project Specific Documents';
                 notidocu1.Plant__c=Pl.id;
                 notidocu1.Opportunity__c=opp.id;
                 notidocu1.CategoryDocandPro__c='Cost Breakup Document'; 
                 insert notidocu1;
                  
                  //Javascript data getting on the controller,That data passing  here     
                  Notification_Documents__c notidocu=new Notification_Documents__c ();                               
                  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:name2','testname'); 
                  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:active2','testname');
                  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:notifictions2','okperfect');
                  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:Plant2','MeadowsExt'); 
                //  ApexPages.currentPage().getParameters().put('page:frm2:Pbc2:sec2:opp2','BG Meadows-Type C'); 
                 
                  //Calling the standard controller extension controller            
                  ApexPages.StandardController controller = new ApexPages.StandardController(notidocu);
                  Brigade_NotificationsDocuments bridgenotidocu=new Brigade_NotificationsDocuments(controller ); 
                   
                   Blob b = Blob.valueOf('Test Data forasfccadddfdureyuewyruyweruiyruyriuyeiryeiryewiryiewyrieyr');
                   bridgenotidocu.mydoc.Body = b;
                   bridgenotidocu.mydoc.Name = 'test';
                   bridgenotidocu.SaveDocu();                  
                 
                 
                   
                                  
                    Blob b1 = Blob.valueOf('Te');
                    bridgenotidocu.mydoc.Body = b1;
                    bridgenotidocu.mydoc.Name = 'test';
                      
                    bridgenotidocu.SaveDocu();
                                     
                         
                   Test.stopTest();         
          
          }    
 }