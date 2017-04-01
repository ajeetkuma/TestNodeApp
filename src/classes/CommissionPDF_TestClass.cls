@isTest
public class CommissionPDF_TestClass{

    public static testMethod void nonagentOppUnitTest() {
        
        PageReference pageRef = Page.CommissionFormPdf;
        Test.setCurrentPage(pageRef);
        Account acc = new Account(Name='testAccount');
        insert acc;
        
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',MobilePhone='8765432145');
        insert con;
        
        Opportunity opp = new Opportunity(Referrer_is_a__c= 'Customer',Referred_by_Name2__c = con.id,Lead_Source__c='Referral',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Commission__c com = new Commission__c(Opportunity__c = opp.id);
        insert com;
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        ApexPages.currentPage().getParameters().put('id',opp.id);
        CommissionPDF controller = new CommissionPDF(std);
        //ApexPages.currentPage().getParameters().put('qp', 'yyyy');
    }
    public static testMethod void agentOppUnitTest() {
        
        PageReference pageRef = Page.CommissionFormPdf;
        Test.setCurrentPage(pageRef);
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',MobilePhone='8765432145');
        insert con;
        
        Opportunity opp = new Opportunity(Channel_Partner__c=chpartner.id,Lead_Source__c='Agents',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Commission__c com = new Commission__c(Opportunity__c = opp.id);
        insert com;
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        ApexPages.currentPage().getParameters().put('id',opp.id);
        CommissionPDF controller = new CommissionPDF(std);
        //ApexPages.currentPage().getParameters().put('qp', 'yyyy');
    }
    public static testMethod void noCommUnitTest() {
        
        PageReference pageRef = Page.CommissionFormPdf;
        Test.setCurrentPage(pageRef);
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',MobilePhone='8765432145');
        insert con;
        
        Opportunity opp = new Opportunity(Channel_Partner__c=chpartner.id,Lead_Source__c='Agents',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        ApexPages.currentPage().getParameters().put('id',opp.id);
        CommissionPDF controller = new CommissionPDF(std);
        //ApexPages.currentPage().getParameters().put('qp', 'yyyy');
    }
}