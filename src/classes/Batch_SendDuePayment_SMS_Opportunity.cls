/*
    Description   : Send SMS for Total Due Payment from opportunity, Based on due in payment 
    Author        : Sukesh G
    Created Date  : 5/2/2016
*/


global class Batch_SendDuePayment_SMS_Opportunity implements Database.Batchable<sObject>,Database.AllowsCallouts{
    String query;
    Public List<id> selectedOpIds;
            
    global Database.QueryLocator start(Database.BatchableContext BC){
        Date dateYesterday  =   Date.today().addDays(-1);
        query               = 'Select id,Unit__c,Total_Due_Payment__c,DND__c,First_Applicant_Name__c,First_Applicant_Number__c,First_Applicant_DND__c  from Opportunity where Total_Due_Payment__c > 0 and id IN :selectedOpIds ' ;
   
        system.debug('***query               ***'+query  );
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope){
    try{
            //System.debug(':::::scope>>>>'+scope);           
            List<smagicinteract__smsmagic__c> smsObjectsToInsert    =  Utility_Class.getOpportunityPaymentSMSListToSend(scope,Utility_Class.PAYMENT_DUE_TEMPLATES,Utility_Class.DUE_PAYMENT_OBJECT,Utility_Class.CONTACT_SMS_API,1);
            
            String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
            
            if(smsObjectsToInsert.size() > 0){
                Database.insert(smsObjectsToInsert,false);
                //System.debug('::::::::::smsObjectsToInsert'+ smsObjectsToInsert);
            }
         
        }catch(Exception ex){
            system.debug('Exception:::'+ex.getMessage());
        }
        
        
            
    }
    
    global void finish(Database.BatchableContext BC){
    }

}