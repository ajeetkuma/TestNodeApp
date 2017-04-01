/*
	Description   	:   This class is used for updating Demand Letter Record based on Sent date
*    Created By     :   Shikha(Extentor Tquila)
*    Created Date   :   01/09/2015
*    Version        :   v1.0

*/
global class Demand_Letter_SMS_Batch implements Database.Batchable<sObject>, Database.AllowsCallouts {
	
	global Database.QueryLocator start(database.BatchableContext bc){
    	// Start Method
		 Date lastmonth = System.today().addMonths(-1);
         String query = 'select id, Sent_Date__c,Mobile_Number__c,Contact_Name__c,Unit__c from Demand_Letter_Repository__c Where Sent_Date__c >=:lastmonth AND Sent_Date__c <= TODAY' ;
        
        return Database.getQueryLocator(query);
       
    }
    // Execute Logic
    global void execute (Database.BatchableContext bc, List<Demand_Letter_Repository__c> scope ){
    	Utility_Class.IS_DEMAND_LETTER_RUNNING = true;
    	
	     try{
		      
		      TriggerHandlerForDemand_Letter_SMS obj	= new TriggerHandlerForDemand_Letter_SMS();
		      obj.sendSmsToContacts(scope);
		      
	     }catch(Exception ex){
	     	system.debug(ex.getMessage());
	     }
    }
    
   // Logic to be Executed at finish
    global void finish(Database.BatchableContext bc){
       
    }

}