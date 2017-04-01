@isTest
public class SaveAsPdfExtension_TestClass{

    public static testMethod void agentOppUnitTest() {
        List<Contact> conList = new List<Contact>();
        PageReference pageRef = Page.ApplicationFormPdff;
        Test.setCurrentPage(pageRef);
        
        
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        conList.add(con);
        Opportunity opp = new Opportunity(Lead_Source__c='Agents',Channel_Partner__c=chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Application_form__c app = new Application_form__c(Opportunity__c = opp.id);
        insert app;
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        
        
        SaveAsPdfExtension controller = new SaveAsPdfExtension(std);
        opp  = controller.getOpportunity();
        opp = controller.getoppAgentReferrel();
        app = controller.getapp();
        opp = controller.getoppNotAgentReferrel();
        conList = controller.getContacts();
        con = controller.getContact();
    }
    
    public static testMethod void nonAgentOppUnitTest() {
        List<Contact> conList = new List<Contact>();
        PageReference pageRef = Page.ApplicationFormPdff;
        Test.setCurrentPage(pageRef);
        
        
        Account acc = new Account(Name='testAccount');
        insert acc;
        
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        conList.add(con);
        Opportunity opp = new Opportunity(Lead_Source__c='Showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Application_form__c app = new Application_form__c(Opportunity__c = opp.id);
        insert app;
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        
        
        SaveAsPdfExtension controller = new SaveAsPdfExtension(std);
        opp  = controller.getOpportunity();
        opp = controller.getoppAgentReferrel();
        app = controller.getapp();
        opp = controller.getoppNotAgentReferrel();
        conList = controller.getContacts();
        con = controller.getContact();
    }
}