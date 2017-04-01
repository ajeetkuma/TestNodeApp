/*
	Description   	:   This class is used for Scheduling Demand Letter Batch Class
*    Created By     :   Shikha(Extentor Tquila)
*    Created Date   :   03/09/2015
*    Version        :   v1.0

*/
global class scheduled_Demand_Letter_SMS_Batch implements Schedulable {
	global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled

           // We now call the batch class to be scheduled
        Demand_Letter_SMS_Batch b = new Demand_Letter_SMS_Batch(); 
        
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b);
     }
}