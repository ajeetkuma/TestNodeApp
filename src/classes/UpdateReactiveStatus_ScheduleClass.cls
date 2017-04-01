/*
  This class is used to schedule Update Reactive Status
  */
  
global class UpdateReactiveStatus_ScheduleClass implements Schedulable {
  global void execute(SchedulableContext SC){
    UpdateReactiveStatus updateStatus = new UpdateReactiveStatus();
    database.executebatch(updateStatus);
  }
}