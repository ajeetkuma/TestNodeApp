public class ReassignmentOfTask {
    public Map<Id, userAssignmentInfo> userIdTouserAssignmentInfoMap = new Map<Id, userAssignmentInfo>();
    Map<String, List<User>> teamToUserListMap = new Map<String, List<User>>();
    Map<Task, String> taskToTeamMap = new Map<Task, String>();
    Map<id, String> taskIDToTeamMap = new Map<id, String>();
    public List<User> allActiveUsersList;
    public ReassignmentOfTask() {}

    public void reassignTask(List<Task> taskList) {
       try{
            
            Map<Id, String> userToTeamMap = new Map<Id, String>();
            Map<String, List<Task>> teamToTaskMap = new Map<String, list<Task>>();
            
            Map<Id, User> IdToUserMap = new Map<Id, User>();
            List<User> userToBeUpdatedList = new List<User>();
            List<User> userForEmailList = new List<User>();
            Map<Id, id> taskIdToUserForEmailMap = new Map<Id,Id>();
            List<Task> taskForEmailList = new List<task>();
            Profile p = [SELECT Id FROM Profile WHERE Name = 'Overage High Volume Customer Portal User_Custom' limit 1];
            List<User> allActiveUsersList = new List<User>([SELECT username ,Email,ManagerId,Name,Team__c,Other_s_Assigned_Tasks__c,
                                                            Self_Assigned_Tasks__c,Self_Assigned_Time__c,
                                                            Other_s_Assigned_Task_time__c, UserType, 
                                                            Last_Self_Escalated_Task_Day__c FROM User 
                                                            WHERE IsActive = true AND ProfileId !=: p.Id AND ContactId = null]);
            


            for(User tmpUser : allActiveUsersList) { 
        
        // Populate the userIdTouserAssignmentInfoMap and IdToUserMap

                if(!IdToUserMap.containsKey(tmpUser.Id)) {
                    IdToUserMap.put(tmpUser.Id, tmpUser);
                }

                if(userIdTouserAssignmentInfoMap.containsKey(tmpUser.Id)) {
                    Decimal assignmentPriority = userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedNumber;
                }
                else {
                    userIdTouserAssignmentInfoMap.put(tmpUser.Id, new userAssignmentInfo(tmpUser, tmpUser.Self_Assigned_Tasks__c, 
                                                      tmpUser.Other_s_Assigned_Tasks__c, tmpUser.Self_Assigned_Time__c, 
                                                      tmpUser.Other_s_Assigned_Task_time__c, tmpUser.Last_Self_Escalated_Task_Day__c));
                }

                if(tmpUser.Team__c != null) {
                    if(!teamToUserListMap.containsKey(tmpUser.Team__c)) {
                        teamToUserListMap.put(tmpUser.Team__c, new List<User>{tmpUser}); 

                    }
                    else {
                       teamToUserListMap.get(tmpUser.Team__c).add(tmpUser);

                    }
                    if(!userToTeamMap.containsKey(tmpUser.Id)) {
                        userToTeamMap.put(tmpUser.Id, tmpUser.Team__c);
                    }
                }           
            } 
            for(Task task : taskList) {
                if(userToTeamMap.containsKey(task.OwnerId)) {
                    if(!teamToTaskMap.containsKey(userToTeamMap.get(task.OwnerId))) {
                        teamToTaskMap.put(userToTeamMap.get(task.OwnerId), new List<Task>{task}); //check the key availability and add tasks properly
                    }
                    else {
                        teamToTaskMap.get(userToTeamMap.get(task.OwnerId)).add(task);
                    }
                    
                }
                if(!taskToTeamMap.containsKey(task)) {
                    
                    taskToTeamMap.put(task, userToTeamMap.get(task.OwnerId)); // (check further)
                    taskIDToTeamMap.put(task.id, userToTeamMap.get(task.OwnerId));
                    
                }
                User newAssignee = getNewAssignee(task, userIdTouserAssignmentInfoMap, userToTeamMap, teamToUserListMap, teamToTaskMap, taskToTeamMap);
                Id currentAssigneeId = task.OwnerId;
                string currentAssigneeName = task.Owner.name ;
                task.Last_Escalation__c = system.now();
                if(newAssignee != null) {
                    if(task.No_of_Escalation__c == 0){
                        task.First_Assigned_User__c = curr_username ;
                        //task.Task_Escalated_To__c = newAssignee.Id;
                    }else{
                        if(task.Task_Escalated_To__c == null){
                            task.Task_Escalated_To__c = curr_username;
                        }else{
                          string str = task.Task_Escalated_To__c +' ; ' +curr_username ;
                            if(str.length()<=255){
                                task.Task_Escalated_To__c = str;
                            }
                        }
                    }
                    task.OwnerId = newAssignee.Id;
                    
                    task.No_of_Escalation__c = task.No_of_Escalation__c + 1;
                  
                    //task.First_Assigned_User__c = currentAssigneeId +currentAssigneeName   ;
                    taskForEmailList.add(task);

                }  
                else {
                    
                     taskIdToUserForEmailMap.put(task.Id,task.OwnerId);
                   
                }  
                if(newAssignee != null) {
                    updateUserIdTouserAssignmentInfoMap(newAssignee, currentAssigneeId);
                    userToBeUpdatedList.add(IdToUserMap.get(newAssignee.Id));
                    userToBeUpdatedList.add(IdToUserMap.get(currentAssigneeId));
                }
                
                
            }
            EmailNotificationHelper enHelper = new EmailNotificationHelper();
           
            enHelper.sendEmailNotificationToTaskRelatedPerson(taskForEmailList);
           if(taskIdToUserForEmailMap.size()>0){
               
            enHelper.sendEmailNotificationToUserManagers(taskIdToUserForEmailMap);
           }
            updateUser(userToBeUpdatedList);
           
            
            
        }
        catch(Exception e) {
            System.debug(e.getMessage());
        }
        
    }

    public User getNewAssignee(Task task, Map<Id, userAssignmentInfo> userIdTouserAssignmentInfoMap, 
                                Map<Id, String> userToTeamMap, Map<String, List<User>> teamToUserListMap, 
                                Map<String, List<Task>> teamToTaskMap, Map<Task, String> taskToTeamMap) {
        Id currentTaskOwnerId = task.OwnerId;
        String teamForTheTask;
        for(Task t : taskToTeamMap.keySet()) {
            if(task.Id == t.Id) {
                teamForTheTask = taskToTeamMap.get(t);
            }
        }
        List<User> getUserList = new List<User>();
        getUserList = getUserWithOldestTimeStamp(currentTaskOwnerId, teamToUserListMap.get(teamForTheTask), userIdTouserAssignmentInfoMap);
        
        if(!getUserList.isEmpty()) {
            return getUserList[0];
        } 
        else {
            return null;
        }
        
    }
    public string curr_username ;
    public List<User> getUserWithOldestTimeStamp(Id currentTaskOwnerId, List<User> userList, Map<Id, userAssignmentInfo> userIdTouserAssignmentInfoMap) {
        List<User> probableNewAssigneeList = new List<User>();
        for(User tmpUser : userList) {
            
            if(curr_username == null && tmpUser.Id == currentTaskOwnerId){
                curr_username = tmpUser.username ;
            }
            if(tmpUser.Id != currentTaskOwnerId && tmpUser.Last_Self_Escalated_Task_Day__c != System.today()) {
                probableNewAssigneeList.add(tmpUser);
            }
        }
        List<User> sortedOutUser = new List<User>();
        List<User> userToBeIndexedList = new List<User>();

        if(!probableNewAssigneeList.isEmpty()) {
            Decimal assignmentPriority = userIdTouserAssignmentInfoMap.get(probableNewAssigneeList[0].Id).othersAssignedNumber;
            for(User tmpUser : probableNewAssigneeList) {
                if(userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedNumber < assignmentPriority) {
                    assignmentPriority = userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedNumber;
                    sortedOutUser.clear();
                    sortedOutUser.add(tmpUser);
                }
                else if(userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedNumber == assignmentPriority) {
                    sortedOutUser.clear();
                    sortedOutUser.add(tmpUser);
                }
                else {
                    userToBeIndexedList.add(tmpUser);
                }
            }
            if(sortedOutUser.isEmpty()) {            
                for(User tmpUser : userToBeIndexedList) {
                    sortedOutUser.clear();
                    sortedOutUser.add(tmpUser);
                }
            }
            return sortedOutUser;
        }
        else {
            
            return probableNewAssigneeList;

        }
        
    }

    public void updateUserIdTouserAssignmentInfoMap(User newAssignee, Id currentAssigneeId) {

        // Update UserInfoMap values

        userIdTouserAssignmentInfoMap.get(currentAssigneeId).selfAssignedTime = System.now();
        userIdTouserAssignmentInfoMap.get(newAssignee.Id).othersAssignedTime = System.now();

        userIdTouserAssignmentInfoMap.get(currentAssigneeId).selfAssignedNumber = 
            userIdTouserAssignmentInfoMap.get(currentAssigneeId).selfAssignedNumber + 1;
        userIdTouserAssignmentInfoMap.get(currentAssigneeId).lastSelfAssignedTaskDay = System.today();
        userIdTouserAssignmentInfoMap.get(newAssignee.Id).othersAssignedNumber = 
            userIdTouserAssignmentInfoMap.get(newAssignee.Id).othersAssignedNumber + 1;

    }

    public void updateUser(List<User> usersList) {
        List<User> usersToUpdateList = new List<User>();
        try {
            for(User tmpUser : usersList) {
                if(userIdTouserAssignmentInfoMap.containsKey(tmpUser.Id)) {
                    

                    tmpUser.Other_s_Assigned_Tasks__c = userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedNumber;
                    tmpUser.Self_Assigned_Tasks__c = userIdTouserAssignmentInfoMap.get(tmpUser.Id).selfAssignedNumber;
                    tmpUser.Self_Assigned_Time__c = userIdTouserAssignmentInfoMap.get(tmpUser.Id).selfAssignedTime;
                    tmpUser.Other_s_Assigned_Task_time__c = userIdTouserAssignmentInfoMap.get(tmpUser.Id).othersAssignedTime;
                    tmpUser.Last_Self_Escalated_Task_Day__c = userIdTouserAssignmentInfoMap.get(tmpUser.Id).lastSelfAssignedTaskDay;
                    usersToUpdateList.add(tmpUser);
                }
            }
            update usersToUpdateList;
        }
        catch (Exception excptn) {
            excptn.getMessage();
        }

    }



    private class userAssignmentInfo {
        User user;
        Decimal selfAssignedNumber;
        Decimal othersAssignedNumber;
        DateTime selfAssignedTime;
        DateTime othersAssignedTime;
        Date lastSelfAssignedTaskDay;
        

        public userAssignmentInfo(User user, Decimal sAN, Decimal oAN, DateTime sAT, DateTime oAT, Date lSATD ) {
            this.user = user;
            if(sAN !=null) {
                this.selfAssignedNumber = sAN;
            }
            else {
                this.selfAssignedNumber = 0;
            }
            if(oAN !=null) {
                this.othersAssignedNumber = oAN;
            }
            else {
                this.othersAssignedNumber = 0;
            }
            if(sAT !=null) {
                this.selfAssignedTime = sAT;
            }
            else {
                this.selfAssignedTime = System.now();
            }
            if(oAT !=null) {
                this.othersAssignedTime = oAT;
            }
            else {
                this.othersAssignedTime = System.now();
            }
            if(lSATD !=null) {
                this.lastSelfAssignedTaskDay = lSATD;
            }
            else {
                this.lastSelfAssignedTaskDay = System.today();
            }
        }
        

    }
}