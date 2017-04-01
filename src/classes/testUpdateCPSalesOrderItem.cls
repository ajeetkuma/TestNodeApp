@isTest(SeeAllData =false)

private class testUpdateCPSalesOrderItem {     
   public static testmethod void testUpdateCPSalesOrderItem (){  
   
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
            
            
            Sale_Order_Item__c SOI1=new Sale_Order_Item__c();
           
            SOI1.id=SOI.id;
            update SOI1;
   
   }
}