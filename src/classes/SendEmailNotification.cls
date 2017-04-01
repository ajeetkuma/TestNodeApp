public class SendEmailNotification {
    public SendEmailNotification() {}

    //@InvocableMethod(label='Send Email Notification at 18th hour' description='Helps send email notifications to Task owner, Task assignee')
    public static void testNotification(List<Task> taskList) {
        
        try {
            Map<Id, String> userIdToEmailMap = new Map<Id, String>();
            for(User tmpUser : [SELECT Email FROM User]) {
                if(!userIdToEmailMap.containsKey(tmpUser.Id)) {
                    userIdToEmailMap.put(tmpUser.Id, tmpUser.Email);
                }
            }
            
            List<Messaging.SingleEmailMessage> mailsToSend = new List<Messaging.SingleEmailMessage>(); 
            for(Task task : taskList) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(userIdToEmailMap.get(task.OwnerId));
                sendTo.add(userIdToEmailMap.get(task.CreatedById));
                mail.setToAddresses(sendTo);
                mail.setReplyTo(userIdToEmailMap.get(task.CreatedById));
                mail.setSenderDisplayName('Brigade Support');
                mail.setSubject('Alert Notification');
                String body = '<html><body>Hi ' + task.Owner_Name__c + ',<br/><br/>';
                  body += 'The task is going to be reassigned to your colleague in your team  if not closed in next 2 hours.';
                  body += 'Please find the task link below.<br/>';              
                  body += '<a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/'+task.Id+'">click here</a>';
                  body += '<br/><br/>Thank You,<br/>Team Brigade';
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