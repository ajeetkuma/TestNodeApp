public class invokeTaskReassignmentNotification3 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignNotificationBatch invokeBatchCls = new invokeTaskReassignNotificationBatch('11:00:00');
        database.executeBatch(invokeBatchCls);
        
        
    }
    
}