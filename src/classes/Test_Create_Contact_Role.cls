@isTest(seeAllData = false)
private class Test_Create_Contact_Role {
    static testMethod void Test_Create_Contact_Role()
    {  
        //Account Created
        Account acc = new Account();
        acc.Name ='Sourav';
        acc.CC_Address__c='sourav.sinha@extentor.com';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.AccountId=acc.Id;
        opp.Name='Souravopp';
        opp.StageName='Site Visit';
        opp.CloseDate=system.today();
        insert opp;
        
        //Related Account Contact Created
        Contact con = new Contact();
        con.FirstName='Sourav';
        con.LastName ='Sinha';
        //con.Salutation'Mr.';
        con.Contact_Type__c='First Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        //con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        
        Opportunity op=[select id,stagename,name from Opportunity];
        system.debug('*****'+op);
        
        OpportunityContactRole opprole = new OpportunityContactRole();
        opprole.ContactId=con.Id;
        opprole.OpportunityId=opp.Id;
        insert opprole;
        
        
        
    }

    static testMethod void Test_Create_Contact_Role1()
    {
        //Account Created
        Account acc1 = new Account();
        acc1.Name ='Sourav1';
        acc1.CC_Address__c=Null;
        insert acc1;
        Opportunity opp1 = new Opportunity();
        //opp1.AccountId=acc1.Id;
        opp1.Name='Sourav1opp';
        opp1.StageName='Site Visit';
        opp1.CloseDate=system.today();
        insert opp1;
        
        //Related Account Contact Created
        Contact con1 = new Contact();
        con1.FirstName='Sourav1';
        con1.LastName ='Sinha';
        //con.Salutation'Mr.';
        con1.Contact_Type__c=Null;
        con1.email=Null;
        //con1.accountid=acc1.id;
        con1.Email=Null;
        con1.MobilePhone=Null;   
        con1.CC_Email2__c=false;   
        con1.CC_GPA__c=false;  
        con1.Email2__c=Null;
        //con.Phone='9988776655';
        con1.Mobilephone=Null;
        insert con1;
        
        
        
        OpportunityContactRole opprole1 = new OpportunityContactRole();
        opprole1.ContactId=con1.Id;
        opprole1.OpportunityId=opp1.Id;
        insert opprole1;
        
        
        
    }
    static testMethod void Test_Create_Contact_Role2()
    {
        //Account Created
        Account acc2 = new Account();
        acc2.Name ='Sourav1';
        acc2.CC_Address__c=Null;
        insert acc2;
        Opportunity opp2 = new Opportunity();
        //opp1.AccountId=acc1.Id;
        opp2.Name='Sourav1opp';
        opp2.StageName='Site Visit';
        opp2.CloseDate=system.today();
        insert opp2;
        
        
        //Related Account Contact Created
        Contact con2 = new Contact();
        con2.FirstName='Sourav1';
        con2.LastName ='Sinha';
        //con.Salutation'Mr.';
        con2.Contact_Type__c=Null;
        con2.email=Null;
        //con1.accountid=acc1.id;
        con2.Email=Null;
        con2.MobilePhone=Null;   
        con2.CC_Email2__c=false;   
        con2.CC_GPA__c=false;  
        con2.Email2__c=Null;
        //con.Phone='9988776655';
        con2.Mobilephone=Null;
        insert con2;
        Contact con3 = new Contact();
        con3.FirstName='Sourav2';
        con3.LastName ='Sinha';
        //con.Salutation'Mr.';
        con3.Contact_Type__c=Null;
        con3.email=Null;
        //con3.accountid=acc2.id;
        con3.Email=Null;
        con3.MobilePhone=Null;   
        con3.CC_Email2__c=false;   
        con3.CC_GPA__c=false;  
        con3.Email2__c=Null;
        //con.Phone='9988776655';
        con3.Mobilephone=Null;
        insert con3;
        
        
        OpportunityContactRole opprole2 = new OpportunityContactRole();
        opprole2.ContactId=con2.Id;
        opprole2.OpportunityId=opp2.Id;
        insert opprole2;
        
        
        
    }
    
    
}