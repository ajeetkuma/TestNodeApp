/**
 *  Description     : The test class is for handler class, Handler_OpportunityTrigger which is used to 
 *                    send email to Contacts if there is no Survey Response after Date of Site Visit is entered.
 *  Date            : 13/7/2015
 *
**/
@isTest(SeeAllData=false)
public class Test_Handler_OpportunityTrigger {


    static testMethod void myUnitTest(){
        
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
            
            Test.startTest();
            
                RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];
                
                RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
                
              
                Plant__c objPlant                       = Utility_TestData.getPlant();
                insert objPlant;
                
                Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
                insert objUnit;
                
                Account objAcc                          = Utility_TestData.getAccountData();
                objAcc.CC_Address__c                    = 'subas@gmail.com';
                insert objAcc;
                
                Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
                objOpp.SurveySent__c					= false;
                insert objOpp;
                
                Contact objCon                          = Utility_TestData.getContact();
                objCon.AccountId                        = objAcc.id;
                objCon.recordTypeId                     = rt1.id;
                objCon.Portal_Access__c					= true;                
                insert objCon;       
               
                objOpp.Date_of_Site_Visit__c            = system.today();
                objOpp.SurveySent__c					= false;           
                Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
                
                update objOpp;           
            
            Test.stopTest();            
        }
    }
    
    static testMethod void myUnitTest2(){
        
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
            
            Test.startTest();
            
                RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];
                
                RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
                
              
                Plant__c objPlant                       = Utility_TestData.getPlant();
                insert objPlant;
                
                Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
                insert objUnit;
                
                Account objAcc                          = Utility_TestData.getAccountData();
                objAcc.CC_Address__c                    = 'subas@gmail.com';
                insert objAcc;
                
                Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
                objOpp.SurveySent__c					= false;
                insert objOpp;
                
                Contact objCon                          = Utility_TestData.getContact();
                objCon.AccountId                        = objAcc.id;
                objCon.recordTypeId                     = rt1.id;
                objCon.Portal_Access__c					= true; 
                Utility_Class.IS_OPP_TRIGGER_RUNNING    = true;
                insert objCon;       
                
                List<Standard_Feedback_Form__c> customList    = new List<Standard_Feedback_Form__c>();
                Standard_Feedback_Form__c data1               = Utility_TestData.getSurveySettings(Utility_Class.BOOKING_CSAT_FEEDBACK);
                customList.add(data1);
                Standard_Feedback_Form__c data2               = Utility_TestData.getSurveySettings(Utility_Class.EXECUTION_WITH_MODIFY);
                customList.add(data2);
                Standard_Feedback_Form__c data3               = Utility_TestData.getSurveySettings(Utility_Class.EXECUTION_WITHOUT_MODIFY);
                customList.add(data3);
                Standard_Feedback_Form__c data4               = Utility_TestData.getSurveySettings(Utility_Class.HANDOVER_FEEDBACK_FORM);
                customList.add(data4);
                Standard_Feedback_Form__c data5               = Utility_TestData.getSurveySettings(Utility_Class.ONE_YEAR_HANDOVER);
                customList.add(data5);
                
                insert customList;
                
                objOpp.Booking_CSAT_Feed_back_form__c               = false;
                objOpp.Execution_with_Modification_Feed_back_fo__c  = false;
                objOpp.Modification_Requested__c                  	= true;
                objOpp.Execution_without_modification_Feed_back__c  = false;
                objOpp.Handover_Feed_back_form__c                 	= false;
                objOpp.X1st_year_Handover_Feedback__c             	= false;
            	objOpp.SurveySent__c								= false;
            	
                Utility_Class.IS_OPP_TRIGGER_RUNNING    			= false;
                
                update objOpp;
                           
            Test.stopTest();
                       
        }
    }
}