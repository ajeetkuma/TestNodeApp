/*----------------------------------------------------------
Name : Test_Batch_SendDuePayment_SMS

Desc : This test class written to cover the Batch_SendDuePayment_SMS

Created By : Sukesh G

Created Date : 30-dec-2015

------------------------------------------------------------*/
@isTest(seealldata=false)
private class Test_Batch_SendDuePayment_SMS {
         public static testMethod void testMethod1() {
       
             
          try{
                 Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
                 User dummyUser = Utility_TestData.getTestUser();
                 insert dummyUser;
                 
                 Master_Payment__c mpObj         = new Master_Payment__c();
                 mpObj.Contact_mobile__c    ='9902189392';
                 mpObj.Contact_Name__c      ='Sukesh';
                 mpObj.Unit__c              ='BX-XX-X2-BX-XX-YY';
                 //mpObj.Due_Amount__c            =1000.90;
                 mpObj.Billing_Date__c      =system.today().addDays(-10);
                 mpObj.Don_t_Disturb__c     =false;
                 mpObj.Don_t_Disturb_Plant__c=false; 
                 mpObj.Payment_Received_SMS__c = true;
                 mpObj.Sum_Of_Money__c         = '20000000';
                 mpObj.Total_Amount__c         =100000.100;
                 mpObj.Stage__c                ='Allotment';
                 insert mpObj;
                 
                 Master_Payment__c[] mp =[Select id,Unit__c,Contact_mobile__c,Contact_Name__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <=:system.today().addDays(-1) AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null ];
                 system.debug('master payment===='+mp);
                 
                 smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
                 tpltext.smagicinteract__Text__c        = 'tets';
                 tpltext.smagicinteract__Name__c        = 'Payment Due New1445425533453624';
                 insert tpltext;
                                
                 Test.startTest(); 
              
                 Batch_SendDuePayment_SMS sh1 = new Batch_SendDuePayment_SMS();
                 database.executeBatch(sh1);
                 //String sch = '0 0 23 * * ?';
                 //system.schedule('Testing', sch, sh1);
                
                 Test.stopTest();
       
             }catch(Exception e){
             system.debug('exception in test class'+e.getMessage());
         }
    
		}   
  
	   public static testMethod void testSMSMagicObj(){
			Test.startTest();
			smagicinteract__smsMagic__c  varSMS = Utility_Class.getSMSMagicObj('Sukesh','9164698599','Master_Payment__c','123456789','Hello',1);
			Boolean tBoolean = Utility_Class.ISBlankOrEmpty('TestMethod');
			Boolean checkFalse = Utility_Class.ISBlankOrEmpty('');
			Test.stopTest();
			
		}
		
		
      /*  try{
            User dummyUser  = Utility_TestData.getTestUser();
            insert dummyUser;
             system.runAs(dummyUser){
            
           Test.setMock(WebServiceMock.class, new MockHttpResponse());
            Master_Payment__c mpObj         = new Master_Payment__c();
                mpObj.Contact_mobile__c     ='9902189392';
                mpObj.Contact_Name__c       ='Sukesh';
                mpObj.Unit__c               ='BX-XX-X2-BX-XX-YY';
                mpObj.Due_Amount__c         =1000.90;
                mpObj.Billing_Date__c       =system.today().addDays(-1);
                mpObj.Don_t_Disturb__c      =false;
                mpObj.Don_t_Disturb_Plant__c=false; 
                //mpObj.Invoice_Date__c         = System.today();
                //mpObj.Invoice_No__c           = 'INV-01';
                mpObj.Payment_Received_SMS__c = true;
                //mpObj.Received_Date__c        = System.today();
                mpObj.Sum_Of_Money__c         = '20000000';
                insert mpObj;
                Date dateYesterday = System.Today();
                smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
                tpltext.smagicinteract__Text__c         = 'tets';
                //tpltext.smagicinteract__Name__c       = 'Payment Due New';
                insert tpltext;
            
                //PAYMENT_DUE_TEMPLATE paymentdeueObj = Utility_Class.PAYMENT_DUE_TEMPLATE;
               // insert paymentdeueObj;
               // MASTER_PAYMENT_OBJECT masterPayment = Utility_Class.MASTER_PAYMENT_OBJECT;
               // insert masterPayment;
               // CONTACT_NAME_API contactNameApi     = Utility_Class.CONTACT_NAME_API;
               // insert contactNameApi;
               // Master_Payment__c mPayment = Utility_TestData.getMasterPaymentInfo();
               // insert mPayment ;
                //List<Master_Payment__c> obj  = [ Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <=:dateYesterday AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null];
                Test.startTest();
                
                String ob =  'Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <=:dateYesterday AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null';
                Batch_SendDuePayment_SMS  sb  = new Batch_SendDuePayment_SMS (   );
                Database.executeBatch(sb);
                //ID batchprocessid = Database.executeBatch(sb,ob,100);
                test.stoptest();
            
            
               // Database.executeBatch(sb,1);
                //Del_leads dl = new Del_Leads();
                //dl.query='select id,Name,Company,Phone,Email from lead where createddate<=:z and date_opened__c=null ';
                ////ID batchprocessid = Database.executeBatch(dl);
              ///  Test.stopTest();
             }
            
         }
         catch(Exception e){}*/

}