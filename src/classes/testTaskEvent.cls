@isTest
public class testTaskEvent{
    public static testMethod void testTaskEvent(){
        account a=new account();
        a.name='Subas Mallick';
        insert a; 
        
        Plant__c pl=new Plant__c();
        pl.Name='Meadows';  
        pl.Admin_Email__c='deve@fmail.com';
        pl.Project__c='Cosmopolis';
        pl.Allowed_portal_access__c=true;
        insert pl;
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
        
        Unit__c uc=new Unit__c();
        uc.Name='bridage';
        uc.Plant__c=pl.Id;
        insert uc; 
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
        
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=uc.Id;
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
        //Contact Information                
        contact c=new contact();
        c.lastname='Mehulkumar NavinchandraPancholi';
        c.Contact_Type__c='First Applicant';
        c.email='developer@extentor.com';
        c.accountid=a.id;
        insert c; 
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);   
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angel es', UserName='standarduser@testorg.com');
        //insert u;
        
        Lead ld=new Lead();
        ld.FirstName='Subas';
        ld.LastName='Mallick';
        ld.Company='Extentor';
        ld.Status='Open';
        ld.LeadSource='Agent';
        ld.Mode_of_Enquiry__c='Chat';
        ld.Date_of_Enquiry__c=system.today();
        ld.Email='subasy2kkw@extgmail.com';
        insert ld;
        
        Task t = new Task();
        t.OwnerId=UserInfo.getUserId();
        t.Subject='Repeated Site Visit';
        t.WhatId= Opp.Id;
        t.ActivityDate=system.today();
        t.Status='In Progress';
        t.Priority='High';
        insert t;
        
        Event e = new Event();
        e.OwnerId=UserInfo.getUserId();
        e.Subject='Repeated Site Visit';
        e.WhatId= opp.Id;
        e.EndDateTime=system.today()+1;
        e.StartDateTime=system.today();
        insert e;
        
        Task t2 = new Task();
        t2.OwnerId=UserInfo.getUserId();
        t2.Subject='Repeated Site Visit';
        t2.WhoId= ld.Id;
        t2.ActivityDate=system.today();
        t2.Status='In Progress';
        t2.Priority='High';
        insert t2;
        
        Event e2 = new Event();
        e2.OwnerId=UserInfo.getUserId();
        e2.Subject='Repeated Site Visit';
        e2.WhoId= ld.Id;
        e2.EndDateTime=system.today()+1;
        e2.StartDateTime=system.today();
        insert e2;
        
        Task t3 = new Task();
        t3.OwnerId=UserInfo.getUserId();
        t3.Subject='Repeated Site Visit';
        t3.WhoId= c.Id;
        t3.ActivityDate=system.today();
        t3.Status='In Progress';
        t3.Priority='High';
        insert t3;
        
        Event e3 = new Event();
        e3.OwnerId=UserInfo.getUserId();
        e3.Subject='Repeated Site Visit';
        e3.WhoId= c.Id;
        e3.EndDateTime=system.today()+1;
        e3.StartDateTime=system.today();
        insert e3;
    }
    
}