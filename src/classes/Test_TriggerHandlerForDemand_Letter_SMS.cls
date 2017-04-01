/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
public class Test_TriggerHandlerForDemand_Letter_SMS {
    Static String oppRecordType    = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Opportunity After SO').getRecordTypeId();
    
    static testMethod void myUnitTest(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
            
            //get dummy for SMS Magic
            
            Account accobj = Utility_TestData.getAccountData();
            insert accobj;
            
            Contact conobj = Utility_TestData.getContact();
            conobj.accountid= accobj.id;
            conobj.Contact_Type__c = Utility_Class.CONTACTROLE_FIRST;
            conobj.mobilephone = '9912377123';
            insert conobj;
            
            Plant__c plantobj = Utility_TestData.getplant();
            insert plantobj;
            
            Unit__c unitobj = Utility_TestData.getUnit(plantobj.id,1);
            insert unitobj;
            
            
            Opportunity oppobj = Utility_TestData.getOpportunity(accobj.id,unitobj.id,1);
            insert oppobj;
            
            
            Demand_Letter_Repository__c demandletter = new Demand_Letter_Repository__c();
            demandletter.Contact_Name__c='test';
            demandletter.CC__c='developer@extentor.com';
            demandletter.Opportunity__c=oppobj.id;
            demandletter.Sent_Date__c= System.today();
            demandletter.Page1__c='test';
            demandletter.Page2__c='test';
            
            demandletter.Selection_Date__c=System.today();
            demandletter.To__c='developer@extentor.com';
            insert demandletter;
            
            String name = String.valueOf(demandletter.Contact_Name__c);
            String mobilephone = demandletter.Mobile_Number__c;
            
            smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
            smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
            smsObj.smagicinteract__Name__c = name;
            smsObj.smagicinteract__ObjectType__c = 'Demand_Letter_Repository__c'; // record type
            smsObj.smagicinteract__disableSMSOnTrigger__c = 1; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
            smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
            smsObj.smagicinteract__senderId__c = 'sms magic';
            smsObj.smagicinteract__SMSText__c = 'smsText';
            insert smsObj;
            //pass information to sms magic
            smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
            tpltext.smagicinteract__Text__c = 'tets';
            tpltext.smagicinteract__Name__c = 'Demand Letter SMS';
            insert tpltext;
            
            Test.startTest(); 
             try{ 
            scheduled_Demand_Letter_SMS_Batch sh1 = new scheduled_Demand_Letter_SMS_Batch();            
            String sch = '0 0 23 * * ?';
            system.schedule('Testing', sch, sh1);
            }
            catch(Exception e){
            e.getMessage();
            }
                
            Test.stopTest();
            
        }
    }
    
    static testMethod void myUnitTest2(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
            
            //get dummy for SMS Magic
            
            Account accobj = Utility_TestData.getAccountData();
            insert accobj;
            
            Contact conobj = Utility_TestData.getContact();
            conobj.accountid= accobj.id;
            conobj.Contact_Type__c = Utility_Class.CONTACTROLE_FIRST;
            conobj.mobilephone = '9912377123';
            insert conobj;
            
            Plant__c plantobj = Utility_TestData.getplant();
            insert plantobj;
            
            Unit__c unitobj = Utility_TestData.getUnit(plantobj.id,1);
            insert unitobj;
            
            
            Opportunity oppobj = Utility_TestData.getOpportunity(accobj.id,unitobj.id,1);
            insert oppobj;
            
            
            Demand_Letter_Repository__c demandletter = new Demand_Letter_Repository__c();
            demandletter.Contact_Name__c='test';
            demandletter.CC__c='developer@extentor.com';
            demandletter.Opportunity__c=oppobj.id;
            demandletter.Sent_Date__c= System.today();
            demandletter.Page1__c='test';
            demandletter.Page2__c='test';
            
            demandletter.Selection_Date__c=System.today();
            demandletter.To__c='developer@extentor.com';
            insert demandletter;
            
            String name = String.valueOf(demandletter.Contact_Name__c);
            String mobilephone = demandletter.Mobile_Number__c;
            
            smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
            smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
            smsObj.smagicinteract__Name__c = name;
            smsObj.smagicinteract__ObjectType__c = 'Demand_Letter_Repository__c'; // record type
            smsObj.smagicinteract__disableSMSOnTrigger__c = 1; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
            smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
            smsObj.smagicinteract__senderId__c = 'sms magic';
            smsObj.smagicinteract__SMSText__c = 'smsText';
            insert smsObj;
            //pass information to sms magic
            smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
            tpltext.smagicinteract__Text__c = 'tets';
            tpltext.smagicinteract__Name__c = 'Demand Letter SMS';
            insert tpltext;
            
            Test.startTest(); 
             try{ 
           		CallBatchApexFromButton.runDemandSendMSGBatch();
            }
            catch(Exception e){
            e.getMessage();
            }
                
            Test.stopTest();
            
        }
    }
    
}