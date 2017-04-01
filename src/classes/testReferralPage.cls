//Test class for Referralcon Class 
// This Test class covers the class Referralcon

@isTest(SeeAllData = true)
    //Test class
        private class testReferralPage{    
        private static testmethod void testtestReferralPagemethod3(){ 
             try{
             
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;
             
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Handover_Feed_back_form__c=false;
            opp.Execution_without_modification_Feed_back__c=false;
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
           // opp.Reserving_Date__c=System.now().date();
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                 
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
             try{
             insert u;
             }
             catch( Exception e){
                
             }
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea; 
            
            lead lea2=new lead();
            lea2.lastName='uday';
            lea2.Company='Exte';
            lea2.Status='open';
            lea2.Mode_of_Enquiry__c='chat';
            lea2.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea2.Email='developer@gmail.com';
            lea2.Alternate_Email__c='developer123@gmail.com';
            lea2.Phone2__c='9878987878';
            lea2.MobilePhone='9861306002'; 
            lea2.Phone='1234123423';
            insert lea2; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             //ref.Description__c='test';
               ref.Email__c='adilsingh@brigadegroup.com';
               ref.Mobile__c='7760087623';
            // ref.Name__c='test';
           //  ref.Lead__c=lea.id;
            // ref.Status__c='Lead-Prospect';
            // ref.Project_Information__c='brigade';
            // ref.Plant__c=pl.id;
             insert ref;
    
            Test.startTest(); 
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
              system.runas(u){                  
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true');            
                  ApexPages.currentPage().getParameters().put('flagvalue1','true'); 
                  ApexPages.currentPage().getParameters().put('Id',ref.id); 
                    Referralcon refcon=new Referralcon(); 
                   
                   //refcon.refId=ref.id;
                    //system.assertEquals(refcon.NewReferralInformation,'fhjsfj');
                   
                   
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9902189392');
                   
                   //  refcon.NewReferralInformation.Email__c=NUll;
                   //  refcon.NewReferralInformation.Mobile__c=Null;
                   //   Referralcon.testDateValue=(date.today()-90).day();  
                      refcon.SaveReferral(); 
                    
                    
                 
                 Test.stopTest();  
               } 
              }
             catch(exception e){
             }  
                    
                 
          }
          
          private static testmethod void testtestReferralPagemethodduplicatelead(){ 
             try{
             
             BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;
             
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Handover_Feed_back_form__c=false;
            opp.Execution_without_modification_Feed_back__c=false;
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
           // opp.Reserving_Date__c=System.now().date();
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.phone='9861306002';
            lea.Phone='1234123423';
            insert lea; 
            
          /*  lead lea2=new lead();
            lea2.lastName='uday';
            lea2.Company='Exte';
            lea2.Status='open';
            lea2.Mode_of_Enquiry__c='chat';
            lea2.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea2.Email='developer@gmail.com';
            lea2.Alternate_Email__c='developer123@gmail.com';
            lea2.Phone2__c='9878987878';
            lea2.MobilePhone='9861306002'; 
            lea2.Phone='1234123423';
            insert lea2; 
         */   
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             //ref.Description__c='test';
            // ref.Email__c='developer@gmail.com';
             //ref.Mobile__c='9876543210';
            // ref.Name__c='test';
               ref.Lead__c=lea.id;
            // ref.Status__c='Lead-Prospect';
            // ref.Project_Information__c='brigade';
            // ref.Plant__c=pl.id;
               insert ref;
    
            Test.startTest(); 
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
              system.runas(u){                  
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true');            
                  ApexPages.currentPage().getParameters().put('flagvalue1','true'); 
                  
                    Referralcon refcon=new Referralcon(); 
                   
                    //system.assertEquals(refcon.NewReferralInformation,'fhjsfj');
                   
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                   
                   //  refcon.NewReferralInformation.Email__c=NUll;
                   //  refcon.NewReferralInformation.Mobile__c=Null;
                    //   Referralcon.testDateValue=(date.today()+90).day(); 
                    Referral__c ref1=new Referral__c(); 
                    ref.Lead__c=lea.id;
                    insert ref1;
                    
                      refcon.SaveReferral(); 
                    
                    
                 
                 Test.stopTest();  
               } 
              }
             catch(exception e){
             } 
                 
                    
                 
          }
          
          
           private static testmethod void lastmodifieddate(){ 
             try{
             
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;         
             
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Handover_Feed_back_form__c=false;
            opp.Execution_without_modification_Feed_back__c=false;
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
           // opp.Reserving_Date__c=System.now().date();
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            
           List<lead> testLead=[SELECT id,name,lastmodifieddate FROM Lead where lastmodifieddate=LAST_N_DAYS:100 limit 10];
           list<Lead> leadList = new list<Lead>();
            for(Lead ld : testLead){
                if(ld.lastmodifieddate.day()>date.today().day() )
                    leadList.add(ld);
            }
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.phone='9861306002';
            lea.Phone='1234123423';
          //  lea.LastModifiedDate=date.today()-18;
            insert lea; 
            
          /*  lead lea2=new lead();
            lea2.lastName='uday';
            lea2.Company='Exte';
            lea2.Status='open';
            lea2.Mode_of_Enquiry__c='chat';
            lea2.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea2.Email='developer@gmail.com';
            lea2.Alternate_Email__c='developer123@gmail.com';
            lea2.Phone2__c='9878987878';
            lea2.MobilePhone='9861306002'; 
            lea2.Phone='1234123423';
            insert lea2; 
         */   
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             //ref.Description__c='test';
             // ref.Email__c='developer@gmail.com';
             //ref.Mobile__c='9876543210';
             // ref.Name__c='test';
             // ref.Lead__c=lea.id;
             // ref.Status__c='Lead-Prospect';
             // ref.Project_Information__c='brigade';
             // ref.Plant__c=pl.id;
             // insert ref;
    
            Test.startTest(); 
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
              system.runas(u){                  
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true');            
                  ApexPages.currentPage().getParameters().put('flagvalue1','true'); 
                  
                  
                           ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','uday');
                           ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','dev@gmail.com'); 
                           ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','1234123412');
                           ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:projectValue','test');
                           ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','abs');
                  
                    Referralcon refcon=new Referralcon(); 
                   
                    //system.assertEquals(refcon.NewReferralInformation,'fhjsfj');
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                   
                   //  refcon.NewReferralInformation.Email__c=NUll;
                   //  refcon.NewReferralInformation.Mobile__c=Null;
                    
                  //  refcon.DuplicateLead=leadList[0].LastModifiedDate;
                      refcon.SaveReferral(); 
                      
                      
                    
                    
                 
                 Test.stopTest();  
              } 
              }
             catch(exception e){
             } 
                 
                    
                 
          }
            
            
      
           private static testmethod void testtestReferralPagemethod(){ 
            
            //Account Information 
            
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Handover_Feed_back_form__c=false;
            opp.Execution_without_modification_Feed_back__c=false;
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
            
            //Profile Information    
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
                                   
            //User Information 
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.Id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
             try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            //Lead Information
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
            // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            lea.COuntry_code_for_mobile__c=91;
            insert lea; 
            
            //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
             
             
             
            //CPproperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c='Exotica';
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='123-1231-qw';
            cpproperity.Active__c=true;
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.Id;
            Insert cpproperity;                
            system.debug('###############################'+cpproperity);
             
            //Refferal  Information
            Referral__c ref=new Referral__c();
            ref.Description__c='test';
            ref.Email__c='developer@gmail.com';
            ref.Mobile__c='9876543210';
            ref.Name__c='test';
            //ref.Lead__c=lea.id;
            ref.Status__c='Lead-Prospect';
            ref.Project_Information__c='brigade';
            ref.Plant__c=pl.id;
            insert ref;
            Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));           
            
            //Portal Level User Login
               system.runas(u){
                Test.startTest();                           
                    Referralcon refcon=new Referralcon();                
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();                  
                    //refcon.SaveReferral();          
                    refcon.CancelReferral();
                    refcon.last();             
                 Test.stopTest();       
               }  
           }   
           
          private static testmethod void testrunastrue(){ 
            
            
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Handover_Feed_back_form__c=true;
            opp.Execution_without_modification_Feed_back__c=true;
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c='', 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            lea.COuntry_code_for_mobile__c=91;
            insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.Id;
             Insert cpproperity;                
             system.debug('###############################'+cpproperity);
             
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
             ref.Email__c='developer@gmail.com';
             ref.Mobile__c='8765432102';
             ref.Name__c='test';
           //  ref.Lead__c=lea.id;
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c='brigade';
             ref.Plant__c=pl.id;
             insert ref;
             
             system.runas(u){
                Test.startTest();                           
                    Referralcon refcon=new Referralcon();                
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();                  
                   // refcon.SaveReferral();          
                    refcon.CancelReferral();
                    refcon.last();             
                 Test.stopTest();       
               } 
                     
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
           
      }  
      
      
       private static testmethod void testtestrunasfalse(){ 
            
            
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='xyz';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Handover_Feed_back_form__c=true;
            opp.Execution_without_modification_Feed_back__c=true;
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.Id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.COuntry_code_for_mobile__c=91;
            lea.Phone='1234123423';
            insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.Id;
             Insert cpproperity;                
             system.debug('###############################'+cpproperity);
             
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
           //  ref.Email__c='developer@gmail.com';
          //   ref.Mobile__c='9876543210';
           //  ref.Name__c='test';
           //  ref.Lead__c=lea.id;
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c='brigade';
             ref.Plant__c=pl.id;
             insert ref;
             
            system.runas(u){
                Test.startTest();                           
                    Referralcon refcon=new Referralcon();                
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();                  
                    //refcon.SaveReferral();          
                    refcon.CancelReferral();
                    refcon.last();             
                 Test.stopTest();       
              } 
            
             
           }     
          
         
      
    
    
     
      private static testmethod void testtestReferralPagemethod4(){ 
          try{  
          
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;      
          
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();
          //  opp.Reserving_Date__c=System.now().date();
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',//OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea; 
            lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea; 
            lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
           //  ref.Email__c='developer@gmail.com';
           //  ref.Name__c='test';
           //  ref.Lead__c=lea.id;
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c='brigade';
             ref.Plant__c=pl.id;
             insert ref;
            
            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
              system.runas(u){
              Test.startTest();         
                  
                 ApexPages.currentPage().getParameters().put('flagvalue','true');             
                 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');            
                
    
                  
                    Referralcon refcon=new Referralcon(); 
                   
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                    refcon.NewReferralInformation.Email__c='subasy2k@gmail.com';
                    refcon.NewReferralInformation.Mobile__c='9988776655';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','tttttt111111tt1t1t1t1t1t1t1t1t1t1tt1t1t1t1');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','sample description');
                    refcon.selectPlant=pl.name;
                    TRY{
                   // refcon.SaveReferral();  
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','tttttt11111t1');
                                                                 
                    refcon.SaveReferral(); 
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer1@gmail.com');
                  refcon.SaveReferral(); 
                 Test.stopTest();       
                } 
                          }
             catch(exception e){
             }
      }
      
      
      private static testmethod void OpportunityNull(){ 
            
            try{
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
             account a=new account();
             a.name='Mehulkumar Navinchandra';
             insert a; 
            
             opportunity opp=new opportunity ();
             opp.name='test';
             opp.AccountId=a.id; 
             opp.StageName='SiteVisit';
             opp.CloseDate=System.now().date();
             //  opp.Reserving_Date__c=System.now().date();
             opp.X1st_year_Handover_Feedback__c=true;
             opp.Handover_Feed_back_form__c=true;
             opp.Execution_without_modification_Feed_back__c=true;
             opp.Execution_with_Modification_Feed_back_fo__c=true;
             opp.Booking_CSAT_Feed_back_form__c=true;
             insert opp;
                
             //Contact Information                
             contact c=new contact();
             c.lastname='Mehulkumar NavinchandraPancholi';
             c.Contact_Type__c='FisrtApplicant';
             c.email='developer@extentor.com';
             c.accountid=opp.AccountId;
             c.Contact_Type__c='First Applicant';
             insert c; 
                
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            try{
             insert u;
             }
             catch( Exception e){
                
             }
            
             lead lea=new lead();
             lea.lastName='uday';
             lea.Company='Exte';
             lea.Status='open';
             lea.Mode_of_Enquiry__c='chat';
             lea.LeadSource='T.V';
             // lea.Date_of_Enquiry__c='January 2, 2010';
             lea.Email='developer@gmail.com';
             lea.Alternate_Email__c='developer123@gmail.com';
             lea.Phone2__c='9878987878';
             lea.MobilePhone='9861306002'; 
             lea.Phone='1234123423';
             lea.Description='test';
             lea.LastName='test';
             lea.Referred_By_Name__c=u.name;
             lea.Type_of_Apartment__c='test';
             lea.Budget__c='test';
             lea.Location__c='south';
             insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             Project__c proj = new Project__c();
             proj.Name = 'Testing Project';
             insert proj;
             
             Unit__c unit = new Unit__c();
             unit.Plant__c = pl.id;
             insert unit;
             
                                         
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Sales_Organisation__c='MyTest';
             cpproperity.Target__c='SetTarget';
             cpproperity.Name='PropertyName1123';
             cpproperity.Property_External_ID__c = 
             cpproperity.Opportunity_Id__c = opp.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;                
            
              Referral__c ref=new Referral__c();
             ref.Description__c='test';
             ref.Email__c='developer123@gmail.com';
             ref.Mobile__c='9861306002';
             ref.Name__c='test';
             ref.Lead__c=lea.id;      
             ref.Type_of_Apartment__c='test'; 
             ref.Description__c='test';
             //ref.company='test';
             //ref.Referred_By_Name__c='ydays';
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c=pl.name;
             ref.Plant__c=pl.id;
             ref.Budget__c='tets';
             ref.Location__c='south';
             ref.Lead__c=lea.id;
             insert ref;
             
             
             Referral__c ref1=new Referral__c();
             ref1.Description__c='test';
             //ref1.Email__c='developer123@gmail.com';
             ref1.Mobile__c='9861306002';
             ref1.Name__c='test';
             ref1.Lead__c=lea.id;      
             ref1.Type_of_Apartment__c='test'; 
             ref1.Description__c='test';
             //ref.company='test';
             //ref.Referred_By_Name__c='ydays';
             ref1.Status__c='Lead-Prospect';
             ref1.Project_Information__c=pl.name;
             ref1.Plant__c=pl.id;
             ref1.Budget__c='tets';
             ref1.Location__c='south';
             ref1.Lead__c=lea.id;
             insert ref1;
            
              ApexPages.currentPage().getParameters().put('Id',ref.Id); 
             Referralcon refcon1 = new Referralcon() ;
             
             Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
            // Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
                      
              system.runas(u){
              
              Test.startTest();         
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true'); 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');
                  
                    Referralcon refcon=new Referralcon(); 
                    refcon.NewReferralInformation = ref;
                    refcon.LeadSuccess=true;
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                   // refcon.NewReferralInformation.Email__c='dev@extro.com';
                  //  refcon.NewReferralInformation.Mobile__c='1231231231';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','test');            
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:projectValue','Aspen');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:typeAparment','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:area','south');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:budget','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:location','south');
                    //system.assertEquals(ANY expected, ANY actual);
                    refcon.selectPlant='Aspen';
                     refcon.LeadSuccess=true;
                    TRY{
                    refcon.SaveReferral(); 
                     refcon.LeadSuccess=true;         
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    
                 
                 Test.stopTest();       
              } 
            } 
            catch( Exception e){
                
            }  
        }  
        
        
       private static testmethod void OpportunityNotNull(){ 
            
            
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
             account a=new account();
             a.name='Mehulkumar Navinchandra';
             a.Account_Group__c = 'Z06-Housing Finance Instittion';
             a.FirstApplicant__c = true;
             a.Payment_transactions__c = 'Z001';
        
             insert a; 
            
             opportunity opp=new opportunity ();
             opp.name='test';
             opp.AccountId=a.id; 
             opp.StageName='SiteVisit';
             opp.CloseDate=System.now().date();
             //  opp.Reserving_Date__c=System.now().date();
             opp.X1st_year_Handover_Feedback__c=false;
             opp.Handover_Feed_back_form__c=false;
             opp.Execution_without_modification_Feed_back__c=false;
             opp.Execution_with_Modification_Feed_back_fo__c=false;
             opp.Booking_CSAT_Feed_back_form__c=false;
             insert opp;
                
             //Contact Information                
             contact c=new contact();
             c.lastname='Mehulkumar NavinchandraPancholi';
             c.Contact_Type__c='FisrtApplicant';
             c.email='developer@extentor.com';
             c.accountid=opp.AccountId;
             //c.Contact_Type__c='First Applicant';
             insert c; 
                
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c='006f0000004TjaYAAS', 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
             try{
             insert u;
             }
             catch( Exception e){
                
             }
            
             lead lea=new lead();
             lea.lastName='uday';
             lea.Company='Exte';
             lea.Status='open';
             lea.LastName='test';
             lea.Mode_of_Enquiry__c='chat';
             lea.LeadSource='T.V';
             // lea.Date_of_Enquiry__c='January 2, 2010';
             lea.Email='developer@gmail.com';
             lea.Alternate_Email__c='developer123@gmail.com';
             lea.Phone2__c='9878987878';
             lea.MobilePhone='9861306002'; 
             lea.Phone='1234123423';
             lea.Referred_By_Name__c=u.name;
             lea.Type_of_Apartment__c='test';
             lea.Budget__c='test';
             lea.Location__c='south';
             lea.COuntry_code_for_mobile__c=91;
             insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             /*CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;  
             */
             
               Project__c proj = new Project__c();
             proj.Name = 'Testing Project';
             insert proj;
             
             Unit__c unit = new Unit__c();
             unit.Plant__c = pl.id;
             insert unit;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Sales_Organisation__c='MyTest';
             cpproperity.Target__c='SetTarget';
             cpproperity.Name='PropertyName1123';
             cpproperity.Property_External_ID__c = 
             cpproperity.Opportunity_Id__c = opp.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;                
                          
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
            // ref.Email__c='developer@gmail.com';
            //  ref.Mobile__c='9876543210';
             ref.Name__c='test';
             ref.Type_of_Apartment__c='test';         
            //  ref.Lead__c=lea.id;
            // ref.company='abd';
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c=pl.name;
             ref.Plant__c=pl.id;
             ref.Budget__c='test';
             ref.Location__c='south';
            // ref.Referred_By_Name__c='test';
             insert ref;
             
             ApexPages.currentPage().getParameters().put('Id',ref.Id); 
             Referralcon refcon = new Referralcon() ;
             
             Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
                      
              system.runas(u){
              
              Test.startTest();         
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true'); 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');
                  
                    //Referralcon refcon=new Referralcon(); 
                   
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                    refcon.countryDetails();
                    refcon.closePopup();
                   // refcon.NewReferralInformation.Email__c='dev@extro.com';
                  //  refcon.NewReferralInformation.Mobile__c='1231231231';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','test');            
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:projectValue','Aspen');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:typeAparment','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:area','south');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:budget','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:location','south');
                  
                    refcon.selectPlant='Aspen';
                    refcon.LeadSuccess=true;
                    
                    TRY{
                    refcon.SaveReferral(); 
                     refcon.LeadSuccess=true;         
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    
                    
                    
                 
                 Test.stopTest();       
            } 
        }  
         
        private static testmethod void ReferalInfoNull(){ 
            
            try{
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
             account a=new account();
             a.name='Mehulkumar Navinchandra';
             insert a; 
            
             opportunity opp=new opportunity ();
             opp.name='test';
             opp.AccountId=a.id; 
             opp.StageName='SiteVisit';
             opp.CloseDate=System.now().date();
             //  opp.Reserving_Date__c=System.now().date();
             opp.X1st_year_Handover_Feedback__c=true;
             opp.Handover_Feed_back_form__c=true;
             opp.Execution_without_modification_Feed_back__c=true;
             opp.Execution_with_Modification_Feed_back_fo__c=true;
             opp.Booking_CSAT_Feed_back_form__c=true;
             insert opp;
                
             //Contact Information                
             contact c=new contact();
             c.lastname='Mehulkumar NavinchandraPancholi';
             c.Contact_Type__c='FisrtApplicant';
             c.email='developer@extentor.com';
             c.accountid=opp.AccountId;
             c.Contact_Type__c='First Applicant';
             insert c; 
                
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            try{
             insert u;
             }
             catch( Exception e){
                
             }
            
             lead lea=new lead();
             lea.lastName='uday';
             lea.Company='Exte';
             lea.Status='open';
             lea.Mode_of_Enquiry__c='chat';
             lea.LeadSource='T.V';
             // lea.Date_of_Enquiry__c='January 2, 2010';
             lea.Email='developer@gmail.com';
             lea.Alternate_Email__c='developer123@gmail.com';
             lea.Phone2__c='9878987878';
             lea.MobilePhone='9861306002'; 
             lea.Phone='1234123423';
             lea.Description='test';
             lea.LastName='test';
             lea.Referred_By_Name__c=u.name;
             lea.Type_of_Apartment__c='test';
             lea.Budget__c='test';
             lea.Location__c='south';
             insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             Project__c proj = new Project__c();
             proj.Name = 'Testing Project';
             insert proj;
             
             Unit__c unit = new Unit__c();
             unit.Plant__c = pl.id;
             insert unit;
             
                                         
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Sales_Organisation__c='MyTest';
             cpproperity.Target__c='SetTarget';
             cpproperity.Name='PropertyName1123';
             cpproperity.Property_External_ID__c = 
             cpproperity.Opportunity_Id__c = opp.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
             ref.Email__c=Null  ;
             ref.Mobile__c='9876543210';
             ref.Name__c='test';
             ref.Lead__c=lea.id;      
             ref.Type_of_Apartment__c='test'; 
             ref.Description__c='test';
             //ref.company='test';
             //ref.Referred_By_Name__c='ydays';
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c=pl.name;
             ref.Plant__c=pl.id;
             ref.Budget__c='tets';
             ref.Location__c='south';
             ref.Lead__c=lea.id;
             insert ref;
            
              ApexPages.currentPage().getParameters().put('Id',ref.Id); 
             Referralcon refcon1 = new Referralcon() ;
             
             Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
            // Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
                      
              system.runas(u){
              
              Test.startTest();         
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true'); 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');
                  
                    Referralcon refcon=new Referralcon(); 
                    refcon.NewReferralInformation = ref;
                    refcon.LeadSuccess=true;
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                   // refcon.NewReferralInformation.Email__c='dev@extro.com';
                  //  refcon.NewReferralInformation.Mobile__c='1231231231';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','test');            
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:projectValue','Aspen');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:typeAparment','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:area','south');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:budget','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:location','south');
                    //system.assertEquals(ANY expected, ANY actual);
                    refcon.selectPlant='Aspen';
                     refcon.LeadSuccess=true;
                    TRY{
                    refcon.SaveReferral(); 
                     refcon.LeadSuccess=true;         
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    
                 
                 Test.stopTest();       
              } 
            } 
            catch( Exception e){
                
            }  
        }  
      
         
        private static testmethod void UserInfoNull(){ 
            
            try{
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
             account a=new account();
             a.name='Mehulkumar Navinchandra';
             insert a; 
            
             opportunity opp=new opportunity ();
             opp.name='test';
             opp.AccountId=a.id; 
             opp.StageName='SiteVisit';
             opp.CloseDate=System.now().date();
             //  opp.Reserving_Date__c=System.now().date();
             opp.X1st_year_Handover_Feedback__c=true;
             opp.Handover_Feed_back_form__c=true;
             opp.Execution_without_modification_Feed_back__c=true;
             opp.Execution_with_Modification_Feed_back_fo__c=true;
             opp.Booking_CSAT_Feed_back_form__c=true;
             insert opp;
                
             //Contact Information                
             contact c=new contact();
             c.lastname='Mehulkumar NavinchandraPancholi';
             c.Contact_Type__c='FisrtApplicant';
             c.email='developer@extentor.com';
             c.accountid=opp.AccountId;
             c.Contact_Type__c='First Applicant';
             insert c; 
                
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            try{
             insert u;
             }
             catch( Exception e){
                
             }
            
             lead lea=new lead();
             lea.lastName='uday';
             lea.Company='Exte';
             lea.Status='open';
             lea.Mode_of_Enquiry__c='chat';
             lea.LeadSource='T.V';
             // lea.Date_of_Enquiry__c='January 2, 2010';
             lea.Email='developer@gmail.com';
             lea.Alternate_Email__c='developer123@gmail.com';
             lea.Phone2__c='9878987878';
             lea.MobilePhone='9861306002'; 
             lea.Phone='1234123423';
             lea.Description='test';
             lea.LastName='test';
             lea.Referred_By_Name__c=u.name;
             lea.Type_of_Apartment__c='test';
             lea.Budget__c='test';
             lea.Location__c='south';
             insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             Project__c proj = new Project__c();
             proj.Name = 'Testing Project';
             insert proj;
             
             Unit__c unit = new Unit__c();
             unit.Plant__c = pl.id;
             insert unit;
             
                                         
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Sales_Organisation__c='MyTest';
             cpproperity.Target__c='SetTarget';
             cpproperity.Name='PropertyName1123';
             cpproperity.Property_External_ID__c = 
             cpproperity.Opportunity_Id__c = opp.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
             ref.Email__c=Null  ;
             ref.Mobile__c='9876543210';
             ref.Name__c='test';
             ref.Lead__c=lea.id;      
             ref.Type_of_Apartment__c='test'; 
             ref.Description__c='test';
             //ref.company='test';
             //ref.Referred_By_Name__c='ydays';
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c=pl.name;
             ref.Plant__c=pl.id;
             ref.Budget__c='tets';
             ref.Location__c='south';
             ref.Lead__c=lea.id;
             insert ref;
            
              ApexPages.currentPage().getParameters().put('Id',ref.Id); 
             Referralcon refcon1 = new Referralcon() ;
             
             Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
            // Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
                      
              system.runas(u){
              
              Test.startTest();         
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true'); 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');
                  
                    Referralcon refcon=new Referralcon(); 
                    refcon.NewReferralInformation = ref;
                    refcon.LeadSuccess=true;
                   // refcon.testData();
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                   // refcon.NewReferralInformation.Email__c='dev@extro.com';
                  //  refcon.NewReferralInformation.Mobile__c='1231231231';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9861306002');
                    
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:userName','test');            
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:userProject','Aspen');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:userMobile','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:userEmail','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:userUnit','south');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:budget','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:Relationship','south');
                    //system.assertEquals(ANY expected, ANY actual);
                    refcon.selectPlant='Aspen';
                     refcon.LeadSuccess=true;
                    TRY{
                    refcon.SaveReferral(); 
                     refcon.LeadSuccess=true;         
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    
                 
                 Test.stopTest();       
              } 
            } 
            catch( Exception e){
                
            }  
        }  
        
           private static testmethod void OpportunityNotNullAndOppConditions(){ 
            
            
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;        
            
             account a=new account();
             a.name='Mehulkumar Navinchandra';
             a.Account_Group__c = 'Z06-Housing Finance Instittion';
             a.FirstApplicant__c = true;
             a.Payment_transactions__c = 'Z001';
        
             insert a; 
            
             opportunity opp=new opportunity ();
             opp.name='test';
             opp.AccountId=a.id; 
             opp.StageName='SiteVisit';
             opp.CloseDate=System.now().date();
             //  opp.Reserving_Date__c=System.now().date();
             opp.X1st_year_Handover_Feedback__c=false;
             opp.Handover_Feed_back_form__c=false;
             opp.Execution_without_modification_Feed_back__c=false;
             opp.Execution_with_Modification_Feed_back_fo__c=false;
             opp.Booking_CSAT_Feed_back_form__c=false;
             insert opp;
                
             //Contact Information                
             contact c=new contact();
             c.lastname='Mehulkumar NavinchandraPancholi';
             c.Contact_Type__c='FisrtApplicant';
             c.email='developer@extentor.com';
             c.accountid=opp.AccountId;
             //c.Contact_Type__c='First Applicant';
             insert c; 
                
             Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
             //try{
             insert u;
            /* }
             catch( Exception e){
                
             }*/
            
             lead lea=new lead();
             lea.lastName='uday';
             lea.Company='Exte';
             lea.Status='open';
             lea.LastName='test';
             lea.Mode_of_Enquiry__c='chat';
             lea.LeadSource='T.V';
             // lea.Date_of_Enquiry__c='January 2, 2010';
             lea.Email='developer@gmail.com';
             lea.Alternate_Email__c='developer123@gmail.com';
             lea.Phone2__c='9878987878';
             lea.MobilePhone='9861306002'; 
             lea.Phone='1234123423';
             lea.Referred_By_Name__c=u.name;
             lea.Type_of_Apartment__c='test';
             lea.Budget__c='test';
             lea.Location__c='south';
             lea.COuntry_code_for_mobile__c=91;
             insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             /*CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;  
             */
             
               Project__c proj = new Project__c();
             proj.Name = 'Testing Project';
             insert proj;
             
             Unit__c unit = new Unit__c();
             unit.Plant__c = pl.id;
             insert unit;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Sales_Organisation__c='MyTest';
             cpproperity.Target__c='SetTarget';
             cpproperity.Name='PropertyName1123';
             cpproperity.Property_External_ID__c = 
             cpproperity.Opportunity_Id__c = opp.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             Insert cpproperity;        
             
             //List<CP_Property__c>  lstCp ;  
            // lstCp.add(cpproperity);      
                          
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
             ref.Email__c='developer@gmail.com';
             ref.Mobile__c='9876543210';
             ref.Name__c='test';
            // ref.Type_of_Apartment__c='test';         
              ref.Lead__c=lea.id;
            // ref.company='abd';
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c=pl.name;
             ref.Plant__c=pl.id;
             ref.Budget__c='test';
            //ref.Location__c='south';
             //ref.Referred_By_Name__c='test';
               //ref.User_Cell__c='qwertyuiop';
             insert ref;
             
             
            
             ApexPages.currentPage().getParameters().put('Id',ref.Id); 
             Referralcon refcon         = new Referralcon() ;
            // refcon.referraldata        = lstReferal;
            // refcon.plant               = pl;
            // refcon.refDetail           = ref1;
            // refcon.listProperty2       = lstCp;
            // refcon.Imagenew            = true;
              
             Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));
                      
              system.runas(u){
              
              Test.startTest();         
                  
                  ApexPages.currentPage().getParameters().put('flagvalue','true'); 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');
                  
                    //Referralcon refcon=new Referralcon(); 
                   
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                    refcon.countryDetails();
                    refcon.closePopup();
                    
                   // refcon.NewReferralInformation.Email__c='dev@extro.com';
                  //  refcon.NewReferralInformation.Mobile__c='1231231231';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer123@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','06002');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','test');            
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:projectValue','Aspen');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:typeAparment','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:area','south');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:budget','test');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:location','south');
                  
                    refcon.selectPlant='Aspen';
                    refcon.LeadSuccess=true;
                    
                    TRY{
                    refcon.SaveReferral(); 
                     refcon.LeadSuccess=true;         
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    
                    
                    
                 
                 Test.stopTest();       
            } 
        }  
        
        
        
        
        
        
        
        
        
        
         private static testmethod void LeadDuplicate(){ 
          try{  
          
            BridageDynamicFields__c briDyn=new BridageDynamicFields__c();
            briDyn.Name='abc';
            briDyn.Email__c='abc@gmail.com';
            briDyn.Organisation_ID__c='jskj';
            briDyn.Portal_Id__c='asd';
            briDyn.URL__c='www.brigade.com';
            insert briDyn;      
          
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            insert a; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();
          //  opp.Reserving_Date__c=System.now().date();
            insert opp;
                
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            insert c; 
                
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
              
              // Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];        
                                   
             User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                    EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',//OpportunityId__c=opp.id, 
                                    LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                    TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
              try{
             insert u;
             }
             catch( Exception e){
                
             }
            
            lead lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea; 
            lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9861306002'; 
            lea.Phone='1234123423';
            insert lea;
             
            lea=new lead();
            lea.lastName='uday';
            lea.Company='Exte';
            lea.Status='open';
            lea.Mode_of_Enquiry__c='chat';
            lea.LeadSource='T.V';
           // lea.Date_of_Enquiry__c='January 2, 2010';
            lea.Email='developer@gmail.com';
            lea.Alternate_Email__c='developer123@gmail.com';
            lea.Phone2__c='9878987878';
            lea.MobilePhone='9878987878'; 
            lea.Phone='1234123423';
            insert lea; 
            
             Plant__c pl=new Plant__c();
             pl.Name='Meadows';  
             pl.Admin_Email__c='deve@fmail.com';
             pl.Project__c='cosmolis';  
             insert pl;
             
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c='Exotica';
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Active__c=true;
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             Insert cpproperity;                
            
             Referral__c ref=new Referral__c();
             ref.Description__c='test';
           //  ref.Email__c='developer@gmail.com';
           //  ref.Name__c='test';
           //  ref.Lead__c=lea.id;
             ref.Status__c='Lead-Prospect';
             ref.Project_Information__c='brigade';
             ref.Plant__c=pl.id;
             insert ref;
            
            
             //Test.setCurrentPageReference(new PageReference('Page.BrigadeReferralpage'));         
              system.runas(u){
              Test.startTest();         
                  
                 ApexPages.currentPage().getParameters().put('flagvalue','true');             
                 
                  ApexPages.currentPage().getParameters().put('flagvalue1','true');            
                
    
                  
                    Referralcon refcon=new Referralcon(); 
                   
                    refcon.CreateNewReferral(); 
                    refcon.getreferraldataAll();
                    refcon.first();
                    refcon.previous();
                    refcon.next();
                    refcon.NewReferralInformation.Email__c='developer@gmail.com';
                    refcon.NewReferralInformation.Mobile__c='9878987878';
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer@gmail.com');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:mobile','9878987878');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','t1t1t1t1t1t1');
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:description','sample description');
                    refcon.selectPlant=pl.name;
                    TRY{
                   // refcon.SaveReferral();  
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:name','t1t1t1t1t1t1');
                                                                 
                    refcon.SaveReferral(); 
                    }CATCH(EXCEPTION E){}
                    refcon.CancelReferral();
                    refcon.last();
                    //refcon.testData();
                    ApexPages.currentPage().getParameters().put('Page:Form:pblock:pbsction:email','developer1@gmail.com');
                  refcon.SaveReferral(); 
                 Test.stopTest();       
                } 
                          }
             catch(exception e){
             }
      }
      
      
        
    }