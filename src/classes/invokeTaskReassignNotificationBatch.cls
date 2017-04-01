public class invokeTaskReassignNotificationBatch implements Database.Batchable<sobject>,Database.stateful{
    
    string schTime ;
    public invokeTaskReassignNotificationBatch(string schTim){
        schTime = schTim;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
       string query = 'select id ,OwnerId,CreatedById,Owner_Name__c,    Owner_Role__c,Activity_Date__c from task where status != \'Completed\' and  Activity_Date__c != null and Escalated__c = true';
       return database.getQueryLocator(query);
        
    }
    
    public void execute(Database.BatchableContext BC, list<task> tasklist){
         list<task> taskLst = new list<task>();
        for(task t: tasklist){
            
            string ActTime ;
            if(system.String.valueOf(t.Activity_Date__c).contains('T')){
                
                ActTime = system.String.valueOf(t.Activity_Date__c).split('T',-1)[1];
               
            }else{
                 
                ActTime = system.String.valueOf(t.Activity_Date__c).split(' ',-1)[1];
                
            }
            
            if(t.Owner_Role__c.touppercase().contains('SALES') &&  ActTime.contains(schTime) && (t.Activity_Date__c).date() == system.today()){
                taskLst.add(t);
                
            }
            
        }
        
        SendEmailNotification.testNotification(taskLst);
        
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
    

}