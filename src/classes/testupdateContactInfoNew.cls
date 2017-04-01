@isTest(SeeAllData =true)

 private class testupdateContactInfoNew { 
      static testMethod void updateContactInfoNew() {
      
          RecordType rt = [select id,Name from RecordType where SobjectType='Account' and Name='Child Account' Limit 1];
          
          RecordType rt1 = [select id,Name from RecordType where SobjectType='Contact' and Name='Child Contact' Limit 1];
         
          contactRecursiveHelper.isContactUpdate = true;
      
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            //acc.recordTypeId=rt.id;
            insert acc;  
            
            system.debug('Record Type name account  '+acc.recordTypeId);
            
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            // con.Contact_Type__c='FisrtApplicant';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.recordTypeId=rt1.id;
            con.Contact_Type__c='First Applicant';
            //  con.Execution_withoutmodification_Feed_back__c=true;
            // con.accountId=acc.Id;
            insert con;
            
            
            system.debug('Record Type name contact'+con.recordTypeId); 
            
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_Mobile__c='9819981998';            
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c='123123kj34';
            bgprofile.CPprofile_EmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_Company__c='extentor';
            bgprofile.CPprofile_EducationalQualification__c='Mca';
            bgprofile.CPprofile_Designation__c='IT';            
            bgprofile.CPprofile_Profession__c='JOb';            
            bgprofile.CPprofile_Industry__c='it';            
            bgprofile.CPprofile_BirthDate__c=system.today();            
            bgprofile.CPprofile_Wedding_Anniversary__c=system.today();          
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile;   
              
             Test.startTest(); 
             
             contactRecursiveHelper.isContactUpdate =false;
             contactRecursiveHelper.isAccountUpdate =false;
             system.debug('5555555555555555'+bgprofile);
             bgprofile.CPprofile_Street3__c='2ndline';
             update bgprofile;           
          
           
           Test.stoptest();         
      
      
      
      
   }
   
}