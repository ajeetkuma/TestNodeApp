global class Schedule_LeadMarkedForDeletionBatchClass implements Schedulable{
    global void execute (SchedulableContext sc){
    DeleteLeadMarkedForDeletionBatchClass ds = new DeleteLeadMarkedForDeletionBatchClass();
    database.executebatch(ds);
    }
}