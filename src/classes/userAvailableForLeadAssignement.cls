public class userAvailableForLeadAssignement {
    
    public list<userWrraper> userList {get;set;}
    public boolean renderSaveBTN {set; get;} 
    public user ussr {get;set;}
    public boolean displayPage {get;set;}
    
    public userAvailableForLeadAssignement(){
        displayPage = true;
		id managerId = Apexpages.currentPage().getParameters().get('id');
        UserRecordAccess accessLevel = [SELECT RecordId, HasEditAccess FROM UserRecordAccess WHERE UserId = :system.UserInfo.getUserId() AND RecordId = :managerId];      
        displayPage = true;
        if(!accessLevel.HasEditAccess){
            displayPage = false;
        }
       
        if(displayPage == true){
        userList = new list<userWrraper>(); 
        list<userWrraper> usrWrap = new list<userWrraper>();
        
        list<user> userLst = [select Name ,username , UserRole.name ,Available_for_Lead_Assignment__c from user where ManagerId = :managerId or id =:managerId];
        
        for(user usr : userLst){
            if(usr.id != managerId){
            	userWrraper userWrap = new userWrraper(usr.id, usr.name , usr.UserRole.name , usr.Available_for_Lead_Assignment__c ); 
                userList.add(userWrap);
            }else{
                ussr = usr;
            }
        }
        	
        		
        	if(userList.size() == 0){
            	renderSaveBTN = false ;
            }else{
                renderSaveBTN = true ;
            }
            
        }
        
    }
    
    public pagereference saveAssignment(){
        list<user> SaveUserLst = new list<user>();
        for(userWrraper usr : userList){
            system.debug(usr);
            user usrlst = new user(id=usr.usrId , Available_for_Lead_Assignment__c = usr.availableforAssignment);
            SaveUserLst.add(usrlst);
        }
        if(ussr != null){
            SaveUserLst.add(ussr);
        }
        Database.update(SaveUserLst,false);
        return null;
    }
    
    public class userWrraper{
        public id usrId {get;set;}
        public string name {get;set;}
        public string role {get;set;}
        public boolean availableforAssignment{get;set;}
        
        public userWrraper(id usrId ,string name, string role,boolean availableforAssignment){
            this.usrId = usrId ;
            this.name = name;
            this.role = role;
            if(availableforAssignment == null){
                this.availableforAssignment =true ;
            }else{
            	this.availableforAssignment = availableforAssignment ;
            }
        }
    }

}