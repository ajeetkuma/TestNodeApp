@isTest//(SeeAllData=true)
 private class testUpdateCPPaymentSchedule{
           static testmethod void UpdateCPPaymentSchedule() {           
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
           
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@gmail.com';
            pl.Project__c='Cosmopolis';  
            insert pl;
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc;
        
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Reserving';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
            opp.Plant__c='KP00 - Meadoows';
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='FisrtApplicant';
            c.email='developer@extentor.com';
            c.accountid=opp.AccountId;
            c.Contact_Type__c='First Applicant';
            c.Booking_CSAT_Feed_back_form__c=false;
            c.ExecutionwithModification_Feed_back_fo__c=false;
            c.Execution_withoutmodification_Feed_back__c=false;
            c.Handover_Feed_back_form__c=false;
            c.X1st_year_Handover_Feedback__c=false;
            insert c; 
              
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
          //  cpproperity.Contact_User_Id__c=UserInfo.getUserId();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c=;
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;  
            
            Sale_Order_Item__c SOI=new Sale_Order_Item__c();
            SOI.Name= 'BG-SON-X-X-0102-XL';
            SOI.Basic_Cost__c=234000.00;
            SOI.Item_category__c='ZTAO';
            SOI.Material__c='BG-SON-X-X-0102-XL';
            SOI.Netvalue__c=23467.00;
            SOI.Opportunity__c=opp.Id;
            SOI.Order_Quantity__c=2;
            SOI.Tax__c=50;
            SOI.Unit_of_measure__c='M2';
            insert SOI;
            
            Payment_Schedule__c PS = new Payment_Schedule__c();
            PS.Billing_Date__c=system.today();
            PS.Bill_Value__c=90000;
            PS.Credit_Memo_Dt__c=system.today();
            PS.Credit_Memo_No__c='12345';
            PS.Description__c='sapmle data';
            PS.Education_Cess__c=9000;
            PS.Invoice_date__c=system.today();
            PS.Invoice_No__c='INV899';
            //PS.Opportunity__c
            PS.Payment_Received_Date__c=system.today();
            //PS.Payment_Schedule_Id__c=
            PS.Payment_Status__c='C';
            PS.Sale_Order_Item__c=SOI.Id;
            PS.Secondary_Education_Cess__c=9000;
            PS.SendSms__c=true;
            PS.Service_Tax__c=900;
            PS.VAT__c=90;
            insert PS;
            
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='Payment Due';
            smagic.smagicinteract__ObjectName__c='Payment Schedule';
            smagic.smagicinteract__Text__c='Sample sms testing';
            insert smagic;
            
            Payment_Schedule__c PS2 = new Payment_Schedule__c();
            PS2.Id=PS.Id;
            PS2.Billing_Date__c=system.today()+3;
            PS2.Bill_Value__c=80000;
            PS2.Credit_Memo_Dt__c=system.today()+1;
            PS2.Credit_Memo_No__c='129345';
            PS2.Description__c='sapmle data2';
            PS2.Education_Cess__c=90000;
            PS2.Invoice_date__c=system.today()+2;
            PS2.Invoice_No__c='INV8989';
            //PS.Opportunity__c
            PS2.Payment_Received_Date__c=system.today()+4;
            //PS.Payment_Schedule_Id__c=
            PS2.Payment_Status__c='A';
            //PS2.Sale_Order_Item__c=SOI.Id;
            PS2.Secondary_Education_Cess__c=90000;
            //PS2.SendSms__c=true;
            PS2.Service_Tax__c=9000;
            PS2.VAT__c=900;
            update PS2;
        }
}