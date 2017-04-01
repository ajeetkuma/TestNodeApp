/**
 *Description : Test Class for Schedule_DuePaymentSMSBatch & SendDuePaymentBatch class
  Auhor 	  : Amritesh
 */
 
@isTest
private class Test_ScheduleDuePaymentSMSBatch {

    static testMethod void myUnitTest() {
        User dummyUser	= Utility_TestData.getTestUser();
        insert dummyUser;
        
        system.runAs(dummyUser){
        	
        	Master_Payment__c testData	= new Master_Payment__c();
        	testData.Contact_Name__c	= 'Test';
        	testData.Contact_mobile__c	= '0000000000';
        	testData.Unit__c			= 'BX-XX-X2-BX';
        	testData.Due_Amount__c		= 200000;
        	testData.Billing_Date__c	= system.today();
        	
        	insert testData;
        	
        	smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
	        tpltext.smagicinteract__Text__c 		= 'tets';
	        tpltext.smagicinteract__Name__c 		= 'Payment Due New';
	        insert tpltext;
        	      	      	
        	Test.startTest(); 
              
            Schedule_DuePaymentSMSBatch sh1 = new Schedule_DuePaymentSMSBatch();            
            String sch = '0 0 23 * * ?';
            system.schedule('Testing', sch, sh1);
                
            Test.stopTest();
        }
    }

}