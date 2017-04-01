@isTest(SeeAllData =true)

 private class testAccountTrigger{       
      static testMethod void AccountTrigger() {
        
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
          
            acc.Primary_Contact_s_Email__c='devp@extentor.com';
            insert acc;  
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            opp.X1st_year_Handover_Feedback__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            opp.Handover_Feed_back_form__c=false;            
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Execution_without_modification_Feed_back__c=false;   
            opp.Active__c =True ;
            opp.Customer_ID__c='12323424233435443uu3i42i432i423';
            opp.Update_Flag__c ='U';
            opp.Customer_ID__c=acc.id;    
            opp.Email__c='Devpe@extentor.com'; 
            insert opp;
            
            
            
            
      
      
    }
    
  }