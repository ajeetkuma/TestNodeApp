/******************************************************************
         Purpose  : Schedule Batch for SendReportsLink_Batch Class                   
          Author  : Amritesh  
******************************************************************/
global class Schedule_SendReportsLink_Batch implements Schedulable{

    global void execute(SchedulableContext sc) {
        SendReportsLink_Batch bObj  = new SendReportsLink_Batch();
        bObj.frequency              = Utility_Class.WEEKLY_FREQUENCY;
        database.executeBatch(bObj);
    }   
}