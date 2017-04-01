@isTest(SeeAllData =false)

 private class testUpdatefeddbackincontact{  
      
   static testMethod void Updatefeddbackincontact() {
      
      Test.startTEst();
      
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
        
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
            opp.Execution_without_modification_Feed_back__c=true;
            insert opp; 
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=a.Id;
            c.Contact_Type__c='First Applicant';
           // c.ExecutionwithModification_Feed_back_fo__c=true;
            insert c; 
            
            Plant__c pl=new Plant__c();
            pl.Name='test';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc;             
                  
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=userinfo.getuserid();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity; 
            
            Survey__c s = new Survey__c();
            s.Name = 'Execution Feed Back1';
            s.URL__c ='/apex/salesforce.com';
            s.Submit_Response__c = 'empty';
            s.thankYouText__c ='Thank_you';
            s.thankYouLink__c='http://www.salesforce.com';
           
            insert s;    
            
             SurveyTaker__c st = new SurveyTaker__c();      
            // st.Case__c = null;
             st.Survey__c = s.id;
             st.Opportunity__c=opp.Id;
             st.Contact__c=c.Id;
            // st.User__c=userinfo.getuserid();
            insert st;
            
            
            
            
            account a1=new account();
            a1.Id=a.Id;
            a1.name='Mehulkumar Navinchandra2';
            update a1; 
        
            opportunity opp1=new opportunity ();
            opp1.Id=opp.Id;
            opp1.name='test';
            opp1.AccountId=a1.id; 
            opp1.StageName='Site Visit';
            opp1.CloseDate=System.now().date();
           // opp1.Reserving_Date__c=System.now().date();
            opp1.X1st_year_Handover_Feedback__c=true;
            Update opp1; 
            
            //Contact Information                
            contact c1=new contact();
            c1.Id=c.Id;
            c1.lastname='Mehulkumar NavinchandraPancholi';
            c1.Contact_Type__c='FisrtApplicant';
            c1.email='developer@extentor.com';
            c1.accountid=opp1.AccountId;
            c1.Contact_Type__c='First Applicant';
           // c1.X1st_year_Handover_Feedback__c=true;
            Update c1; 
            
            Survey__c s1 = new Survey__c();
            s1.Id=s.Id;
            s1.Name = '1st year Handover Feedback';
            s1.URL__c ='/apex/salesforce.com';
            s1.Submit_Response__c = 'empty';
            s1.thankYouText__c ='Thank_you';
            s1.thankYouLink__c='http://www.salesforce.com';
            update s1;  
            
            SurveyTaker__c st1 = new SurveyTaker__c();      
            st1.Id=st.Id;
             st1.Survey__c = s1.id;
             st1.Contact__c =c1.id;
            // st.User__c=userinfo.getuserid();
            update st1;            
            
            /*
            account a2=new account();
            a2.name='Mehulkumar Navinchandra';
            insert a2; 
        
            opportunity opp2=new opportunity ();
            opp2.name='test';
            opp2.AccountId=a2.id; 
            opp2.StageName='Site Visit';
            opp2.CloseDate=System.now().date();
           // opp2.Reserving_Date__c=System.now().date();
            opp2.Booking_CSAT_Feed_back_form__c=true;
            insert opp2; 
            
            //Contact Information                
            contact c2=new contact();
            c2.lastname='Mehulkumar NavinchandraPancholi';
            c2.Contact_Type__c='FisrtApplicant';
            c2.email='developer@extentor.com';
            c2.accountid=opp2.AccountId;
            c2.Contact_Type__c='First Applicant';
          //  c2.Booking_CSAT_Feed_back_form__c=true;
            insert c2; 
            
            Survey__c s2 = new Survey__c();
            s2 .Name = 'Booking CSAT Feed back form';
            s2 .URL__c ='/apex/salesforce.com';
            s2 .Submit_Response__c = 'empty';
            s2 .thankYouText__c ='Thank_you';
            s2 .thankYouLink__c='http://www.salesforce.com';
            insert s2 ;  
            
            SurveyTaker__c st2 = new SurveyTaker__c();      
            // st.Case__c = null;
             st2 .Survey__c = s2.id;
             st2 .Contact__c =c2.id;
            // st.User__c=userinfo.getuserid();
            insert st2;
            
            
            
            
            account a3=new account();
            a3.name='Mehulkumar Navinchandra';
            insert a3; 
        
            opportunity opp3=new opportunity ();
            opp3.name='test12';
            opp3.AccountId=a3.id; 
            opp3.StageName='Site Visit';
            opp3.CloseDate=System.now().date();
           // opp3.Reserving_Date__c=System.now().date();
            opp3.Execution_with_Modification_Feed_back_fo__c=true;
            insert opp3; 
            
            //Contact Information                
            contact c3=new contact();
            c3.lastname='Mehulkumar NavinchandraPancholi';
            c3.Contact_Type__c='FisrtApplicant';
            c3.email='developer@extentor.com';
            c3.accountid=opp3.AccountId;
            c3.Contact_Type__c='First Applicant';
           // c3.Execution_withoutmodification_Feed_back__c=true;
            insert c3; 
            
           */
            
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',OpportunityId__c=opp.id, 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u; 
            
           System.runAs(u){
            
            Survey__c s3 = new Survey__c();
            s3.Id=s.Id;
            s3 .Name = 'Execution Feed Back2';
            s3 .URL__c ='/apex/salesforce.com';
            s3 .Submit_Response__c = 'empty';
            s3 .thankYouText__c ='Thank_you';
            s3 .thankYouLink__c='http://www.salesforce.com';
            Update s3 ;  
            
            SurveyTaker__c st3 = new SurveyTaker__c();      
             st3.Id = st.Id;
             st3.Survey__c = s.id;
             st3.Contact__c =c.id;
            // st.User__c=userinfo.getuserid();
            update st3;
          }
            Test.stopTEst(); 

 
   }
   
   
   
 
}