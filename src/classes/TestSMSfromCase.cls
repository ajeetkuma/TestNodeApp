@isTest
public class TestSMSfromCase {
    static testMethod void test1(){
        
        smagicinteract__SMS_Template__c smstemp=new smagicinteract__SMS_Template__c();
        smstemp.smagicinteract__Name__c='SendSMStoCaseOwner';
        smstemp.smagicinteract__Text__c='fgasfdgfsafd';
        insert smstemp;
        
        User thisUser = [select Id,ProfileId,managerId from User where Id = :UserInfo.getUserId()];
        User u = new User();
     	u.ProfileId = thisUser.ProfileId;
     	u.LastName = 'last';
     	u.Email = 'puser000@amamama.com';
     	u.Username = 'puser000@amamama.com' + System.currentTimeMillis();
     	
     	u.Title = 'title';
     	u.Alias = 'alias';
     	u.TimeZoneSidKey = 'America/Los_Angeles';
     	u.EmailEncodingKey = 'UTF-8';
     	u.LanguageLocaleKey = 'en_US';
     	u.LocaleSidKey = 'en_US';
        insert u;
        thisUser.ManagerId=u.id;
        update thisUser;
       
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
        cs.Category_portal__c='Project';
        //cs.Category_portal__c='Flat Inspection';
        cs.Case_Division_Portal__c='Custom Relationship Management';
        insert cs;
       	List<Id> ids=new List<Id>();
        ids.add(cs.id);
        test.startTest();
        SMSfromCase.sendSMStoCaseOwner(ids);
        test.stopTest();
        //CaseEsclated.escalateCasetoManager(ids,'bdbdbbd');
    }
}