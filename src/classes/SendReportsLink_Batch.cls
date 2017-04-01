/*
	Description : This Batch is scheduled to run every Monday morning 
				  and send email to managers with Email Template which
				  contains report links
	Auhtor		: Amritesh			  
*/
global class SendReportsLink_Batch implements Database.Batchable<sObject> {
	
	string query;
	public string frequency;
	
	// Constructor
	global SendReportsLink_Batch(){
		query		= '';
		frequency	= '';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){		
		query	= 'Select id,ManagerId,Manager.Email,Manager.FirstName from user where IsActive = true AND ManagerId != null';
      	return Database.getQueryLocator(query);
   	}

   	global void execute(Database.BatchableContext BC, List<User> scope){
   		
   		try{
	   		List<Messaging.SingleEmailMessage> emailList	= new List<Messaging.SingleEmailMessage>();
	   		String templateName								= '';
	   		
	   		// check for mail frequecy: daily or weekly 
	   		// based on that fetch email template
	   		if(frequency == Utility_Class.DAILY_FREQUENCY){
	   			templateName	= Utility_Class.DAILY_EMAIL_TEMPLATE_NAME;
	   		}
	   		if(frequency == Utility_Class.WEEKLY_FREQUENCY){
	   			templateName	= Utility_Class.WEEKLY_EMAIL_TEMPLATE_NAME;
	   		}
	   		
	   		EmailTemplate templateId 						= [Select id from EmailTemplate where name =: templateName];
	   		
	   		Set<id> dupCheck	= new Set<id>();
	   		for(User u	: scope){
		   		
		   		if(!dupCheck.contains(u.ManagerId)){
		   			
		   			dupCheck.add(u.ManagerId);
		   					   			
		    		Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
					msg.setTemplateId(templateId.id);
					msg.setTargetObjectId(u.ManagerId);
					msg.setSaveAsActivity(false);
					emailList.add(msg);
		   		}
	   		}
	   		Messaging.sendEmail(emailList);
   		}catch(Exception ex){
   			system.debug('Exception ::'+ex.getMessage());
   		}
    }

   	global void finish(Database.BatchableContext BC){}  
}