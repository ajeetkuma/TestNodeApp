public class invokeTaskReassignment3 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignBatch invokeBatchCls = new invokeTaskReassignBatch('11:00:00');
        database.executeBatch(invokeBatchCls);
    }

}