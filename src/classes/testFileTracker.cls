@isTest(SeeAllData =true)
    private class testFileTracker { 
     static testMethod void fileTrackerShare(){
     
     Opportunity opp = new Opportunity();
     Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
                                 
     User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
            LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
            TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            
        File_Tracker__c ft= new File_Tracker__c();
        ft.Opportunity__c = opp.id;
        ft.Comments__c = 'test';
        ft.Dispatch_Date__c = datetime.newInstance(2014, 9, 15, 12, 30, 0);
        ft.Dispatch_Mode__c = 'Driver';
        ft.DIspatch_Type__c ='documents';
        ft.Documents_List__c = 'test';
        ft.User__c = u.id;
        //ft.RecordTypeId  = '0128A0000008cUA';
        Test.startTest();
        try{
        insert ft;
        }catch(Exception e){
            System.debug('Error'+e);
        }
        Test.stopTest();
            
       
    
        }
    }