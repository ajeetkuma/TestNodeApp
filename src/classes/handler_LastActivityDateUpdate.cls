/*
Description        :    Handler class to get the last activity update date from Lead and Opportunity for the task.
Created By         :    Anju Alexander
Version            :    V1.0
*/

public class handler_LastActivityDateUpdate{
    
    /*public void AfterUpdateOpp(List<Task> tasklist){
        getLastActivityUpdateDate(tasklist); 
    }*/
    public void AfterInsertUpdateOpp(List<Task> tasklist)    {
        getLastActivityUpdateDate(tasklist); 
    }
    
    
    /*
Description    :     Method to get LastActivityUpdateDate for opportunity
*/
    public void getLastActivityUpdateDate(List<Task> tasklist)    {
        Id oppId;
        Date lastActivityDate;
        Date lastActivityDateOpp;
        List<Task> tlist = new List<Task>();
        Set<Id> tset = new Set<Id>();
        for (Task tskObj: tasklist){
            oppId = tskObj.WhatId;
            tset.add(tskObj.WhatId);
            //System.debug('OPP'+tskObj);  
        }
        
        Map<Id,Task> tmap = new Map<Id,Task>();
        try{
            if(tset.size()>0){
                tlist = [select Id, CreatedDate,whatId  from Task where WhatId in :tset order by CreatedDate DESC LIMIT 1];
            }
        }
        catch(Exception e){
            
        }
        for(Task t : tlist){
            tmap.put(t.whatId,t);   
        }
        
        List<Opportunity> ulist = new List<Opportunity>();
        // Now update opportunity.
        List<Opportunity> olist = new List<Opportunity>();
        try{
            if(tset.size()>0){
                
                olist = [select Sales_Person_1__c,Id from Opportunity where Id IN :tset ];
            }
        }catch(Exception e){
            
        }
        try{
            if(olist.size()>0){
                For(Opportunity op : olist){
                    op.LastActivityDate__c=Date.ValueOf(tmap.get(op.id).CreatedDate);
                    ulist.add(op);
                }
            }
        }
        catch(Exception e){
            
        }
        try{
            if(ulist.size()>0){   
                update ulist;   
            }
        }
        catch(Exception e){
            
        }
        
    }
    
    /*
* Description       : Method to get last activity update date for Lead.
*/ 
    /*public void AfterUpdateLead(List<Task> tasklist){
        getLastActivityDateForLead(tasklist);    
    }*/
    public void AfterInsertUpdateLead(List<Task> tasklist){
        getLastActivityDateForLead(tasklist); 
    }
    
    public void getLastActivityDateForLead(List<Task> tasklist){
        Id leadId;
        Date lastActivityDate;
        Date lastActivityDateOpp;
        List<Task> tlist = new List<Task>();
        Set<Id> tset = new Set<Id>();
        Map<Id,Task> tmap = new Map<Id,Task>();
        List<Lead> ulist = new List<Lead>();
        List<Lead> leadList = new List<Lead>();
        try{
            for (Task tskObj: tasklist){
                leadId = tskObj.WhoId;
                tset.add(tskObj.WhoId);
               // System.debug('OPP'+tskObj);  
            }
            if(tset.size()>0){
                tlist = [select Id, CreatedDate,whoId  from Task where WhoId in :tset order by CreatedDate DESC LIMIT 1];
            }

            for(Task t : tlist){
                tmap.put(t.whoId,t);   
            }
            
            
            // Now update opportunity.
            
           
            if(tset.size()>0){
                
                leadList = [select Id from Lead where Id IN :tset ];
            }
       
            if(leadList.size()>0){
                For(Lead op : leadList){
                    op.LastActivityDate__c=tmap.get(op.id).CreatedDate;
                    ulist.add(op);
                }
            }
            if(ulist.size()>0){   
                update ulist;   
            }
        }
        catch(Exception e){
            e.getMessage();
        }
    } 
}