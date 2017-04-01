@isTest
public class userAvailableForLeadAssignementTest {
	
    @istest
    public static void testmydetail(){
        user usr  = [select id from user where MobilePhone = '1234' ];
        system.PageReference pg = Page.userAvailableForLeadAssignment ; 
       	pg.getParameters().put('id',usr.id);
        Test.setCurrentPage(pg);
        test.startTest();
        userAvailableForLeadAssignement usrAvail = new userAvailableForLeadAssignement();
        usrAvail.saveAssignment();
        test.stopTest();
    }
    
    @testsetup
    public static void testSetUpData(){
        double d = Math.random();
       profile p = [select id from profile limit 1];
       User u = new User(Alias = 'standt', Email='Developer1@gmail.com', 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='1234',
                      TimeZoneSidKey='America/Los_Angeles',IsActive = true,UserName='developer1@test.com'+d );
        Double d1 = d + 1;
        insert u ;
        
        User u1 = new User(Alias = 'standt', Email='Developer1@gmail.com', 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='5678',
                      TimeZoneSidKey='America/Los_Angeles',IsActive = true,managerid = u.id ,UserName='developer1@test.com'+d1 );
       insert u1;
       
    }
}