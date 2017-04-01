//test class cp profile creation
@isTest
private class TestClassCPProfileCreation {
    static testMethod void cpProfileTest(){
        //varibale declaration
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
        con.Contact_Type__c = 'First Applicant';
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
        con.RecordtypeId = mastercontact.id;
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
        insert conChild1;
        
       
        
        //Profile Information        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];   
        //user creation 
           User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                      TimeZoneSidKey='America/Los_Angeles',contactid=con.Id, UserName=Math.random() + '@test.com');
         insert u;
         
        //intialization batch class
        Test.startTest();
            CP_Profile_CReation cpProfile = new CP_Profile_CReation();
            ID batchprocessid = Database.executeBatch(cpProfile);
        Test.StopTest();  
        
         AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, 
        CreatedBy.Email, CompletedDate, CreatedDate FROM AsyncApexJob WHERE Id = :batchprocessid];

       System.assertEquals('Completed', a.Status, 'AsyncApexJob Status');
        
         
     }
}