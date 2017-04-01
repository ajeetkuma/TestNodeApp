@IsTest 
private with sharing class MyProfilePageControllerTest {
    private static testmethod void testSetContactFields(){
    
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
            
            //Contact Information                
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
                                
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
              
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
          //  cpproperity.Contact_User_Id__c=UserInfo.getUserId();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;  
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
             User u = new User(Alias = 'standt', Email='Developer@extentor.com',OpportunityId__c=opp.id, 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u; 
            
            system.runas(u) {
            
            Test.startTest();          
            

             MyProfilePageController myPro=new MyProfilePageController (); 
               myPro.getIsEdit();
               myPro.edit();
               myPro.save();
               myPro.changePassword();
               myPro.cancel();
               //myPro.setContactFields();
             
           Test.stopTest();                     
            
      }
    
    }
}