global class invokeTaskReassignBatch implements Database.Batchable<sobject>,Database.stateful {
     string schTime ;
    public invokeTaskReassignBatch(string schTim){
        schTime = schTim;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
       string query = 'select id ,  Owner_Role__c,Activity_Date__c from task where status != \'Completed\' and  Activity_Date__c != null and Escalated__c = true';
        return database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext BC, list<task> tasklist){
         list<task> updatetaskList = new list<task>();
        for(task t: tasklist){
            
            string ActTime ;
            if(system.String.valueOf(t.Activity_Date__c).contains('T')){
                
                ActTime = system.String.valueOf(t.Activity_Date__c).split('T',-1)[1];
                
            }else{
                
                ActTime = system.String.valueOf(t.Activity_Date__c).split(' ',-1)[1];
                
            }
            
            if(t.Owner_Role__c.touppercase().contains('SALES') &&  ActTime.contains(schTime) && (t.Activity_Date__c).date() == system.today()){
                t.Start_re_assignment_of_task__c = true ;
                t.Escalated__c = false;
                updatetaskList.add(t);
                
            }
            
        }
        
        update updatetaskList;
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    
}