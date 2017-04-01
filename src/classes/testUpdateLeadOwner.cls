@isTest
private class testUpdateLeadOwner{
    private static testMethod void updateLead(){
        Lead ld= new Lead();
        ld.lastName='Atal' ;
        ld.Company='Ext';
        ld.Status='Open';
        ld.MobilePhone='9916819953';
        ld.Mode_of_Enquiry__c='Chat';
        ld.LeadSource='EDM';
        ld.Date_of_Enquiry__c=system.today();
        ld.Email='subas.mallick@extentor.com';
        ld.SMS_Text__c ='text'; 
        insert ld; 
        
        Referral__c ref = new Referral__c ();
        ref.Name__c='Test';
        ref.Status__c='Lead-Prospect';
        ref.Lead__c=ld.Id;
        insert ref;
    }
}