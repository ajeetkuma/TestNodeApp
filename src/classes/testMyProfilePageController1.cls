@isTest(SeeAllData = false)

    private class testMyProfilePageController1{
    
       private static testmethod void testMyProfilePageController1(){ 
       
           account a=new account();
           a.name='Mehulkumar Navinchandra';
           insert a; 
        
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            c.Booking_CSAT_Feed_back_form__c=false;
            c.ExecutionwithModification_Feed_back_fo__c=false;
            c.Execution_withoutmodification_Feed_back__c=false;
            c.Handover_Feed_back_form__c=false;
            c.X1st_year_Handover_Feedback__c=false;
            insert c; 
            
          Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
        
          User u = new User(Alias = 'standt', Email='Developer@extentor.com',contactid=c.id,
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',Feedback_Check__c=false,
                                LocaleSidKey='en_US', department = 'STP',MobilePhone='2345234567',ProfileId = p.Id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
         insert u;                       
        
         system.runas(u){
            Test.startTest();                     
            MyProfilePageController1 myproiflecon=new MyProfilePageController1 ();
            myproiflecon.getUser();
            myproiflecon.getIsEdit();
            myproiflecon.edit();
            myproiflecon.save();
            myproiflecon.changePassword();
            myproiflecon.cancel();
            
            Test.stopTest();    
        }                
    
   }
   
 }