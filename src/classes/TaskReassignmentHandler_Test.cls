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
@isTest(seeAllData=false)
private class TaskReassignmentHandler_Test {
   public static testmethod void Batchtest(){
       
        
        
           Profile p=[Select Id from Profile where Name='Standard User'];
           UserRole ur = new UserRole(Name='sales');
           insert ur;
           string rndm = string.valueOf(system.Math.random()); 
           User usr=new User(Alias='standt',Email='invoketaskreassign@testorg.com',EmailEncodingKey='UTF-8', LastName='invoketaskreassign',LanguageLocaleKey='en_US',LocaleSidKey='en_US', ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',UserRoleId=ur.id,UserName='invoketaskreassign@testorg.com'+rndm);
           insert usr; 
           System.runAs(usr){
               
        task tsk=new task();
        tsk.status='In Progress';
        tsk.Activity_Date__c=System.now();
        tsk.Escalated__c = true;
        tsk.OwnerId = usr.id;
        insert tsk;
        String sch = '0 0 23 * * ?';
        String sch1 = '0 5 * * * ?';
         invokeTaskReassignBatch itr=new invokeTaskReassignBatch(String.valueOf(System.now()));
         Database.executeBatch(itr);
         invokeTaskReassignNotificationBatch itrb=new invokeTaskReassignNotificationBatch(String.valueOf(System.now()));
         Database.executeBatch(itrb);
         invokeTaskReassignment3 itr3= new invokeTaskReassignment3();
         system.schedule('Test Territory Check', sch, itr3);
         invokeTaskReassignment2 itr2=new invokeTaskReassignment2();
          system.schedule('Test Territory Check1', sch, itr2); 
         invokeTaskReassignment1 itr1=new invokeTaskReassignment1();
          system.schedule('Test Territory Check2', sch, itr1);
         invokeTaskReassignmentNotification2 itrn2=new invokeTaskReassignmentNotification2();
          system.schedule('Test Territory Check3', sch, itrn2); 
         invokeTaskReassignmentNotification3 itrn3=new invokeTaskReassignmentNotification3();
           system.schedule('Test Territory Check4', sch, itrn3);  
         invokeTaskReassignmentNotification1 itrn1=new invokeTaskReassignmentNotification1();
          system.schedule('Test Territory Check5', sch, itrn1);  
    }
   }
}