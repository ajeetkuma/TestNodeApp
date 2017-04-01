public class invokeTaskReassignmentNotification2 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignNotificationBatch invokeBatchCls = new invokeTaskReassignNotificationBatch('22:00:00'); 
        database.executeBatch(invokeBatchCls);
        
    }
    
}