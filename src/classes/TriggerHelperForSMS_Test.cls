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
private class TriggerHelperForSMS_Test {
    
    public static testmethod void testPopulateLeadInfo() {
        
        //User Information

        User userInfo = new User();
        userInfo.Username = 'userInfo23shikha@company.com';
        userInfo.Email = 'userInfo23shikha@company.com';
        userInfo.Lastname = 'user1';
        userInfo.Firstname = 'test1';
        userInfo.Alias = 'test1';
        userInfo.CommunityNickname = '123461';
        userInfo.UserRole = [select id, Name from userrole where Name = 'Executive Enquiry Management'];
        SObject prof = [select id, Name from profile where Name = 'System Administrator'];
        userInfo.ProfileId = (ID) prof.get('ID');
        userInfo.MobilePhone = '9800112212';
        userInfo.EmailEncodingKey = 'UTF-8';
        userInfo.LanguageLocaleKey = 'en_US';
        userInfo.LocaleSidKey = 'en_US';
        userInfo.TimeZoneSidKey = 'America/Los_Angeles';
        insert userInfo;
        System.debug('****************userInfo' + userInfo);
        
        //Lead Information
        Lead leadInfo = new Lead();
        leadInfo.LastName = 'Shikha1';
        leadInfo.MobilePhone = '9187664410';
        leadInfo.Company = 'Shikha';
        leadInfo.Mode_of_Enquiry__c = 'Inbound Call';
        leadInfo.Lead_Source__c = 'Agents';
        leadInfo.Email = 's@gmail.com';
        leadInfo.Project__c = 'Brigate';
        leadInfo.Date_of_Enquiry__c = System.today();
        leadInfo.Active_Validation__c = false;
        insert leadInfo;
        System.debug('****************l' + leadInfo);
        
        //Task Information
        Task taskInfo = new Task();
        taskInfo.WhoId = leadInfo.id;
        taskInfo.OwnerId = userInfo.id;
        taskInfo.Contact_Lead_Name__c = leadInfo.LastName;
        taskInfo.Contact_Lead_Email_Id__c = leadInfo.Email;
        taskInfo.Contact_Lead_Mobile_No__c = leadInfo.MobilePhone;
        taskInfo.Lead_Contact_Project__c = leadInfo.Project__c;
        taskInfo.Subject = 'Repeated Enquiry by Phone Call';
        taskInfo.Status = 'Not Started';
        taskInfo.Priority = 'Normal';

        System.debug('****************taskbefore' + taskInfo);
        insert taskInfo;
        System.debug('****************task' + taskInfo);
        }
        
        public static testmethod void testPopulateContactInfo() {
        
        //User Information

        User userInfoForContact = new User();
        userInfoForContact.Username = 'userInfo23shikha@company.com';
        userInfoForContact.Email = 'userInfo23shikha@company.com';
        userInfoForContact.Lastname = 'user1';
        userInfoForContact.Firstname = 'test1';
        userInfoForContact.Alias = 'test1';
        userInfoForContact.CommunityNickname = '123461';
        userInfoForContact.UserRole = [select id, Name from userrole where Name = 'Executive Enquiry Management'];
        SObject prof = [select id, Name from profile where Name = 'System Administrator'];
        userInfoForContact.ProfileId = (ID) prof.get('ID');
        userInfoForContact.MobilePhone = '9800112212';
        userInfoForContact.EmailEncodingKey = 'UTF-8';
        userInfoForContact.LanguageLocaleKey = 'en_US';
        userInfoForContact.LocaleSidKey = 'en_US';
        userInfoForContact.TimeZoneSidKey = 'America/Los_Angeles';
        insert userInfoForContact;
        System.debug('****************userInfoForContact' + userInfoForContact);
        
        
        account a = new account();
        a.name = 'Subas Mallick';
        insert a;

        //Contact Information                
        contact c = new contact();
        c.lastname = 'Mehulkumar NavinchandraPancholi';
        c.Contact_Type__c = 'First Applicant';
        c.email = 'developer@extentor.com';
        c.MobilePhone = '9810051009';
        c.accountid = a.id;
        insert c;
        
        
        //Task Information
        Task taskInfoC = new Task();
        taskInfoC.WhoId = c.id;
        taskInfoC.OwnerId = userInfoForContact.id;
        taskInfoC.Contact_Lead_Name__c = c.LastName;
        taskInfoC.Contact_Lead_Email_Id__c = c.Email;
        taskInfoC.Contact_Lead_Mobile_No__c = c.MobilePhone;
        taskInfoC.Lead_Contact_Project__c = 'Not Updated';
        taskInfoC.Subject = 'Repeated Enquiry by Phone Call';
        taskInfoC.Status = 'Not Started';
        taskInfoC.Priority = 'Normal';

        System.debug('****************taskInfoC' + taskInfoC);
        insert taskInfoC;
        System.debug('****************taskInfoC' + taskInfoC);
        }


    public static testmethod void testSendSMSToUser() {

        //User Information

        User testUser1 = new User();
        testUser1.Username = 'testUser123shikha@company.com';
        testUser1.Email = 'testUser123shikha@company.com';
        testUser1.Lastname = 'user1';
        testUser1.Firstname = 'test1';
        testUser1.Alias = 'test1';
        testUser1.CommunityNickname = '123461';
        testUser1.UserRole = [select id, Name from userrole where Name = 'Executive Enquiry Management'];
        SObject prof = [select id, Name from profile where Name = 'System Administrator'];
        testUser1.ProfileId = (ID) prof.get('ID');
        testUser1.MobilePhone = '9800112212';
        testUser1.EmailEncodingKey = 'UTF-8';
        testUser1.LanguageLocaleKey = 'en_US';
        testUser1.LocaleSidKey = 'en_US';
        testUser1.TimeZoneSidKey = 'America/Los_Angeles';
        insert testUser1;
        System.debug('****************testUser1' + testUser1);


        //Lead Information
        Lead l1 = new Lead();
        l1.LastName = 'Shikha1';
        l1.MobilePhone = '9187664410';
        l1.Company = 'Shikha';
        l1.Mode_of_Enquiry__c = 'Inbound Call';
        l1.Lead_Source__c = 'Agents';
        l1.Email = 's@gmail.com';
        l1.Project__c = 'Brigate';
        l1.Active_Validation__c = false;
        l1.Date_of_Enquiry__c = System.today();
        insert l1;
        System.debug('****************l' + l1);

        //Task Information
        Task task1 = new Task();
        task1.WhoId = l1.id;
        task1.OwnerId = testUser1.id;
        task1.Contact_Lead_Name__c = l1.LastName;
        task1.Contact_Lead_Email_Id__c = l1.Email;
        task1.Contact_Lead_Mobile_No__c = l1.MobilePhone;
        task1.Lead_Contact_Project__c = l1.Project__c;
        task1.Subject = 'Repeated Enquiry by Phone Call';
        task1.Status = 'Not Started';
        task1.Priority = 'Normal';

        System.debug('****************taskbefore' + task1);
        insert task1;
        System.debug('****************task' + task1);
        Test.startTest();
        smagicinteract__Incoming_SMS__c incomingSMS = new smagicinteract__Incoming_SMS__c();
        incomingSMS.smagicinteract__external_field__c = 'test';
        incomingSMS.smagicinteract__Inbound_Number__c = '987654321';
        incomingSMS.smagicinteract__Mobile_Number__c = task1.Contact_Lead_Mobile_No__c;
        incomingSMS.smagicinteract__SMS_Text__c = 'test SMS 2';
        insert incomingSMS;
        List < smagicinteract__Incoming_SMS__c > incomingList = [select Id, smagicinteract__Mobile_Number__c from smagicinteract__Incoming_SMS__c where smagicinteract__Mobile_Number__c = : task1.Contact_Lead_Mobile_No__c];
        //system.assertEquals(incomingList[0].Task__c,task1.Id);

        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
        smsObject.smagicinteract__SenderId__c = 'sms magic';
        smsObject.smagicinteract__PhoneNumber__c = task1.Contact_Lead_Mobile_No__c;
        smsObject.smagicinteract__Name__c = task1.Contact_Lead_Name__c;
        smsObject.smagicinteract__ObjectType__c = 'Task';
        smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest() ? 1 : 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
        smsObject.smagicinteract__SMSText__c = 'sms text';
        system.debug('==============test==========' + smagicinteract.ApexAPI.generateUniqueKey());
        insert smsObject;
        system.debug('==============test==========' + smsObject);
        smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
        tpltext.smagicinteract__Text__c = 'tets';
        tpltext.smagicinteract__Name__c = 'Customer Lead SMS';
        insert tpltext;
         Test.stopTest();
        
    }

    public static testmethod void testSendSMSToUser2() {


        account a = new account();
        a.name = 'Subas Mallick';
        insert a;

        //Contact Information                
        contact c = new contact();
        c.lastname = 'Mehulkumar NavinchandraPancholi';
        c.Contact_Type__c = 'First Applicant';
        c.email = 'developer@extentor.com';
        c.MobilePhone = '9810051009';
        c.accountid = a.id;
        insert c;


        //User Information

        User testUser1 = new User();
        testUser1.Username = 'testUser123shikha@company.com';
        testUser1.Email = 'testUser123shikha@company.com';
        testUser1.Lastname = 'user1';
        testUser1.Firstname = 'test1';
        testUser1.Alias = 'test1';
        testUser1.CommunityNickname = '123461';
        testUser1.UserRole = [select id, Name from userrole where Name = 'Executive Enquiry Management'];
        SObject prof = [select id, Name from profile where Name = 'System Administrator'];
        testUser1.ProfileId = (ID) prof.get('ID');
        testUser1.MobilePhone = '9800112212';
        testUser1.EmailEncodingKey = 'UTF-8';
        testUser1.LanguageLocaleKey = 'en_US';
        testUser1.LocaleSidKey = 'en_US';
        testUser1.TimeZoneSidKey = 'America/Los_Angeles';
        insert testUser1;
        System.debug('****************testUser1' + testUser1);



        //Task Information
        Task task = new Task();
        task.WhoId = c.id;
        task.OwnerId = testUser1.id;
        //task.Owner_Mobile_Number__c = testUser1.MobilePhone;
        //task.Owner_Email__c = 'testUser123shikha@company.com';
        task.Contact_Lead_Name__c = c.lastname;
        task.Contact_Lead_Email_Id__c = c.email;
        task.Contact_Lead_Mobile_No__c = c.MobilePhone;
        task.Lead_Contact_Project__c = 'Not Updated';
        task.Subject = 'Repeated Enquiry by Phone Call';
        task.Status = 'Not Started';
        task.Priority = 'Normal';

        System.debug('****************taskbefore' + task);
        insert task;
        System.debug('****************task' + task);
        Test.startTest();
        smagicinteract__Incoming_SMS__c incomingSMS = new smagicinteract__Incoming_SMS__c();
        incomingSMS.smagicinteract__external_field__c = 'test';
        incomingSMS.smagicinteract__Inbound_Number__c = '987654321';
        incomingSMS.smagicinteract__Mobile_Number__c = task.Owner_Mobile_Number__c;
        incomingSMS.smagicinteract__SMS_Text__c = 'test SMS';
        insert incomingSMS;
        List < smagicinteract__Incoming_SMS__c > incomingList = [select Id, smagicinteract__Mobile_Number__c from smagicinteract__Incoming_SMS__c where smagicinteract__Mobile_Number__c = : task.Owner_Mobile_Number__c];
        //system.assertEquals(incomingList[0].Task__c,task.Id);
        
        smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
        smsObject.smagicinteract__SenderId__c = 'sms magic';
        smsObject.smagicinteract__PhoneNumber__c = task.Owner_Mobile_Number__c;
        smsObject.smagicinteract__Name__c = task.Owner_Name__c;
        smsObject.smagicinteract__ObjectType__c = 'Task';
        smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest() ? 1 : 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
        smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
        smsObject.smagicinteract__SMSText__c = 'sms text';
        system.debug('==============test==========' + smagicinteract.ApexAPI.generateUniqueKey());
        insert smsObject;
        system.debug('==============test==========' + smsObject);
        smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
        tpltext.smagicinteract__Text__c = 'tets';
        tpltext.smagicinteract__Name__c = 'User Lead SMS';
        insert tpltext;
         Test.stopTest();
        
    }
    public static testmethod void testSendSMSToUser3() {


        //User Information

        User testUser1 = new User();
        testUser1.Username = 'testUser123shikha@company.com';
        testUser1.Email = 'testUser123shikha@company.com';
        testUser1.Lastname = 'user1';
        testUser1.Firstname = 'test1';
        testUser1.Alias = 'test1';
        testUser1.CommunityNickname = '123461';
        testUser1.UserRole = [select id, Name from userrole where Name = 'Executive Enquiry Management'];
        SObject prof = [select id, Name from profile where Name = 'System Administrator'];
        testUser1.ProfileId = (ID) prof.get('ID');
        testUser1.MobilePhone = '9800112212';
        testUser1.EmailEncodingKey = 'UTF-8';
        testUser1.LanguageLocaleKey = 'en_US';
        testUser1.LocaleSidKey = 'en_US';
        testUser1.TimeZoneSidKey = 'America/Los_Angeles';
        insert testUser1;
        System.debug('****************testUser1' + testUser1);

        //Lead Information
        Lead l1 = new Lead();
        l1.LastName = 'Shikha1';
        l1.MobilePhone = '9187664410';
        l1.Company = 'Shikha';
        l1.Mode_of_Enquiry__c = 'Inbound Call';
        l1.Lead_Source__c = 'Agents';
        l1.Email = 's@gmail.com';
        l1.Project__c = 'Brigate';
        l1.Date_of_Enquiry__c = System.today();
        l1.Active_Validation__c = false;
        insert l1;
        System.debug('****************l' + l1);


        //Task Information
        Task task = new Task();
        task.WhoId = l1.id;
        task.OwnerId = testUser1.id;
        //task.Owner_Mobile_Number__c = testUser1.MobilePhone;
        //task.Owner_Email__c = 'testUser123shikha@company.com';
        task.Contact_Lead_Name__c = l1.lastname;
        task.Contact_Lead_Email_Id__c = l1.email;
        task.Contact_Lead_Mobile_No__c = l1.MobilePhone;
        task.Lead_Contact_Project__c = 'Not Updated';
        task.Subject = 'Repeated Enquiry by Phone Call';
        task.Status = 'Not Started';
        task.Priority = 'Normal';

        System.debug('****************taskbefore' + task);
        insert task;
        System.debug('****************task' + task);
        Test.startTest();
        
        smagicinteract__Incoming_SMS__c incomingSMS = new smagicinteract__Incoming_SMS__c();
        incomingSMS.smagicinteract__external_field__c = 'test';
        incomingSMS.smagicinteract__Inbound_Number__c = '987654321';
        incomingSMS.smagicinteract__Mobile_Number__c = task.Owner_Mobile_Number__c;
        incomingSMS.smagicinteract__SMS_Text__c = 'test SMS';
        insert incomingSMS;
        List < smagicinteract__Incoming_SMS__c > incomingList = [select Id, smagicinteract__Mobile_Number__c from smagicinteract__Incoming_SMS__c where smagicinteract__Mobile_Number__c = : task.Owner_Mobile_Number__c];
        //system.assertEquals(incomingList[0].Task__c,task.Id);
         Test.stopTest();
        
    }
    public static testmethod void testSendSMSToUser4() {
        User adminuser = BRIGADE_InitializeTestData.createUserwithRole('abcq','mm','TestRM','kishlay.mathur@extentor4.com','sales4@brigade.com','234','System Administrator','Admin');
        
        insert adminuser;
        User Managementuser = BRIGADE_InitializeTestData.createUserwithRole('21','435','TestRM','kishlay.mathur@extentor5.com','sales5@brigade.com','768','System Administrator','ExecutiveEnquiryManagement');
        insert Managementuser;
        TriggerHelperForSMS ins = new TriggerHelperForSMS();
        list<Task> listOfTask = new List<Task>();
        system.runas(Managementuser){
            Task newTask = new Task(Description = 'Survey Transaction',
                                        Priority = 'Normal', 
                                        Status = 'Inbound Email', 
                                        Subject = 'Other', 
                                        OwnerID = adminuser.id,
                                        ReminderDateTime = System.now()+1 
                                        );             
            insert newTask;
            listOfTask.add(newTask);
            smagicinteract__SMS_Template__c sdmtemp = new smagicinteract__SMS_Template__c(smagicinteract__Name__c = 'Customer Lead SMS',smagicinteract__ObjectName__c ='Payment_Schedule__c',smagicinteract__Text__c = 'Dear {!Contact.name}');
            insert sdmtemp ;
        }
        ins.sendSmsToLead_Contact(listOfTask);
        
    }
    public static testmethod void testSendSMSToUser5() {
        User adminuser = BRIGADE_InitializeTestData.createUserwithRole('abcq','mm','TestRM','kishlay.mathur@extentor4.com','sales4@brigade.com','234','System Administrator','Admin');
        
        insert adminuser;
        User Managementuser = BRIGADE_InitializeTestData.createUserwithRole('21','435','TestRM','kishlay.mathur@extentor5.com','sales5@brigade.com','768','System Administrator','ExecutiveEnquiryManagement');
        insert Managementuser;
        TriggerHelperForSMS ins = new TriggerHelperForSMS();
        list<Task> listOfTask = new List<Task>();
        system.runas(Managementuser){
            Task newTask = new Task(Description = 'Survey Transaction',
                                        Priority = 'Normal', 
                                        Status = 'Inbound Email', 
                                        Subject = 'Other', 
                                        OwnerID = adminuser.id,
                                        ReminderDateTime = System.now()+1 
                                        );             
            insert newTask;
            listOfTask.add(newTask);
            smagicinteract__SMS_Template__c sdmtemp = new smagicinteract__SMS_Template__c(smagicinteract__Name__c = 'User Lead SMS',smagicinteract__ObjectName__c ='Task',smagicinteract__Text__c ='You have a Task assigned Customer name: {!Task.contact_lead_name__c}' );
            insert sdmtemp ;
        }
        ins.sendSmsToUser(listOfTask);
        
    }
    
}