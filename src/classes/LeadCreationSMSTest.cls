@istest(seealldata = false)
public class LeadCreationSMSTest {
    
    public static testmethod void testsendSMSToLead(){
       	Utility_TestClass.createSMSTemplate('LeadCreation','Lead');
       	double i = math.random();
         lead l = new lead(lastName='Atal' + i,Company='Ext'+i,
                                         Status='Open',
                                         MobilePhone='4321987650',
                                         Mode_of_Enquiry__c='Chat',
                                         LeadSource='EDM',
                                         Date_of_Enquiry__c=system.today(),
                                         Email='subas.mallick@extentor.com',
                                         SMS_Text__c ='text',ownerid= Label.WebToLeadOwnerID);
        insert l;
    }
   
    
    

}