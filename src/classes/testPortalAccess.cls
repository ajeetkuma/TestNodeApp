@isTest(SeeAllData =true)
public class testPortalAccess{
    public static testMethod void testPortalAccess(){
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Handed Over';
            opp.CloseDate=System.now().date();
            opp.Reserving_Date__c=System.now().date();
            opp.Unit__c=uc.Id;
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
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

            

            
            Case cs= new Case();
            cs.ContactId=c.Id;
            cs.Origin='Web';
            insert cs;
        Test.startTest();
        portalAccess myportal = new portalAccess(new ApexPages.StandardController(pl));
        myportal.selectedValue=pl.Project__c;
        myportal.getItems();
        myportal.getPlantName();
        myportal.selectedPlant =pl.name;
        //myportal.portalAccess ();
        myportal.isPortalAcess='Yes';
        myportal.Search();
        //myportal.setValueTopageList();
        myportal.Activate();
        myportal.selectAllRecordToSeleted();
        myportal.Next();
        myportal.Previous();
        myportal.setIsSelectToFalse();
        myportal.getPageNumber();
        myportal.getTotal_size();
        myportal.getTotalPages();
        myportal.sortlist();
        
        //covering else condition
        myportal.isReverse=False;
        myportal.isPortalAcess='No';
        myportal.Search();
        myportal.selectAllRecordToSeleted();
        myportal.sortlist();
        myportal.Search2();
         myportal.isPortalAcess='Yes';
        myportal.Search();
        myportal.selectAllRecordToSeleted();
        myportal.sortlist();
        myportal.Search2();
        Test.stopTest();        
    }
}