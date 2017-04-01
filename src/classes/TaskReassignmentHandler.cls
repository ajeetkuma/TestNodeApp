public with sharing class TaskReassignmentHandler {
    public TaskReassignmentHandler() {}

    public void onBeforeUpdate(List<Task> newTaskList, Map<Id, Task> oldTaskMap) {
        List<Task> taskList = new List<Task>();
        try {
            for(Task task : newTaskList) {
                Task oldTask = oldTaskMap.get(task.Id);
                if(task.Start_re_assignment_of_task__c != oldTask.Start_re_assignment_of_task__c) {
                    if(task.Status != 'Completed') {
                        task.Start_re_assignment_of_task__c = false;
                        
                        taskList.add(task);
                        
                    }
                }
                
            }
            
            ReassignmentOfTask assignTask = new ReassignmentOfTask();
            assignTask.reassignTask(taskList);

        }
        catch(Exception e) {
            system.debug('exception::'+e.getMessage());
        }   
    }
    
}