/*
*Name : Shikha Devi
*Created Date : 09/07/2015
*After Insert : After creating Master Payment SMS will go for payment Received and due payment.
*
*/

trigger Payment_SMS on Master_Payment__c (after insert, after update) {
    //-- Instantiate the handler
    TriggerHelperForSMSOnPayment handler = new TriggerHelperForSMSOnPayment();
    

  // Calling method
    
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){    	
    	handler.sendSmsOnReceving(Trigger.new);
    }
    
    
}