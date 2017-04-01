@isTest(seeAllData = false)
private class testContactTrigger{
    static testMethod void ContactTrigger() { 
        Account acc=new Account();
        acc.Name='Subas';
        acc.CC_Address__c='subas@gmail.com';
        insert acc;
       
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='First Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        //con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
    }
    
    static testMethod void ContactTrigger2() { 
        Account acc=new Account();
        acc.Name='Subas';
        acc.FirstApplicant__c=false;
        //acc.CC_Address__c='subas@gmail.com';
        insert acc;
        
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='Second Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
    }
    
    static testMethod void ContactTrigger3() { 
        Account acc=new Account();
        acc.Name='Subas';
        //acc.CC_Address__c='subas@gmail.com';
        insert acc;
        
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='Third Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
    }
    
    static testMethod void ContactTrigger4() { 
        Account acc=new Account();
        acc.Name='Subas';
        //acc.CC_Address__c='subas@gmail.com';
        insert acc;
        
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='Fourth Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
    }
    
    static testMethod void ContactTrigger5() { 
        Account acc=new Account();
        acc.Name='Subas';
        //acc.CC_Address__c='subas@gmail.com';
        insert acc;
        
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='GPA Holder';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
    }
    
        static testMethod void ContactTrigger6() { 
        Account acc=new Account();
        acc.Name='Subas';
        //acc.CC_Address__c='subas@gmail.com';
        insert acc;
        
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='GPA Holder';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        //con.CC_Email2__c=true;   
        //con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
        
        Contact con3=new Contact();
        con3.Id=con.Id;
        delete con3;
            
    }
   /*  static testMethod void ContactTrigger7() { 
        
        Account acc=new Account();
        acc.Name='Shikha';
        acc.Rating = 'Hot';
        insert acc;

       Opportunity opp = new Opportunity();
        opp.accountid = acc.id;
        opp.Name = 'Shikha Opportunity';
        opp.CloseDate = Date.today();
        opp.StageName = 'Allotment';
        opp.Match_Field_Validation__c = true; 
        opp.Photographs_Received__c = true; 
        opp.Received_the_Address_Proof_Copy__c = true; 
        opp.Type = 'Retail';
        opp.LeadSource = 'Agent';
        insert opp;
             
        Contact cont=new Contact();
        cont.accountid=acc.id;
        cont.firstname='Shikha';
        cont.lastname='Devi';
        cont.Salutation='Miss';
        cont.Contact_Type__c='GPA Holder';
        cont.email='developer@extentor.com';
        cont.Email='developer@gmail.com';
        cont.MobilePhone='8884937365';     
        cont.Email2__c='developrr@gmail.com';
        cont.Phone='9988776655';
        cont.Mobilephone='9876543210';
        cont.Birthdate =Date.today().adddays(-2000);    
        cont.Company__c = 'Extentor';
        cont.Designation__c = 'developer';
        cont.Profession__c = 'IT profeser';
        cont.Income_Tax_PAN_GIR_No__c = '123342';
        cont.Industry__c = 'Automobile';
        cont.Educational_Qualification__c = 'B-tech'; 
        insert cont;
             
        
         
         Contact con1 = new Contact();
         con1.Id = cont.Id;
       //  con1.Birthdate = null;
         con1.Company__c = 'Extentor';
         update con1;     
    }*/
     static testMethod void ContactTrigger8() { 
         
        Country__c country = new Country__c();
        country.Name = 'India';
        insert country;
        
        
        Account acc=new Account();
        acc.Name='Shikha Devi';
        acc.Customer_Group__c ='Z3- Proprietary';
        acc.Distribution_channel__c ='10- Residential Sale';
        acc.Street1__c= 'ABC Street';
        acc.CountryL__c = country.Id;
        acc.Postal_Code__c = '176209';
        acc.Rating = 'Hot';
        //acc.FirstApplicant__c =TRUE;
        insert acc;
         
        Contact cont= new Contact();
        cont.accountid=acc.id;
        cont.firstname='Shikha';
        cont.lastname='Devi';
        cont.Salutation='Miss';
        cont.Contact_Type__c='First Applicant';
        cont.email='developer@extentor.com';
        cont.Email='developer@gmail.com';
        cont.MobilePhone='8884937365';     
        cont.Email2__c='developrr@gmail.com';
        cont.Phone='9988776655';
        cont.Mobilephone='9876543210';
        cont.Birthdate = null ;    
        cont.Company__c = null;
        cont.Designation__c = null;
        cont.Profession__c = null;
        cont.Income_Tax_PAN_GIR_No__c = null;
        cont.Industry__c = null;
        cont.Educational_Qualification__c = null;
        insert cont;
        System.debug('**********'+cont);
         Plant__c plant1 = new Plant__c();
         plant1.Name = 'KNPR - ALTAMONT';
         plant1.Admin_Email__c = 'developer@extentor.com';
         plant1.Project__c = 'Brigade Altamont';
         insert plant1;
         
         Unit__c unit1 = new Unit__c();
         unit1.Plant__c = plant1.Id;
         unit1.Name = 'BG-ALT-A-X-0109-XX';
         insert unit1;
         
        Opportunity opp = new Opportunity();
        opp.accountid = acc.id;
        opp.Name = 'Shikha Opportunity';
        opp.CloseDate = Date.today();
        opp.StageName = 'Reserving';
        opp.Type = 'Retail';
        opp.LeadSource = 'Agent';
        opp.Sales_office__c = '1120 - Dubai Sales Office';
        opp.Customer_pricing_procedure__c ='1- Flats Under Constr';
        opp.Cash_Management_Group__c ='A3- Employee Vendor';
        opp.Recon_Account__c ='0023000010- Debtors - Domestic';
        opp.Plant__c = 'KNPR - ALTAMONT';
        opp.Plant2__c = plant1.id;
        opp.Unit__c = unit1.Id;
        opp.ZTX1__c ='0- No VAT';
        opp.ZTX2__c ='0- No ST';
        opp.ZTX3__c = '0- No ECS';
        opp.ZTX4__c ='0- No HES';
        opp.Partner_Functions__c='ZC- Customer Relations';
        Try{
        insert opp;
        }Catch(Exception e){}
        
         system.debug('*******'+opp);
         
         OpportunityContactRole contOpp = new OpportunityContactRole();
         contOpp.ContactId = cont.Id;
         contOpp.OpportunityId = opp.Id;
         contOpp.IsPrimary = True;
         contOpp.Role = 'First Applicant';
         try{         
         Insert contOpp ;
         }Catch(Exception e){}
         
         Account acc2 = New Account();
         acc2.Id = acc.Id;
         acc2.FirstApplicant__c =True;
         try{
         update acc2;
         }Catch(Exception e){}
         
         Opportunity opp2 = new Opportunity();
         opp2.Id = opp.Id;
         opp2.StageName = 'Allotment';
         opp2.Match_Field_Validation__c= true;
         try{
         insert opp2;
         }Catch(Exception e){}
         
        Contact cont2= new Contact();
        cont2.Id=cont.Id;
        cont2.firstname='Shikha1';
         try{
         update cont2;
         }Catch(Exception e){
             
         }
         
        Contact cont3 = new Contact();
        cont3.Id=cont.Id;
        cont3.Birthdate= Null;
        cont3.Company__c = 'Extentor';
        cont3.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont3.Profession__c= 'DGP';
         cont3.Designation__c= 'Developer';
         cont3.Industry__c= 'Education';
         cont3.Educational_Qualification__c= 'BCom';
         try{
         update cont3;
         }Catch(Exception e){
             
         }
         
        Contact cont4 = new Contact();
        cont4.Id=cont.Id;
        cont4.Birthdate= System.Today();
        cont4.Company__c = Null;
        cont4.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont4.Profession__c= 'DGP';
         cont4.Designation__c= 'Developer';
         cont4.Industry__c= 'Education';
         cont4.Educational_Qualification__c= 'BCom';
         try{
         update cont4;
         }Catch(Exception e){
             
         }
         
        Contact cont5 = new Contact();
        cont5.Id=cont.Id;
        cont5.Birthdate= System.Today();
        cont5.Company__c = 'Extentor';
        cont5.Income_Tax_PAN_GIR_No__c = Null;
        cont5.Profession__c= 'DGP';
         cont5.Designation__c= 'Developer';
         cont5.Industry__c= 'Education';
         cont5.Educational_Qualification__c= 'BCom';
         try{
         update cont5;
         }Catch(Exception e){
             
         }
         
        Contact cont6 = new Contact();
        cont6.Id=cont.Id;
        cont6.Birthdate= System.Today();
        cont6.Company__c = 'Extentor';
        cont6.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont6.Profession__c= Null;
         cont6.Designation__c= 'Developer';
         cont6.Industry__c= 'Education';
         cont6.Educational_Qualification__c= 'BCom';
         try{
         update cont6;
         }Catch(Exception e){
             
         }
         
        Contact cont7 = new Contact();
        cont7.Id=cont.Id;
        cont7.Birthdate= System.Today();
        cont7.Company__c = 'Extentor';
        cont7.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont7.Profession__c= 'DGP';
         cont7.Designation__c= Null;
         cont7.Industry__c= 'Education';
         cont7.Educational_Qualification__c= 'BCom';
         try{
         update cont7;
         }Catch(Exception e){
             
         }
         
        Contact cont8 = new Contact();
        cont8.Id=cont.Id;
        cont8.Birthdate= System.Today();
        cont8.Company__c = Null;
        cont8.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont8.Profession__c= 'DGP';
         cont8.Designation__c= 'Developer';
         cont8.Industry__c= Null;
         cont8.Educational_Qualification__c= 'BCom';
         try{
         update cont8;
         }Catch(Exception e){
             
         }
         
         Contact cont9 = new Contact();
        cont9.Id=cont.Id;
        cont9.Birthdate= System.Today();
        cont9.Company__c = Null;
        cont9.Income_Tax_PAN_GIR_No__c= 'ABCFD1234A';
        cont9.Profession__c= 'DGP';
         cont9.Designation__c= 'Developer';
         cont9.Industry__c= 'IT';
         cont9.Educational_Qualification__c= Null;
         try{
         update cont9;
         }Catch(Exception e){
             
         }
         
         
         
    }
     static testMethod void ContactTrigger9() { 
        Account acc=new Account();
        acc.Name='Subas';
        acc.CC_Address__c='subas@gmail.com';
        insert acc;
       
        Contact con=new Contact();
        con.firstname='Subas';
        con.lastname='Mallick';
        con.Salutation='Mr';
        con.Contact_Type__c='First Applicant';
        con.email='developer@extentor.com';
        con.accountid=acc.id;
        con.Email='developer@gmail.com';
        con.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con.CC_GPA__c=false;  
        con.Email2__c='developrr@gmail.com';
        //con.Phone='9988776655';
        con.Mobilephone='9876543210';
        insert con;
        
        Contact con2=new Contact();
        con2.Id=con.Id;
        con2.firstname='Subas2';
        con2.lastname='Mallick2';
        con2.Salutation='Mr';
        //con2.Contact_Type__c='First Applicant';
        con2.email='developer@extentor.com';
        //con.accountid=acc.id;
        con2.Email='developer@gmail.com';
        con2.MobilePhone='8884937365';   
        con.CC_Email2__c=true;   
        con2.CC_GPA__c=false;  
        con2.Email2__c='developrr2@gmail.com';
        con2.Phone='9900776655';
        con2.Mobilephone='9875643210';
        update con2;
        delete con;  
    }
    
}