@isTest(seeAlldata=false)
public class Test_TriggerHelperForPayment {
    static testMethod void myUnitTest(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
        test.startTest();
         Plant__c objPlant                      = Utility_TestData.getPlant();
        insert objPlant;
        
        Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
        insert objUnit;
        
        Account objAcc                          = Utility_TestData.getAccountData();
        objAcc.CC_Address__c                    = 'subas@gmail.com';
        insert objAcc;
        
         
        Contact objCon                          = Utility_TestData.getContact();
        objCon.AccountId                        = objAcc.id;
        objCon.Contact_Type__c                  = 'First Applicant';
        objCon.Email                            = 'test@gmail.com';
        objCon.MobilePhone                      = '9900099000';
        objCon.DoNotCall                        = true;    
        insert objCon;
        
        Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
        insert objOpp;
       
       
        Sale_Order_Item__c objsale              = new Sale_Order_Item__c();
        objsale.Opportunity__c                  = objOpp.id;
        insert objsale;
        
        Payment_Schedule__c paySch              = new Payment_Schedule__c();
        Date myDate                             = date.newInstance(2012,05,22);
        paySch.Billing_Date__c                  = myDate;
        paySch.Payment_Status__c                = 'A';
      // paySch.Mile_Stone_Block__c              = 'Z1';
        
        paySch.Sale_Order_Item__c               = objsale.id;
        insert paySch;
        
        
        
        test.stopTest();
        }
        
    }
    static testMethod void myUnitTest1(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
        test.startTest();
        Plant__c objPlant                       = Utility_TestData.getPlant();
        insert objPlant;
        
        Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
        insert objUnit;
        
        Account objAcc                          = Utility_TestData.getAccountData();
        objAcc.CC_Address__c='subas@gmail.com';
        insert objAcc;
        
        Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
        insert objOpp;
        
        Contact objCon                          = Utility_TestData.getContact();
        objCon.AccountId                        = objAcc.id;
        objCon.Contact_Type__c                  = 'First Applicant';
        objCon.Email                            = 'test@gmail.com';
        objCon.MobilePhone                      = '9900033000';
        
        insert objCon;
       
        Sale_Order_Item__c objsale = new Sale_Order_Item__c();
        objsale.Opportunity__c=objOpp.id;
        insert objsale;
        Payment_Schedule__c paySch= new Payment_Schedule__c();
        Date myDate                             = date.newInstance(2012,05,22);
        paySch.Billing_Date__c = myDate;
        paySch.Sale_Order_Item__c=objsale.id;
        paySch.Payment_Status__c                = 'A';
        //paySch.Mile_Stone_Block__c              = 'Z1';
        
        insert paySch;
        
        Date myDate3                             = date.newInstance(2012,05,21);
        paySch.Billing_Date__c = myDate3;
        update paySch;
        
        
        
        Payment_Schedule__c paySch2= new Payment_Schedule__c();
         Date myDate2                             = date.newInstance(2012,05,22);
        paySch2.Billing_Date__c =myDate2;
        paySch2.Payment_Status__c                = 'A';
       // paySch2.Mile_Stone_Block__c              = 'Z1';
        
        paySch2.Sale_Order_Item__c = objsale.id;
        
        insert paySch2;
        test.stopTest();
        }  
    }
    
     static testMethod void myUnitTest2(){
        User testUser   = Utility_TestData.getTestUser();
        insert testUser;
        system.runAs(testUser){
        test.startTest();
        Plant__c objPlant                       = Utility_TestData.getPlant();
        insert objPlant;
        
        Unit__c objUnit                         = Utility_TestData.getUnit(objPlant.id,2);
        insert objUnit;
        
        Account objAcc                          = Utility_TestData.getAccountData();
        objAcc.CC_Address__c='subas@gmail.com';
        insert objAcc;
        
        Opportunity objOpp                      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
        insert objOpp;
        
        Contact objCon                          = Utility_TestData.getContact();
        objCon.AccountId                        = objAcc.id;
        objCon.Contact_Type__c                  = 'First Applicant';
        objCon.Email                            = 'test@gmail.com';
        objCon.MobilePhone                      = '9900033000';
        
        insert objCon;
       
        Sale_Order_Item__c objsale = new Sale_Order_Item__c();
        objsale.Opportunity__c=objOpp.id;
        insert objsale;
        Payment_Schedule__c paySch= new Payment_Schedule__c();
        Date myDate                             = date.newInstance(2012,05,22);
        paySch.Billing_Date__c = myDate;
        paySch.Sale_Order_Item__c=objsale.id;
        paySch.Payment_Status__c                = 'A';
        //paySch.Mile_Stone_Block__c              = 'Z1';
        
        insert paySch;
        
        Date myDate3                             = date.newInstance(2012,05,21);
       // paySch.Billing_Date__c = myDate3;
       // update paySch;
        
        
        
        Payment_Schedule__c paySch2= new Payment_Schedule__c();
         Date myDate2                             = date.newInstance(2012,05,22);
        paySch2.Billing_Date__c =myDate2;
        paySch2.Payment_Status__c                = 'A';
        paySch2.Mile_Stone_Block__c              = 'Z1';
        
        paySch2.Sale_Order_Item__c = objsale.id;
        
        insert paySch2;
        delete paySch2;    
        test.stopTest();
        }  
    }
}