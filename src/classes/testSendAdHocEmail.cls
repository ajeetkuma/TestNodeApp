@isTest(seealldata=false)
private class testSendAdHocEmail {
    static testMethod void testSendAdHocEmail (){
        
        Account acc = new Account();
        acc.Name = 'BriAccount';
        acc.House_number__c = '#45';
        acc.Street1__c = 'Devasandra main road';
        acc.Street2__c = 'near hdfc bank atm';
        acc.Street3__c = 'kr puram';
        acc.Postal_Code__c = '560036';
        acc.City__c = 'Bangalore';
        acc.District__c = 'Bangalore';
       // acc.RegionL__c = region.id;
       // acc.CountryL__c = country.Id;
        insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Bhoja';
        con.AccountId = acc.id;
        con.LastName = 'Shetty';
        con.Contact_Type__c = 'First Applicant';
        con.Email = 'developer1@extentor.com';
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
        con.Portal_Access__c = false;
        con.De_Activate_Date_of_Portal_User__c = system.today();
        insert con;
        
        set<string> cc=new set<string>();
        cc.add(con.id);
        //Profile Information        
          Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];   
        //user creation 
         User u = new User(Alias = 'standt', Email='Developer1@gmail.com', 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                      TimeZoneSidKey='America/Los_Angeles',contactid=con.Id,IsActive = true,UserName='developer1@test.com' ,Extenal_Id__c='developer1@test.com');
         insert u;
        //intialization batch class
        Test.startTest();
         
         SendAdHocEmail sendAdhoc = new SendAdHocEmail (cc);
    
          //sendAdhoc.query = 'SELECT id, lastname from contact';
          
          ID batchprocessid = Database.executeBatch(sendAdhoc);
         
        // Database.executeBatch(new SendAdHocEmail(con));
         
        Test.StopTest(); 
    
  }
 
}