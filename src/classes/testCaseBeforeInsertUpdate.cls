@isTest(SeeAllData=true)
private class testCaseBeforeInsertUpdate{
    private static testMethod void CaseBeforeInsert(){

            User thisUser = [select Id from User where Id = :UserInfo.getUserId()];
            
            account a=new account();
            a.name='Subas Mallick';
            insert a; 
           
           //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='developer@gmail.com';
            pl.Project__c='Cosmopolis';
            pl.Admin_User__c =thisUser.Id;
            insert pl;
            
            //unit Information
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc;
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Reserving';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
            opp.Date_of_Enquiry__c = System.now().date();
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
            
            //Case Information
            Case cs=new Case();
            cs.ContactId=c.Id;
            cs.status='Open';
            cs.Origin='Web';
            cs.Priority='High';
            cs.Email_to_Manager__c=true;
            cs.Opportunity__c=opp.Id;
            System.debug(':======Before======'+cs);
           // insert cs;
            System.debug(':======After======'+cs); 
            
            /*Case Information
            Case cs2=new Case();
            cs2.Id=cs.Id;
            cs2.ContactId=c.Id;
            cs2.status='In-Progress';
            cs2.Origin='Email';
            cs2.Priority='High';
            cs2.Email_to_Manager__c=True;
            cs2.Opportunity__c=opp.Id;
            cs2.Categories_Service__c='Project Specific Updates';
            update cs2;*/   
    
    }
    private static testMethod void CaseBeforeInsert2(){

            User thisUser = [select Id from User where Id = :UserInfo.getUserId()];
            
            account a=new account();
            a.name='Subas Mallick';
            insert a; 
           
           //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='developer@gmail.com';
            pl.Project__c='Cosmopolis';
            //pl.Admin_User__c =thisUser.Id;
            insert pl;
            
            //unit Information
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc;
            
            //Opportunity Information
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
            
            //Case Information
            Case cs=new Case();
            cs.ContactId=c.Id;
            cs.Change_owner__c = False;
            cs.status='Open';
            cs.Origin='Web';
            cs.Priority='High';
            cs.Email_to_Manager__c=true;
            cs.Opportunity__c=opp.Id;
            System.debug(':====Before2nd========'+cs);
            //insert cs; 
            System.debug(':===After=2nd========'+cs);
            /*Case Information
            Case cs2=new Case();
            cs2.Id=cs.Id;
            cs2.ContactId=c.Id;
            cs2.status='In-Progress';
            cs2.Origin='Email';
            cs2.Priority='High';
            cs2.Email_to_Manager__c=True;
            cs2.Opportunity__c=opp.Id;
            cs2.Categories_Service__c='Project Specific Updates';
            update cs2;   */
    
    }    
}