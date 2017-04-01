/*----------------------------------------------------------
Name : Test_Batch_SendDuePayment_SMS_opportunity

Desc : This test class written to cover the Batch_SendDuePayment_SMS_Opportunity

Created By : Sukesh G

Created Date : 30-dec-2015

------------------------------------------------------------*/
@isTest(seealldata=true)
private class Test_Batch_SendDuePaymentOpportunity{
     public static testMethod void testMethod1() {
     
           
        try{
             Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
             User dummyUser  = Utility_TestData.getTestUser();
             insert dummyUser;
            
                Country__c country = new Country__c();
        country.Name = 'India';
        insert country;
        
        
        Account acc=new Account();
        acc.Name='Shikha Devi';
        acc.Customer_Group__c ='Z3- Proprietary';
        acc.Distribution_channel__c ='10- Residential Sale';
        acc.Street1__c= 'ABC Street';
        acc.CountryL__c = country.Id;
        acc.Postal_Code__c = '176209';
        acc.Rating = 'Hot';
        //acc.FirstApplicant__c =TRUE;
        insert acc;
         
        Contact cont= new Contact();
        cont.accountid=acc.id;
        cont.firstname='Shikha';
        cont.lastname='Devi';
        cont.Salutation='Miss';
        cont.Contact_Type__c='First Applicant';
        cont.email='developer@extentor.com';
        cont.Email='developer@gmail.com';
        cont.MobilePhone='8884937365';     
        cont.Email2__c='developrr@gmail.com';
        cont.Phone='9988776655';
        cont.Mobilephone='9876543210';
        cont.Birthdate = null ;    
        cont.Company__c = null;
        cont.Designation__c = null;
        cont.Profession__c = null;
        cont.Income_Tax_PAN_GIR_No__c = null;
        cont.Industry__c = null;
        cont.Educational_Qualification__c = null;
        insert cont;
        System.debug('**********'+cont);
         Plant__c plant1 = new Plant__c();
         plant1.Name = 'KNPR - ALTAMONT';
         plant1.Admin_Email__c = 'developer@extentor.com';
         plant1.Project__c = 'Brigade Altamont';
         insert plant1;
         
         Unit__c unit1 = new Unit__c();
         unit1.Plant__c = plant1.Id;
         unit1.Name = 'BG-ALT-A-X-0109-XX';
         insert unit1;
         
        Opportunity opp = new Opportunity();
        opp.accountid = acc.id;
        opp.Name = 'Shikha Opportunity';
        opp.CloseDate = Date.today();
        opp.StageName = 'Reserving';
        opp.Type = 'Retail';
        opp.LeadSource = 'Agent';
        opp.Sales_office__c = '1120 - Dubai Sales Office';
        opp.Customer_pricing_procedure__c ='1- Flats Under Constr';
        opp.Cash_Management_Group__c ='A3- Employee Vendor';
        opp.Recon_Account__c ='0023000010- Debtors - Domestic';
        opp.Plant__c = 'KNPR - ALTAMONT';
        opp.Plant2__c = plant1.id;
        opp.Unit__c = unit1.Id;
        opp.ZTX1__c ='0- No VAT';
        opp.ZTX2__c ='0- No ST';
        opp.ZTX3__c = '0- No ECS';
        opp.ZTX4__c ='0- No HES';
        opp.Partner_Functions__c='ZC- Customer Relations';
        Try{
        insert opp;
        }Catch(Exception e){}
        
         system.debug('*******'+opp);
         
         OpportunityContactRole contOpp = new OpportunityContactRole();
         contOpp.ContactId = cont.Id;
         contOpp.OpportunityId = opp.Id;
         contOpp.IsPrimary = True;
         contOpp.Role = 'First Applicant';
         try{         
         Insert contOpp ;
         }Catch(Exception e){}
         
         Account acc2 = New Account();
         acc2.Id = acc.Id;
         acc2.FirstApplicant__c =True;
         try{
         update acc2;
         }Catch(Exception e){}
         
         Opportunity opp2 = new Opportunity();
         opp2.Id = opp.Id;
         opp2.StageName = 'Allotment';
         opp2.Match_Field_Validation__c= true;
         try{
         insert opp2;
         
         Payment_Schedule__c ps =  new Payment_Schedule__c();
         ps.Education_Cess__c = 100;
         ps.opportunity__C = opp2.id;
         insert ps;
            
            }Catch(Exception e){}
            
            
            
       
           
              // Master_Payment__c[] mp  =[Select id,Contact_mobile__c,Contact_Name__c,Unit__c,Due_Amount__c,Billing_Date__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c from Master_Payment__c where Billing_Date__c <=:system.today().addDays(-1) AND  Received_Date__c = null AND Invoice_Date__c = null AND Invoice_No__c = null];
             //system.debug('master payment===='+mp);
             
             smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
             tpltext.smagicinteract__Text__c     = 'tets';
             tpltext.smagicinteract__Name__c     = 'Payment Due New1445425533453624';
             insert tpltext;
                            
               Test.startTest(); 
              
                Batch_SendDuePayment_SMS_Opportunity sh1 = new Batch_SendDuePayment_SMS_Opportunity();
                database.executeBatch(sh1);
               //String sch = '0 0 23 * * ?';
               //system.schedule('Testing', sch, sh1);
                
                Test.stopTest();
       
           }catch(Exception e){
             system.debug('exception in test class'+e.getMessage());
         }
    
  }   

}