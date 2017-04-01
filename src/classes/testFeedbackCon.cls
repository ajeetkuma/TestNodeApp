@isTest(SeeAllData =false)
   
    private class testFeedbackCon {    
    
        public static testmethod void testFeedbackCon () {
            
            //Account Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
        
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            opp.Handover_Feed_back_form__c=false;            
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Execution_without_modification_Feed_back__c=false;         
            insert opp; 
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;            
           
            //User Infromation
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',OpportunityId__c=opp.id, 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
             //Cpproperity Information  
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
            // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;            
            Insert cpproperity;  
            
           
           // insert u; 
            system.runas(u) {
            
            Test.startTest();          
            
                Test.setCurrentPageReference(new PageReference('Page.feedback')); 
                 
                 FeedbackCon Feeb=new FeedbackCon ();             
                 Feeb.getCountries();
                 Feeb.getItems();
                 Feeb.getReopenPopup (); 
                 feeb.usr.OpportunityId__c=opp.id;
                 feeb.headerCountry1=opp.id;
                 Feeb.countryDetails();    
                 
                 u.OpportunityId__c=Feeb.headerCountry1;
                 update u;
                 
                          
                 
           Test.stopTest();                     
            
      }
   }
   
   
   
   
   public static testmethod void testUserOppNotnullandtruefeedback () {
            
            //Account Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
        
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            opp.Handover_Feed_back_form__c=true;            
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Execution_without_modification_Feed_back__c=true;         
            insert opp; 
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
            
            //Cpproperity Information  
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            //cpproperity.Contact_User_Id__c=UserInfo.getUserId();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
            // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;            
            Insert cpproperity;  
            
            //User Infromation
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',OpportunityId__c=opp.id, 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           // insert u; 
            system.runas(u) {
            
            Test.startTest();          
            
                Test.setCurrentPageReference(new PageReference('Page.feedback')); 
                 
                 FeedbackCon Feeb=new FeedbackCon ();             
                 Feeb.getCountries();
                 Feeb.getItems();
                 Feeb.getReopenPopup (); 
                 feeb.usr.OpportunityId__c=opp.id;
                 feeb.headerCountry1=opp.id;
                 Feeb.countryDetails();             
                 
           Test.stopTest();                     
            
      }
   }
   
      public static testmethod void testFeedbackCon2 () {
          
            //Account Information
            account a1=new account();
            a1.name='Mehulkumar Navinchandra';
            insert a1; 
        
            //Opportunity Information
            opportunity opp1=new opportunity ();
            opp1.name='test';
            opp1.AccountId=a1.id; 
            opp1.StageName='SiteVisit';
            opp1.CloseDate=System.now().date();
            opp1.X1st_year_Handover_Feedback__c=false;
            opp1.Booking_CSAT_Feed_back_form__c=false;
            opp1.Handover_Feed_back_form__c=false;            
            opp1.Execution_with_Modification_Feed_back_fo__c=false;
            opp1.Execution_without_modification_Feed_back__c=false;  
            insert opp1; 
            
            //Contact Information                
            contact c1=new contact();
            c1.lastname='Mehulkumar NavinchandraPancholi';
            c1.Contact_Type__c='FisrtApplicant';
            c1.email='developer@extentor.com';
            c1.accountid=opp1.AccountId;
            c1.Booking_CSAT_Feed_back_form__c=false;
            c1.Contact_Type__c='First Applicant';
            insert c1; 
                                
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;
             
            
            Unit__c uc1=new Unit__c();
            uc1.Name='bridage';
            uc1.Plant__c=pl1.id;
            insert uc1;             
               
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp1.id;
            Insert cpproperity1; 
             
            Test.startTest();          
            
            Test.setCurrentPageReference(new PageReference('Page.feedback'));  
            FeedbackCon Feeb=new FeedbackCon (); 
                     
            Feeb.getCountries();
            Feeb.getItems();
            Feeb.getReopenPopup (); 
            Feeb.usr.OpportunityId__c=opp1.id;
            Feeb.headerCountry1=opp1.id;
            Feeb.countryDetails();  
            
             
           Test.stopTest();         
    
      }
      
      
        public static testmethod void testuserOppnull () {
            
            //Account Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
        
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            opp.Handover_Feed_back_form__c=true;            
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Execution_without_modification_Feed_back__c=true;         
            insert opp; 
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
            
            //Cpproperity Information  
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            //cpproperity.Contact_User_Id__c=UserInfo.getUserId();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
            // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;            
            Insert cpproperity;  
            
            //User Infromation
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           // insert u; 
            system.runas(u) {
            
            Test.startTest();          
            
                Test.setCurrentPageReference(new PageReference('Page.feedback')); 
                 
                 FeedbackCon Feeb=new FeedbackCon ();             
                 Feeb.getCountries();
                 Feeb.getItems();
                 Feeb.getReopenPopup (); 
                 feeb.usr.OpportunityId__c=opp.id;
                 feeb.headerCountry1=opp.id;
                 Feeb.countryDetails();             
                 
           Test.stopTest();                     
            
      }
   }
   
   
    public static testmethod void normalmodefeedtrue() {
          
            //Account Information
            account a1=new account();
            a1.name='Mehulkumar Navinchandra';
            insert a1; 
        
            //Opportunity Information
            opportunity opp1=new opportunity ();
            opp1.name='test';
            opp1.AccountId=a1.id; 
            opp1.StageName='SiteVisit';
            opp1.CloseDate=System.now().date();
            opp1.X1st_year_Handover_Feedback__c=true;
            opp1.Booking_CSAT_Feed_back_form__c=true;
            opp1.Handover_Feed_back_form__c=true;            
            opp1.Execution_with_Modification_Feed_back_fo__c=true;
            opp1.Execution_without_modification_Feed_back__c=true;  
            insert opp1; 
            
            //Contact Information                
            contact c1=new contact();
            c1.lastname='Mehulkumar NavinchandraPancholi';
            c1.Contact_Type__c='FisrtApplicant';
            c1.email='developer@extentor.com';
            c1.accountid=opp1.AccountId;
            c1.Booking_CSAT_Feed_back_form__c=false;
            c1.Contact_Type__c='First Applicant';
            insert c1; 
                                            
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;             
            
            Unit__c uc1=new Unit__c();
            uc1.Name='bridage';
            uc1.Plant__c=pl1.id;
            insert uc1;             
               
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp1.id;
            Insert cpproperity1; 
             
            Test.startTest();          
            
            Test.setCurrentPageReference(new PageReference('Page.feedback'));  
            FeedbackCon Feeb=new FeedbackCon (); 
                     
            Feeb.getCountries();
            Feeb.getItems();
            Feeb.getReopenPopup (); 
            Feeb.usr.OpportunityId__c=opp1.id;
            Feeb.headerCountry1=opp1.id;
            Feeb.countryDetails();              
            Test.stopTest();         
    
      }
    
    
     
    
}