/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_Class2 {

     static testMethod void test01() {
        Test.startTest();
        
        TestCoverage_2 testClass1 = new TestCoverage_2();
        testClass1.testCoverageOnly01();
        testClass1.testCoverageOnly02();
        testClass1.testCoverageOnly03();
        testClass1.testCoverageOnly04();
        testClass1.testCoverageOnly05();
        testClass1.testCoverageOnly06();
        testClass1.testCoverageOnly07();
        testClass1.testCoverageOnly08();
        testClass1.testCoverageOnly09();
        testClass1.testCoverageOnly10();
        testClass1.testCoverageOnly11();
        testClass1.testCoverageOnly12();
        testClass1.testCoverageOnly13();
        testClass1.testCoverageOnly14();
        testClass1.testCoverageOnly15();
        testClass1.testCoverageOnly16();
        testClass1.testCoverageOnly17();
        testClass1.testCoverageOnly18();
        testClass1.testCoverageOnly19();
        testClass1.testCoverageOnly20();
        testClass1.testCoverageOnly21();
        testClass1.testCoverageOnly22();
        Test.stopTest();
    }
}