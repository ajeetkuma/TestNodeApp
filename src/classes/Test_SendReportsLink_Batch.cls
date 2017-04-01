/**
 *Description : Test Class for SendReportsLink_Batch & Daily_ScheduledReportLink class
  Auhor 	  : Amritesh
 */
@isTest
private class Test_SendReportsLink_Batch {

    static testMethod void myUnitTest() {
        User dummyUser	= Utility_TestData.getTestUser();
        insert dummyUser;
        
        system.runAs(dummyUser){
        	
        	User dummyUser1		= Utility_TestData.getTestUser();
        	dummyUser.LastName	= 'Test User1';
        	dummyUser.Username	= 'test@bgroupTest1.com';
        	dummyUser.ManagerId	= dummyUser.Id;
        	
        	Test.startTest(); 
              
            Schedule_SendReportsLink_Batch sh1 = new Schedule_SendReportsLink_Batch();            
            String sch = '0 0 23 * * ?';
            system.schedule('Testing', sch, sh1);
                
            Test.stopTest();
        }
    }
    
    static testMethod void myUnitTest2() {
        User dummyUser	= Utility_TestData.getTestUser();
        insert dummyUser;
        
        system.runAs(dummyUser){
        	
        	User dummyUser1		= Utility_TestData.getTestUser();
        	dummyUser.LastName	= 'Test User1';
        	dummyUser.Username	= 'test@bgroupTest1.com';
        	dummyUser.ManagerId	= dummyUser.Id;
        	
        	Test.startTest(); 
              
            Daily_ScheduledReportLink sh1 = new Daily_ScheduledReportLink();            
            String sch = '0 0 23 * * ?';
            system.schedule('Testing', sch, sh1);
                
            Test.stopTest();
        }
    }
}