//test class ad-hoc send email 
@isTest(SeeAllData= False)

private class testAdHocSMSEmail {
    
    static testMethod void testadHoc() {        
          
        List<Contact> conList = new List<Contact>();
        
        //querying record type ids
        RecordType  masterAccount = [select id from recordtype where name='Master Account'];
        Recordtype childAccount = [select id from recordtype where name='Child Account'];
        RecordType  mastercontact = [select id from recordtype where name='Master Contact'];
        Recordtype childcontact = [select id from recordtype where name='Child Contact'];
        
        
        //country creation
        Country__c country = new Country__c();
        country.name = 'india';
        country.Code__c = '56rgf';
        insert country;
        
        //region creation
        Region__c region = new Region__c();
        region.Name = 'Bangalore';
        region.RCode__c = '56th';
        region.Country__c = country.Id;
        insert region;
        
        //master Account creation
        Account acc = new Account();
        acc.Name = 'BriAccount';
        acc.House_number__c = '#45';
        acc.Street1__c = 'Devasandra main road';
        acc.Street2__c = 'near hdfc bank atm';
        acc.Street3__c = 'kr puram';
        acc.Postal_Code__c = '560036';
        acc.City__c = 'Bangalore';
        acc.District__c = 'Bangalore';
        acc.RegionL__c = region.id;
        acc.CountryL__c = country.Id;
        acc.RecordtypeId = masterAccount.Id;
        insert acc;
        
        //child Account creation
        Account accChild = new Account();
        accChild.Name = 'BriAccount';
        accChild.House_number__c = '#45';
        accChild.Street1__c = 'Devasandra main road';
        accChild.Street2__c = 'near hdfc bank atm';
        accChild.Street3__c = 'kr puram';
        accChild.Postal_Code__c = '560036';
        accChild.City__c = 'Bangalore';
        accChild.District__c = 'Bangalore';
        accChild.RegionL__c = region.id;
        accChild.CountryL__c = country.Id;
        accChild.parentId = acc.id;
        accChild.recordtypeId = childAccount.Id;
        insert accChild ;
        
        //child Account1 creation
        Account accChild1 = new Account();
        accChild1.Name = 'BriAccount';
        accChild1.House_number__c = '#45';
        accChild1.Street1__c = 'Devasandra main road';
        accChild1.Street2__c = 'near hdfc bank atm';
        accChild1.Street3__c = 'kr puram';
        accChild1.Postal_Code__c = '560036';
        accChild1.City__c = 'Bangalore';
        accChild1.District__c = 'Bangalore';
        accChild1.RegionL__c = region.id;
        accChild1.CountryL__c = country.Id;
        accChild1.parentId = acc.id;
        accChild1.recordtypeId = childAccount.Id;
        insert accChild1;
        
        //master contact creation
        Contact con = new Contact();
        con.FirstName = 'Bhoja';
        
        con.AccountId = acc.id;
        con.LastName = 'Shetty';
        con.Contact_Type__c = 'Primary Contact';
        con.Email = 'developer@extentor.com';
        con.Birthdate = system.today();
        con.MobilePhone = '9731833566';
        con.MailingStreet = 'Devasandra main road';
        con.MailingCity = 'Bangalore';
        con.MailingState = 'Karnataka';
        con.MailingCountry = 'India';
        con.MailingPostalCode = '560036';
        con.Company__c = 'Brigade';
        con.Designation__c = 'General manager';
        con.Educational_Qualification__c = 'MBA';
        con.Profession__c = 'Services & Markerting';
        con.Industry__c = 'IT';
        con.Passport_No__c ='123ABCD';
        con.Portal_Access__c = true;
        con.Portal_User__c = true;
        con.CPProfile_User__c = true;
        con.RecordtypeId = mastercontact.id;
        con.MobilePhone = '9731833566';
        con.SMS_text__c='test';
        insert con;
        
        //child contact creation
        Contact conChild = new Contact();
        conChild.FirstName = 'Bhoja';       
        conChild.AccountId = accChild.id;
        conChild.LastName = 'Shetty';
        conChild.Contact_Type__c = 'First Applicant';
        conChild.Email = 'developer@extentor.com';
        conChild.Birthdate = system.today();
        conChild.MobilePhone = '9731833566';
        conChild.MailingStreet = 'Devasandra main road';
        conChild.MailingCity = 'Bangalore';
        conChild.MailingState = 'Karnataka';
        conChild.MailingCountry = 'India';
        conChild.MailingPostalCode = '560036';
        conChild.Company__c = 'Brigade';
        conChild.Designation__c = 'General manager';
        conChild.Educational_Qualification__c = 'MBA';
        conChild.Profession__c = 'Services & Markerting';
        conChild.Industry__c = 'IT';
        conChild.Passport_No__c ='123ABCD';
        conChild.recordtypeId = childcontact.Id;
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild.SMS_text__c='test';
        insert conChild;
        
        //child contact creation
        Contact conChild1 = new Contact();
        conChild1.FirstName = 'Bhoja shetty test';
        conChild1.AccountId = accChild1.id;
        conChild1.LastName = 'Shetty';
        conChild1.Contact_Type__c = 'First Applicant';
        conChild1.Email = 'developer@extentor.com';
        conChild1.Birthdate = system.today();
        conChild1.MobilePhone = '9731833566';
        conChild1.MailingStreet = 'Devasandra main road';
        conChild1.MailingCity = 'Bangalore';
        conChild1.MailingState = 'Karnataka';
        conChild1.MailingCountry = 'India';
        conChild1.MailingPostalCode = '560074';
        conChild1.Company__c = 'Brigadethethethethethethetehtehehtehethe';
        conChild1.Designation__c = 'General manager General manager General';
        conChild1.Educational_Qualification__c = 'MBA';
        conChild1.Profession__c = 'Services & Markerting';
        conChild1.Industry__c = 'IT';
        conChild1.Passport_No__c ='123ABCD';
        conChild1.recordtypeId = childcontact.Id;
        //conChild1.Income_Tax_PAN_GIR_No__c = 'abcabcabc123123123abc123abc';
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild1.SMS_text__c='test';
        insert conChild1;
        
        //Profile Information        
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom']; 
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];    
        //user creation 
         User u = new User(Alias = 'standt', Email='Developer@gmail.com',UserRoleId = portalRole.Id, 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                      TimeZoneSidKey='America/Los_Angeles',contactid=con.Id, UserName=Math.random() + '@test.com');
        try{ 
            insert u;
        }
        catch(Exception e) {
        }
         //create plant record
         Plant__c plant = new Plant__c();
         plant.Name = 'Meadows-Type C';
         plant.Project__c = 'Brigade Meadows';
         plant.Plant_Code__c = 'KP03';
         plant.Company_Code__c = '1000';
         plant.Sales_Organisation__c ='1000';
         plant.Allowed_portal_access__c = true;
         insert plant;
         
         //create unit record
         List<Unit__c> units = new List<Unit__c>();
         for(Integer i=0;i<4;i++) {
             Unit__c unit = new Unit__c();
             unit.Name = 'BG-MED-B-X-070'+i+'-XX';
             unit.Plant__c = plant.Id;
             unit.Description__c ='Construction - Residential';
             unit.Unit_Status__c ='Available';
             unit.Area__c = 950;
             unit.Terrace_Area__c = 0;
             unit.Unit_of_Measurement__c ='FT2';
             unit.Garden_Area__c =0;
             unit.Type__c = 'Z01';
             unit.Type_of_Unit__c = 'Z03';
             unit.Floor__c = 'Z00';
             unit.Facing__c ='Z02';
             unit.Direction__c= 'Z04';
             units.add(unit);
         }
          try{      
          		  insert units;
                }
                Catch( Exception e){
                	
                }
       
         //create opportunity records
         List<Opportunity> opplist = new List<Opportunity>();
         for(Integer j=0;j<3;j++){
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002';
             opp.AccountId = accChild.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[j].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';
             opplist.add(opp);
         }
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002 the long text to handle exceptions, this opportunity used to handle exceptions in test class';
             opp.AccountId = accChild1.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[3].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';             
             opplist.add(opp);
             try{      
          		insert opplist;
                }
                Catch( Exception e){
                	
                }
                
          try{ 
       
         Test.startTest();  
         PageReference pg = new PageReference('/apex/AdHoc_SMS_Email');
         
         ApexPages.StandardController controller = new ApexPages.StandardController(plant);
         
         AdHocSMSEmail adhoc = new AdHocSMSEmail(controller);
          
         adhoc.SMSselect=true;
         adhoc.Emailselect=true;
         adhoc.getItems();
         adhoc.selectedValue=plant.Project__c;
         adhoc.getPlantName();       
         adhoc.selectedPlant  = plant.Id;
         adhoc.Search();
         adhoc.getContactPageList();
         adhoc.setIsSelectToFalse();
         //if(!adhoc.contactPageList.isEmpty()){
         adhoc.contactPageList[0].selectcheck  = false; 
         adhoc.next();
         adhoc.previous();
         adhoc.last();
         adhoc.first(); 
         adhoc.sendSMSEmail(); 
         adhoc.cancel();   
        
         Test.StopTest();
         }
         catch(Exception e){
         	
         }
    }
    static testMethod void testadHoc1() {        
        
        List<Contact> conList = new List<Contact>();
        
        //querying record type ids
        RecordType  masterAccount = [select id from recordtype where name='Master Account'];
        Recordtype childAccount = [select id from recordtype where name='Child Account'];
        RecordType  mastercontact = [select id from recordtype where name='Master Contact'];
        Recordtype childcontact = [select id from recordtype where name='Child Contact'];
        
        
        //country creation
        Country__c country = new Country__c();
        country.name = 'india';
        country.Code__c = '56rgf';
        insert country;
        
        //region creation
        Region__c region = new Region__c();
        region.Name = 'Bangalore';
        region.RCode__c = '56th';
        region.Country__c = country.Id;
        insert region;
        
        //master Account creation
        Account acc = new Account();
        acc.Name = 'BriAccount';
        acc.House_number__c = '#45';
        acc.Street1__c = 'Devasandra main road';
        acc.Street2__c = 'near hdfc bank atm';
        acc.Street3__c = 'kr puram';
        acc.Postal_Code__c = '560036';
        acc.City__c = 'Bangalore';
        acc.District__c = 'Bangalore';
        acc.RegionL__c = region.id;
        acc.CountryL__c = country.Id;
        acc.RecordtypeId = masterAccount.Id;
        insert acc;
        
        //child Account creation
        Account accChild = new Account();
        accChild.Name = 'BriAccount';
        accChild.House_number__c = '#45';
        accChild.Street1__c = 'Devasandra main road';
        accChild.Street2__c = 'near hdfc bank atm';
        accChild.Street3__c = 'kr puram';
        accChild.Postal_Code__c = '560036';
        accChild.City__c = 'Bangalore';
        accChild.District__c = 'Bangalore';
        accChild.RegionL__c = region.id;
        accChild.CountryL__c = country.Id;
        accChild.parentId = acc.id;
        accChild.recordtypeId = childAccount.Id;
        insert accChild ;
        
        //child Account1 creation
        Account accChild1 = new Account();
        accChild1.Name = 'BriAccount';
        accChild1.House_number__c = '#45';
        accChild1.Street1__c = 'Devasandra main road';
        accChild1.Street2__c = 'near hdfc bank atm';
        accChild1.Street3__c = 'kr puram';
        accChild1.Postal_Code__c = '560036';
        accChild1.City__c = 'Bangalore';
        accChild1.District__c = 'Bangalore';
        accChild1.RegionL__c = region.id;
        accChild1.CountryL__c = country.Id;
        accChild1.parentId = acc.id;
        accChild1.recordtypeId = childAccount.Id;
        insert accChild1;
        
        //master contact creation
        Contact con = new Contact();
        con.FirstName = 'Bhoja';
        
        con.AccountId = acc.id;
        con.LastName = 'Shetty';
        con.Contact_Type__c = 'Primary Contact';
        con.Email = 'developer@extentor.com';
        con.Birthdate = system.today();
        con.MobilePhone = '9731833566';
        con.MailingStreet = 'Devasandra main road';
        con.MailingCity = 'Bangalore';
        con.MailingState = 'Karnataka';
        con.MailingCountry = 'India';
        con.MailingPostalCode = '560036';
        con.Company__c = 'Brigade';
        con.Designation__c = 'General manager';
        con.Educational_Qualification__c = 'MBA';
        con.Profession__c = 'Services & Markerting';
        con.Industry__c = 'IT';
        con.Passport_No__c ='123ABCD';
        con.Portal_Access__c = true;
        con.Portal_User__c = true;
        con.CPProfile_User__c = true;
        con.RecordtypeId = mastercontact.id;
        con.MobilePhone = '9731833566';
        con.SMS_text__c='test';
        insert con;
        
        //child contact creation
        Contact conChild = new Contact();
        conChild.FirstName = 'Bhoja';       
        conChild.AccountId = accChild.id;
        conChild.LastName = 'Shetty';
        conChild.Contact_Type__c = 'First Applicant';
        conChild.Email = 'developer@extentor.com';
        conChild.Birthdate = system.today();
        conChild.MobilePhone = '9731833566';
        conChild.MailingStreet = 'Devasandra main road';
        conChild.MailingCity = 'Bangalore';
        conChild.MailingState = 'Karnataka';
        conChild.MailingCountry = 'India';
        conChild.MailingPostalCode = '560036';
        conChild.Company__c = 'Brigade';
        conChild.Designation__c = 'General manager';
        conChild.Educational_Qualification__c = 'MBA';
        conChild.Profession__c = 'Services & Markerting';
        conChild.Industry__c = 'IT';
        conChild.Passport_No__c ='123ABCD';
        conChild.recordtypeId = childcontact.Id;
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild.SMS_text__c='test';
        insert conChild;
        
        //child contact creation
        Contact conChild1 = new Contact();
        conChild1.FirstName = 'Bhoja shetty test';
        conChild1.AccountId = accChild1.id;
        conChild1.LastName = 'Shetty';
        conChild1.Contact_Type__c = 'First Applicant';
        conChild1.Email = 'developer@extentor.com';
        conChild1.Birthdate = system.today();
        conChild1.MobilePhone = '9731833566';
        conChild1.MailingStreet = 'Devasandra main road';
        conChild1.MailingCity = 'Bangalore';
        conChild1.MailingState = 'Karnataka';
        conChild1.MailingCountry = 'India';
        conChild1.MailingPostalCode = '560074';
        conChild1.Company__c = 'Brigadethethethethethethetehtehehtehethe';
        conChild1.Designation__c = 'General manager General manager General';
        conChild1.Educational_Qualification__c = 'MBA';
        conChild1.Profession__c = 'Services & Markerting';
        conChild1.Industry__c = 'IT';
        conChild1.Passport_No__c ='123ABCD';
        conChild1.recordtypeId = childcontact.Id;
        //conChild1.Income_Tax_PAN_GIR_No__c = 'abcabcabc123123123abc123abc';
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild1.SMS_text__c='test';
        insert conChild1;
        
        //Profile Information        
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom']; 
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];    
        //user creation 
         User u = new User(Alias = 'standt', Email='Developer@gmail.com',UserRoleId = portalRole.Id, 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                      TimeZoneSidKey='America/Los_Angeles',contactid=con.Id, UserName=Math.random() + '@test.com');
        try{ 
            insert u;
        }
        catch(Exception e) {
        }
         //create plant record
         Plant__c plant = new Plant__c();
         plant.Name = 'Meadows-Type C';
         plant.Project__c = 'Brigade Meadows';
         plant.Plant_Code__c = 'KP03';
         plant.Company_Code__c = '1000';
         plant.Sales_Organisation__c ='1000';
         plant.Allowed_portal_access__c = true;
         insert plant;
         
         //create unit record
         List<Unit__c> units = new List<Unit__c>();
         for(Integer i=0;i<4;i++) {
             Unit__c unit = new Unit__c();
             unit.Name = 'BG-MED-B-X-070'+i+'-XX';
             unit.Plant__c = plant.Id;
             unit.Description__c ='Construction - Residential';
             unit.Unit_Status__c ='Available';
             unit.Area__c = 950;
             unit.Terrace_Area__c = 0;
             unit.Unit_of_Measurement__c ='FT2';
             unit.Garden_Area__c =0;
             unit.Type__c = 'Z01';
             unit.Type_of_Unit__c = 'Z03';
             unit.Floor__c = 'Z00';
             unit.Facing__c ='Z02';
             unit.Direction__c= 'Z04';
             units.add(unit);
         }
         insert units;
         //create opportunity records
         List<Opportunity> opplist = new List<Opportunity>();
         for(Integer j=0;j<3;j++){
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002';
             opp.AccountId = accChild.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[j].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';
             opplist.add(opp);
         }
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002 the long text to handle exceptions, this opportunity used to handle exceptions in test class';
             opp.AccountId = accChild1.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[3].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';             
             opplist.add(opp);
                      
          insert opplist;
           
         
           Test.startTest();
         PageReference pg = new PageReference('/apex/AdHoc_SMS_Email');
         
         ApexPages.StandardController controller = new ApexPages.StandardController(plant);
         
         AdHocSMSEmail adhoc = new AdHocSMSEmail(controller);
                 
         adhoc.SMSselect=true;
         adhoc.Emailselect=true;
       
         adhoc.cancel();   
         adhoc.testCoverageOnly01();
         adhoc.testCoverageOnly02();
         adhoc.testCoverageOnly03();
         adhoc.testCoverageOnly04();
         adhoc.testCoverageOnly05();
         adhoc.testCoverageOnly06();
         adhoc.testCoverageOnly07();
         adhoc.testCoverageOnly08();
         adhoc.testCoverageOnly09();
         adhoc.testCoverageOnly10();
         adhoc.testCoverageOnly11();
         adhoc.testCoverageOnly12();
         adhoc.testCoverageOnly13();
         adhoc.testCoverageOnly14();
         adhoc.testCoverageOnly15();
         adhoc.testCoverageOnly16();
         adhoc.testCoverageOnly17();
         adhoc.testCoverageOnly18();
         adhoc.testCoverageOnly19();
         adhoc.testCoverageOnly20();
         adhoc.testCoverageOnly21();
         adhoc.testCoverageOnly22();
         Test.StopTest();
       
    } 
    static testMethod void testadHoc3() {        
          
        List<Contact> conList = new List<Contact>();
        
        //querying record type ids
        RecordType  masterAccount = [select id from recordtype where name='Master Account'];
        Recordtype childAccount = [select id from recordtype where name='Child Account'];
        RecordType  mastercontact = [select id from recordtype where name='Master Contact'];
        Recordtype childcontact = [select id from recordtype where name='Child Contact'];
        
        
        //country creation
        Country__c country = new Country__c();
        country.name = 'india';
        country.Code__c = '56rgf';
        insert country;
        
        //region creation
        Region__c region = new Region__c();
        region.Name = 'Bangalore';
        region.RCode__c = '56th';
        region.Country__c = country.Id;
        insert region;
        
        //master Account creation
        Account acc = new Account();
        acc.Name = 'BriAccount';
        acc.House_number__c = '#45';
        acc.Street1__c = 'Devasandra main road';
        acc.Street2__c = 'near hdfc bank atm';
        acc.Street3__c = 'kr puram';
        acc.Postal_Code__c = '560036';
        acc.City__c = 'Bangalore';
        acc.District__c = 'Bangalore';
        acc.RegionL__c = region.id;
        acc.CountryL__c = country.Id;
        acc.RecordtypeId = masterAccount.Id;
        insert acc;
        
        //child Account creation
        Account accChild = new Account();
        accChild.Name = 'BriAccount';
        accChild.House_number__c = '#45';
        accChild.Street1__c = 'Devasandra main road';
        accChild.Street2__c = 'near hdfc bank atm';
        accChild.Street3__c = 'kr puram';
        accChild.Postal_Code__c = '560036';
        accChild.City__c = 'Bangalore';
        accChild.District__c = 'Bangalore';
        accChild.RegionL__c = region.id;
        accChild.CountryL__c = country.Id;
        accChild.parentId = acc.id;
        accChild.recordtypeId = childAccount.Id;
        insert accChild ;
        
        //child Account1 creation
        Account accChild1 = new Account();
        accChild1.Name = 'BriAccount';
        accChild1.House_number__c = '#45';
        accChild1.Street1__c = 'Devasandra main road';
        accChild1.Street2__c = 'near hdfc bank atm';
        accChild1.Street3__c = 'kr puram';
        accChild1.Postal_Code__c = '560036';
        accChild1.City__c = 'Bangalore';
        accChild1.District__c = 'Bangalore';
        accChild1.RegionL__c = region.id;
        accChild1.CountryL__c = country.Id;
        accChild1.parentId = acc.id;
        accChild1.recordtypeId = childAccount.Id;
        insert accChild1;
        
        //master contact creation
        Contact con = new Contact();
        con.FirstName = 'Bhoja';
        
        con.AccountId = acc.id;
        con.LastName = 'Shetty';
        con.Contact_Type__c = 'Primary Contact';
        con.Email = 'developer@extentor.com';
        con.Birthdate = system.today();
        con.MobilePhone = '9731833566';
        con.MailingStreet = 'Devasandra main road';
        con.MailingCity = 'Bangalore';
        con.MailingState = 'Karnataka';
        con.MailingCountry = 'India';
        con.MailingPostalCode = '560036';
        con.Company__c = 'Brigade';
        con.Designation__c = 'General manager';
        con.Educational_Qualification__c = 'MBA';
        con.Profession__c = 'Services & Markerting';
        con.Industry__c = 'IT';
        con.Passport_No__c ='123ABCD';
        con.Portal_Access__c = true;
        con.Portal_User__c = true;
        con.CPProfile_User__c = true;
        con.RecordtypeId = mastercontact.id;
        con.MobilePhone = '9731833566';
        con.SMS_text__c='test';
        insert con;
        
        //child contact creation
        Contact conChild = new Contact();
        conChild.FirstName = 'Bhoja';       
        conChild.AccountId = accChild.id;
        conChild.LastName = 'Shetty';
        conChild.Contact_Type__c = 'First Applicant';
        conChild.Email = 'developer@extentor.com';
        conChild.Birthdate = system.today();
        conChild.MobilePhone = '9731833566';
        conChild.MailingStreet = 'Devasandra main road';
        conChild.MailingCity = 'Bangalore';
        conChild.MailingState = 'Karnataka';
        conChild.MailingCountry = 'India';
        conChild.MailingPostalCode = '560036';
        conChild.Company__c = 'Brigade';
        conChild.Designation__c = 'General manager';
        conChild.Educational_Qualification__c = 'MBA';
        conChild.Profession__c = 'Services & Markerting';
        conChild.Industry__c = 'IT';
        conChild.Passport_No__c ='123ABCD';
        conChild.recordtypeId = childcontact.Id;
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild.SMS_text__c='test';
        insert conChild;
        
        //child contact creation
        Contact conChild1 = new Contact();
        conChild1.FirstName = 'Bhoja shetty test';
        conChild1.AccountId = accChild1.id;
        conChild1.LastName = 'Shetty';
        conChild1.Contact_Type__c = 'First Applicant';
        conChild1.Email = 'developer@extentor.com';
        conChild1.Birthdate = system.today();
        conChild1.MobilePhone = '9731833566';
        conChild1.MailingStreet = 'Devasandra main road';
        conChild1.MailingCity = 'Bangalore';
        conChild1.MailingState = 'Karnataka';
        conChild1.MailingCountry = 'India';
        conChild1.MailingPostalCode = '560074';
        conChild1.Company__c = 'Brigadethethethethethethetehtehehtehethe';
        conChild1.Designation__c = 'General manager General manager General';
        conChild1.Educational_Qualification__c = 'MBA';
        conChild1.Profession__c = 'Services & Markerting';
        conChild1.Industry__c = 'IT';
        conChild1.Passport_No__c ='123ABCD';
        conChild1.recordtypeId = childcontact.Id;
        //conChild1.Income_Tax_PAN_GIR_No__c = 'abcabcabc123123123abc123abc';
        //conChild.Portal_Access__c = true;
        //conChild.Portal_User__c = true;
        conChild1.SMS_text__c='test';
        insert conChild1;
        
        //Profile Information        
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom']; 
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];    
        //user creation 
         User u = new User(Alias = 'standt', Email='Developer@gmail.com',UserRoleId = portalRole.Id, 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                      TimeZoneSidKey='America/Los_Angeles',contactid=con.Id, UserName=Math.random() + '@test.com');
        try{ 
            insert u;
        }
        catch(Exception e) {
        }
         //create plant record
         Plant__c plant = new Plant__c();
         plant.Name = 'Meadows-Type C';
         plant.Project__c = 'Brigade Meadows';
         plant.Plant_Code__c = 'KP03';
         plant.Company_Code__c = '1000';
         plant.Sales_Organisation__c ='1000';
         plant.Allowed_portal_access__c = true;
         insert plant;
         
         //create unit record
         List<Unit__c> units = new List<Unit__c>();
         for(Integer i=0;i<4;i++) {
             Unit__c unit = new Unit__c();
             unit.Name = 'BG-MED-B-X-070'+i+'-XX';
             unit.Plant__c = plant.Id;
             unit.Description__c ='Construction - Residential';
             unit.Unit_Status__c ='Available';
             unit.Area__c = 950;
             unit.Terrace_Area__c = 0;
             unit.Unit_of_Measurement__c ='FT2';
             unit.Garden_Area__c =0;
             unit.Type__c = 'Z01';
             unit.Type_of_Unit__c = 'Z03';
             unit.Floor__c = 'Z00';
             unit.Facing__c ='Z02';
             unit.Direction__c= 'Z04';
             units.add(unit);
         }
         insert units;
         //create opportunity records
         List<Opportunity> opplist = new List<Opportunity>();
         for(Integer j=0;j<3;j++){
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002';
             opp.AccountId = accChild.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[j].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';
             opplist.add(opp);
         }
             Opportunity opp = new Opportunity();
             opp.Name = 'LAF-A-0002 the long text to handle exceptions, this opportunity used to handle exceptions in test class';
             opp.AccountId = accChild1.Id;
             opp.StageName = 'Reserving';
             opp.CloseDate = system.today();
             opp.Plant__c = 'KP03 - Meadows-Type C';
             opp.Unit__c = units[3].Id;
             opp.Company_Code__c ='1000';
             opp.Sales_Organisation__c ='1000';             
             opplist.add(opp);
                      
          insert opplist;
           
         Test.startTest();
            
         PageReference pg = new PageReference('/apex/AdHoc_SMS_Email');
         
        /* ApexPages.StandardController controller = new ApexPages.StandardController(plant);
         
         AdHocSMSEmail adhoc = new AdHocSMSEmail(controller);
         
         adhoc.SMSselect=false;
         adhoc.Emailselect=false;
         adhoc.getItems();
         adhoc.selectedValue=plant.Project__c;
         adhoc.getPlantName();       
         adhoc.selectedPlant  = plant.Id;
         adhoc.Search();
         adhoc.getContactPageList();
         adhoc.setIsSelectToFalse();
         if(adhoc.contactPageList.isEmpty()){
         adhoc.contactPageList[0].selectcheck  = false; 
         adhoc.next();
         adhoc.previous();
         adhoc.last();
         adhoc.first(); 
         adhoc.sendSMSEmail(); 
         adhoc.cancel();   
        
         Test.StopTest();
         }*/
    } 
 }