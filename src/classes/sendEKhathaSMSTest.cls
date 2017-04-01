@isTest(seealldata = false)
public class sendEKhathaSMSTest {

    public static testmethod void ekhattests()
    {
         
        Utility_TestClass.oppcontrole();    
          
        PageReference pageRef = Page.sendEKhathaSMS;
        
        pageRef.getParameters().put('id',Utility_TestClass.planrec.id);
        pageRef.getParameters().put('for','Ekhatha');
        system.Test.setCurrentPage(pageRef);
         
        Utility_TestClass.createSMSTemplate('EKhathaSMS','CONTACT');
        sendEKhathaSMS ses=new sendEKhathaSMS();
        ses.populateUnitName();
      
    }
    
    public static testmethod void KrishiKalyanTest()
    {
         
        Utility_TestClass.oppcontrole();    
          
        PageReference pageRef = Page.sendEKhathaSMS;
        
        pageRef.getParameters().put('id',Utility_TestClass.planrec.id);
        pageRef.getParameters().put('for','KrishiKalyan');
        system.Test.setCurrentPage(pageRef);
         
        Utility_TestClass.createSMSTemplate('KrishiKalyanSMS','CONTACT');
        sendEKhathaSMS ses=new sendEKhathaSMS();
        ses.populateUnitName();
      
    }
    
    public static testmethod void updateCallDipostion(){
	
	double d = Math.random();
	lead led = Utility_TestData.createLead('ABC'+d);
        insert led;
	task tsk = Utility_TestData.createTask(led.id,system.today(),userinfo.getuserid());
        insert tsk ;
	task t = new task(id=tsk.id,Call_disposition__c='others');
		update t;
	
	}
    
     public static testmethod void updateCallDipostion_con(){
		OpportunityContactRole oppCon = Utility_TestClass.oppcontrole(); 
         Task tempTask = new Task(Subject = 'Subject',
                                 OwnerId = userinfo.getuserID(),
                                 WhoID = oppCon.contactId,
                                 whatId = oppCon.OpportunityId,
                                 Call_disposition__c='others'
                                 );
        insert tempTask;
         
     }
}