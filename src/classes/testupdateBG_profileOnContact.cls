@isTest(SeeAllData =true)

 private class testupdateBG_profileOnContact{      
  
      static testMethod void updateBG_profileOnContact() {
      
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
            insert acc;         
           
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.Contact_Type__c='FisrtApplicant';
            con.email='developer@extentor.com';              
            con.Income_Tax_PAN_GIR_No__c='1231231231';         
            con.Company__c='esxt';
            con.Educational_Qualification__c='mca';
            con.Designation__c='se';
            con.Profession__c='job';
            con.Industry__c='IT';
            con.Birthdate=system.today();
            con.Wedding_Anniversary__c=system.today();
            con.accountId=acc.Id;
            con.MobilePhone='1231231234';
            insert con;                 
           
            //Bgprofile Information
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
            
                 acc.House_number__c='2-128';
                 update acc;   
                    
                 
            Test.startTest();                    
                contactRecursiveHelper.isContactUpdate =false; 
                system.debug('5555555555555555'+bgprofile);             
                            
                
                 con.Designation__c='Manager';
                 update con;              
                
            Test.stoptest(); 
      
    }
    
  }