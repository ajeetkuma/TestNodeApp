public class invokeTaskReassignment1 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignBatch invokeBatchCls = new invokeTaskReassignBatch('10:55:00');
        database.executeBatch(invokeBatchCls);
       
    }

}