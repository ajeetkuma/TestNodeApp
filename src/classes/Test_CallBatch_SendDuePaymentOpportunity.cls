/*---------------------------------------------------------------
Test className : Test_Call_Batch_SendDuePayment_SMS

Class Name : Call_Batch_SendDuePayment_SMS

Created By : Sukesh G

Created Date : 8-2-2016

Description : Test class written for custom button JS to run batches.
To cover the class Call_Batch_SendDuePayment_SMS _opportunity

----------------------------------------------------------------*/
@isTest
private class  Test_CallBatch_SendDuePaymentOpportunity {
     
    static testMethod void myUnitTest() {
      try{
        Test.startTest(); 
        // Test.setMock(WebServiceMock.class, new MockHttpResponse());
        //calling the runBatch_sendDue Payment_SMS method from the test class
           List<id> idOPs;
            Call_Batch_SendDuePaymentSMSOpportunity.runBatch_SendDuePayment_SMS_Opportunity(idOPs);
        Test.stopTest(); 
      }
       catch(Exception e){
         System.debug('exception Found');
      }
      
    }
    
    
     public static testMethod void testMethod4() {
            
               
                 //Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
                 //User dummyUser = Utility_TestData.getTestUser();
                 //insert dummyUser;
                 
                 Master_Payment__c mpObj         = new Master_Payment__c();
                 mpObj.Contact_mobile__c    ='9902189392';
                 mpObj.Contact_Name__c      ='Sukesh';
                 mpObj.Unit__c              ='BX-XX-X2-BX-XX-YY';
                 mpObj.Due_Amount__c            =1000.90;
                 mpObj.Billing_Date__c      =system.today().addDays(-10);
                 mpObj.Don_t_Disturb__c     =false;
                 mpObj.Don_t_Disturb_Plant__c=false; 
                 mpObj.Payment_Received_SMS__c = true;
                 mpObj.Sum_Of_Money__c         = '20000000';
                 insert mpObj;
                 
                 Master_Payment__c[] mp =[Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <=:system.today().addDays(-1) AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null];
                 system.debug('master payment===='+mp);
                 
                // smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
                 //tpltext.smagicinteract__Text__c        = 'tets';
                 //tpltext.smagicinteract__Name__c        = 'Payment Due New1445425533453624';
                 //insert tpltext;
                                
                 
               Test.startTest();
                 Batch_SendDuePayment_SMS sh1 = new Batch_SendDuePayment_SMS();
                 database.executeBatch(sh1);
                 
           
                
                 Test.stopTest();
                          
        }
}