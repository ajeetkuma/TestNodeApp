/*
	Description : Send SMS for Total Due Payment,10th of every Month
	Author		: Amritesh
*/
global class SendDuePaymentBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
	
	String query;
			
	global Database.QueryLocator start(Database.BatchableContext BC){
	 	
	 	Date date25th	= System.today().addDays(15);
	 	query			= 'Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <: date25th AND Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null';
    	return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Master_Payment__c> scope){
		
		try{			
			List<smagicinteract__smsmagic__c> smsObjectsToInsert	= Utility_Class.getMasterPaymentSMSListToSend(scope,Utility_Class.PAYMENT_DUE_TEMPLATE,Utility_Class.MASTER_PAYMENT_OBJECT,Utility_Class.CONTACT_NAME_API,1);
			
			String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
         	
         	if(smsObjectsToInsert.size() > 0){
         		Database.insert(smsObjectsToInsert,false);
         	}
         
		}catch(Exception ex){
			system.debug('Exception:::'+ex.getMessage());
		}
   			
   	}
	
   	global void finish(Database.BatchableContext BC){
   	}

}