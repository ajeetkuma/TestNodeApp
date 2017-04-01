/*
  This class is used to schedule cp_creation batchable class 
  */
  
global class CP_Creation_ScheduleClass implements Schedulable {
	global void execute(SchedulableContext SC){
		CP_User_Creation usrCreation = new CP_User_Creation();
		database.executebatch(usrCreation);
	}
}