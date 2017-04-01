/*
  This class is used to schedule cppeoperty creation batchable class 
  */

global class CPProperty_ScheduleClass implements Schedulable {
    global void execute(SchedulableContext SC){
        CP_Property_CreationClass cppropertyCreation = new CP_Property_CreationClass();
        database.executebatch(cppropertyCreation,25);
    }
}