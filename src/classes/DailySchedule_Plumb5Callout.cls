/***************************************************************
         Purpose  : Schedule Class to call Plumb5Callout Class
         Author   : Amritesh
    Created Date  : 26/08/2015
****************************************************************/
global class DailySchedule_Plumb5Callout implements Schedulable {
	global void execute(SchedulableContext SC) {
		Plumb5Callout.callPlumb5API();
    }
}