@isTest
private class AppForm_Test {
      
      
      @isTest static void test_method_one() {
            // Implement test code
             test.StartTest();
                  //-----------Test for Pageref-----------------------------------

                  PageReference pageRef = Page.ApplicationForm;

                  Account acc = new Account(Name='Abce');
                  insert acc;

                  Opportunity  testOppty = new Opportunity();
                  testOppty.name='testOppty';
                  testOppty.Date__c=System.today();
                  testOppty.CH_Date__c=System.today();
                  testOppty.AccountId=acc.id;
                  //-------Satge Name & closed Date is required
                  testOppty.StageName='Open';
                  testOppty.CloseDate=System.today();
                  insert testOppty;

                  Contact con       = new Contact(LastName='Last');
                  insert con;
                  Channel_Partner__c cp = new Channel_Partner__c(Name='cp');
                  insert cp;
                  Project__c p = new Project__c(Name='someProject');
                  insert p;

                  Plant__c plant         = new Plant__c(Name='SomePlant',Project__c='someProject',ProjectLookup__c=p.Id);
                  insert plant;
                  Unit__c unit           =new Unit__c(Name='someUnit',Plant__c=plant.Id);
                  insert unit;
                  
                  Target__c t = new Target__c();
                  t.Start_Date__c=System.today();
                  t.End_Date__c=System.today();
                  t.Project_Lookup__c=p.Id;
                  t.Project__c=p.Name;
                  insert t;


                  Test.setCurrentPage(pageRef);
                  pageRef.getParameters().put('id',testOppty.id);



                  ApexPages.StandardController sc = new ApexPages.standardController(testOppty);
                  AppFormController  controller = new AppFormController(sc);
                  //System.assertNotEquals(null,controller.autoRun());
                  storeapprovalcomment_TestClass.oTPGenerateUnitTest();
                  storeapprovalcomment_TestClass.oTPValidateSuccessUnitTest();
                  storeapprovalcomment_TestClass.oTPValidateFailUnitTest();
                  storeapprovalcomment_TestClass.oTPValidateFailUnitTest1();
                  ApplicationFormController afc = new ApplicationFormController();
                  AppFormController a = new  AppFormController();
                  AppFormController.otpGenration(con.Id);
                  
                  AppFormController.Intialize();
                  AppFormController.ChangeProjectDetails(testOppty.Id,'someProject','SomePlant','someUnit');
                  AppFormController.fetchIndustryType();
                  AppFormController.fetchCarParkingType();
                  AppFormController.fetchSalutation();
                  AppFormController.fetchResidencyStatus();
                  AppFormController.fetchRelationTypes();
                  AppFormController.fetchPaymentTypes();
                  AppFormController.fetchFinanceTypes();
                  AppFormController.fetchBuyingPurpose();
                  AppFormController.fetchLeadSource();
                  AppFormController.fetchRefferedBy();
                  AppFormController.fetchChannelPartner();

                  AppFormController.calculateDate('2016-08-24T08:59:51.761Z');
                  
                  

            test.StopTest();
      }
      
      @isTest static void test_method_two() {
             Account acc = new Account(Name='Abce');
                  insert acc;
                  Profile pr = [SELECT Id, Name FROM Profile WHERE Name = 'Custom Sales User']; 
        
                  User userSalesData = new User(Alias = 'abcd', 
                                 
                                  Email= 'sales1@brigade.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'test',
                                  LastName = 'last', 
                                  EmployeeNumber = 'abcd',                                   
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  TimeZoneSidKey = 'Asia/Kolkata',
                                  ProfileId = pr.Id, 
                                  ContactId = null,
                                  UserName= 'sales1@brigade.com'
                                  );
                  
                  insert userSalesData;
                  Channel_Partner__c chpartner = new Channel_Partner__c(Name='chp');
                  insert chpartner ;
                  Project__c p = new Project__c(Name='someProject');
                  insert p;

                  Plant__c plant         = new Plant__c(Basic_Rate_PSFT__c =5000,Name='SomePlant',Project__c='someProject',ProjectLookup__c=p.Id,Project_Head__c=userSalesData.Id);
                  insert plant;
                  Unit__c unit           =new Unit__c(Name='someUnit',Plant__c=plant.Id);
                  insert unit;
                  Opportunity  testOppty = new Opportunity();
                  testOppty.name='testOppty';
                  testOppty.Date__c=System.today();
                  testOppty.CH_Date__c=System.today();
                  testOppty.AccountId=acc.id;
                  testOppty.PT_Unit_Price_Agreed__c=1000;
                  testOppty.Unit__c=unit.Id;
                  //-------Satge Name & closed Date is required
                  testOppty.StageName='Open';
                  testOppty.CloseDate=System.today();
                  testOppty.Channel_Partner__c=chpartner.Id;
                  testOppty.Plant2__c=plant.Id;
                  insert testOppty ; 
      // Implement test code
                  List<Contact> conList = new List<Contact>();
                  Contact congpa = new Contact(LastName='testContactgpa',AccountId=acc.id,Email='test@j.com');
                  congpa.Contact_Type__c='GPA Holder';
                  Contact con = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com');
                  insert con;

                  Contact con2 = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',Contact_Type__c='Second Applicant');
                  insert con2;
                  Contact con3 = new Contact(LastName='testContact',AccountId=acc.id,Email='test@j.com',Contact_Type__c='Third Applicant');
                  insert con3;

                  conList.add(con);
                  conList.add(con2);
                  conList.add(con3);
                  OpportunityContactRole oppconRole = new OpportunityContactRole(ContactId=con.id,OpportunityId=testOppty.id,IsPrimary = true);
                  insert oppconRole;
                  Application_Form__c appform = new Application_Form__c(Requested_Lead_source__c='Agents',Channel_Partner__c=chpartner.id,Opportunity__c = testOppty.id,Lead_Source_Approval_Status__c = 'Submitted');
                  appform.Channel_Partner__c=chpartner.Id;
                  Application_Form__c appform1 = new Application_Form__c(Requested_Lead_source__c='Agents',Channel_Partner__c=chpartner.id,Opportunity__c = testOppty.id,Lead_Source_Approval_Status__c = 'Submitted');
                  appform.Channel_Partner__c=chpartner.Id;
                  /*insert appform;*/
                  
                  
                  List<String> dateFields=new List<String>();
                  List<String> dateFields1=new List<String>();
                  String date1='2016-08-24T08:59:51.761Z';
                  String date2='2016-08-24T08:59:51.761Z';
                  dateFields.add(date1);
                  dateFields1.add(date1);
                  dateFields.add(date2);
                  dateFields1.add(date2);
                  PageReference pdfPage = Page.ApplicationFormPdff;
                  Test.setCurrentPage(pdfPage);

                  pdfPage.getParameters().put('id',testOppty.id);

                  
                 // pdfPage.getParameters().put('id',testOppty.id);
                 // Blob pdfBlob = Blob.valueOf('Test Data'); 

                  Blob pdfBlob;
                     
                  pdfBlob=Blob.valueOf('UNIT.TEST');
                     
                      
                  Attachment attach = new Attachment(ParentId = testOppty.id, Name = 'ApplicationForm', body = pdfBlob); //create the attachment object
        
                  insert attach; 
                  String oppId=String.valueof(testOppty.Id);
                  AppFormController.save(oppId,'ajeet.kumar6171@gmail.com');
                  AppFormController.attachPDF(testOppty.Id,'ajeet.kumar6171@gmail.com'); 
                  AppFormController.otpVerification(testOppty.Id,con.Id,'1234');
                  AppFormController.saveContacts(testOppty.id,acc,conList,testOppty,appform,unit,'Agents','Referral',plant,'chp',true,dateFields,dateFields1,congpa);
                  testOppty.PT_Unit_Price_Agreed__c=5000;
                  update testOppty;
                  AppFormController.saveContacts(testOppty.id,acc,conList,testOppty,appform1,unit,'Agents','Agents',plant,'chp',true,dateFields,dateFields1,congpa);

      } 
      
}