/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed 
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.}
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class enquiryTriggerHandler_TestClass {

    static testMethod void bothEmailAndMobileFilledAlias3UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd;abce');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void bothEmailAndMobileFilledAlias2UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd;abce');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void bothEmailAndMobileFilledAlias1UnitTest() {
        
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd;abce');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void MobileFilledAlias3UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    
    static testMethod void MobileFilledAlias2UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void MobileFilledAlias1UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void MobileFilledAlias1ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        //test.StartTest();
        checkRecursive.run = true;
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','','Internet','Showcase','Open','8088883014','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');           
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        

    }
    
    static testMethod void MobileFilledAlias2ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        //test.StartTest();
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','','Internet','Showcase','Open','8088883014','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');   
        checkRecursive.run = true;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        

    }
    
    static testMethod void MobileFilledAlias3ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        //test.StartTest();
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','','Internet','Showcase','Open','8088883014','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');   
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        

    }
    static testMethod void EmailFilledAlias3UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce;abcf');
       // Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void EmailFilledAlias2UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void EmailFilledAlias1UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd');
        //Lead[] leads = new Lead[] {ld,ld3};
        insert ld3;

    }
    static testMethod void EmailFilledAlias1ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        //ConvertedAccountId
        //ConvertedContactId
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        //test.StartTest();
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','test@gmail.com','Internet','Showcase','Open','','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');   
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        /*Database.LeadConvert dl = new Database.LeadConvert();
        dl.setLeadId(leads[0].id);
        dl.setConvertedStatus(convertStatus.MasterLabel);
        Database.LeadConvertResult lcr = Database.convertLead(dl);
        System.assertEquals(lcr.isSuccess(),true);
        lead ls = [SELECT id,isConverted FROM Lead WHERE Id =: leads[0].id];*/
        
        //system.debug(leads[0].isConverted +'isConverted');

    }
    
    static testMethod void EmailFilledAlias2ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        //ConvertedAccountId
        //ConvertedContactId
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        
        //test.StartTest();
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','test@gmail.com','Internet','Showcase','Open','','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');   
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        checkRecursive.run = true;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        /*Database.LeadConvert dl = new Database.LeadConvert();
        dl.setLeadId(leads[0].id);
        dl.setConvertedStatus(convertStatus.MasterLabel);
        Database.LeadConvertResult lcr = Database.convertLead(dl);
        System.assertEquals(lcr.isSuccess(),true);
        lead ls = [SELECT id,isConverted FROM Lead WHERE Id =: leads[0].id];*/
        
        //system.debug(leads[0].isConverted +'isConverted');

    }
    static testMethod void EmailFilledAlias3ConvertedUnitTest() {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        Account acc = new Account(Name='testAccount');
        insert acc;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='TV',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        //ConvertedAccountId
        //ConvertedContactId
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        //test.StartTest();
        Lead lead1 = BRIGADE_InitializeTestData.createConvertedLead('existing','contact','test@gmail.com','Internet','Showcase','Open','','ABCD','',con.id,acc.id,opp.id);
        insert lead1;
        Database.LeadConvert[] leadsToConvert = new Database.LeadConvert[0];       
        Database.LeadConvert converter = new Database.LeadConvert();         
        converter.setLeadId(lead1.id);                              
        converter.setAccountId(acc.id);               
        converter.setContactId(con.id);                //converter.setOwnerId('00570000000oflK');                converter.setConvertedStatus('Closed - Converted');               
        converter.setConvertedStatus('Qualified Response Awaited');             
        leadsToConvert.add( converter );         
        
        Database.ConvertLead( leadsToConvert, true );   
        system.debug(lead1+'lead1');   
        checkRecursive.run = true;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce;abcf');
        //Lead[] leads = new Lead[] {lead1,ld3};
        insert ld3;
        //test.StopTest();
        

    }
    static testMethod void noMatchFoundAlias1UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        checkRecursive.run = true;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test5@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd');
        
        insert ld3;

    }
    static testMethod void noMatchFoundAlias2UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        checkRecursive.run = true;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test3@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce');
        
        insert ld3;

    }
    static testMethod void noMatchFoundAlias3UnitTest() {
        
        User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
        insert userSalesData;
        User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
        insert userSalesData2;
        User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
        insert userSalesData3;
        Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','','ABCD','abcd;abce;abcf');
        insert ld;
        checkRecursive.run = true;
        //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
        //insert ld2;
        Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test4@gmail.com','Site Walk-in','Showcase','Open','','ABCD','abcd;abce;abcf');
        
        insert ld3;

    }
    static testMethod void MatchFoundAliasMobileUnitTest() {
        User adminuser = BRIGADE_InitializeTestData.createUser('abcq','mm','TestRM','kishlay.mathur@extentor4.com','sales4@brigade.com','234','System Administrator',null);
        insert adminuser;
        //User ad = [SELECT id FROM User WHERE Name = 'Web 2 Lead'];
        
        system.runas(adminuser){
            
            User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
            insert userSalesData;
            User userSalesData2 = BRIGADE_InitializeTestData.createUser('abce','mm','TestRM','kishlay.mathur@extentor2.com','sales2@brigade.com','234','Custom Sales User',null);
            insert userSalesData2;
            User userSalesData3 = BRIGADE_InitializeTestData.createUser('abcf','mm','TestRM','kishlay.mathur@extentor3.com','sales3@brigade.com','234','Custom Sales User',null);
            insert userSalesData3;
            //test.starttest();
            Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
            insert ld;
            
            //Lead ld2 = BRIGADE_InitializeTestData.createLead('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','abcd');
            //insert ld2;
           // test.starttest();
           checkRecursive.run = true;
            Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd;abce;abcf');
            //test.starttest();
            insert ld3;
           // test.stoptest();
        }

    }
    static testMethod void MatchFoundwithWalkinUnitTest() {
            User userSalesData = BRIGADE_InitializeTestData.createUser('abcd','mm','TestRM','kishlay.mathur@extentor1.com','sales1@brigade.com','234','Custom Sales User',null);
            insert userSalesData;
            checkRecursive.run = false;
            Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd');
            insert ld;
            checkRecursive.run = true;
            Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Site Walk-in','Showcase','Open','8088883014','ABCD','abcd');
            insert ld3;
            
            
    }
    static testMethod void MatchFoundwithoutWalkinMobileUnitTest() {
            Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','');
            insert ld;
            checkRecursive.run = true;
            Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','','Internet','Showcase','Open','8088883014','ABCD','');
            insert ld3;
    }
    static testMethod void MatchFoundwithoutWalkinEmailUnitTest() {
            Lead ld = BRIGADE_InitializeTestData.createLead('fname','lname','test4@gmail.com','Internet','Showcase','Open','','ABCD','');
            insert ld;
            checkRecursive.run = true;
            Lead ld3 = BRIGADE_InitializeTestData.createLead('fname','lname','test4@gmail.com','Internet','Showcase','Open','','ABCD','');
            insert ld3;
    }
    
}