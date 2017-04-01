@isTest(SeeAllData= false)
private class testreferralUpdate {
 
    static testMethod void myReferralUpdate() {

 
        List<Lead> leadList = new List<Lead>();
        //Use the current user as owner of new opps
        Id owner = UserInfo.getUserId();
        //Create 101 new opportunties to test with
        for(Integer i=1; i<102; i++){
            leadList.add(new Lead(lastName='Atal' + i,
                                         OwnerId = owner,
                                         Company='Ext',
                                         Status='Open',
                                         MobilePhone='9916819953',
                                         Mode_of_Enquiry__c='Chat',
                                         LeadSource='EDM',
                                         Date_of_Enquiry__c=system.today(),
                                         Email='subas.mallick@extentor.com',
                                         SMS_Text__c ='text'                                         
            ));
            }
            insert leadList;
            Lead ld = new Lead();
            ld.Id=leadList[0].Id;
            ld.OwnerId = owner;
            ld.Company='Ext';
            ld.Status='Open';
            ld.MobilePhone='9916819953';
            ld.Mode_of_Enquiry__c='Chat';
            ld.LeadSource='EDM';
            ld.Date_of_Enquiry__c=system.today();
            ld.Email='subas.mallick@extentor.com';
            ld.SMS_Text__c ='textSample';
            update ld;
            }
            }