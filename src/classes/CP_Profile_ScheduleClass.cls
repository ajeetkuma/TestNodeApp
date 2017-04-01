/*
  This class is used to schedule cp_creation batchable class 
  */

global class CP_Profile_ScheduleClass implements Schedulable{
    global void execute(SchedulableContext SC){
        CP_Profile_CReation cpprofileCreation = new CP_Profile_CReation();
        database.executebatch(cpprofileCreation,25);
    }
}