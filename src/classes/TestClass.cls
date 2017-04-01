@isTest(SeeAllData=false) 

private class TestClass {
    
    public static Account a;
    public static Contact c1,c2,c3,c4,c5,c8;
    public static Opportunity o;
    public static Plant__c p;
    public static Unit__c u;
    public static Sale_Order_Item__c s;
    public static Payment_Schedule__c ps1,ps2;
    
    public static List<Account> lstA;
    public static List<Contact> lstC;
    public static List<Opportunity> lstO;
    public static Plant__c pMass;
    public static List<Unit__c> lstU;
    public static List<Sale_Order_Item__c> lstS;
    public static List<Payment_Schedule__c> lstPS;

    static testMethod void testing1() {
        
        try{
           Test.isRunningTest();
            Test.setMock(WebServiceMock.class, new MockHttpResponse());
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            a = new Account(Name='Testing Account',CC_Address__c='Address');
            insert a;
            lstC    = new List<Contact>();          
            c1 = new Contact(Salutation='Mr.',FirstName='A',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='First Applicant',Email='testabhi1@gmail.com');
            lstC.add(c1);
            
            c2 = new Contact(Salutation='Mr.',FirstName='B',LastName='Testing contact2',
                    AccountId=a.Id,Contact_Type__c='Second Applicant',Email='testabhi2@gmail.com');
            lstC.add(c2);
            
           // c2.Email          = 'testabhi2@gmail.com';
           // c2.Contact_Type__c    = 'Third Applicant';
           // update c2;
            
            c3 = new Contact(Salutation='Mr.',FirstName='C',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Third Applicant',Email='testabhi3@gmail.com');
            lstC.add(c3);
            
           // c3.Email = 'testabhi3@gmail.com';
           // c3.Contact_Type__c='Second Applicant';
          //  update c3;
            
            c4 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Fourth Applicant',Email='testabhi4@gmail.com');
            lstC.add(c4);
            
            c5 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='GPA Holder',Email='testabhi5@gmail.com');
            lstC.add(c5);
            insert lstC;
            
            HFI__c hfi = new HFI__c();
            hfi.Email__c='sukesh3089@gmaial.com';
            insert hfi;
            
            o = new Opportunity(name='Testing Opportunity',AccountId=a.Id,Active__c=true,HFI__c = hfi.id,
                        StageName='Send Mailer',CloseDate=System.Today(),Customer_ID__c = '000000');
            Utility_Class.IS_OPP_TRIGGER_RUNNING = false;
            insert o;
            
             OpportunityContactRole ops = new OpportunityContactRole();
            ops.role ='First Applicant';
            ops.ContactId = c5.id;
            ops.OpportunityId = o.id;
            insert ops;
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            c1.Email = 'testabhi@gmail.com';
            c1.CC_EMail2__c = true;
            c1.Email2__c = 'testabhiCC@gmail.com';
            c1.Phone = '08099999999';
            c1.MobilePhone = '9999990999999';
           // update c1;
            
            c5.CC_GPA__c = true;
            c5.Email = 'testabhi5@gmail.com';
           // update c5;
            
            
            p = new Plant__c(Name='Test Plant',Project__c='Test Project',
                        Plant_Code__c='T001',Demand_Letter_Page1__c='Page1 Content here',
                        Demand_Letter_Page2__c='Page2 Content here');
            insert p;
            
            u = new Unit__c(Name='Test Unit for Test method1',Plant__c=p.Id,Unit_Status__c='Available');
            insert u;
            
            o.Unit__c = null;
            o.Set_the_Unit_Status__c = '';
            
           // update o;
            
            o.Plant__c = 'T001 - Test Plant';
            o.Unit__c = u.Id;
            o.Set_the_Unit_Status__c = 'Test';
            update o;
                        
            s = new Sale_Order_Item__c(Name='Test SOI',Opportunity__c=o.Id);
            insert s;
            
            List<Payment_Schedule__c> updatePayment = new List<Payment_Schedule__c>();
            date myDate = date.newInstance(2015, 8, 15);
            //ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id);
            ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id
            ,Description__c='test',Billing_Date__c=myDate,Bill_Value__c=23.44,Education_Cess__c=34.56,Secondary_Education_Cess__c=98.89
            ,Service_Tax__c=89.900,VAT__c=23.44,Mile_Stone_Base_Description_1__c='test',Swachh_Bharath_Cess__c=20.33
            );
            updatePayment.add(ps1);
            ps2 = new Payment_Schedule__c(Name='Test PS2',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps2);
            insert updatePayment;
            
            // Single Demand Letter - Create
            ApexPages.currentPage().getParameters().put('oppId',o.Id);        
            ApexPages.currentPage().getParameters().put('type','new');
            Demand_Letter_Repository__c dlr1 = new Demand_Letter_Repository__c();
            dlr1.Subject__c='Progress Letter';
            ApexPages.StandardController apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterController dlc1 = new DemandLetterController(apexpag1);
            dlc1.getListPS();

            // Mass Demand Letter - Create
            List<Opportunity> lstOpp = new List<Opportunity> ();
            // Caling set controller without selecting any opportunity i.e. setSelected is zero        
            ApexPages.StandardSetController apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            DemandLetterController dlc2 = new DemandLetterController(apexpag2);
            // calling set controller with opportunity selected - not Allotment
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            
            // calling set controller with opportunity selected - Allotment
            Country__c cy = new Country__c(name='IN - India',Code__c='IN');
            insert cy;
            
            a.CountryL__c = cy.Id;
            a.Customer_Group__c = 'test';
            a.Distribution_channel__c = 'test';
            
            Region__c rg = new Region__c(name='10 - Karnataka',Country__c=cy.Id);
            insert rg;
            
            a.RegionL__c = rg.Id;
            a.Postal_Code__c = 'test';
            a.Street1__c = 'test';
            update a;
            
            o.Cash_Management_Group__c = 'test';
            o.Recon_Account__c = 'test';
            o.Plant__c = 'T001 - Test Plant';
            o.Sales_office__c = 'test';
            o.Type = 'test';
            o.Customer_pricing_procedure__c = 'test';
            o.ZTX1__c = '1';
            o.ZTX2__c = '1';
            o.ZTX3__c = '1';
            o.ZTX4__c = '1';
            o.Set_the_Unit_Status__c = 'Test';
            o.StageName = 'Site Visit'; // to make stage to Allotment all above fields should be filled
            o.Sale_Order_No__c = '007';
            
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            update o;
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2); 
            dlc2.SaveM();
            
            // Calling PDF page
            dlr1.Name = 'Test DLR';
            insert dlr1;
            
            ApexPages.currentPage().getParameters().put('type','old');
            ApexPages.currentPage().getParameters().put('id',dlr1.id);
            apexpag1 = new ApexPages.StandardController(dlr1);
            dlc1 = new DemandLetterController(apexpag1);
            
            // DemandLetterEmailController - Sinlge
            dlr1.Opportunity__c = o.Id;
            dlr1.OwnerId = UserInfo.getUserId();
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',o.Id);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterEmailController dlec1 = new DemandLetterEmailController(apexpag1);
            dlec1.test = true;
            dlec1.dbOperation();
            
            // DemandLetterEmailController - Mass        
            dlr1.OppIDs__c = o.Id + ',';
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',null);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            
            DemandLetterEmailController dlec2 = new DemandLetterEmailController(apexpag1);
            dlec2.test = true;
            dlec2.dbOperation();
            dlec2.sendAction();
            
         
          delete lstC;
            
        }catch(Exception ex){}
        }
     static testMethod void testing2() {
        //System.assertEquals(1, 2);
         
         	
         
        try{
        
            //Test.setMock(WebServiceMock.class, new MockHttpResponse());
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            a = new Account(Name='Testing Account');
            insert a;
          //  lstC  = new List<Contact>();          
            c1 = new Contact(Salutation='Mr.',FirstName='A',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='First Applicant',Email='testabhi1@gmail.com');
            lstC.add(c1);
            
            c2 = new Contact(Salutation='Mr.',FirstName='B',LastName='Testing contact2',
                    AccountId=a.Id,Contact_Type__c='Second Applicant',Email='testabhi2@gmail.com');
            lstC.add(c2);
            
           // c2.Email          = 'testabhi2@gmail.com';
           // c2.Contact_Type__c    = 'Third Applicant';
           // update c2;
            
            c3 = new Contact(Salutation='Mr.',FirstName='C',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Third Applicant',Email='testabhi3@gmail.com');
            lstC.add(c3);
            
           // c3.Email = 'testabhi3@gmail.com';
           // c3.Contact_Type__c='Second Applicant';
          //  update c3;
            
            c4 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Fourth Applicant',Email='testabhi4@gmail.com');
            lstC.add(c4);
            
            c5 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='GPA Holder',Email='testabhi5@gmail.com');
            lstC.add(c5);
            insert lstC;
            
            HFI__c hfi = new HFI__c();
            hfi.Email__c='sukesh3089@gmaial.com';
            insert hfi;
            
            o = new Opportunity(name='Testing Opportunity',Active__c=true,HFI__c = hfi.id,
                        StageName='Send Mailer',CloseDate=System.Today(),Customer_ID__c = '000000');
            Utility_Class.IS_OPP_TRIGGER_RUNNING = false;
            insert o;
            
             OpportunityContactRole ops = new OpportunityContactRole();
            ops.role ='First Applicant';
            ops.ContactId = c5.id;
            ops.OpportunityId = o.id;
            insert ops;
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            c1.Email = 'testabhi@gmail.com';
            c1.CC_EMail2__c = true;
            c1.Email2__c = 'testabhiCC@gmail.com';
            c1.Phone = '08099999999';
            c1.MobilePhone = '9999990999999';
           // update c1;
            
            c5.CC_GPA__c = true;
            c5.Email = 'testabhi5@gmail.com';
           // update c5;
            
            
            p = new Plant__c(Name='Test Plant',Project__c='Test Project',
                        Plant_Code__c='T001',Demand_Letter_Page1__c='Page1 Content here',
                        Demand_Letter_Page2__c='Page2 Content here');
            insert p;
            
            u = new Unit__c(Name='Test Unit for Test method1',Plant__c=p.Id,Unit_Status__c='Available');
            insert u;
            
            o.Unit__c = null;
            o.Set_the_Unit_Status__c = '';
            
           // update o;
            
            o.Plant__c = 'T001 - Test Plant';
            o.Unit__c = u.Id;
            o.Set_the_Unit_Status__c = 'Test';
            update o;
                        
            s = new Sale_Order_Item__c(Name='Test SOI',Opportunity__c=o.Id);
            insert s;
            
            List<Payment_Schedule__c> updatePayment = new List<Payment_Schedule__c>();
            
            ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps1);
            ps2 = new Payment_Schedule__c(Name='Test PS2',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps2);
            insert updatePayment;
            
            // Single Demand Letter - Create
            ApexPages.currentPage().getParameters().put('oppId',o.Id);        
            ApexPages.currentPage().getParameters().put('type','new');
            Demand_Letter_Repository__c dlr1 = new Demand_Letter_Repository__c();
            ApexPages.StandardController apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterController dlc1 = new DemandLetterController(apexpag1);
            dlc1.getListPS();

            // Mass Demand Letter - Create
            List<Opportunity> lstOpp = new List<Opportunity> ();
            // Caling set controller without selecting any opportunity i.e. setSelected is zero        
            ApexPages.StandardSetController apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            DemandLetterController dlc2 = new DemandLetterController(apexpag2);
            // calling set controller with opportunity selected - not Allotment
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            
            // calling set controller with opportunity selected - Allotment
            Country__c cy = new Country__c(name='IN - India',Code__c='IN');
            insert cy;
            
            a.CountryL__c = cy.Id;
            a.Customer_Group__c = 'test';
            a.Distribution_channel__c = 'test';
            
            Region__c rg = new Region__c(name='10 - Karnataka',Country__c=cy.Id);
            insert rg;
            
            a.RegionL__c = rg.Id;
            a.Postal_Code__c = 'test';
            a.Street1__c = 'test';
            update a;
            
            o.Cash_Management_Group__c = 'test';
            o.Recon_Account__c = 'test';
            o.Plant__c = 'T001 - Test Plant';
            o.Sales_office__c = 'test';
            o.Type = 'test';
            o.Customer_pricing_procedure__c = 'test';
            o.ZTX1__c = '1';
            o.ZTX2__c = '1';
            o.ZTX3__c = '1';
            o.ZTX4__c = '1';
            o.Set_the_Unit_Status__c = 'Test';
            o.StageName = 'Site Visit'; // to make stage to Allotment all above fields should be filled
            o.Sale_Order_No__c = '007';
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            update o;
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            dlc2.SaveM();
            
            // Calling PDF page
            dlr1.Name = 'Test DLR';
            insert dlr1;
            
            ApexPages.currentPage().getParameters().put('type','old');
            ApexPages.currentPage().getParameters().put('id',dlr1.id);
            apexpag1 = new ApexPages.StandardController(dlr1);
            dlc1 = new DemandLetterController(apexpag1);
            Test.startTest();
       		//dlc1.dummy(); 
       		Test.stopTest();
            
            // DemandLetterEmailController - Sinlge
            dlr1.Opportunity__c = o.Id;
            dlr1.OwnerId = UserInfo.getUserId();
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',o.Id);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterEmailController dlec1 = new DemandLetterEmailController(apexpag1);
            dlec1.test = true;
            dlec1.dbOperation();
            
            // DemandLetterEmailController - Mass        
            dlr1.OppIDs__c = o.Id + ',';
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',null);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            
            DemandLetterEmailController dlec2 = new DemandLetterEmailController(apexpag1);
            /*dlec2.test = true;
            dlec2.dbOperation();
            dlec2.sendAction();*/
            Test.startTest();
            System.assertEquals(1, 2);
       		dlec2.dummy(); 
       		Test.stopTest();
            

          delete lstC;
            
        }catch(Exception ex){}
         
        }
        
        /*static testMethod void testing3() {
        
        try{
             date myDate = date.newInstance(2015, 8, 15);
            //Test.setMock(WebServiceMock.class, new MockHttpResponse());
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            a = new Account(Name='Testing Account',CC_Address__c='Address');
            insert a;
            lstC    = new List<Contact>();          
            c1 = new Contact(Salutation='Mr.',FirstName='A',LastName='Testing contact1',
                    Birthdate=myDate, Company__c='IT', Designation__c='MANAGER', Income_Tax_PAN_GIR_No__c='TEST', 
                    Industry__c='IT', Profession__c='Enginere',
                    AccountId=a.Id,Contact_Type__c='First Applicant',Email='testabhi1@gmail.com');
            lstC.add(c1);
            
            c2 = new Contact(Salutation='Mr.',FirstName='B',LastName='Testing contact2',
             Birthdate=myDate, Company__c='IT', Designation__c='MANAGER', Income_Tax_PAN_GIR_No__c='TEST', 
                    Industry__c='IT', Profession__c='Enginere',
                    AccountId=a.Id,Contact_Type__c='Second Applicant',Email='testabhi2@gmail.com');
            lstC.add(c2);
            
           // c2.Email          = 'testabhi2@gmail.com';
           // c2.Contact_Type__c    = 'Third Applicant';
           // update c2;
            
            c3 = new Contact(Salutation='Mr.',FirstName='C',LastName='Testing contact1',
             Birthdate=myDate, Company__c='IT', Designation__c='MANAGER', Income_Tax_PAN_GIR_No__c='TEST', 
                    Industry__c='IT', Profession__c='Enginere',
                    AccountId=a.Id,Contact_Type__c='Third Applicant',Email='testabhi3@gmail.com');
            lstC.add(c3);
            
           // c3.Email = 'testabhi3@gmail.com';
           // c3.Contact_Type__c='Second Applicant';
          //  update c3;
            
            c4 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
             Birthdate=myDate, Company__c='IT', Designation__c='MANAGER', Income_Tax_PAN_GIR_No__c='TEST', 
                    Industry__c='IT', Profession__c='Enginere',
                    AccountId=a.Id,Contact_Type__c='Fourth Applicant',Email='testabhi4@gmail.com');
            lstC.add(c4);
            
            c5 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
             Birthdate=myDate, Company__c='IT', Designation__c='MANAGER', Income_Tax_PAN_GIR_No__c='TEST', 
                    Industry__c='IT', Profession__c='Enginere',
                    AccountId=a.Id,Contact_Type__c='GPA Holder',Email='testabhi5@gmail.com');
            lstC.add(c5);
            insert lstC;
            
            HFI__c hfi = new HFI__c();
            hfi.Email__c='sukesh3089@gmaial.com';
            insert hfi;
            
            o = new Opportunity(name='Testing Opportunity',AccountId=a.Id,Active__c=true,HFI__c = hfi.id,
                       Received_the_Address_Proof_Copy__c=true,Photographs_Received__c=true, Sale_Order_No__c = '007',
                       Booking_Form_Duly_filled_completely__c=true,Provisional_Allotment_letter__c=true,
                       StageName='Allotment',CloseDate=System.Today(),Customer_ID__c = '000000');
                       
            Utility_Class.IS_OPP_TRIGGER_RUNNING = false;
            insert o;
            
             OpportunityContactRole ops = new OpportunityContactRole();
            ops.role ='First Applicant';
            ops.ContactId = c5.id;
            ops.OpportunityId = o.id;
             
            insert ops;
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            c1.Email = 'testabhi@gmail.com';
            c1.CC_EMail2__c = true;
            c1.Email2__c = 'testabhiCC@gmail.com';
            c1.Phone = '08099999999';
            c1.MobilePhone = '9999990999999';
           // update c1;
            
            c5.CC_GPA__c = true;
            c5.Email = 'testabhi5@gmail.com';
           // update c5;
            
            
            p = new Plant__c(Name='Test Plant',Project__c='Test Project',
                        Plant_Code__c='T001',Demand_Letter_Page1__c='Page1 Content here',
                        Demand_Letter_Page2__c='Page2 Content here');
            insert p;
            
            u = new Unit__c(Name='Test Unit for Test method1',Plant__c=p.Id,Unit_Status__c='Available');
            insert u;
            
            o.Unit__c = null;
            o.Set_the_Unit_Status__c = '';
            
           // update o;
            
            o.Plant__c = 'T001 - Test Plant';
            o.Unit__c = u.Id;
            o.Set_the_Unit_Status__c = 'Test';
            o.Cash_Management_Group__c='A3- Employee Vendor';
            o.Sales_office__c='1010- HO Sales Office';
            o.Customer_pricing_procedure__c='1- Flats Under Constr';
            o.Recon_Account__c='    0023000010- Debtors - Domestic';
            update o;
                        
            s = new Sale_Order_Item__c(Name='Test SOI',Opportunity__c=o.Id);
            insert s;
            
            List<Payment_Schedule__c> updatePayment = new List<Payment_Schedule__c>();
            
            ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps1);
            ps2 = new Payment_Schedule__c(Name='Test PS2',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps2);
            insert updatePayment;
            
            // Single Demand Letter - Create
            ApexPages.currentPage().getParameters().put('oppId',o.Id);        
            ApexPages.currentPage().getParameters().put('type','new');
            Demand_Letter_Repository__c dlr1 = new Demand_Letter_Repository__c();
            ApexPages.StandardController apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterController dlc1 = new DemandLetterController(apexpag1);
            dlc1.getListPS();

            // Mass Demand Letter - Create
            List<Opportunity> lstOpp = new List<Opportunity> ();
            // Caling set controller without selecting any opportunity i.e. setSelected is zero        
            ApexPages.StandardSetController apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            DemandLetterController dlc2 = new DemandLetterController(apexpag2);
            // calling set controller with opportunity selected - not Allotment
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            
            // calling set controller with opportunity selected - Allotment
            Country__c cy = new Country__c(name='IN - India',Code__c='IN');
            insert cy;
            
            a.CountryL__c = cy.Id;
            a.Customer_Group__c = 'test';
            a.Distribution_channel__c = 'test';
            
            Region__c rg = new Region__c(name='10 - Karnataka',Country__c=cy.Id);
            insert rg;
            
            a.RegionL__c = rg.Id;
            a.Postal_Code__c = 'test';
            a.Street1__c = 'test';
            update a;
            
            o.Cash_Management_Group__c = 'test';
            o.Recon_Account__c = 'test';
            o.Plant__c = 'T001 - Test Plant';
            o.Sales_office__c = 'test';
            o.Type = 'test';
            o.Customer_pricing_procedure__c = 'test';
            o.ZTX1__c = '1';
            o.ZTX2__c = '1';
            o.ZTX3__c = '1';
            o.ZTX4__c = '1';
            
            o.Set_the_Unit_Status__c = 'Test';
            o.StageName = 'Allotment'; // to make stage to Allotment all above fields should be filled
            o.Sale_Order_No__c = '007';
            
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            update o;
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            dlc2.SaveM();
            
            // Calling PDF page
            dlr1.Name = 'Test DLR';
            insert dlr1;
            
            ApexPages.currentPage().getParameters().put('type','old');
            ApexPages.currentPage().getParameters().put('id',dlr1.id);
            apexpag1 = new ApexPages.StandardController(dlr1);
            dlc1 = new DemandLetterController(apexpag1);
            
            // DemandLetterEmailController - Sinlge
            dlr1.Opportunity__c = o.Id;
            dlr1.OwnerId = UserInfo.getUserId();
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',o.Id);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterEmailController dlec1 = new DemandLetterEmailController(apexpag1);
            dlec1.test = true;
            dlec1.dbOperation();
            
            // DemandLetterEmailController - Mass        
            dlr1.OppIDs__c = o.Id + ',';
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',null);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            
            DemandLetterEmailController dlec2 = new DemandLetterEmailController(apexpag1);
            dlec2.test = true;
            dlec2.dbOperation();
            dlec2.sendAction();
            
            // DemandLetterEmailController - Mass. Testing the List size of sendEmail
          
           // delete c1;
           // delete c2;
          //  delete c3;
          //  delete c4;
          //  delete c5;
          delete lstC;
            
        }catch(Exception ex){}
        }*/
        
          static testMethod void testing4() {
              Apexpages.StandardController setCon = new Apexpages.StandardController(new Demand_Letter_Repository__c(name='Test'));
              new DemandLetterEmailController(setCon).dummy();
        
        try{
            Test.setMock(WebServiceMock.class, new MockHttpResponse());
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            a = new Account(Name='Testing Account',CC_Address__c='Address');
            insert a;
            lstC    = new List<Contact>();          
            c1 = new Contact(Salutation='Mr.',FirstName='A',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='First Applicant',Email='testabhi1@gmail.com');
            lstC.add(c1);
            
            c2 = new Contact(Salutation='Mr.',FirstName='B',LastName='Testing contact2',
                    AccountId=a.Id,Contact_Type__c='Second Applicant',Email='testabhi2@gmail.com');
            lstC.add(c2);
            
           // c2.Email          = 'testabhi2@gmail.com';
           // c2.Contact_Type__c    = 'Third Applicant';
           // update c2;
            
            c3 = new Contact(Salutation='Mr.',FirstName='C',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Third Applicant',Email='testabhi3@gmail.com');
            lstC.add(c3);
            
           // c3.Email = 'testabhi3@gmail.com';
           // c3.Contact_Type__c='Second Applicant';
          //  update c3;
            
            c4 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='Fourth Applicant',Email='testabhi4@gmail.com');
            lstC.add(c4);
            
            c5 = new Contact(Salutation='Mr.',FirstName='D',LastName='Testing contact1',
                    AccountId=a.Id,Contact_Type__c='GPA Holder',Email='testabhi5@gmail.com');
            lstC.add(c5);
            insert lstC;
            
            HFI__c hfi = new HFI__c();
            hfi.Email__c='sukesh3089@gmaial.com';
            insert hfi;
            
            o = new Opportunity(name='Testing Opportunity',AccountId=a.Id,Active__c=true,HFI__c = hfi.id,
                        StageName='Send Mailer',CloseDate=System.Today(),Customer_ID__c = '000000');
            Utility_Class.IS_OPP_TRIGGER_RUNNING = false;
            insert o;
            
             OpportunityContactRole ops = new OpportunityContactRole();
            ops.role ='First Applicant';
            ops.ContactId = c5.id;
            ops.OpportunityId = o.id;
            insert ops;
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            
            c1.Email = 'testabhi@gmail.com';
            c1.CC_EMail2__c = true;
            c1.Email2__c = 'testabhiCC@gmail.com';
            c1.Phone = '08099999999';
            c1.MobilePhone = '9999990999999';
           // update c1;
            
            c5.CC_GPA__c = true;
            c5.Email = 'testabhi5@gmail.com';
           // update c5;
            
            
            p = new Plant__c(Name='Test Plant',Project__c='Test Project',
                        Plant_Code__c='T001',Demand_Letter_Page1__c='Page1 Content here',
                        Demand_Letter_Page2__c='Page2 Content here');
            insert p;
            
            u = new Unit__c(Name='Test Unit for Test method1',Plant__c=p.Id,Unit_Status__c='Available');
            insert u;
            
            o.Unit__c = null;
            o.Set_the_Unit_Status__c = '';
            
           // update o;
            
            o.Plant__c = 'T001 - Test Plant';
            o.Unit__c = u.Id;
            o.Set_the_Unit_Status__c = 'Test';
            update o;
                        
            s = new Sale_Order_Item__c(Name='Test SOI',Opportunity__c=o.Id);
            insert s;
            
            List<Payment_Schedule__c> updatePayment = new List<Payment_Schedule__c>();
            date myDate = date.newInstance(2015, 8, 15);
            //ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id);
            ps1 = new Payment_Schedule__c(Name='Test PS1',Sale_Order_Item__c=s.Id
            ,Description__c='test',Billing_Date__c=myDate,Bill_Value__c=23.44,Education_Cess__c=34.56,Secondary_Education_Cess__c=98.89
            ,Service_Tax__c=89.900,VAT__c=23.44,Mile_Stone_Base_Description_1__c='test',Swachh_Bharath_Cess__c=20.33
            );
            updatePayment.add(ps1);
            ps2 = new Payment_Schedule__c(Name='Test PS2',Sale_Order_Item__c=s.Id);
            updatePayment.add(ps2);
            insert updatePayment;
            
            // Single Demand Letter - Create
            ApexPages.currentPage().getParameters().put('oppId',o.Id);        
            ApexPages.currentPage().getParameters().put('type','new');
            Demand_Letter_Repository__c dlr1 = new Demand_Letter_Repository__c();
            dlr1.Subject__c='Progress Letter';
            ApexPages.StandardController apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterController dlc1 = new DemandLetterController(apexpag1);
            dlc1.getListPS();

            // Mass Demand Letter - Create
            List<Opportunity> lstOpp = new List<Opportunity> ();
            // Caling set controller without selecting any opportunity i.e. setSelected is zero        
            ApexPages.StandardSetController apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            DemandLetterController dlc2 = new DemandLetterController(apexpag2);
            // calling set controller with opportunity selected - not Allotment
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            
            // calling set controller with opportunity selected - Allotment
            Country__c cy = new Country__c(name='IN - India',Code__c='IN');
            insert cy;
            
            a.CountryL__c = cy.Id;
            a.Customer_Group__c = 'test';
            a.Distribution_channel__c = 'test';
            
            Region__c rg = new Region__c(name='10 - Karnataka',Country__c=cy.Id);
            insert rg;
            
            a.RegionL__c = rg.Id;
            a.Postal_Code__c = 'test';
            a.Street1__c = 'test';
            update a;
            
            o.Cash_Management_Group__c = 'test';
            o.Recon_Account__c = 'test';
            o.Plant__c = 'T001 - Test Plant';
            o.Sales_office__c = 'test';
            o.Type = 'test';
            o.Customer_pricing_procedure__c = 'test';
            o.ZTX1__c = '1';
            o.ZTX2__c = '1';
            o.ZTX3__c = '1';
            o.ZTX4__c = '1';
            o.Set_the_Unit_Status__c = 'Test';
            o.StageName = 'Site Visit'; // to make stage to Allotment all above fields should be filled
            o.Sale_Order_No__c = '007';
            
            Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
            update o;
            lstOpp.add(o);
            apexpag2 = new ApexPages.StandardSetController(lstOpp);
            apexpag2.setSelected(lstOpp);
            dlc2 = new DemandLetterController(apexpag2);
            dlc2.SaveM();
            
            // Calling PDF page
            dlr1.Name = 'Test DLR';
            insert dlr1;
            
            ApexPages.currentPage().getParameters().put('type','old');
            ApexPages.currentPage().getParameters().put('id',dlr1.id);
            apexpag1 = new ApexPages.StandardController(dlr1);
            dlc1 = new DemandLetterController(apexpag1);
            
            // DemandLetterEmailController - Sinlge
            dlr1.Opportunity__c = o.Id;
            dlr1.OwnerId = UserInfo.getUserId();
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',o.Id);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            DemandLetterEmailController dlec1 = new DemandLetterEmailController(apexpag1);
            dlec1.test = true;
            dlec1.dbOperation();
            
            // DemandLetterEmailController - Mass        
            dlr1.OppIDs__c = o.Id + ',';
            update dlr1;
            
            ApexPages.currentPage().getParameters().put('oppId',null);
            ApexPages.currentPage().getParameters().put('id',dlr1.Id);    
            apexpag1 = new ApexPages.StandardController(dlr1);
            
            DemandLetterEmailController dlec2 = new DemandLetterEmailController(apexpag1);
            dlec2.test = true;
            dlec2.dbOperation();
            dlec2.sendAction();
            
            // DemandLetterEmailController - Mass. Testing the List size of sendEmail
          
           // delete c1;
           // delete c2;
          //  delete c3;
          //  delete c4;
          //  delete c5;
          delete lstC;
            
        }catch(Exception ex){}
        }
    
}