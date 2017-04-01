/*
  This class is used to schedule reactive portal access batchable class 
  */

global class ReactivePortalAccess_ScheduleClass implements Schedulable {
	global void execute(SchedulableContext SC){
		ReactivatePortalAccess reActivePortalUser = new ReactivatePortalAccess();
		database.executebatch(reActivePortalUser);
	}
}