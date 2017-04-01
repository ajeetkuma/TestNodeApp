/*Task count update in Lead and Opportunity */
trigger TaskCountUpdate on Task (after delete, after insert, after undelete, after update) {
    
    Set<ID> OpportunityIds = new Set<ID>();
    
    //We only care about tasks linked to Opportunitys.
    
    String OpportunityPrefix = Opportunity.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Opportunity ids coming from the new data
    
    if(trigger.new!=null){
        for (Task t : Trigger.new) {
            if (t.WhatId!= null && string.valueof(t.WhatId).startsWith(OpportunityPrefix) ) {
                
                if(!OpportunityIds.contains(t.WhatId)){
                    //adding unique Opportunity ids since there can be many tasks with single Opportunity
                    OpportunityIds.add(t.WhatId);
                }
            }
        }
    }
    
    //Also add any Opportunity ids coming from the old data (deletes, moving an activity from one Opportunity to another)
    
    if(trigger.old!=null){
        for (Task t2 : Trigger.old) {
            if (t2.WhatId!= null && string.valueof(t2.WhatId).startsWith(OpportunityPrefix) )
            {
                if(!OpportunityIds.contains(t2.WhatId)){
                    //adding unique Opportunity ids since there can be many tasks with single Opportunity
                    OpportunityIds.add(t2.WhatId);
                }
            }
        }
    }
    
    if (OpportunityIds.size() > 0){
    	
         try{ 
	        List<Opportunity> OpportunitysWithTasks = [select id,Task_Count__c,(select id from Tasks) from Opportunity where Id IN : Opportunityids];
	        
	        List<Opportunity> OpportunitysUpdatable = new List<Opportunity>();
	        
	        for(Opportunity L : OpportunitysWithTasks){
	            
	            L.Task_Count__c = L.Tasks.size();
	            OpportunitysUpdatable.add(L);
	            
	        }
	        
	        if(OpportunitysUpdatable.size()>0){
            	update OpportunitysUpdatable;
            }
         }catch(Exception e){}            
            //update all the Opportunitys with activity count            
        }
    
    /*============================================= */
    
    Set<ID> LeadIds = new Set<ID>();
    
    //We only care about tasks linked to Leads.
    
    String leadPrefix = Lead.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Lead ids coming from the new data
    
    if(trigger.new!=null){
        for (Task t : Trigger.new) {
            if (t.WhoId!= null && string.valueof(t.WhoId).startsWith(leadPrefix) ) {
                
                if(!LeadIds.contains(t.WhoId)){
                    //adding unique lead ids since there can be many tasks with single lead
                    LeadIds.add(t.WhoId);
                }
            }
        }
    }
    
    //Also add any Lead ids coming from the old data (deletes, moving an activity from one Lead to another)
    
    if(trigger.old!=null){
        for (Task t2 : Trigger.old) {
            if (t2.WhoId!= null && string.valueof(t2.WhoId).startsWith(leadPrefix) )
            {
                if(!LeadIds.contains(t2.WhoId)){
                    //adding unique lead ids since there can be many tasks with single lead
                    LeadIds.add(t2.WhoId);
                }
            }
        }
    }
    
    if (LeadIds.size() > 0){
        
        try{
        
	        List<Lead> leadsWithTasks = [select id,Task_Count__c,Status,IsConverted,(select id from Tasks) from Lead where Id IN : Leadids];
	        system.debug('##########################################'+leadsWithTasks);
	        List<Lead> leadsUpdatable = new List<Lead>();
	        
	        for(Lead L : leadsWithTasks){
	          if(L.Tasks.size()<>0){  
	            L.Task_Count__c = L.Tasks.size();
	            leadsUpdatable.add(L);
	            }
	        }
	        system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+leadsUpdatable);
	        if(leadsUpdatable.size()>0){
	            
	            update leadsUpdatable;
	            //update all the leads with activity count
	            
	        }
	        
        }catch(Exception ex){}
    }
//*************************************************************************************************    
    Set<ID> ContactIds = new Set<ID>();
    
    //We only care about tasks linked to Contacts.
    
    String ContactPrefix = Contact.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Contact ids coming from the new data
    
    if(trigger.new!=null){
        for (Task t : Trigger.new) {
            if (t.WhoId!= null && string.valueof(t.WhoId).startsWith(ContactPrefix) ) {
                
                if(!ContactIds.contains(t.WhoId)){
                    //adding unique Contact ids since there can be many tasks with single Contact
                    ContactIds.add(t.WhoId);
                }
            }
        }
    }
    
    //Also add any Contact ids coming from the old data (deletes, moving an activity from one Contact to another)
    
    if(trigger.old!=null){
        for (Task t2 : Trigger.old) {
            if (t2.WhoId!= null && string.valueof(t2.WhoId).startsWith(ContactPrefix) )
            {
                if(!ContactIds.contains(t2.WhoId)){
                    //adding unique Contact ids since there can be many tasks with single Contact
                    ContactIds.add(t2.WhoId);
                }
            }
        }
    }
    
    if (ContactIds.size() > 0){
        
        try{
        
	        List<Contact> ContactsWithTasks = [select id,Task_Count__c,(select id from Tasks where WhatId=:'') from Contact where Id IN : Contactids];
	        
	        List<Contact> ContactsUpdatable = new List<Contact>();
	        
	        for(Contact L : ContactsWithTasks){
	            
	            L.Task_Count__c = L.Tasks.size();
	            ContactsUpdatable.add(L);
	            
	        }
	        
	        if(ContactsUpdatable.size()>0){
	            
	            update ContactsUpdatable;
	            //update all the Contacts with activity count
	            
	        }
        }catch(Exception ex){
        	system.debug('exception::'+ex.getMessage());
        }
        
    }
    
    handler_LastActivityDateUpdate handler = new handler_LastActivityDateUpdate();
    if((Trigger.isUpdate && Trigger.isAfter)||(Trigger.isInsert && Trigger.isAfter))
    {
    handler.AfterInsertUpdateOpp(trigger.new);
    handler.AfterInsertUpdateLead(trigger.new);    
    }
  /*  if(Trigger.isInsert && Trigger.isAfter)
    {
    handler.AfterInsertOpp(trigger.new);
    handler.AfterInsertLead(trigger.new);    
    }*/
    
    
}