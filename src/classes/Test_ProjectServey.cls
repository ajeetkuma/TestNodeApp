/*
 *  Description : Test Class for ProjectServey
 * Author       : Amritesh
 */
@IsTest
Private class Test_ProjectServey{
    
    static testmethod void projectServeryTest(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
            
            
            Test.startTest();
            
                List<Project_Survey__c> testQsnRecord = new List<Project_Survey__c>();
                String qusnRecordType   = ProjectServey_Controller.SURVEY_QUESTION_RECORDTYPE;
                for(Integer i = 0;i<10;i++){
                    testQsnRecord.add(new Project_Survey__c(RecordTypeId=qusnRecordType,Question_Name__c='Test'+i,Answer_choice__c='Good;Bad'));
                }
            
                insert testQsnRecord;
                Account accTest     = Utility_TestData.getAccountData();
                insert accTest;
                Plant__c plant      = Utility_TestData.getPlant();
                insert plant;
                Unit__c unit        = Utility_TestData.getUnit(plant.id, 0);
                insert unit;
                Opportunity oppTest =  Utility_TestData.getOpportunity(accTest.id, unit.id, 0);
                insert oppTest;
                
                ApexPages.currentPage().getParameters().put('oppSurveyId',oppTest.id);
                ProjectServey_Controller.questionWrapper testwrp    = new ProjectServey_Controller.questionWrapper();
                ProjectServey_Controller tesnCntr                   = new ProjectServey_Controller();
                tesnCntr.questionWrapperList[0].selectedValue       = null;
                tesnCntr.saveSurvey();
                tesnCntr.questionWrapperList[0].selectedValue       = 'Good';
                tesnCntr.saveSurvey();
                
                ApexPages.currentPage().getParameters().put('oppSurveyId','testingwithWrongId');
                ProjectServey_Controller testCntr                   = new ProjectServey_Controller();
                
            Test.stopTest();
        }
    }    

}