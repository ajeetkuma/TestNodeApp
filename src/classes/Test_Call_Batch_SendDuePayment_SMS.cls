/*---------------------------------------------------------------
Test className : Test_Call_Batch_SendDuePayment_SMS

Class Name : Call_Batch_SendDuePayment_SMS

Created By : Sukesh G

Created Date : 31-12-2015

Description : Test class written for custom button JS to run batches.
To cover the class Call_Batch_SendDuePayment_SMS

----------------------------------------------------------------*/
@istest(seealldata = false)
private class  Test_Call_Batch_SendDuePayment_SMS {


    @istest
    public static void testbatchMeth(){
        list<plant__c> plant = new list<plant__c>();
        plant = [select id from plant__c limit 1];
        Test.startTest();
        
        SendSMStoALLContact sms = new SendSMStoALLContact(plant[0].id);
    //Database.executeBatch(sms);
        Call_Batch_SendDuePayment_SMS.runBatch_SendDuePayment_SMS(plant[0].id);
        list<opportunity> oppr = new list<opportunity>();
        oppr = [select Unit_Name__c ,(select Total__c from Payment_Schedules__r where Status__c = 'Due' or Status__c = 'Overdue') from opportunity];
        sms.execute(null, oppr);
        
        DeleteSMSStagingRec_sch.execute(null); 
        
        Test.stopTest();
        
    }
    
    @testSetup
    public static void testdataCreation(){
        Account acc = Utility_TestData.getAccountData();
        insert acc ;
        Plant__c plant = Utility_TestData.getPlant();
        insert plant ;
        Unit__c unit = Utility_TestData.getUnit(plant.id ,1);
        insert unit ;
    Opportunity oppr = Utility_TestData.getOpportunity(acc.id,unit.id,1);
        insert oppr ;
        contact con = Utility_TestData.getContact();
        con.mobilephone='9999999999';
        insert con ;
        opportunityContactRole opprCon = new opportunityContactRole(opportunityID = oppr.id ,contactID = con.id);
        insert opprCon ;
        Sale_Order_Item__c salesOrder = Utility_TestData.getSalesOrder(oppr.id);
        insert salesOrder;
            
        date myDate = date.newInstance(2015, 8, 15);
          
      Payment_Schedule__c ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=salesOrder.Id,  Opportunity__c = oppr.id
          ,Description__c='test',Billing_Date__c=myDate,Bill_Value__c=23.44,Education_Cess__c=34.56,Secondary_Education_Cess__c=98.89,Payment_Status__c ='A'
          ,Service_Tax__c=89.900,VAT__c=23.44,Mile_Stone_Base_Description_1__c='test',Swachh_Bharath_Cess__c=20.33,Krishi_Kalyan_Cess__c = 20
          );
        insert ps1;
        
        Utility_TestClass.createSMSTemplate('PaymentSMSToContact', 'SMS_Sending_Object__c');
        
          SMS_Sending_Object__c SMSObj = new SMS_Sending_Object__c();
            SMSObj.Mobile_No__c = 'con.MobilePhone' ;
            SMSObj.Record_ID__c = 'con.id' ;
            SMSObj.Related_To__c = 'oppID' ;
            SMSObj.Record_Type__c = 'contact';
            SMSObj.Unique_Identifier__c = 'uniqueID' ;
            SMSObj.SMS_Merge_Field_1__c = 'opportunityID_UnitMap.get(oppID)';
            SMSObj.SMS_Merge_Field_2__c = 'string.valueof(opportunityID_totalMap.get(oppID))';
            
          insert SMSObj ;
          Test.setCreatedDate(SMSObj.id, system.today()-40);
        
    }
}