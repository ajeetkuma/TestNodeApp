@isTest(SeeAllData =true)   
    private class testBrigadeHomePageControllerv1 {    
        private static testmethod void testBrigadeHomePageControllerv1 () {
        
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            opp.Handover_Feed_back_form__c=true;            
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Execution_without_modification_Feed_back__c=true;    
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);   
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',Feedback_Skip_Count__c=3, 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',//OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
             
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c='Exotica';
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='b-x-123';
            cpproperity.Opportunity_Id__c=opp.Id;
            cpproperity.Project_Name__c='Brigade Meadows-';
            Insert cpproperity;  
            
          
             Notification_Documents__c notidocu=new Notification_Documents__c ();    
             notidocu.Notification_Type__c='Text';
             notidocu.Active__c=true;
             notidocu.Name__c='test';
             notidocu.Notifications__c='Test for text';
             notidocu.Notification_Type__c='Image';
             notidocu.Notification_Type__c='Document';
             notidocu.Category__c='General';
             notidocu.Place_of_Image__c='First Section';
             notidocu.Place_of_Image__c='Second Section';
             insert notidocu;      
             
             system.runas(u){
             Test.startTest();   
                            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeHomePage'));         
             BrigadeHomePageControllerv1 homepagecontroller=new BrigadeHomePageControllerv1 (); 
            // homepagecontroller.unitnumber= cpproperity.Unit_Code__c;
             homepagecontroller.displayPopup=true;
             homepagecontroller.getProjectNotifications();
             //homepagecontroller.countryDetails();
             homepagecontroller.getItems();
             homepagecontroller.Feedback1();
             homepagecontroller.skipFeedback();
             homepagecontroller.getCountries();
            Test.stoptest();
            }
        }
        
          private static testmethod void testBrigadeHomePageControllerv12 () {
        
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            opp.Handover_Feed_back_form__c=true;            
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Execution_without_modification_Feed_back__c=true;    
            opp.Unit__c=uc.Id;
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);   
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
             
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c='Exotica';
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Project_Name__c='Brigade Meadows-';
            cpproperity.Unit_Code__c='b-x-1234';
            cpproperity.Opportunity_Id__c=opp.Id;
            //cpproperity.Project_Unit_No__c='Brigade Meadows-B-X-0702';
            Insert cpproperity;  
            
          
             Notification_Documents__c notidocu=new Notification_Documents__c ();    
             notidocu.Notification_Type__c='Text';
             notidocu.Active__c=true;
             notidocu.Name__c='test';
             notidocu.Notifications__c='Test for text';
             notidocu.Notification_Type__c='Image';
             notidocu.Notification_Type__c='Document';
             notidocu.Category__c='General';
            // notidocu.Place_of_Image__c='First Section';
            // notidocu.Place_of_Image__c='Second Section';
             insert notidocu;      
             
             system.runas(u){
             Test.startTest();   
                            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeHomePage'));         
             BrigadeHomePageControllerv1 homepagecontroller=new BrigadeHomePageControllerv1 ();
             homepagecontroller.unitnumber=cpproperity.Unit_Code__c;
             homepagecontroller.getProjectNotifications();
             homepagecontroller.countryDetails();
             homepagecontroller.getItems();
             homepagecontroller.Feedback1();
             homepagecontroller.skipFeedback();
             homepagecontroller.getCountries();
            Test.stoptest();
            }
        }
        
        private static testmethod void testBrigadeHomePageControllerv13 () {
        
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            opp.Handover_Feed_back_form__c=false;            
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Execution_without_modification_Feed_back__c=false;    
            opp.Unit__c=uc.Id;
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);   
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
             
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c='Exotica';
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Project_Name__c='Brigade Meadows-';
            cpproperity.Unit_Code__c='b-x-1234';
            cpproperity.Opportunity_Id__c=opp.Id;
            //cpproperity.Project_Unit_No__c='Brigade Meadows-B-X-0702';
            Insert cpproperity;  
            
          
             Notification_Documents__c notidocu=new Notification_Documents__c ();    
             notidocu.Notification_Type__c='Text';
             notidocu.Active__c=true;
             notidocu.Name__c='test';
             notidocu.Notifications__c='Test for text';
             notidocu.Notification_Type__c='Image';
             notidocu.Notification_Type__c='Document';
             notidocu.Category__c='General';
            // notidocu.Place_of_Image__c='First Section';
            // notidocu.Place_of_Image__c='Second Section';
             insert notidocu;      
             
             system.runas(u){
             Test.startTest();   
                            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeHomePage'));         
             BrigadeHomePageControllerv1 homepagecontroller=new BrigadeHomePageControllerv1 ();
             homepagecontroller.unitnumber=cpproperity.Unit_Code__c;
             homepagecontroller.getProjectNotifications();
             homepagecontroller.countryDetails();
             homepagecontroller.getItems();
             homepagecontroller.Feedback1();
             homepagecontroller.skipFeedback();
             homepagecontroller.getCountries();
            Test.stoptest();
            }
        }
        private static testmethod void testBrigadeHomePageControllerv14 () {
        
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            opp.Handover_Feed_back_form__c=false;            
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Execution_without_modification_Feed_back__c=false;    
            opp.Unit__c=uc.Id;
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);   
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
             
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c='Exotica';
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Project_Name__c='Brigade Meadows-';
            cpproperity.Unit_Code__c='b-x-1234';
            cpproperity.Opportunity_Id__c=opp.Id;
            //cpproperity.Project_Unit_No__c='Brigade Meadows-B-X-0702';
            Insert cpproperity;  
            
          
             Notification_Documents__c notidocu=new Notification_Documents__c ();    
             notidocu.Notification_Type__c='Text';
             notidocu.Active__c=true;
             notidocu.Name__c='test';
             notidocu.Notifications__c='Test for text';
             notidocu.Notification_Type__c='Image';
             notidocu.Notification_Type__c='Document';
             notidocu.Category__c='General';
            // notidocu.Place_of_Image__c='First Section';
            // notidocu.Place_of_Image__c='Second Section';
             insert notidocu;      
             
             system.runas(u){
             Test.startTest();   
                            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeHomePage'));         
             BrigadeHomePageControllerv1 homepagecontroller=new BrigadeHomePageControllerv1 ();
             homepagecontroller.unitnumber=cpproperity.Unit_Code__c;
             homepagecontroller.getProjectNotifications();
             homepagecontroller.countryDetails();
             homepagecontroller.getItems();
             homepagecontroller.Feedback1();
             homepagecontroller.skipFeedback();
             homepagecontroller.getCountries();
            Test.stoptest();
            }
        }
        
         
  }