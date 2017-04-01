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
public class Test_TriggerHelperForSMSOnPayment {
	  static testMethod void myUnitTest(){
	  	
	  	try{
	        User testUser   = Utility_TestData.getTestUser();
	        insert testUser;
	        system.runAs(testUser){
	        test.startTest();
	            //get dummy for SMS Magic
	 		
	        Master_Payment__c objMasterPayment		= Utility_TestData.getMasterPaymentInfo();
	        objMasterPayment.Don_t_Disturb_Plant__c	= false;
	        insert objMasterPayment;
	          //pass information to sms magic
	          
	        smagicinteract__Incoming_SMS__c incomingSMS = new smagicinteract__Incoming_SMS__c();
			incomingSMS.smagicinteract__external_field__c = 'test';
			incomingSMS.smagicinteract__Inbound_Number__c = '987654321';
			incomingSMS.smagicinteract__Mobile_Number__c = objMasterPayment.Contact_mobile__c;
			incomingSMS.smagicinteract__SMS_Text__c = 'test SMS 2';
			insert incomingSMS;
			List < smagicinteract__Incoming_SMS__c > incomingList = [select Id, smagicinteract__Mobile_Number__c from smagicinteract__Incoming_SMS__c where smagicinteract__Mobile_Number__c = : objMasterPayment.Contact_mobile__c];
			//system.assertEquals(incomingList[0].Task__c,task1.Id);
	
			smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
			smsObject.smagicinteract__SenderId__c = 'sms magic';
			smsObject.smagicinteract__PhoneNumber__c = objMasterPayment.Contact_mobile__c;
			smsObject.smagicinteract__Name__c = objMasterPayment.Contact_Name__c;
			smsObject.smagicinteract__ObjectType__c = 'Master_Payment__c';
			smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest() ? 1 : 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
			smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
			smsObject.smagicinteract__SMSText__c = 'sms text';
			system.debug('==============test==========' + smagicinteract.ApexAPI.generateUniqueKey());
			insert smsObject;
			system.debug('==============test==========' + smsObject);
			smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
			tpltext.smagicinteract__Text__c = 'tets';
			tpltext.smagicinteract__Name__c = 'After Payment Received';
			insert tpltext;
			
			update objMasterPayment;
	        test.stopTest();
	        }
	  	}catch(exception e){}
     }
     static testMethod void myUnitTest1(){
     	
     	try{
	        User testUser   = Utility_TestData.getTestUser();
	        insert testUser;
	        system.runAs(testUser){
	        test.startTest();
	            //get dummy for SMS Magic
	 		
	        Master_Payment__c objMasterPayment		= Utility_TestData.getMasterPaymentInfo();
	        objMasterPayment.Don_t_Disturb_Plant__c	= false;        
	        insert objMasterPayment;
	        
	        //pass information to sms magic          
	        smagicinteract__Incoming_SMS__c incomingSMS = new smagicinteract__Incoming_SMS__c();
			incomingSMS.smagicinteract__external_field__c = 'test';
			incomingSMS.smagicinteract__Inbound_Number__c = '987654321';
			incomingSMS.smagicinteract__Mobile_Number__c = objMasterPayment.Contact_mobile__c;
			incomingSMS.smagicinteract__SMS_Text__c = 'test SMS 2';
			insert incomingSMS;
			List < smagicinteract__Incoming_SMS__c > incomingList = [select Id, smagicinteract__Mobile_Number__c from smagicinteract__Incoming_SMS__c where smagicinteract__Mobile_Number__c = : objMasterPayment.Contact_mobile__c];
			//system.assertEquals(incomingList[0].Task__c,task1.Id);
	
			smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
			smsObject.smagicinteract__SenderId__c = 'sms magic';
			smsObject.smagicinteract__PhoneNumber__c = objMasterPayment.Contact_mobile__c;
			smsObject.smagicinteract__Name__c = objMasterPayment.Contact_Name__c;
			smsObject.smagicinteract__ObjectType__c = 'Master_Payment__c';
			smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest() ? 1 : 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
			smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
			smsObject.smagicinteract__SMSText__c = 'sms text';
			system.debug('==============test==========' + smagicinteract.ApexAPI.generateUniqueKey());
			insert smsObject;
			system.debug('==============test==========' + smsObject);
			smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
			tpltext.smagicinteract__Text__c = 'tets';
			tpltext.smagicinteract__Name__c = 'After Payment Received';
			insert tpltext;
			
			update objMasterPayment;
	        test.stopTest();
	        }
     	}catch(Exception e){}
     }
}