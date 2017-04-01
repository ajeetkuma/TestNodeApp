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
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ApplicationSubmitForApproval_TestClass {

    static testMethod void agentUnitTest() {
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='Showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Application_Form__c testlead = new Application_Form__c(Requested_Lead_source__c='Agents',Channel_Partner__c=chpartner.id,Opportunity__c = opp.id,Lead_Source_Approval_Status__c = 'Submitted');
        insert testlead;
        testlead.Lead_Source_Approval_Status__c = 'Approved';
        update testlead;
    }
    
    static testMethod void referralUnitTest() {
        Account acc = new Account(Name='testAccount');
        insert acc;
        Account acc1 = new Account(Name='testAccount');
        insert acc1;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        
        Contact con1 = new Contact(LastName='testContact',AccountId=acc1.id,Email='test@j.com');
        insert con1;
        Opportunity opp = new Opportunity(Lead_Source__c='Showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today());
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Application_Form__c testlead = new Application_Form__c(Requested_Lead_source__c='Referral',Referred_by_Name__c=con1.id,Opportunity__c = opp.id,Lead_Source_Approval_Status__c = 'Submitted');
        insert testlead;
        testlead.Lead_Source_Approval_Status__c = 'Approved';
        update testlead;
    }
}