/*
*
*Name : Shikha Devi
*Created Date : 29/1/2015
Modified Date : 3/7/2015
Modified By : Neha Mishra
*After Insert : After creating Task for lead/contact SMS will goto Lead/Contact as well Task owner
*
*/
trigger SMS_Sending on Task(before insert,after insert, before update, after update){
    
    
    //-- Instantiate the handler
    TriggerHelperForSMS handler = new TriggerHelperForSMS();
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        list<Sobject> updateSobject = new list<Sobject>();
        
        for(task tsk : Trigger.new){
            string callDisposition = tsk.Call_disposition__c ;
            string previousCallDisposition ;
            if(Trigger.oldMap != null ){
                previousCallDisposition = Trigger.oldMap.get(tsk.id).Call_disposition__c;
            }
            boolean CallDispositionValueChange = true;
            if(previousCallDisposition != null && callDisposition != null &&  callDisposition.equalsIgnoreCase(previousCallDisposition)){
                CallDispositionValueChange = false;
            }
            
            if(callDisposition != null && callDisposition != '' && CallDispositionValueChange){
                string taskWhoid = tsk.whoid ;
                string taskWhatid = tsk.WhatId;
                if(taskWhoid != null ){
                    if(taskWhoid.startsWith('00Q')){
                        lead led = new lead(id= taskWhoid ,Latest_Call_Disposition__c = callDisposition);
                        updateSobject.add(led);
                    }else if(taskWhoid.startsWith('003')){
                        contact con = new contact(id= taskWhoid ,Latest_Call_Disposition__c = callDisposition);
                        updateSobject.add(con);
                        
                        if(taskWhatid != null && taskWhatid.startsWith('006')){
                            opportunity opp = new opportunity(id= taskWhatid ,Latest_Call_Disposition__c = callDisposition);
                            updateSobject.add(opp);
                        }
                    }
                }
                
            }
        }
        if(updateSobject.size()>0){
            Database.update(updateSobject,false);
        }
    }
    
    // -- Before Insert      
    if (Trigger.isInsert && Trigger.isBefore && Utility_Class.IS_TASK_TRIGGER_RUNNING == false) {        
        handler.populateFieldsOfLeadonTask(Trigger.new);
        handler.populateFieldsOfContactonTask(Trigger.new);
       
    } 
    
    
    // -- After Insert      
    if (Trigger.isInsert && Trigger.isAfter && Utility_Class.IS_TASK_TRIGGER_RUNNING == false) {
        
        UpdateDateFieldHandler updateFieldHandler = new UpdateDateFieldHandler();
        updateFieldHandler.onAfterInsert(Trigger.new);
               
        MAP<String,SMS_Trigger__c> mapOfCustomSMSObject = SMS_Trigger__c.getAll(); 
        if(mapOfCustomSMSObject.size()>0){
          handler.sendSmsToUser(Trigger.new);
          handler.sendSmsToLead_Contact(Trigger.new);
        } 
    }
    
    // -- Before Update
    if (Trigger.isUpdate && Trigger.isBefore && Utility_Class.IS_TASK_TRIGGER_RUNNING == false) {
      
        TaskReassignmentHandler reassignmentHandler = new TaskReassignmentHandler();
        reassignmentHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);

    }
    
    if (Trigger.isInsert){
        
    
        TriggerHelperForSMS handler1 = new TriggerHelperForSMS();
        
        TaskReassignmentHandler reassignmentHandler1 = new TaskReassignmentHandler();
        
        MAP<String,String> strMap = new MAP<String,String>();
        MAP<String,String> strMap1 = new MAP<String,String>();
        MAP<String,String> strMap2 = new MAP<String,String>();
        MAP<String,String> strMap3 = new MAP<String,String>();
        
        String hanlderMap   = '';
        
        List<String> strList    = new List<String>();
        List<String> strList1   = new List<String>();
        List<String> strList2   = new List<String>();
        List<String> strList3   = new List<String>();   
        
        Set<String> setList     = new Set<String>();
        Set<String> setList1    = new Set<String>();
        Set<String> setList2    = new Set<String>();
        Set<String> setList3    = new Set<String>();    
        
        MAP<String,String> smmIdMap = new MAP<String,String>();
        MAP<String,String> smmIdMap1 = new MAP<String,String>();
        MAP<String,String> smmIdMap2 = new MAP<String,String>(); 
        
        MAP<String,String> accMap = new MAP<String,String>();
        MAP<String,String> accMap1 = new MAP<String,String>();
        MAP<String,String> accMap2 = new MAP<String,String>();
    }
 }