@isTest(SeeAllData =true)

private class testSendSMSUpdate{    

    static testmethod void testSendSMSUpdate(){  
                                 
            account a=new account();
            a.name='testfor';
            a.House_number__c ='2-128';
            a.Street1__c      ='LastLine';
            a.Street2__c      ='Postoffice';
            a.Street3__c      ='Nextone';
            a.Postal_Code__c  ='123456';
            a.City__c         ='bangalore';  
            a.CC_Address__c   ='wernext';      
            insert a;  
                          
            contact c=new contact();
            c.lastname='test';
            c.Contact_Type__c='First Applicant';
            c.Email ='Developer@gmail.com';
            c.accountid=a.id;
            c.MobilePhone='8884937365';
            c.Company__c='extenotr';
            c.Educational_Qualification__c ='bbm';
            c.Designation__c ='se';
            c.Profession__c ='job';
            c.Industry__c ='it';            
            insert c; 
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=c.accountid; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            
            Sale_Order_Item__c ss=new Sale_Order_Item__c();            
            ss.Opportunity__c=opp.id;
            insert ss;            
            
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=ss.id;
            ps.SendSms__c=false;
            //ps.Payment_Received_Date__c=System.now().date();
            ps.Billing_Date__c=System.now().date();
            insert ps;            
            ps.Payment_Received_Date__c=System.now().date();            
            update ps;
            ps.SendSms__c = true;
            update ps;
    }  
}