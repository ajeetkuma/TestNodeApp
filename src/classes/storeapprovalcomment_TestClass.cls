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
@isTest(seeAllData=true) 
public class storeapprovalcomment_TestClass {

    static testMethod void approvePHUnitTest() {
    try{
        id projectHeadId = UserInfo.getUserId();
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        Sale_Order_Item__c soi= new Sale_Order_Item__c(name='test',Opportunity__c = opp.id);
        insert soi;
        system.debug(soi+'soi');
        Payment_Schedule__c ps = new Payment_Schedule__c(name='test',Sale_Order_Item__c = soi.id,Bill_Value__c=1234,Status_As_Text__c = 'Received',Payment_Status__c ='C');
        insert ps;
        system.debug(ps+'ps');
        Sale_Order_Item__c soirecord = [SELECT id,Bill_Value__c FROM Sale_Order_Item__c  WHERE ID =:soi.id];
        system.debug(soirecord +'soirecord');
        opportunity oppRecord = [SELECT id,Bill_Value__c,Lead_Source__c FROM opportunity WHERE id=: opp.id];
        system.debug(oppRecord+'oppRecord');
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Commission__c testcom = new Commission__c(Status__c ='Submitted',Opportunity__c = opp.id,Commission_percentage__c =1);
        insert testcom;
        Commission__c comrecord = [SELECT id,Status__c,Opportunity__r.Lead_Source__c,Opportunity__r.Bill_Value__c,Commission_percentage__c  FROM Commission__c  WHERE id=: testcom.id ];
        system.debug(comrecord+'comrecord');
        // Create an approval request for the commission
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(comrecord.id);
        req1.setNextApproverIds(new Id[] {projectHeadId});
        Approval.ProcessResult result1 = Approval.process(req1);
        List<Id> newWorkItemIds = result1.getNewWorkitemIds();
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req3 = new Approval.ProcessWorkitemRequest();
        req3.setComments('Approving request.');
        req3.setAction('Approve');
        req3.setNextApproverIds(new Id[] {projectHeadId});
            
        // Use the ID from the newly created item to specify the item to be worked
        req3.setWorkitemId(newWorkItemIds.get(0));
        Approval.ProcessResult result2 =  Approval.process(req3);
        //comrecord.Status__c = 'Approved By Project Head';
        //update comrecord;
        }catch(Exception e){}
       
    }
    
     static testMethod void approveHODUnitTest() {
     try{
        id projectHeadId = UserInfo.getUserId();
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        Sale_Order_Item__c soi= new Sale_Order_Item__c(name='test',Opportunity__c = opp.id);
        insert soi;
        system.debug(soi+'soi');
        Payment_Schedule__c ps = new Payment_Schedule__c(name='test',Sale_Order_Item__c = soi.id,Bill_Value__c=1234,Status_As_Text__c = 'Received',Payment_Status__c ='C');
        insert ps;
        system.debug(ps+'ps');
        Sale_Order_Item__c soirecord = [SELECT id,Bill_Value__c FROM Sale_Order_Item__c  WHERE ID =:soi.id];
        system.debug(soirecord +'soirecord');
        opportunity oppRecord = [SELECT id,Bill_Value__c,Lead_Source__c FROM opportunity WHERE id=: opp.id];
        system.debug(oppRecord+'oppRecord');
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Commission__c testcom = new Commission__c(Status__c ='Submitted',Opportunity__c = opp.id,Commission_percentage__c =1);
        insert testcom;
        Commission__c comrecord = [SELECT id,Status__c,Opportunity__r.Lead_Source__c,Opportunity__r.Bill_Value__c,Commission_percentage__c  FROM Commission__c  WHERE id=: testcom.id ];
        system.debug(comrecord+'comrecord');
        // Create an approval request for the commission
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(comrecord.id);
        req1.setNextApproverIds(new Id[] {projectHeadId});
        Approval.ProcessResult result1 = Approval.process(req1);
        List<Id> newWorkItemIds = result1.getNewWorkitemIds();
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req3 = new Approval.ProcessWorkitemRequest();
        req3.setComments('Approving request.');
        req3.setAction('Approve');
        req3.setNextApproverIds(new Id[] {projectHeadId});
            
        // Use the ID from the newly created item to specify the item to be worked
        req3.setWorkitemId(newWorkItemIds.get(0));
        Approval.ProcessResult result2 =  Approval.process(req3);
        //comrecord.Status__c = 'Approved By Project Head';
        //update comrecord;
        
        
        List<Id> newWorkItemIds1 = result2.getNewWorkitemIds();
            
         // Instantiate the new ProcessWorkitemRequest object and populate it
         Approval.ProcessWorkitemRequest req4 = new Approval.ProcessWorkitemRequest();
         req4.setComments('Approving request.');
         req4.setAction('Approve');
         //req4.setNextApproverIds(new Id[] {reportingmanageruser.Id});
    
         // Use the ID from the newly created item to specify the item to be worked
         req4.setWorkitemId(newWorkItemIds1.get(0));
    
         // Submit the request for approval
         Approval.ProcessResult result3 =  Approval.process(req4);
         }catch(Exception e){}
    }
    public static testMethod void oTPGenerateUnitTest() {
         Account acc = new Account(Name='testAccount');
         insert acc;
        
         Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
         insert con;
         ToGenerateRandomOTP.generateRandomOTP(con.id);
     }
     public static testMethod void oTPValidateSuccessUnitTest() {
         Account acc = new Account(Name='testAccount');
         insert acc;
         Opportunity opp = new Opportunity(Lead_Source__c='showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
         insert opp;
         Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',OTP__c='4567');
         insert con;
         ToGenerateRandomOTP.validateOTP(opp.id,con.id,con.OTP__c);
     }
     public static testMethod void oTPValidateFailUnitTest() {
         Account acc = new Account(Name='testAccount');
         insert acc;
         Opportunity opp = new Opportunity(Lead_Source__c='showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
         insert opp;
         Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',OTP__c='4567');
         insert con;
         ToGenerateRandomOTP.validateOTP(opp.id,con.id,'2343');
     }
     public static testMethod void oTPValidateFailUnitTest1() {
         Account acc = new Account(Name='testAccount');
         insert acc;
         Opportunity opp = new Opportunity(Lead_Source__c='showcase',AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
         insert opp;
         Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
         insert con;
         ToGenerateRandomOTP.validateOTP(opp.id,con.id,con.OTP__c);
     }
     public static testMethod void rejectedUnitTest() {
         try{
        id projectHeadId = UserInfo.getUserId();
        Account acc = new Account(Name='testAccount');
        insert acc;
        Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
        insert chpartner ;
        Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
        insert con;
        Opportunity opp = new Opportunity(Lead_Source__c='Agents',Channel_Partner__c = chpartner.id,AccountID=acc.id,Name='testopp',StageName='Site Visit',CloseDate = system.today()+4);
        insert opp;
        Sale_Order_Item__c soi= new Sale_Order_Item__c(name='test',Opportunity__c = opp.id);
        insert soi;
        system.debug(soi+'soi');
        Payment_Schedule__c ps = new Payment_Schedule__c(name='test',Sale_Order_Item__c = soi.id,Bill_Value__c=1234,Status_As_Text__c = 'Received',Payment_Status__c ='C');
        insert ps;
        system.debug(ps+'ps');
        Sale_Order_Item__c soirecord = [SELECT id,Bill_Value__c FROM Sale_Order_Item__c  WHERE ID =:soi.id];
        system.debug(soirecord +'soirecord');
        opportunity oppRecord = [SELECT id,Bill_Value__c,Lead_Source__c FROM opportunity WHERE id=: opp.id];
        system.debug(oppRecord+'oppRecord');
        OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=opp.id,IsPrimary = true);
        insert oppconRole;
        Commission__c testcom = new Commission__c(Status__c ='Submitted',Opportunity__c = opp.id,Commission_percentage__c =1);
        insert testcom;
        Commission__c comrecord = [SELECT id,Status__c,Opportunity__r.Lead_Source__c,Opportunity__r.Bill_Value__c,Commission_percentage__c  FROM Commission__c  WHERE id=: testcom.id ];
        system.debug(comrecord+'comrecord');
        // Create an approval request for the commission
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(comrecord.id);
        req1.setNextApproverIds(new Id[] {projectHeadId});
        Approval.ProcessResult result1 = Approval.process(req1);
        List<Id> newWorkItemIds = result1.getNewWorkitemIds();
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req3 = new Approval.ProcessWorkitemRequest();
        req3.setComments('Approving request.');
        req3.setAction('Reject');
        req3.setNextApproverIds(new Id[] {projectHeadId});
            
        // Use the ID from the newly created item to specify the item to be worked
        req3.setWorkitemId(newWorkItemIds.get(0));
        Approval.ProcessResult result2 =  Approval.process(req3);
        //comrecord.Status__c = 'Approved By Project Head';
        //update comrecord; 
        }catch(Exception e){}
     }
     public static testMethod void deleteLeadMarkedFordeletionUnitTest() {
        User uweb = [SELECT id From User WHERE Username='web2lead@brigadegroup.com'];
        system.runas(uweb){
        Lead ld = BRIGADE_InitializeTestData.createLeadmarkedDelete('fname','lname','test@gmail.com','Internet','Showcase','Open','8088883014','ABCD','');
        //ld.Mark_For_Deletion__c = true;
        checkRecursive.run = false;
        insert ld;
        }
        Test.startTest();
        Schedule_LeadMarkedForDeletionBatchClass temp = new Schedule_LeadMarkedForDeletionBatchClass();
        String sch = '0 45 23 * * ?'; 
        system.schedule('Stock Delete', sch, temp);
        DeleteLeadMarkedForDeletionBatchClass b = new DeleteLeadMarkedForDeletionBatchClass();
        Database.executeBatch(b);
        Test.stopTest();
     }
}