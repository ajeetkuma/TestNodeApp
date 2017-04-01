//test class for cp user creation
@isTest
private class CPUserCreationTestClass {
    static testMethod void cpUserTest(){
        //varibale declaration
        List<Contact> conList = new List<Contact>();
        
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
        
        //Account creation
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
        insert acc;
        
        //contact creation
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
        insert con;
        //contact creation
        Contact con1 = new Contact();
        con1.AccountId = acc.id;
        con1.LastName = 'Shetty&Shetty';
        con1.Contact_Type__c = 'Second Applicant';
        con1.Email = 'developer@extentor.com';
        con1.Birthdate = system.today();
        con1.MobilePhone = '9731833566';
        con1.MailingStreet = 'Devasandra main road';
        con1.MailingCity = 'Bangalore';
        con1.MailingState = 'Karnataka';
        con1.MailingCountry = 'India';
        con1.MailingPostalCode = '560036';
        con1.Company__c = 'Brigade';
        con1.Designation__c = 'General manager';
        con1.Educational_Qualification__c = 'MBA';
        con1.Profession__c = 'Services & Markerting';
        con1.Industry__c = 'IT';
        //con1.Income_Tax_PAN_GIR_No__c = 'dFG45GH';
        con1.Portal_Access__c = true;
        insert con1;
        
        //intialization batch class
        Test.startTest();
            CP_User_Creation cpuser = new CP_User_Creation();
            ID batchprocessid = Database.executeBatch(cpuser);
        Test.StopTest();  
        
        
    }
}