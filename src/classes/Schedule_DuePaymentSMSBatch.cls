/***************************************************************
         Purpose  : Schedule Class to call SendDuePaymentBatch
         			for Sending Due Payment SMS
         Author   : Amritesh
    Created Date  : 08/09/2015
****************************************************************/
global class Schedule_DuePaymentSMSBatch implements Schedulable {
	global void execute(SchedulableContext SC){
		SendDuePaymentBatch b	= new SendDuePaymentBatch();
		Database.executeBatch(b);	
    }
}