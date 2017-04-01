@isTest(seeAllData=false)
public class Test_handler_LastActivityDateUpdate {
      static testMethod void myUnitTest(){
    User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
        test.startTest();
        
        Plant__c objPlant                       = Utility_TestData.getPlant();
        insert objPlant;
        
        Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
        insert objUnit;
        
        Account objAcc                          = Utility_TestData.getAccountData();
        objAcc.CC_Address__c='subas@gmail.com';
        insert objAcc;
        
        Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
        insert objOpp;
   
            Task newTask=new Task();
            newTask.Subject='Send email';
            newTask.WhatId=objOpp.id;
            newTask.ActivityDate=System.today();
        
            insert newTask;    
        test.stopTest();
        }
      }
      
      static testMethod void myUnitTestLead(){
    User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
        test.startTest();
        
        Plant__c objPlant                       = Utility_TestData.getPlant();
        insert objPlant;
        
        Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
        insert objUnit;
        
        Account objAcc                          = Utility_TestData.getAccountData();
        objAcc.CC_Address__c='subas@gmail.com';
        insert objAcc;
        
        Lead objlead                            = Utility_TestData.createLead('Test'); 
        insert objLead;    
   
   
            Task newTask=new Task();
            newTask.Subject='Send email';
            newTask.WhoId=objLead.id;
            newTask.ActivityDate=System.today();
        
            insert newTask;    
        test.stopTest();
        }
      }

}