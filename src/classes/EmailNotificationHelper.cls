public class EmailNotificationHelper {

    public Map<Id, Id> userIdToManagerIdMap 	= new Map<Id, Id>();
    public Map<Id, String> userIdToEmailMap 	= new Map<Id, String>();
	public Map<String,User> userDetailMap	 	= new Map<String, User>();
	
    public EmailNotificationHelper() {

        // Populating userIdToManagerIdMap and userIdToEmailMap 
		
        for(User tmpUser : [SELECT Id,Name,Email, ManagerId FROM User WHERE IsActive = true AND ContactId = null]) {
            if(!userIdToEmailMap.containsKey(tmpUser.Id)) {
                userIdToEmailMap.put(tmpUser.Id, tmpUser.Email);
            }
            if(!userIdToManagerIdMap.containsKey(tmpUser.Id)) {
                userIdToManagerIdMap.put(tmpUser.Id, tmpUser.ManagerId);
            }
            userDetailMap.put(tmpUser.Id,tmpUser);
        }
        
    }

/*******************************************************************************************************
  * @Author Neha@extentor
  * @description Sends email to users.
  * @param List of User
  */ 

    public void sendEmailNotificationToUserManagers(Map<Id,Id> taskToUserListMap) {
        List<Messaging.SingleEmailMessage> mailsToSend = new List<Messaging.SingleEmailMessage>(); 
        List<String> sendToEmailAddresses = new List<String>();
        
        try{
            for(Id taskId : taskToUserListMap.keySet()) {
               
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                   
					id ownerID = taskToUserListMap.get(taskId);
					
					if(userIdToManagerIdMap.containsKey(ownerID) && userIdToManagerIdMap.get(ownerID) != null) {
                        sendToEmailAddresses.add(userIdToEmailMap.get(userIdToManagerIdMap.get(ownerID)));
						string managerName = userDetailMap.get(userIdToManagerIdMap.get(ownerID)).name;
                   
                    mail.setToAddresses(sendToEmailAddresses);
					mail.setReplyTo(userIdToEmailMap.get(ownerID));
                    mail.setSenderDisplayName('Brigade Support');
                    mail.setSubject('Task Re Assignment Message');
					String body = '<html><body>Hi ' + managerName + ', <br/><br/>';
                      body += 'The Below Task has not been completed. <br/>';
                      body += 'Currently there are no users in the team to whom the task could be re assigned as every one’s tasks in your Team are on reassignment mode. <br/>';
                      body += '<a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+taskId+'">click here</a> <br/> <br/>';
                      body += '<br/>Thanks,<br/>';
                      body += 'Brigade</body></html>';
                      mail.setHtmlBody(body);
                    mail.setSaveAsActivity(false);
                    mailsToSend.add(mail);
					
					}
            }
            
            if(mailsToSend.size() > 0) {
                Messaging.sendEmail(mailsToSend);
                
            }
        }catch(Exception e){
            system.debug(e.getMessage());
        }
       
    }

/*******************************************************************************************************
  * @Author Neha@extentor
  * @description Sends email to users associated with a Task.
  * @param List of Task
  */ 
    public void sendEmailNotificationToTaskRelatedPerson(List<Task> taskList) {
        try {
            List<Messaging.SingleEmailMessage> mailsToSend = new List<Messaging.SingleEmailMessage>(); 
            List<String> sendToEmailAddresses = new List<String>();
            List<String> CCEmailAddresses = new List<String>();
            
            for(Task task : taskList) {
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                if(userIdToEmailMap.containsKey(task.OwnerId)) {
                    
                    sendToEmailAddresses.add(userIdToEmailMap.get(task.OwnerId));
                    if(userIdToManagerIdMap.get(task.OwnerId) != null) {
                       
                        CCEmailAddresses.add(userIdToEmailMap.get(userIdToManagerIdMap.get(task.OwnerId)));
                    }
                    
                    CCEmailAddresses.add(userIdToEmailMap.get(task.CreatedById));
                    
                }
                
                mail.setToAddresses(sendToEmailAddresses);
                mail.setCcAddresses(CCEmailAddresses);
                mail.setReplyTo(userIdToEmailMap.get(task.CreatedById));
                
                mail.setSenderDisplayName('Brigade Support');
                mail.setSubject('Task Re Assignment Message');
                  String body = '<html><body>Hi ' +userDetailMap.get(task.OwnerId).Name + ',<br/><br/>';
				  body += 'The task is being re-assigned to you as it was not attended by your colleague. Please find the task link below<br/>';
                  body += '<a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+task.Id+'">click here</a><br/><br/>';
                  body += 'Thanks,<br/>';
                  body += 'Brigade</body></html>';
                  mail.setHtmlBody(body);
                mail.setSaveAsActivity(false);
                mailsToSend.add(mail);

            }
            
            if(mailsToSend.size() > 0) {
                Messaging.sendEmail(mailsToSend);
            }
        }
        catch (Exception e) {
          System.debug(e.getMessage());
        }
    }

}