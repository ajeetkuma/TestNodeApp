@isTest(SeeAllData =false)

  private class testsendsmsBillingdate714210trigger{
  
     static testMethod void  sendsmsBillingdate7() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';              
            opp.PDC_details__c='NO';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
                   
            //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c=false;
            ps.Bill_Value__c =decimal.valueof('120344');
            ps.Service_Tax__c =decimal.valueof('12');
            ps.VAT__c =decimal.valueof('12');
            ps.Education_Cess__c =decimal.valueof('12');
            ps.Secondary_Education_Cess__c=decimal.valueof('123');
            ps.X7_days_sms__c=false;
            // ps.X14_days_sms__c=false;
            //   ps.X21_Days_sms__c=false;
            // ps.X5_days_sms__c=false;
            //  ps.On_the_day_sms__c=false;
            ps.Billing_Date__c=System.now().date();
            insert ps;    
            
             smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='7 days after billing date';           
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;
            
            ps.X7_days_sms__c=true;
            //    ps.X14_days_sms__c=true;
            //  ps.X21_Days_sms__c=true;
            //  ps.X5_days_sms__c=true;
            ps.On_the_day_sms__c=true;
            update ps;              
           
     
     
     }
     
     
     
     static testMethod void  sendsmsBillingdate14() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';              
            opp.PDC_details__c='NO';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
                   
            //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c=false;
            ps.Bill_Value__c =decimal.valueof('120344');
            ps.Service_Tax__c =decimal.valueof('12');
            ps.VAT__c =decimal.valueof('12');
            ps.Education_Cess__c =decimal.valueof('12');
            ps.Secondary_Education_Cess__c=decimal.valueof('123');
            // ps.X7_days_sms__c=false;
            ps.X14_days_sms__c=false;
            //   ps.X21_Days_sms__c=false;
            // ps.X5_days_sms__c=false;
            //  ps.On_the_day_sms__c=false;
            ps.Billing_Date__c=System.now().date();
            insert ps;
            
             smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='14 days after billing date';        
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;
                
            
           // ps.X7_days_sms__c=true;
           ps.X14_days_sms__c=true;
           //  ps.X21_Days_sms__c=true;
           //  ps.X5_days_sms__c=true;
            ps.On_the_day_sms__c=true;
            update ps;  
            
           
            
            
            
            
           
     
     
     }
     
    
     static testMethod void  sendsmsBillingdate5() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';              
            opp.PDC_details__c='NO';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
                   
            //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c =false;
            ps.Bill_Value__c =decimal.valueof('120344');
            ps.Service_Tax__c =decimal.valueof('12');
            ps.VAT__c =decimal.valueof('12');
            ps.Education_Cess__c =decimal.valueof('12');
            ps.Secondary_Education_Cess__c=decimal.valueof('123');
            // ps.X7_days_sms__c=false;
            // ps.X14_days_sms__c=false;
            //   ps.X21_Days_sms__c=false;
            //   ps.X5_days_sms__c=false;
            //ps.SendSms__c =true;
            ps.Billing_Date__c=System.now().date();
            insert ps;    
            
          /*  smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='5 days before billing date';     
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;
            */
            
           // ps.X7_days_sms__c=true;
           //    ps.X14_days_sms__c=true;
           //  ps.X21_Days_sms__c=true;
          //  ps.X5_days_sms__c=true;
           // ps.On_the_day_sms__c=true;
           ps.SendSms__c =true;
            update ps;  
            
     
     
     }
    
     
      static testMethod void  sendsmsBillingdate0() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';              
            opp.PDC_details__c='NO';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
                   
            //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c=false;
            ps.Bill_Value__c =decimal.valueof('120344');
            ps.Service_Tax__c =decimal.valueof('12');
            ps.VAT__c =decimal.valueof('12');
            ps.Education_Cess__c =decimal.valueof('12');
            ps.Secondary_Education_Cess__c=decimal.valueof('123');
            // ps.X7_days_sms__c=false;
            // ps.X14_days_sms__c=false;
            //   ps.X21_Days_sms__c=false;
            // ps.X5_days_sms__c=false;
              ps.On_the_day_sms__c=false;
            ps.Billing_Date__c=System.now().date();
            insert ps;    
            
            
             smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='Same day on billing date';    
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;
            
            
            // ps.X7_days_sms__c=true;
            // ps.X14_days_sms__c=true;
            //  ps.X21_Days_sms__c=true;
            // ps.X5_days_sms__c=true;
            ps.On_the_day_sms__c=true;
            update ps;              
            
           
     
     
     }
     
     static testMethod void  sendsmsBillingdateYes() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';              
            opp.PDC_details__c='YES';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
            
             //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test11';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c=false;
            ps.Bill_Value__c =decimal.valueof('120344');
            ps.Service_Tax__c =decimal.valueof('12');
            ps.VAT__c =decimal.valueof('12');
            ps.Education_Cess__c =decimal.valueof('12');
            ps.Secondary_Education_Cess__c=decimal.valueof('123');
            // ps.X7_days_sms__c=false;
            // ps.X14_days_sms__c=false;
            ps.X21_Days_sms__c=false;
            // ps.X5_days_sms__c=false;
            //  ps.On_the_day_sms__c=false;
            ps.Billing_Date__c=System.now().date();
            insert ps;  
            
             smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c='21 days after billing date YES';   
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;  
            
            
            
           // ps.X7_days_sms__c=true;
           //    ps.X14_days_sms__c=true;
            ps.X21_Days_sms__c=true;
           //  ps.X5_days_sms__c=true;
           // ps.On_the_day_sms__c=true;
            update ps;  
            
           
     
     
     }
     
     
     static testMethod void  sendsmsBillingdateNO() { 
     
            //Account Information
            account acc=new account();
            acc.name='Mehulkumar Navinchandra';
            acc.House_number__c='2-128';
            acc.Street1__c='1stline';
            acc.Street2__c='Near';
            acc.Street3__c='2ndline';
            acc.Postal_Code__c='123123';
            acc.City__c='Ban';
            acc.Primary_Contact_s_Name__c='test';
            insert acc;  
                                  
            //Contact Information                
            contact con=new contact();
            con.lastname='Mehulkumar NavinchandraPancholi';
            con.email='deve@extentor.com';
            con.accountid=acc.Id;
            con.Contact_Type__c='First Applicant';
            con.accountId=acc.Id;
            insert con;            
            
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Discussion';
            opp.CloseDate=System.now().date();   
            opp.plant__c='Cosmopolis';  
           // opp.PDC_details__c='YES';  
            opp.PDC_details__c='NO';     
            insert opp;
            
            //Profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            
            //User Information
            User u = new User(Alias = 'standt', Email='Developer@extentor.com',
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            insert u;   
     
            //Bgprofile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.CPprofile_HouseNumber__c='2128';
            bgprofile.CPprofile_Street1__c='1stline';
            bgprofile.CPprofile_Street2__c='backline';
            bgprofile.CPprofile_Street3__c='backline';
            bgprofile.CPprofile_BillingPostcode__c='123123';
            bgprofile.Contact__c=con.id;
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_BillingCity__c='ban';
            insert bgprofile; 
            
            //Plant Information
            Plant__c pl1=new Plant__c();
            pl1.Name='Meadows';  
            pl1.Admin_Email__c='deve@fmail.com';
            pl1.Project__c='cosmolis';  
            insert pl1;            
           
            //CpProperity Information
            CP_Property__c cpproperity1=new CP_Property__c ();
            cpproperity1.name='test';
            cpproperity1.Plant__c=pl1.id;
            cpproperity1.Contact_User_Id__c=userinfo.getuserid();
            cpproperity1.Unit_Code__c='123-1231-qw';
            cpproperity1.Project_Name__c ='bridage';
           // cpproperity.Project_Unit_No__c='1-2-3';
            cpproperity1.Active__c=true;
            cpproperity1.Opportunity_Id__c=opp.id;
            Insert cpproperity1; 
            
            
            //Salesorder Items
            Sale_Order_Item__c csoredr=new  Sale_Order_Item__c(); 
            csoredr.Opportunity__c=opp.id;          
            csoredr.Name='test';
            insert csoredr;
            
                   
            //Payment Schedlue Information
            Payment_Schedule__c ps=new Payment_Schedule__c ();
            ps.Name='test';
            ps.Opportunity__c=opp.id;
            ps.Sale_Order_Item__c=csoredr.id;
            ps.SendSms__c=false;
           // ps.X7_days_sms__c=false;
           // ps.X14_days_sms__c=false;
            ps.X21_Days_sms__c=false;
            //  ps.X5_days_sms__c=false;
            ps.On_the_day_sms__c=false;
            ps.Billing_Date__c=System.now().date();
            insert ps;    
            
            smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =u.MobilePhone ;
             smsObject.smagicinteract__Name__c = ps.Name; 
             smsObject.smagicinteract__ObjectType__c = 'Payment_Schedule__c '; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             
            smagicinteract__SMS_Template__c smagic = new smagicinteract__SMS_Template__c();
            smagic.smagicinteract__Name__c=' 21 days after billing date NO';
            smagic.smagicinteract__Text__c='Sample sms testing7';
            insert smagic;   
                        
            //  ps.X7_days_sms__c=true;
            //  ps.X14_days_sms__c=true;
            ps.X21_Days_sms__c=true;
            //   ps.X5_days_sms__c=true;
            //   ps.On_the_day_sms__c=true;
            update ps;            
          
            
                  
           
     
     
     }
     
     
   }