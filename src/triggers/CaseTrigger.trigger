trigger CaseTrigger on Case (after insert,after update) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        
        list<id> contactID = new list<id>();
        for(case insertedCase : Trigger.new ){
            
            id conID = insertedCase.id ;
            if(conID != null){
                contactID.add(conID);
            }
            
        }//End of For Loop
        
        if(contactID.size()>0){
            sendEKhathaSMS.sendSMSToContact(contactID,'NewCaseLogged','CASE','Contact_s_Mobile__c');
            SMSfromCase.sendSMStoCaseOwner(contactID);
        }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        list<id> contactID = new list<id>();
        list<id> caseIDforOwnerNotification = new list<id>();
        list<id> firstLevelEscalation = new list<id>();
        list<id> secondLevelEscalation = new list<id>();
        for(case updatedCase : Trigger.new ){
            
            if(updatedCase.IsClosed){
                contactID.add(updatedCase.id);
            }
            
            /*if(trigger.oldmap.get(updatedCase.id).ownerid != updatedCase.OwnerId && updatedCase.Escalated_After_24_Hours__c == false){
                caseIDforOwnerNotification.add(updatedCase.id);
            }*/
            
            if((trigger.oldmap.get(updatedCase.id).Escalated_After_24_Hours__c != updatedCase.Escalated_After_24_Hours__c) && updatedCase.Escalated_After_24_Hours__c == true && updatedCase.isclosed == false && updatedCase.Status == 'New' && CaseEsclated.allowCaseEscalation == true ){
                firstLevelEscalation.add(updatedCase.id);
            }
            
            if((trigger.oldmap.get(updatedCase.id).Second_Level_Escalation__c != updatedCase.Second_Level_Escalation__c) && updatedCase.Second_Level_Escalation__c == true && updatedCase.isclosed == false && updatedCase.Status == 'New' && CaseEsclated.allowCaseEscalation == true){
                secondLevelEscalation.add(updatedCase.id);
            }
        }//End of For Loop
        
        if(contactID.size()>0){
            sendEKhathaSMS.sendSMSToContact(contactID,'CaseClosedNotification','CASE','Contact_s_Mobile__c');
        }
        /*if(caseIDforOwnerNotification.size()>0){
            SMSfromCase.sendSMStoCaseOwner(caseIDforOwnerNotification);
        }*/
        
        if(firstLevelEscalation.size()>0){
            CaseEsclated.escalateCasetoManager(firstLevelEscalation,'CaseEscalatedToManager');
        }
        
        if(secondLevelEscalation.size()>0){
            CaseEsclated.escalateCasetoManager(secondLevelEscalation,'CaseEscalatedToSecondManager');
        }
    }

}