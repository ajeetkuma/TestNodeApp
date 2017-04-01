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
private class Test_Offer_Page_Controller {

    public static testMethod void testMyController() {
            test.starttest();
            //Test.setCurrentPage(page.record_entry);
            ApexPages.StandardController qe = new ApexPages.standardController(new offer__c());
            Offer_Page_Controller controller = new Offer_Page_Controller(qe);
           // controller.Accid;
          //  controller.accName;
           Offer__c o= new Offer__c();
             o.Name= 'Test';
             o.Approved_BY_HOD__c=true;
             insert o;
             
             Attachment a = new Attachment();
             Blob b = Blob.valueOf('Test Data');
             a.ParentId= o.id;
             a.Name= 'Test Attachment for Offer';
             a.Body= b;
             insert a;
           
            controller.getSelectedValues();
            controller.getSelectedValues1();
            controller.getSelectedValuesForUnit();
            controller.getunSelectedValues();
            controller.getunSelectedValues1();
            controller.getunSelectedValuesforUnit();
            controller.selectclick();
            controller.selectclick1();
            controller.selectclickforUnit();
            controller.unselectclick();
            controller.unselectclick1();
            controller.unselectclickforUnit();
           // controller.doSave();
            controller.Cancel();
          
            test.stoptest();  
    }
     public static testMethod void testMyController1() {
            test.starttest();
            //Test.setCurrentPage(page.record_entry);
            ApexPages.StandardController qe = new ApexPages.standardController(new offer__c());
            Offer_Page_Controller controller = new Offer_Page_Controller(qe);
             Offer__c o= new Offer__c();
             o.Name= 'Test';
             o.Approved_BY_HOD__c=true;
             insert o;
             
             Attachment a = new Attachment();
             Blob b = Blob.valueOf('Test Data');
             a.ParentId= o.id;
             a.Name= 'Test Attachment for Offer';
             a.Body= b;
             insert a;
            test.stoptest();  
    }
    
    
}