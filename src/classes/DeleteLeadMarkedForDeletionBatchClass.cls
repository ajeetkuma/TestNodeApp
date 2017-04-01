global with sharing class DeleteLeadMarkedForDeletionBatchClass implements Database.Batchable<sObject>{

    
    
    global DeleteLeadMarkedForDeletionBatchClass (){
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query='select id,Mark_For_Deletion__c from Lead where Mark_For_Deletion__c=true';
        return Database.getQueryLocator(query);   
    }
    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        list<Lead> leadListToDelete= new list<Lead>();
        if(scope.size()>0){
            //List<Sales_Planing_Staging__c> spList=(List<Sales_Planing_Staging__c>)scope; 
            for(SObject templd : scope){
                lead ld1 = (lead)templd ;
                leadListToDelete.add(ld1);
            }
        }
        if(leadListToDelete.size()>0){
            delete leadListToDelete;
        }
    }
    global void finish(Database.BatchableContext BC) {
        //put your email address to get exception notifications
    }   
}