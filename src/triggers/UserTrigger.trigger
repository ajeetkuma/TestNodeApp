trigger UserTrigger on User (after insert, after update) {
    
    
        if(trigger.isafter && trigger.isinsert){
			UserTriggerHelper.insertCSforuser(trigger.New);
		}  
		if(trigger.isafter && trigger.isupdate){
            UserTriggerHelper.updateCSforuser(trigger.New, trigger.OldMap);
		}
}