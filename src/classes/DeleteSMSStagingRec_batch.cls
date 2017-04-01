public class DeleteSMSStagingRec_batch implements Database.Batchable<Sobject> {
    
    public static Database.QueryLocator start(Database.BatchableContext bc){
        date deletionDate = system.today() - 30;
        
        string query = 'select id from SMS_Sending_Object__c where createdDate <= :deletionDate';
        return database.getQueryLocator(query);
    }
    
    public static void execute(Database.BatchableContext bc , list<SMS_Sending_Object__c> smsRec){
        Database.delete(smsRec,false);
    }
    
    public static void finish(Database.BatchableContext bc){
        
    }

}