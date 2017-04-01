/*
  This class is used to schedule deactive portal access batchable class 
  */

global class DeactivePortalAccess_Schedule_Class implements Schedulable {
	global void execute(SchedulableContext SC){
		DeactivatePortalAccess deActivePortalUser = new DeactivatePortalAccess();
		database.executebatch(deActivePortalUser);
	}
}