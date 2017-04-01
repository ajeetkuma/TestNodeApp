/*
  This class is used to schedule Update revoke access
  */
  
global class UpdateRevokeStatus_ScheduleClass implements Schedulable {
  global void execute(SchedulableContext SC){
    UpdateRevokePortalAcessStatus updateStatus = new UpdateRevokePortalAcessStatus();
    database.executebatch(updateStatus);
  }
}