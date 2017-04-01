//test class for schedule classes
@isTest
private class BatchScheduleTestClass {
    static testMethod void cpUserSchedule(){
        CP_Creation_ScheduleClass cpuser = new CP_Creation_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('cpuserschedule', sch, cpuser); 
    }
    static testMethod void cpProfileSchedule(){
        CP_Profile_ScheduleClass cpProfile = new CP_Profile_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('cpprofileschedule', sch, cpProfile); 
    }
    static testMethod void cpPropertySchedule(){
        CPProperty_ScheduleClass cpProperty = new CPProperty_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('cppropertyschedule', sch, cpProperty); 
    }
    static testMethod void deActiveSchedule(){
        DeactivePortalAccess_Schedule_Class deActiveUser = new DeactivePortalAccess_Schedule_Class();
        String sch='0 0 23 * * ?';
        system.schedule('deActiveUserAccess', sch, deActiveUser); 
    }
    static testMethod void reActiveSchedule(){
        ReactivePortalAccess_ScheduleClass reActiveUser = new ReactivePortalAccess_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('reActiveUserAccess', sch, reActiveUser); 
    }
    static testMethod void  UpdateReactiveStatusSchedule(){
        UpdateReactiveStatus_ScheduleClass  UpdateReactiveStatus = new UpdateReactiveStatus_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('UpdateReactiveStatus', sch,  UpdateReactiveStatus); 
    }
    static testMethod void  UpdateRevokeStatusSchedule(){
        UpdateRevokeStatus_ScheduleClass  UpdateRevokeStatus= new UpdateRevokeStatus_ScheduleClass();
        String sch='0 0 23 * * ?';
        system.schedule('UpdateRevokeStatus', sch,  UpdateRevokeStatus); 
    }
}