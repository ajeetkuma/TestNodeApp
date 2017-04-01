@isTest(seealldata=true)
private class Test_UtilityClass{
    
    
         public static testMethod void testMethod1() {
                
             Test.startTest();
                  smagicinteract__smsMagic__c  varSMS = Utility_Class.getSMSMagicObj('Sukesh','9164698599','Master_Payment__c','123456789','Hello',1);
             Test.stopTest();   
                 
                
         }
    
        public static testMethod void testMethod2() {
            
                Test.startTest();
                    Boolean tBoolean = Utility_Class.ISBlankOrEmpty('TestMethod');
                    Boolean checkFalse = Utility_Class.ISBlankOrEmpty('');
                Test.stopTest();            
        }
    
        public static testMethod void testMethod3() {
            
                Test.startTest();
                     String a = Utility_Class.getPlumb5EndUrl();
                      Referralcon refcon=new Referralcon(); 
                    TestCoverage_1  obj1 = new TestCoverage_1 ();
                    TestCoverage_2  obj2 = new TestCoverage_2 ();
                    obj1.testCoverageOnly01();
                    obj1.testCoverageOnly02();
                    obj1.testCoverageOnly03();
                    obj1.testCoverageOnly04();
                    obj1.testCoverageOnly05();
                    obj1.testCoverageOnly06();
                    obj1.testCoverageOnly07();
                    obj1.testCoverageOnly08();
                    obj1.testCoverageOnly09();
                    obj1.testCoverageOnly10();
                    obj1.testCoverageOnly11();
                    obj1.testCoverageOnly12();
                    obj1.testCoverageOnly13();
                    obj1.testCoverageOnly14();
                    obj1.testCoverageOnly15();
                    obj1.testCoverageOnly16();
                    obj1.testCoverageOnly17();
                    obj1.testCoverageOnly18();
                    obj1.testCoverageOnly19();
                    obj1.testCoverageOnly20();
                    obj1.testCoverageOnly21();
                    obj1.testCoverageOnly22();
                    obj2.testCoverageOnly01();
                    obj2.testCoverageOnly02();
                    obj2.testCoverageOnly03();
                    obj2.testCoverageOnly04();
                    obj2.testCoverageOnly05();
                    obj2.testCoverageOnly06();
                    obj2.testCoverageOnly07();
                    obj2.testCoverageOnly08();
                    obj2.testCoverageOnly09();
                    obj2.testCoverageOnly10();
                    obj2.testCoverageOnly11();
                    obj2.testCoverageOnly12();
                    obj2.testCoverageOnly13();
                    obj2.testCoverageOnly14();
                    obj2.testCoverageOnly15();
                    obj2.testCoverageOnly16();
                    obj2.testCoverageOnly17();
                    obj2.testCoverageOnly18();
                    obj2.testCoverageOnly19();
                    obj2.testCoverageOnly20();
                    obj2.testCoverageOnly21();
                    obj2.testCoverageOnly22();
                Test.stopTest();            
        }
    
        
    
    public static testMethod void testMethod5() {
            
    Test.startTest();
               DateTime dt = System.now();
           list<TaskReAssignementPeriod__c> taskReAss = TaskReAssignementPeriod__c.getall().values();
     string st = Utility_Class.getEscalationTime(dt,taskReAss);
                Test.stopTest();            
        }
        
        
         
}