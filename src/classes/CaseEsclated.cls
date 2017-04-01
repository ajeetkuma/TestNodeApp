public class CaseEsclated {
    
    public static boolean allowCaseEscalation = true ;
    public static void escalateCasetoManager(list<id> caseIds,string uniqueIdetifier){
        
        list<case> caseDetail = new list<case>();
        caseDetail = [select owner.name,Manager_ID__c,CaseNumber,Current_Owner_s_Manager_Email_Id__c,Owner_s_Manager_Name__c from case where id IN :caseIds and owner.type='user'];
        
        list<case> updateCaseList = new list<case>();
        list<SMS_Sending_Object__c> EmailList = new list<SMS_Sending_Object__c>();
        for(case cs: caseDetail){
            if(cs.Manager_ID__c != null){
            case cse = new case(id = cs.id,ownerid = cs.Manager_ID__c,status ='Escalated');
            updateCaseList.add(cse);
            SMS_Sending_Object__c emailRec = new SMS_Sending_Object__c();
            emailRec.Record_Type__c='case';
            emailRec.Unique_Identifier__c=uniqueIdetifier;
            emailRec.Email_Address__c = cs.Current_Owner_s_Manager_Email_Id__c;
            emailRec.Record_ID__c=cs.id;
            emailRec.SMS_Merge_Field_1__c=cs.Owner_s_Manager_Name__c;
            emailRec.SMS_Merge_Field_2__c =cs.CaseNumber ;
            emailRec.SMS_Merge_Field_3__c =cs.owner.name;
            EmailList.add(emailRec);
                
            } 
        }
        
        if(updateCaseList.size()>0){
            Database.update(updateCaseList,false);
            allowCaseEscalation = false ;
        }
        
        if(EmailList.size() >0){
            Database.Insert(EmailList,false);
        }
    }

}