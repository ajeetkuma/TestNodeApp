/******************************************************************
         Purpose  : Schedule Batch for SendReportsLink_Batch Class                   
          Author  : Amritesh  
******************************************************************/
global class Daily_ScheduledReportLink implements Schedulable{

    global void execute(SchedulableContext sc) {
        SendReportsLink_Batch bObj  = new SendReportsLink_Batch();
        bObj.frequency              = Utility_Class.DAILY_FREQUENCY;
        database.executeBatch(bObj);
    }   
}