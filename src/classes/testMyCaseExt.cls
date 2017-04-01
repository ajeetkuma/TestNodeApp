@isTest(SeeAllData=true)
public class testMyCaseExt{

    public static testMethod void testpropertyExt(){
        
            //Account Information
            account a=new account();
            a.name='Subas Mallick';
            insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            //Unit Information
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
            opp.X1st_year_Handover_Feedback__c=true;
            opp.Handover_Feed_back_form__c=true;
            opp.Execution_without_modification_Feed_back__c=true;
            opp.Execution_with_Modification_Feed_back_fo__c=true;
            opp.Booking_CSAT_Feed_back_form__c=true;
            // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            //try{
            insert opp; 
            //}
           // catch(exception e){
          //  }
            
            
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',//OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
                             
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                       
            
            //CpProperty Information
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c=pl.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             cpproperity.Active__c=true;
             Insert cpproperity;  
             system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity);             
            
             //Case Information
             Case cs= new Case();
             cs.ContactId=c.Id;
             cs.Origin='Web';
             insert cs;
            
             system.runas(u){
             Test.startTest();
             myCase_ext mycase = new myCase_ext(new ApexPages.StandardController(cs));
             mycase.caseId=cs.Id;
             mycase.CancelReferral();
             mycase.editPage();
             mycase.back();
             mycase.selectedCode=opp.Id;
             mycase.save2();
             //mycase.save2();
             mycase.saveAttach();
             mycase.getUnitCodeValue();  
                      
             mycase.selectedRT='Service';
            
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');               
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','description of test case');
            
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');               
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','description of test case');
             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:pri1','Low');               
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:myBlockSec3:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:myBlockSec3:des1','Description of test case');
             
             mycase.pageSave();
             mycase.saveAttach();
             mycase.saveSuggestion();
             mycase.saveService();
             mycase.saveProductCase();
             mycase.pageSave();             
                        
             Test.stopTest();            
           }
     }   
     
     
     public static testMethod void testpropertyExt1(){
        
            //Account Information
            account a=new account();
            a.name='Subas Mallick';
            insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            //Unit Information
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
            // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            opp.X1st_year_Handover_Feedback__c=False;
            opp.Handover_Feed_back_form__c=false;
            opp.Execution_without_modification_Feed_back__c=false;
            opp.Execution_with_Modification_Feed_back_fo__c=false;
            opp.Booking_CSAT_Feed_back_form__c=false;
            insert opp; 
            
            
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
                             
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                       
            
            //CpProperty Information
             CP_Property__c cpproperity=new CP_Property__c ();
             cpproperity.Plant__c=pl.id;
             cpproperity.Contact_User_Id__c=u.id;
             cpproperity.Unit_Code__c='123-1231-qw';
             cpproperity.Project_Name__c='bridage';
             cpproperity.Opportunity_Id__c=opp.id;
             cpproperity.Active__c=true;
             Insert cpproperity;  
             system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity);             
            
             //Case Information
             Case cs= new Case();
             cs.ContactId=c.Id;
             cs.Origin='Web';
             insert cs;
            
             system.runas(u){
             Test.startTest();
             myCase_ext mycase2 = new myCase_ext(new ApexPages.StandardController(cs));
             mycase2.flag='true';
             myCase_ext mycase = new myCase_ext(new ApexPages.StandardController(cs));

             mycase.flag='true';
             mycase.caseId=cs.Id;
             mycase.CancelReferral();
             mycase.editPage();
             mycase.back();
             mycase.selectedCode=opp.Id;
              mycase.save2();
             //mycase.save2();
             mycase.saveAttach();
             mycase.saveService();
             mycase.getUnitCodeValue();  
                      
             mycase.selectedRT='Service';
            
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','');   
             mycase.pageSave();         
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','');
             mycase.pageSave(); 
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','');
             mycase.pageSave();
             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','');
             mycase.pageSave();
             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:subcat1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:pri1',''); 
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:pri1','Low'); 
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:myBlockSec3:sub1','');
             mycase.pageSave();
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cstype','Product');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:cate1','Civil');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:reas1','New problem');             
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:sec1:pri1','Low');  
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:sub1','Test Subject');           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock1:myBlockSec1:des1','test');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:myBlockSec2:des1','test2');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:cate1','Others');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:sec3:pri1','Low'); 
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:myBlockSec3:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock3:myBlockSec3:des1','');
             mycase.pageSave();
             mycase.saveAttach();
             
             //------------------------------
             
             mycase.selectedRT='Service';
                           
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cstype','Suggestion');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm:myBlock:myBlock2:sec2:pri1','Low');
                                                         
             ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:des1','test');
             mycase.saveSuggestion();
             ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:des1','');
             mycase.saveSuggestion();
             ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:sub1','');
             //ApexPages.currentPage().getParameters().put('page:frm2:myBlock2:myBlockSec2:des1','test');
             mycase.saveSuggestion();
             
             mycase.selectedRT='Service';
                           
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:pri1','Low');                                                         
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:myBlockSec3:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:myBlockSec3:des1','test');
             mycase.saveSuggestion();
             
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','');
             mycase.saveService();
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','');
             mycase.saveService();
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:pri1','');
             mycase.saveService();
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:myBlockSec3:sub1','');
             mycase.saveService();
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:pri1','Low');                                                         
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:myBlockSec3:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:myBlockSec3:des1','');
             mycase.saveService();
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm3:myBlock3:sec3:subcat1','');
             mycase.saveService();
             
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','');
             mycase.saveProductCase();
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cate1','');
             mycase.saveProductCase();
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:pri1','');
             mycase.saveProductCase();
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:pri1','Low');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:myBlockSec1:sub1','');
             mycase.saveProductCase();
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:subcat1','slope');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:pri1','Low');                                                         
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:myBlockSec1:sub1','Test Subject');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:myBlockSec1:des1','');
             mycase.saveProductCase();
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cstype','Service');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:cate1','Other');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:reas1','New problem');
             ApexPages.currentPage().getParameters().put('page:frm1:myBlock1:sec1:subcat1','');
             mycase.saveProductCase();
             //------------------------------

             mycase.saveService();
             mycase.saveProductCase();
             mycase.pageSave();
                        
             Test.stopTest();            
           }
     }   
     
     
}