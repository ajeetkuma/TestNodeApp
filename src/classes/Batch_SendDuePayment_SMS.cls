/*
    Description   : Send SMS for Total Due Payment from Master Payment, Based on Yesterday's Billing Date
    Author        : Shikha devi
    Created Date  : 30/12/2015
*/


global class Batch_SendDuePayment_SMS implements Database.Batchable<sObject>,Database.AllowsCallouts{
    String query;
            
    global Database.QueryLocator start(Database.BatchableContext BC){

        Date dateYesterday  =   Date.today().addDays(-1);
        query               = 'Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Total_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c,Stage__c  from Master_Payment__c where  Billing_Date__c <=:dateYesterday AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null AND Total_Amount__c > 0';
   
        system.debug('***Query***'+query);
        return Database.getQueryLocator(query);
        
    }

    global void execute(Database.BatchableContext BC, List<Master_Payment__c> scope){
    try{
            System.debug(':::::scope>>>>'+scope);           
            List<smagicinteract__smsmagic__c> smsObjectsToInsert    = Utility_Class.getMasterPaymentSMSListToSend(scope,Utility_Class.PAYMENT_DUE_TEMPLATE,Utility_Class.MASTER_PAYMENT_OBJECT,Utility_Class.CONTACT_NAME_API,1);
            
            String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
            
            if(smsObjectsToInsert.size() > 0){
                Database.insert(smsObjectsToInsert,false);
                System.debug('::::::::::smsObjectsToInsert'+ smsObjectsToInsert);
            }
         
        }catch(Exception ex){
            system.debug('Exception:::'+ex.getMessage());
        }
        
        
            
    }
    
    global void finish(Database.BatchableContext BC){
    }

}