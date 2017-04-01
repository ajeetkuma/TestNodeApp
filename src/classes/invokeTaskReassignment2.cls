public class invokeTaskReassignment2 implements system.Schedulable{
    
    public void execute(system.SchedulableContext sc){
        
        invokeTaskReassignBatch invokeBatchCls = new invokeTaskReassignBatch('22:00:00'); 
        database.executeBatch(invokeBatchCls);
        
    }

}