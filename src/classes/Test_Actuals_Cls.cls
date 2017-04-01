/**
 *Description : Test Class for ActaulsCalculation_Cls Class
  Author      : Amritesh
 */
@isTest
private class Test_Actuals_Cls {

    static testMethod void actuals_Test() {
        
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        
        system.runAs(testUser){
            
            Test.startTest();
                
                Project__c dummyProject     = Utility_TestData.getProject();
                insert dummyProject;
                
                Account dummyAcc            = Utility_TestData.getAccountData();
                insert dummyAcc;
                
                Plant__c dummyPlant         = Utility_TestData.getPlant();
                dummyPlant.ProjectLookup__c = dummyProject.Id;
                insert dummyPlant;
                
                Unit__c dummyUnit           = Utility_TestData.getUnit(dummyPlant.Id,0);                
                insert dummyUnit;
            
                Unit__c dummyUnit2          = Utility_TestData.getUnit(dummyPlant.Id,0);                
                insert dummyUnit2;
                
                Target__c dummyTarget       = Utility_TestData.getTarget(dummyProject.id, dummyPlant.id);
                insert dummyTarget;
            
                Target__c dummyTarget2      = Utility_TestData.getTarget(dummyProject.id, dummyPlant.id);
                dummyTarget2.Start_Date__c  = system.today().addMonths(4);
                dummyTarget2.End_Date__c    = system.today().addMonths(7);
                insert dummyTarget2;
                
                Contact dummyContact        = Utility_TestData.getContact();
                dummyContact.Accountid      = dummyAcc.id;
                insert dummyContact;
                
                Opportunity dummyOpp        = Utility_TestData.getOpportunity(dummyAcc.Id, dummyUnit.Id, 0);
                dummyOpp.Sale_Order_Date__c = system.today().addMonths(1);
                dummyOpp.Sale_Order_No__c   = 'Test-123456';
                insert dummyOpp;
            
                Opportunity dummyOpp2       = Utility_TestData.getOpportunity(dummyAcc.Id, dummyUnit2.Id, 0);
                dummyOpp2.Sale_Order_Date__c= system.today().addMonths(1);
                dummyOpp2.StageName         = 'Allotment';
                dummyOpp2.Sale_Order_No__c   = 'Test-123457';
                insert dummyOpp2;
                
                OpportunityContactRole ocr  = new OpportunityContactRole();
                ocr.ContactId               = dummyContact.Id;
                ocr.OpportunityId           = dummyOpp.Id;
                ocr.IsPrimary               = True;
                ocr.Role                    = 'First Applicant';                
                insert ocr;
                
                Sale_Order_Item__c sOrder   = Utility_TestData.getSalesOrder(dummyOpp.id);
                insert sOrder;
                
                dummyOpp.StageName          = 'Allotment';
            
                Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
                update dummyOpp;
                
                
                Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
                Handler_TargetTrigger.IS_TARGET_RUNNING = false;
                dummyOpp.Sale_Order_Date__c = System.today().addMonths(6);
                update dummyOpp;
                
                Handler_TargetTrigger.IS_TARGET_RUNNING = false;
                update dummyTarget;
                
            Test.stopTest();
            
        }
    
    }
}