public class DeleteSMSStagingRec_sch implements system.Schedulable{
	
    public  static void execute(System.SchedulableContext sc){
        DeleteSMSStagingRec_batch delRec = new DeleteSMSStagingRec_batch();
        database.executeBatch(delRec);
    }
}