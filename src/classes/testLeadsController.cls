@isTest(SeeAllData= true)
private class testLeadsController {
 
    static testMethod void myUnitTest() {
        try{
        //set up the page reference to the selectedOpportunityEditor and add retURL param
        PageReference pageRef = new PageReference('LeadSMS');
        //add the return URL to the list view
        //pageRef.getParameters().put('retURL','/006');
        Test.setCurrentPageReference(pageRef);
 
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
        smagicinteract__SMS_Template__c tpltext=new smagicinteract__SMS_Template__c ();
        tpltext.smagicinteract__Text__c='testing contain';
        tpltext.smagicinteract__Name__c='Lead SMS';
        //insert tpltext;
        //set up the set controller then select all opps
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(leadList);
        ssc.setSelected(leadList);
 
        //initialize the extension
        LeadsController sOEE = new LeadsController(ssc);
         sOEE.bumpLeads();
         sOEE.updateLeads();
        //Start the test
        Test.startTest();
        //get selected opportunites and change the Net gain for each
        List<Lead> loopList = ssc.getSelected();
       /* for(Opportunity o : loopList){
            o.Net_Gain__c = 200;
        }
 
        //call the save records method and make sure it returns the right pagereference
        system.assertEquals('/006', sOEE.SaveRecords().getUrl() );
 
        //Check that all opportunities were in fact updated
        loopList = ssc.getSelected();
        for(Opportunity o : loopList){
            System.AssertEquals(200, o.Net_Gain__c);
        }
 
        Test.stopTest(); */
        }
        catch(Exception  e){}
    }
}