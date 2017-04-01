@isTest(SeeAllData =false)

 private class testAccountTriggerUpdated{       
      static testMethod void AccountTrigger() {
        
            account acc=new account();
            acc.name='Test-abc';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Same_as_Correspondence_Address__c=true;
            //acc.RecordType.name='Child Record';
          
            acc.Primary_Contact_s_Email__c='devp@extentor.com';
            insert acc;
         }
         
         static testMethod void AccountTriggerOne() {
        
            account acc=new account();
            acc.name='Test-abc';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Same_as_Correspondence_Address__c=true;
            //acc.RecordType.name='Child Record';
          
            acc.Primary_Contact_s_Email__c='devp@extentor.com';
            insert acc;
            
            acc.Street1__c='CA';
            update acc;

         }
         
      static testMethod void AccountTriggerTwo() {
        try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }
      static testMethod void AccountTriggerThree() {
          try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerFour() {
            try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerFive() {
            try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c='abc';
            acc.A_Street_3__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerSix() {
           try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c='abc';
            acc.A_Street_3__c='abc';
            acc.A_Postal_Code__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerSeven() {
            try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c='abc';
            acc.A_Street_3__c='abc';
            acc.A_Postal_Code__c='abcd';
            acc.A_City__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerEight() {
            try {
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c='abc';
            acc.A_Street_3__c='abc';
            acc.A_Postal_Code__c='abcd';
            acc.A_City__c='kanpur';
             acc.A_Region__c=null;
            insert acc;
            }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }   
         static testMethod void AccountTriggerNine() {
            try {
            Country__c cont=new Country__c();
            cont.Name='India';
            
            cont.Code__c='001';
            insert cont;
         
            system.debug('+++++++++++++ID country+++++' + cont.ID);
         
              Region__c reg=new Region__c();
              reg.Name='bangalore';
              reg.Country__c=cont.Id;
              system.debug('++++++++Country_record++++++++++' + reg.Country__c);
              insert reg;
              
              /* Region__c rg=new Region__c();
               rg.name='Bangalore';
               rg.Country__r.ID=cont.Id;
               rg.Country__c=cont.ID;
               
               system.debug('++++++++Country_record++++++++++' + rg.Country__c);
               insert rg; */
           
            account acc=new account();
            acc.name='Test-abc';
            acc.Same_as_Correspondence_Address__c=false;
            acc.A_House_Number__c='abc';
            acc.A_Street_1__c='abc';
            acc.A_Street_2__c='abc';
            acc.A_Street_3__c='abc';
            acc.A_Postal_Code__c='abcd';
            acc.A_City__c='kanpur';
            acc.A_Region__c=reg.ID;
            acc.A_Country__c=cont.ID;
            insert acc;
               }
            catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            }
         }     
 }