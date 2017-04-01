/*****************
Author: Nirosha MG
Created Date: 19/12/2016
Purpose: To create a record in File Tracker and to share it with approvers.


******************/
trigger fileTrackerShare on File_Tracker__c(before insert,after insert){
List<File_Tracker__c> ftList = new List<File_Tracker__c>();
List<File_Tracker__c> listOfReceiverRecords = new List<File_Tracker__c>();
// To change the record type from Sender Record to Receiver record on click of Save.
    list<File_Tracker__c> ftListNew = new list<File_Tracker__c>();
    Id devReceiverRecordId = Schema.SObjectType.File_Tracker__c.getRecordTypeInfosByName().get('Receiver Record').getRecordTypeId();
    if(Trigger.isBefore && Trigger.isInsert){
       for(File_Tracker__c ft: Trigger.New){
       Id devSenderRecordId = Schema.SObjectType.File_Tracker__c.getRecordTypeInfosByName().get('Sender Record').getRecordTypeId();
      
        if(ft.RecordTypeId == devSenderRecordId){
            ft.RecordTypeId = devReceiverRecordId ;
             } 
       }
    }
// To give edit permissions only to the Aprrover(to whom the file is shared)    
    if(Trigger.isAfter && Trigger.isInsert){
        list<File_Tracker__share> ftShareList = new list<File_Tracker__share>();
         for(File_Tracker__c ft: Trigger.New){
           if(ft.RecordTypeId == devReceiverRecordId ){
            File_Tracker__share ftshare = new File_Tracker__share();
            ftshare.UserOrGroupID  = ft.User__c;
            ftshare.AccessLevel = 'Edit';
            ftshare.parentID = ft.id;
            ftshare.RowCause = Schema.File_Tracker__share.RowCause.USER_ACCESS__c;
            system.debug('----'+ftshare);
               ftShareList.add(ftshare);
            
           }
        }   
        
        Database.SaveResult[] dsr = Database.Insert(ftShareList,false);
        //system.debug('---'+dsr.getID());
    }
            
        
}