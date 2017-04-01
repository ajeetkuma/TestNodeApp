public class UserTriggerHelper {
	
    
    public static void insertCSforuser(list<user> triggerNew){
        List<LeadCount__c> updateCS = new List<LeadCount__c>();
            for(user usr : triggerNew){
                string projectAllocated = usr.Associated_Project__c;
                if(projectAllocated != null){
                    list<string> SplitedSTR = projectAllocated.split(';',-1);
                    for(string str : SplitedSTR ){
                        LeadCount__c LC = new LeadCount__c(UserId__c = usr.id ,ProjectID__c = str ,name = usr.id+''+str ,No_of_Lead_Assigned__c = 0);
                        updateCS.add(LC);
                    }
                    Database.insert(updateCS,false);
                }
        	}
   	}
    
    public static void updateCSforuser(list<user> triggerNew, map<id,user> triggerOldMap){
        
        	List<LeadCount__c> updateCS = new List<LeadCount__c>();
			list<string> newCS = new list<string>();
			list<string> delCS = new list<string>();
			
			for(user usr : triggerNew){
				set<string> prevValSet = new set<string>();
				string prevValue = triggerOldMap.get(usr.id).Associated_Project__c;
				list<string> splitedPrevValues = new list<string>();
				if(prevValue != null){
					splitedPrevValues = prevValue.split(';',-1);
					prevValSet.addAll(splitedPrevValues);
				}
				string projectAllocated = usr.Associated_Project__c;
				if(projectAllocated != null){
					list<string> SplitedSTR = projectAllocated.split(';',-1);
					for(string str : SplitedSTR){
						if(!prevValSet.contains(str)){
							newCS.add(str);
						}else{
							prevValSet.remove(str);
						}
					}
					
					for(string str : newCS ){
							LeadCount__c LC = new LeadCount__c(UserId__c = usr.id ,ProjectID__c = str ,name = usr.id+''+str ,No_of_Lead_Assigned__c = 0);
							updateCS.add(LC);
					}
					if(prevValSet.size()>0){
						for(string str : prevValSet){
							delCS.add(usr.id+''+str);
						}
					}
				}
	}
		Database.upsert(updateCS,false);
		if(delCS.size()>0){
			list<LeadCount__c> delLC = new list<LeadCount__c>();
			delLC = [select id from LeadCount__c where name IN : delCS];
			database.delete(delLC,false);
		}
    }
}