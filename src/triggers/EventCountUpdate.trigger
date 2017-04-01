/* Trigger to update Event Count in Lead and Opportunity */
trigger EventCountUpdate on Event (after delete, after insert, after undelete, after update) {
    
    Set<ID> OpportunityIds = new Set<ID>();
    
    //We only care about Events linked to Opportunitys.
    
    String OpportunityPrefix = Opportunity.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Opportunity ids coming from the new data
    
    if(trigger.new!=null){
        for (Event t : Trigger.new) {
            if (t.WhatId!= null && string.valueof(t.WhatId).startsWith(OpportunityPrefix) ) {
                
                if(!OpportunityIds.contains(t.WhatId)){
                    //adding unique Opportunity ids since there can be many Events with single Opportunity
                    OpportunityIds.add(t.WhatId);
                }
            }
        }
    }
    
    //Also add any Opportunity ids coming from the old data (deletes, moving an activity from one Opportunity to another)
    
    if(trigger.old!=null){
        for (Event t2 : Trigger.old) {
            if (t2.WhatId!= null && string.valueof(t2.WhatId).startsWith(OpportunityPrefix) )
            {
                if(!OpportunityIds.contains(t2.WhatId)){
                    //adding unique Opportunity ids since there can be many Events with single Opportunity
                    OpportunityIds.add(t2.WhatId);
                }
            }
        }
    }
    
    if (OpportunityIds.size() > 0){
        
        
        
        List<Opportunity> OpportunitysWithEvents = [select id,Event_Count__c,(select id from Events) from Opportunity where Id IN : Opportunityids];
        
        List<Opportunity> OpportunitysUpdatable = new List<Opportunity>();
        
        for(Opportunity L : OpportunitysWithEvents){
            
            L.Event_Count__c = L.Events.size();
            OpportunitysUpdatable.add(L);
            
        }
        
        if(OpportunitysUpdatable.size()>0){
            
            update OpportunitysUpdatable;
            //update all the Opportunitys with activity count
            
        }
        
    }
    
    /*================================================================*/    
    
    Set<ID> LeadIds = new Set<ID>();
    
    //We only care about Events linked to Leads.
    
    String leadPrefix = Lead.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Lead ids coming from the new data
    
    if(trigger.new!=null){
        for (Event t : Trigger.new) {
            if (t.WhoId!= null && string.valueof(t.WhoId).startsWith(leadPrefix) ) {
                
                if(!LeadIds.contains(t.WhoId)){
                    //adding unique lead ids since there can be many Events with single lead
                    LeadIds.add(t.WhoId);
                }
            }
        }
    }
    
    //Also add any Lead ids coming from the old data (deletes, moving an activity from one Lead to another)
    
    if(trigger.old!=null){
        for (Event t2 : Trigger.old) {
            if (t2.WhoId!= null && string.valueof(t2.WhoId).startsWith(leadPrefix) )
            {
                if(!LeadIds.contains(t2.WhoId)){
                    //adding unique lead ids since there can be many Events with single lead
                    LeadIds.add(t2.WhoId);
                }
            }
        }
    }
    
    if (LeadIds.size() > 0){
        
        
        
        List<Lead> leadsWithEvents = [select id,Event_Count__c,Status,(select id from Events) from Lead where Id IN : Leadids];
        
        List<Lead> leadsUpdatable = new List<Lead>();
        
        for(Lead L : leadsWithEvents){
          if(L.Events.size()<>0){  
            L.Event_Count__c = L.Events.size();
            leadsUpdatable.add(L);
           } 
        }
        
        if(leadsUpdatable.size()>0){
            
            update leadsUpdatable;
            //update all the leads with activity count
            
        }
        
    }
//*********************************************************************************************
    Set<ID> ContactIds = new Set<ID>();
    
    //We only care about Events linked to Contacts.
    
    String ContactPrefix = Contact.SObjectType.getDescribe().getKeyPrefix();
    
    //Add any Contact ids coming from the new data
    
    if(trigger.new!=null){
        for (Event t : Trigger.new) {
            if (t.WhoId!= null && string.valueof(t.WhoId).startsWith(ContactPrefix) ) {
                
                if(!ContactIds.contains(t.WhoId)){
                    //adding unique Contact ids since there can be many Events with single Contact
                    ContactIds.add(t.WhoId);
                }
            }
        }
    }
    
    //Also add any Contact ids coming from the old data (deletes, moving an activity from one Contact to another)
    
    if(trigger.old!=null){
        for (Event t2 : Trigger.old) {
            if (t2.WhoId!= null && string.valueof(t2.WhoId).startsWith(ContactPrefix) )
            {
                if(!ContactIds.contains(t2.WhoId)){
                    //adding unique Contact ids since there can be many Events with single Contact
                    ContactIds.add(t2.WhoId);
                }
            }
        }
    }
    
    if (ContactIds.size() > 0){
        
        
        
        List<Contact> ContactsWithEvents = [select id,Event_Count__c,(select id from Events where WhatId=:'') from Contact where Id IN : Contactids];
        
        List<Contact> ContactsUpdatable = new List<Contact>();
        
        for(Contact L : ContactsWithEvents){
            
            L.Event_Count__c = L.Events.size();
            ContactsUpdatable.add(L);
            
        }
        
        if(ContactsUpdatable.size()>0){
            
            update ContactsUpdatable;
            //update all the Contacts with activity count
            
        }
        
    }    
}