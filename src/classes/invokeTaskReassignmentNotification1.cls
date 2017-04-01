public class invokeTaskReassignmentNotification1 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignNotificationBatch invokeBatchCls = new invokeTaskReassignNotificationBatch('10:55:00');
        database.executeBatch(invokeBatchCls);
        
    }
    
}