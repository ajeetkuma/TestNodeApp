/* ================================================
@Name:  UpdateDateFieldHandler
@Copyright notice: 
Copyright (c) 2015, Brigade and developed by Extentor
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are not permitted.                                                                                                    
@====================================================
@====================================================
@Purpose:                                                                                                               
@====================================================
@====================================================
@History                                                                                                                    
@---------                                                                                                                       
@VERSION________AUTHOR______________DATE______________DETAIL                   
1.0        Neha@extentor     12/01/2015      INITIAL DEVELOPMENT                                 

@=======================================================  */
public class UpdateDateFieldHandler {
	
	private final string NEXT_DAY_ASSIGNMET_STR	= 'Next Day'; // Used for Task Re-Assigement, createdDate+1 Scenario 
	
    public UpdateDateFieldHandler(){}

    public void onAfterInsert(final List<Task> newTaskList) {
        
        updateActivityDate(newTaskList);     
    }

    /*public void onBeforeUpdate(final List<Task> newTaskList, final Map<Id, Task> oldTaskMap) {
        //updateActivityDate(newTaskList);
                
        List<Task> taskList = new List<Task>();
        for(Task task : newTaskList) {
            Task oldTask = oldTaskMap.get(task.Id);
            if (task.ActivityDate != oldTask.ActivityDate && task.ActivityDate != null) {
                taskList.add(task);
            }
        }
        if (!taskList.isEmpty()) {
            updateActivityDate(taskList);
        }
             
    }*/

    public void updateActivityDate(List<Task> taskList) { 
        /*
        Map<Task, String>  dueDateToTaskIdMap = new Map<Task, String>();
        DateTime tempDateTime = System.now();
        String tempTime;
        for(Task task : taskList) {
            if(task.ActivityDate != null) {
                dueDateToTaskIdMap.put(task, String.valueOf(task.ActivityDate));
            }
            
        }
        for(Task task : dueDateToTaskIdMap.keySet()) {
            tempTime = dueDateToTaskIdMap.get(task) + ' ' + String.valueOf(tempDateTime.time());
            task.Activity_Date__c = DateTime.valueOf(tempTime);
        }
        */
        
        try{
	        List<TaskReAssignementPeriod__c> taskPeriodList	= TaskReAssignementPeriod__c.getAll().values();
	        List<Task> updateTaskList						= new List<Task>();
	        
	        for(Task ts : taskList){
	        	String tCreatedDate			= String.valueOf(ts.createdDate).split(' ')[0];
	        	String escalatedString		= Utility_Class.getEscalationTime(ts.createdDate,taskPeriodList);
	        	if(escalatedString != null){
	        		
	        		List<String> escalatedTimeStr	= escalatedString.split('@@@');
	        		if(escalatedTimeStr.size() == 2){
	        			Task tsUpdate	= new Task();
	        			tsUpdate.Id		= ts.id;
	        			if(escalatedTimeStr[0] != null && escalatedTimeStr[1] != null && escalatedTimeStr[0].contains(NEXT_DAY_ASSIGNMET_STR)){
	        				tsUpdate.Activity_Date__c	= DateTime.valueOf(tCreatedDate+' '+escalatedTimeStr[1]+':00').addHours(23);
	        			}else{
	        				tsUpdate.Activity_Date__c	= DateTime.valueOf(tCreatedDate+' '+escalatedTimeStr[1]+':00').addHours(-1);
	        			}
	        			updateTaskList.add(tsUpdate);
	        		}
	        	}
	        }
	        if(updateTaskList.size() > 0){
	        	Utility_Class.IS_TASK_TRIGGER_RUNNING = true;
	        	update updateTaskList;
	        }
        }catch(Exception ex){
        	system.debug('Exception ex::'+ex.getMessage());
        }
    }
}