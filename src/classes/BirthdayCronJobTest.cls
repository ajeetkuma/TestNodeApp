@isTest(SeeAllData =true)
class BirthdayCronJobTest {

    static testmethod void test() {
        //Test.startTest();
      String debugAddress = 'eyewell@salesforce.com';
      String BirthdayEmailTemplateName = 'Happy Birthday';
      String AnniversaryEmailTemplateName = 'Celebrating your Anniversary';      
        
        Integer testMonth = date.today().month();
        Integer testDay = date.today().day();
        BirthdayCronJob BCJ = new BirthdayCronJob(); 
        
        //run the test once, without ensuring that a contact with today's birthday exists;
        //BCJ.sendMail(); 
         Account testacc = new Account();
         testacc.Name='Brigade';
         insert testacc;
                 //EmailTemplate anniversaryTemplate = [select Id,Name,Subject,body from EmailTemplate limit 1];
        EmailTemplate anniversaryTemplate = new EmailTemplate();
        anniversaryTemplate.Name = 'Celebrating your Anniversary';
        anniversaryTemplate.Subject = 'Email';
        anniversaryTemplate.Body = 'Wellcome to Brigade group';
       // insert anniversaryTemplate;
       // System.assert(anniversaryTemplate.id<>null);
        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'Contact';
        testContact.Email = 'eyewell@salesforce.com';
        testContact.Birthdate           = date.today();
        testContact.Anniversary_Date__c = date.today();
        testContact.Send_Birthday_Email__c    = true;
        testContact.Send_Anniversary_Email__c = true;
        testContact.Contact_Type__c = 'First Applicant';
        testContact.AccountId = testacc.Id;
        insert testContact;
        

        //run the test again, now that a contact with today's birthday exists
        system.debug('##############BCJ'+BCJ);
        BCJ.sendMail();
        
        // Schedule the test job  
    
        String CRON_EXP = '0 0 0 3 9 ? 2022';
        String jobId = System.schedule('testBasicScheduledApex', CRON_EXP, new BirthdayCronJob());
        
        // Get the information from the CronTrigger API object  
    
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime
                            FROM CronTrigger 
                            WHERE id = :jobId];
        
        // Verify the expressions are the same  
        System.assertEquals(CRON_EXP, ct.CronExpression);
    
        // Verify the job has not run  
        System.assertEquals(0, ct.TimesTriggered);
        
        // Verify the next time the job will run  
    
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
        //System.assertNotEquals('testScheduledApexFromTestMethodUpdated',
        //  [SELECT id, name FROM account WHERE id = :a.id].name);

        //Test.stopTest();
        
        //System.assertEquals('testScheduledApexFromTestMethodUpdated',
        //  [SELECT id, name FROM account WHERE id = :a.id].name);
        
        //Clean up
        delete testContact;
        
    }
}