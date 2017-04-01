@isTest(SeeAllData =True)
   
    private class testCPprofileCreationpage{    
       
        public static testmethod void testCPprofilemeth() {
        
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];  
                  
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
        
            //Acccount Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            a.recordTypeId=rt.id;
            insert a; 
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
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
            c.recordTypeId=rt1.id;
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;              
           
            //Unit Information
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
                                
             //CpProperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.Id;
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;  
                                         
            
            //BGProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();         
            bgprofile.name='test';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.CPprofile_Mobile__c='3245344454';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
             bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c ='wew';
            bgprofile.CPprofile_MirroringStreet2__c ='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c ='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c ='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c ='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c ='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c ='India';
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            bgprofile.CPprofile_MirroringDesignation__c ='It';
            bgprofile.CPprofile_MirroringIndustry__c ='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c ='mca';
            bgprofile.CPprofile_MirroringProfession__c ='sda';
            
            bgprofile.User__c=u.id; 
            bgprofile.contact__c=c.id;
            
            insert bgprofile;
            
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            
            update bgprofile;
            
            Test.startTest();
                                                    
            CPprofileCreationpagecon bgprofileCON=new CPprofileCreationpagecon();
                     
            BG_CPprofile__c Cpprofileobj=new BG_CPprofile__c ();  
              
            bgprofileCON.CPprofileObj2 =bgprofile;  
            bgprofileCON.updatepage(); 
                     
           Test.stopTest();    
    
   }
   
   
    public static testmethod void testCPprofilemethod() {
        
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];  
                  
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
        
            //Acccount Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            a.recordTypeId=rt.id;
            insert a; 
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
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
            c.recordTypeId=rt1.id;
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;              
           
            //Unit Information
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
                                
             //CpProperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.Id;
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;  
                                         
            
            //BGProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();         
            bgprofile.name='test';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.CPprofile_Mobile__c='3245344454';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
            bgprofile.CPprofile_MirroringIndustry__c='NONIT';
            bgprofile.CPprofile_MirroringProfession__c='JOSA';
            bgprofile.CPprofile_MirrorEducationalQualification__c='DEF';  
            bgprofile.CPprofile_MirroringDesignation__c='IEDIW';
            bgprofile.CPprofile_MirroringCompany__c='WEFW';
            //bgprofile.Mailing_Address__c='ASDA,ASD';
            bgprofile.CPprofile_Profession__c='ETSFRO'; 
            bgprofile.CPprofile_MailingStreet__c='SADSA';
            bgprofile.CPprofile_HouseNumber__c='231';
            bgprofile.CPprofile_BillingCity__c='KARNATAKA';
            bgprofile.CPprofile_Street1__c='HASDA';
            bgprofile.CPprofile_Street2__c='SDHISA';
            bgprofile.CPprofile_Street3__c='ADA';
            bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c ='wew';
            bgprofile.CPprofile_MirroringStreet2__c ='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c ='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c ='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c ='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c ='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c ='India';
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            bgprofile.CPprofile_MirroringDesignation__c ='It';
            bgprofile.CPprofile_MirroringIndustry__c ='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c ='mca';
            bgprofile.CPprofile_MirroringProfession__c ='sda';
            bgprofile.User__c=u.id; 
            bgprofile.contact__c=c.id;
            insert bgprofile;           
            
            system.debug('2222222222222222222222bgprofile'+bgprofile);
             bgprofile.CPprofile_MirroringEmailForCommunication__c='dev@extentor.com';                      
             update bgprofile;
             
             
              Task t= new task();
              //t.OwnerId = pl.Id;
              t.Whatid = opp.id;
              t.Whoid = bgprofile.Contact__c;
              t.Subject = 'Portal user updated personal information';
              t.ActivityDate = system.today()+1;
              insert t;
           
             system.runas(u) {
           
               Test.startTest();                     
             
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'To be verified by Portal administration ');
                     ApexPages.addMessage(myMsg); 
                     Apexpages.currentpage().getparameters().put('flag','true');
                     
                     CPprofileCreationpagecon bgprofileCON=new CPprofileCreationpagecon();
                     
                     bgprofileCON.headerCountry1=cpproperity.Opportunity_Id__c;
                     u.OpportunityId__c=cpproperity.Opportunity_Id__c;
                     update u;
                    // bgprofileCON.CPprofileObj2=bgprofile;
                     
                     bgprofileCON.flag ='true'; 
                     bgprofileCON.cancelpage();
                     bgprofileCON.searchPage();                                        
                     
                  //   bgprofileCON.updatepage();
                                          
                    
                      
                     bgprofileCON.getReopenPopup();
                     bgprofileCON.cpProfile();
                     
                     bgprofileCON.getCountries();
                     bgprofileCON.countryDetails();
                     bgprofileCON.getItems();
                     
           Test.stopTest();
    
      }
    
   }
   
   
   public static testmethod void testCPprofilemethod1() {
        
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];  
                  
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
        
            //Acccount Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            a.recordTypeId=rt.id;
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
            c.recordTypeId=rt1.id;
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;              
           
            //Unit Information
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
                                
             //CpProperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.Id;
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;  
                                         
            
            //BGProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();         
            bgprofile.name='test';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.CPprofile_Mobile__c='3245344454';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
            bgprofile.CPprofile_MirroringIndustry__c='NONIT';
            bgprofile.CPprofile_MirroringProfession__c='JOSA';
            bgprofile.CPprofile_MirrorEducationalQualification__c='DEF';  
            bgprofile.CPprofile_MirroringDesignation__c='IEDIW';
            bgprofile.CPprofile_MirroringCompany__c='WEFW';
            //bgprofile.Mailing_Address__c='ASDA,ASD';
            bgprofile.CPprofile_Profession__c='ETSFRO'; 
            bgprofile.CPprofile_MailingStreet__c='SADSA';
            bgprofile.CPprofile_HouseNumber__c='231';
            bgprofile.CPprofile_BillingCity__c='KARNATAKA';
            bgprofile.CPprofile_Street1__c='HASDA';
            bgprofile.CPprofile_Street2__c='SDHISA';
            bgprofile.CPprofile_Street3__c='ADA';
            bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c ='wew';
            bgprofile.CPprofile_MirroringStreet2__c ='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c ='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c ='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c ='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c ='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c ='India';
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            bgprofile.CPprofile_MirroringDesignation__c ='It';
            bgprofile.CPprofile_MirroringIndustry__c ='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c ='mca';
            bgprofile.CPprofile_MirroringProfession__c ='sda';
            bgprofile.User__c=u.id; 
            bgprofile.contact__c=c.id;
            insert bgprofile; 
                       
             system.runas(u) {
               Test.startTest();   
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'To be verified by Portal administration ');
                     ApexPages.addMessage(myMsg); 
                     Apexpages.currentpage().getparameters().put('flag','true');
                     
                     CPprofileCreationpagecon bgprofileCON=new CPprofileCreationpagecon();                      
                     bgprofileCON.flag ='true'; 
                     bgprofileCON.cancelpage();
                     bgprofileCON.searchPage();
                     bgprofileCON.getReopenPopup();
                     bgprofileCON.cpProfile();
                     bgprofileCON.getCountries();
                    // bgprofileCON.countryDetails();
                     bgprofileCON.getItems();
                     
           Test.stopTest();
    
      }
    
   }
   
   public static testmethod void testCPprofilemethod2() {
        
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];  
                  
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
        
            //Acccount Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            a.recordTypeId=rt.id;
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
            c.recordTypeId=rt1.id;
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;              
           
            //Unit Information
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
                                
             //CpProperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=userinfo.getuserid();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            contactRecursiveHelper.createProjectDocs  = true;
            Insert cpproperity;  
                                         
            
            //BGProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();         
            bgprofile.name='test';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.CPprofile_Mobile__c='3245344454';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
            bgprofile.CPprofile_MirroringIndustry__c='NONIT';
            bgprofile.CPprofile_MirroringProfession__c='JOSA';
            bgprofile.CPprofile_MirrorEducationalQualification__c='DEF';  
            bgprofile.CPprofile_MirroringDesignation__c='IEDIW';
            bgprofile.CPprofile_MirroringCompany__c='WEFW';
            //bgprofile.Mailing_Address__c='ASDA,ASD';
            bgprofile.CPprofile_Profession__c='ETSFRO'; 
            bgprofile.CPprofile_MailingStreet__c='SADSA';
            bgprofile.CPprofile_HouseNumber__c='231';
            bgprofile.CPprofile_BillingCity__c='KARNATAKA';
            bgprofile.CPprofile_Street1__c='HASDA';
            bgprofile.CPprofile_Street2__c='SDHISA';
            bgprofile.CPprofile_Street3__c='ADA';
            bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c ='wew';
            bgprofile.CPprofile_MirroringStreet2__c ='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c ='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c ='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c ='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c ='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c ='India';
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            bgprofile.CPprofile_MirroringDesignation__c ='It';
            bgprofile.CPprofile_MirroringIndustry__c ='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c ='mca';
            bgprofile.CPprofile_MirroringProfession__c ='sda';
            bgprofile.User__c=u.id; 
            bgprofile.contact__c=c.id;
            insert bgprofile;           
            
            
            
             system.runas(u) {
           
               Test.startTest();                     
             
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'To be verified by Portal administration ');
                     ApexPages.addMessage(myMsg); 
                     Apexpages.currentpage().getparameters().put('flag','true');
                     
                     CPprofileCreationpagecon bgprofileCON=new CPprofileCreationpagecon();
                     
                     bgprofileCON.headerCountry1=cpproperity.Opportunity_Id__c;
                     u.OpportunityId__c=cpproperity.Opportunity_Id__c;
                     update u;
                     
                     
                     bgprofileCON.flag ='true'; 
                     bgprofileCON.cancelpage();
                     bgprofileCON.searchPage();
                   
                      
                     bgprofileCON.getReopenPopup();
                     bgprofileCON.cpProfile();
                     
                     bgprofileCON.getCountries();
                     bgprofileCON.countryDetails();
                     bgprofileCON.getItems();
                     
           Test.stopTest();
    
      }
    
   }
   
    public static testmethod void testCPprofilemethod3() {
        
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];  
                  
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
        
            //Acccount Information
            account a=new account();
            a.name='Mehulkumar Navinchandra';
            a.recordTypeId=rt.id;
            insert a; 
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
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
            c.recordTypeId=rt1.id;
            insert c; 
            
            //Plant Information                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;              
           
            //Unit Information
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
                                
             //CpProperity Information
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=userinfo.getuserid();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            contactRecursiveHelper.createProjectDocs  = true;
            Insert cpproperity;  
                                         
            
            //BGProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();         
            bgprofile.name='test';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.CPprofile_Mobile__c='3245344454';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
            bgprofile.CPprofile_MirroringIndustry__c='NONIT';
            bgprofile.CPprofile_MirroringProfession__c='JOSA';
            bgprofile.CPprofile_MirrorEducationalQualification__c='DEF';  
            bgprofile.CPprofile_MirroringDesignation__c='IEDIW';
            bgprofile.CPprofile_MirroringCompany__c='WEFW';
            //bgprofile.Mailing_Address__c='ASDA,ASD';
            bgprofile.CPprofile_Profession__c='ETSFRO'; 
            bgprofile.CPprofile_MailingStreet__c='SADSA';
            bgprofile.CPprofile_HouseNumber__c='231';
            bgprofile.CPprofile_BillingCity__c='KARNATAKA';
            bgprofile.CPprofile_Street1__c='HASDA';
            bgprofile.CPprofile_Street2__c='SDHISA';
            bgprofile.CPprofile_Street3__c='ADA';
            bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c ='wew';
            bgprofile.CPprofile_MirroringStreet2__c ='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c ='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c ='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c ='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c ='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c ='India';
            bgprofile.CPprofile_MirroringCompany__c ='extentor';
            bgprofile.CPprofile_MirroringDesignation__c ='It';
            bgprofile.CPprofile_MirroringIndustry__c ='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c ='mca';
            bgprofile.CPprofile_MirroringProfession__c ='sda';
            bgprofile.User__c=u.id; 
            bgprofile.contact__c=c.id;
            insert bgprofile;              
           
               Test.startTest();                     
             
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'To be verified by Portal administration ');
                     ApexPages.addMessage(myMsg); 
                     Apexpages.currentpage().getparameters().put('flag','true');
                     
                     CPprofileCreationpagecon bgprofileCON=new CPprofileCreationpagecon();
                     
                                       
                     
                     bgprofileCON.flag ='true'; 
                     bgprofileCON.cancelpage();
                     bgprofileCON.searchPage();
                   
                      
                     bgprofileCON.getReopenPopup();
                     bgprofileCON.cpProfile();
                     
                     
                     
                    
                     
                    // bgprofileCON.updatepage();
                    
                     bgprofileCON.getItems();
                     
           Test.stopTest();
    
   }
   
   

}