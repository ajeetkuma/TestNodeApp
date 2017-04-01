/*
	Description : Test Class for DailySchedule_Plumb5Callout,Plum5Callout,
				  Process_Plumb5Response,Plumb5JSON2ApexWrapper
	Author		: Amritesh
*/

@IsTest
private class Test_Plumb5Callout {
	
	static testmethod void testPlumb5CallOut(){
		
		User testUser	= Utility_TestData.getTestUser();
		insert testUser;
		
		system.runAs(testUser){
			
						
			Plumb5APIInfo__c dummyPlumb5	= Utility_TestData.getPlumb5Info();
			insert dummyPlumb5;
			
			Test.startTest(); 
			
			// Set mock callout class 
        	Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
              
            DailySchedule_Plumb5Callout sh1 = new DailySchedule_Plumb5Callout();            
            String sch = '0 0 23 * * ?';
            system.schedule('Testing', sch, sh1);
                
            Test.stopTest();
		}
		
	}
	
    static testMethod void testcallPlumb5API(){
        Plumb5Callout.callPlumb5API();
        
    }
	static testmethod void testParsePlumb5Response(){
		
		User testUser	= Utility_TestData.getTestUser();
		insert testUser;
		
		system.runAs(testUser){
			
			Lead dummyLead		= Utility_TestData.createLead('Test Lead');
			dummyLead.Email		= 'testLead1@test.com';
			insert dummyLead;
			
			Contact dummyCon	= Utility_TestData.getContact();
			insert dummyCon;
			
			String jsonResponse	= '[{"SerialId":"0","EmailId":"testLead1@test.com","TotalVisits":"1","Sessions":"1","Location":"India","Source":"www.google.co.in","SearchKey":"brigade.com","Score":"0","Sent":5,"Open":4,"Click":0,"LastSentDate":"9/2/2015 5:43:30 PM"},{"SerialId":"1","EmailId":"test@gmail.com","TotalVisits":"4","Sessions":"4","Location":"India","Source":"www.google.com","SearchKey":"brigadegroup.com","Score":"0","Sent":3,"Open":1,"Click":0,"LastSentDate":"9/1/2015 5:52:34 PM"}]';
			Plumb5Callout.parsePlumb5Response(jsonResponse);
			
		}
		
	}
	
}