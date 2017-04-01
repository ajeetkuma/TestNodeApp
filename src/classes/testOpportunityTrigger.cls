@istest

//Test class
    private class testOpportunityTrigger{
    //Test method    
        public static testmethod void testOpportunityTrigger(){     
             
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;  
             
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
            account a=new account();
            a.name='testfor';
            a.House_number__c ='2-128';
            a.Street1__c      ='LastLine';
            a.Street2__c      ='Postoffice';
            a.Street3__c      ='Nextone';
            a.Postal_Code__c  ='123456';
            a.City__c         ='bangalore';  
            a.CC_Address__c   ='wernext';      
            insert a;   
             
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
            opp.Set_the_Unit_Status__c='Reserved';
            opp.Unit__c=uc.id;
            insert opp; 
            
            opportunity opp1=new opportunity ();
            opp1.name='test';
            opp1.AccountId=a.id; 
            opp1.StageName='Site Visit';
            opp1.CloseDate=System.now().date();
           // opp1.Reserving_Date__c=System.now().date();
            opp1.Unit__c=uc.id;
            Opp1.Set_the_Unit_Status__c = null;
            opp1.id=opp.id;
            update opp1;
            
            
            
            
      }
      
      public static testmethod void testOpportunityTrigger1(){  
             
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;  
             
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
            account a=new account();
            a.name='testfor';
            a.House_number__c ='2-128';
            a.Street1__c      ='LastLine';
            a.Street2__c      ='Postoffice';
            a.Street3__c      ='Nextone';
            a.Postal_Code__c  ='123456';
            a.City__c         ='bangalore';  
            a.CC_Address__c   ='wernext';      
            insert a;  
             
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
            opp.Set_the_Unit_Status__c='Available';
            opp.Unit__c=null;
            insert opp; 
            
            opportunity opp1=new opportunity ();
            opp1.name='test';
            opp1.AccountId=a.id; 
            opp1.StageName='Site Visit';
            opp1.CloseDate=System.now().date();
           // opp1.Reserving_Date__c=System.now().date();
            opp1.Unit__c=null;
            Opp1.Set_the_Unit_Status__c = null;
            opp1.id=opp.id;
            update opp1;
            
            
      }
      
       public static testmethod void testOpportunityTrigger2(){  
             
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;  
             
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
             
            account a=new account();
            a.name='testfor';
            a.House_number__c ='2-128';
            a.Street1__c      ='LastLine';
            a.Street2__c      ='Postoffice';
            a.Street3__c      ='Nextone';
            a.Postal_Code__c  ='123456';
            a.City__c         ='bangalore';  
            a.CC_Address__c   ='wernext';      
            insert a;
             
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
            opp.Unit_s_prior_id__c='Available';
            opp.Unit__c=null;
            insert opp; 
            
            
            opportunity opp1=new opportunity ();
            opp1.name='test';
            opp1.AccountId=a.id; 
            opp1.StageName='Allotment';
            opp1.CloseDate=System.now().date();
         //   opp1.Reserving_Date__c=System.now().date();
            opp1.Unit_s_prior_id__c=null;       
            opp1.id=opp.id;     
            try{
            update opp1;
            }Catch(Exception e){
                
            }
            
            
            
      }
}