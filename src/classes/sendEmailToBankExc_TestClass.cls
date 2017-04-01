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
private class sendEmailToBankExc_TestClass {

    static testMethod void sendMailSuccessUnitTest() {
      String str = '';
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Plant__c pl = new Plant__c(name='test',Project__c ='test');
        insert pl;
        HFI__c hfi = new HFI__c(Name='testHFI',TAN_No__c='sdsd');
        insert hfi;
        Branch__c br = new Branch__c(Name='testBranch',HFI__c = hfi.id,Postal_Code__c=4252526);
        insert br;
        Bank_Executive__c be = new Bank_Executive__c(name='test',Email_id__c='test@gamil.com',Branch__c=br.id);
        insert be;
        Plant_Bank_exc__c pbe = new Plant_Bank_exc__c(Bank_Executive__c = be.id,Plant__c = pl.id);
        insert pbe;
        Opportunity opp = new Opportunity(Plant2__c=pl.id,Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        str = sendEmailToBankExecutive.sendEmailMethod(pl.id, opp.id,hfi.id);
    }
    static testMethod void sendMailFailUnitTest() {
      String str = '';
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Plant__c pl = new Plant__c(name='test',Project__c ='test');
        insert pl;
        HFI__c hfi = new HFI__c(Name='testHFI',TAN_No__c='sdsd');
        insert hfi;
        Branch__c br = new Branch__c(Name='testBranch',HFI__c = hfi.id,Postal_Code__c=4252526);
        insert br;
        Bank_Executive__c be = new Bank_Executive__c(name='test',Branch__c=br.id,Email_id__c = 'testqw@gmail.com');
        insert be;
        Plant_Bank_exc__c pbe = new Plant_Bank_exc__c(Bank_Executive__c = be.id,Plant__c = pl.id);
        insert pbe;
        Opportunity opp = new Opportunity(Plant2__c=pl.id,Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        str = sendEmailToBankExecutive.sendEmailMethod(pl.id, opp.id,hfi.id);
    }
    static testMethod void sendMailSuccessHFIUnitTest() {
      String str = '';
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Plant__c pl = new Plant__c(name='test',Project__c ='test');
        insert pl;
        HFI__c hfi = new HFI__c(Name='testHFI',TAN_No__c='sdsd');
        insert hfi;
        Branch__c br = new Branch__c(Name='testBranch',HFI__c = hfi.id,Postal_Code__c=4252526);
        insert br;
        Bank_Executive__c be = new Bank_Executive__c(name='test',Email_id__c='test@gamil.com',Branch__c=br.id);
        insert be;
        Plant_Bank_exc__c pbe = new Plant_Bank_exc__c(Bank_Executive__c = be.id,Plant__c = pl.id);
        insert pbe;
        Opportunity opp = new Opportunity(HFI__c = hfi.id,Plant2__c=pl.id,Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        str = sendEmailToBankExecutive.sendEmailMethod(pl.id, opp.id,hfi.id);
    }
}