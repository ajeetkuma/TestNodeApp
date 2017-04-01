/*-----------------------------------------------
 * Name        : Sukesh G
 * Class Name  : updateMasterPayment
 * Description : test class for updateMasterPayment.
 *               when contact has been updated the Master 
 *               payment will be updated So based on the 
 *               contact id we are updating the Master Payment
 * ---------------------------------------------*/
@isTest(SeeAllData =false)
private class updateMasterPayment_Test {

           public static testMethod void method1(){
               account a=new account();
               a.name='Sukesh G';
               insert a; 
               
               Contact c = new Contact();
               c.lastName = 'G';
               c.AccountId = a.id;
               insert c;
               
               Master_Payment__c mPayment = new Master_Payment__c();
               mPayment.Contact_Id__c = c.id;
               insert mPayment;
               
               c.lastName = 'B';
               update c;
               
           }
}