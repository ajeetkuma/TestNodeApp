@isTest(SeeAllData=false)

public class testpropertyExt{

    public static testMethod void testpropertyExt(){
          //try{
          string unitnumber = 'BG-ALT-B-X-0114-XX';
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',//OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
            //try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
            /*}
            catch( Exception e)
            {
                
            }   */                 
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
           
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            Payment_Footer__c pf = new Payment_Footer__c(Name='test', Description__c='testttttt');
            insert pf;
            
            system.runas(u){
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.getItems();
            proExt.countryDetails();
            proExt.getCountries();
            proExt.getReopenPopup();
            proExt.getPDF();
            proExt.CancelPayment(); 
            Test.stopTest();
            
          }
         //}catch(Exception e){}
        }  
        
        
         public static testMethod void testpropertyExt1(){
          try{
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',OpportunityId__c=opp.id, 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
            }
            catch( Exception e)
            {
                
            }                      
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            system.runas(u){
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.getItems();
            proExt.countryDetails();
            proExt.getCountries();
            proExt.getReopenPopup();
            proExt.getPDF();
            proExt.CancelPayment(); 
            proExt.getPaymentList();
           
            Test.stopTest();
            
           }
           }catch(Exception e){}
        }   
        
        
        
        
        
          public static testMethod void testpropertyExt2(){
           try{
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
            }
            catch( Exception e)
            {
                
            }                      
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            CP_Sale_Order_Item__c cpSalesOrderItem =  new CP_Sale_Order_Item__c();
            cpSalesOrderItem.CP_Property__c = cpproperity.id;
            cpSalesOrderItem.Name = 'Testing';
            insert cpSalesOrderItem;
            
           
            
            CP_Payment_Schedule__c cpList = new CP_Payment_Schedule__c();
           
            cpList.Name ='Test';
            cpList.Payment_Status__c= 'C';
            cpList.Service_Tax__c =100;
            cpList.VAT__c =100;
            cpList.Education_Cess__c =100;
            cpList.Secondary_Education_Cess__c = 100;
            
            cpList.Bill_Value__c = 123;
            cpList.CP_Property__c = cpproperity.id;
            cpList.CP_Sale_Order_Item__c = cpSalesOrderItem.id;
            insert cpList;
                     
                              
            Boolean OnlysingleProject;
            system.runas(u){
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.selectedValue  = 'bridage';
            proExt.selectedCode   =  cpproperity.Project_Unit_No__c;
            proExt.getItems();
            proExt.countryDetails();
            proExt.getCountries();
            proExt.getReopenPopup();
            proExt.getPDF();
            proExt.CancelPayment(); 
            proExt.getPaymentList();
            OnlysingleProject=false;
             
           
            Test.stopTest();
            
           }
           }catch(Exception e){}
           
          
          }
          
          
           
            public static testMethod void testpropertyExt3(){
           //try{
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           //try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
           /* }
            catch( Exception e)
            {
                
            }   */                   
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            CP_Sale_Order_Item__c cpSalesOrderItem =  new CP_Sale_Order_Item__c();
            cpSalesOrderItem.CP_Property__c = cpproperity.id;
            cpSalesOrderItem.Name = 'Testing';
            insert cpSalesOrderItem;
            
           
            
            CP_Payment_Schedule__c cpList = new CP_Payment_Schedule__c();
           
            cpList.Name ='Test';
            cpList.Payment_Status__c= 'A';
            cpList.Service_Tax__c =100;
            cpList.VAT__c =100;
            cpList.Education_Cess__c =100;
            cpList.Secondary_Education_Cess__c = 100;
            
            cpList.Bill_Value__c = 123;
            cpList.CP_Property__c = cpproperity.id;
            cpList.CP_Sale_Order_Item__c = cpSalesOrderItem.id;
            insert cpList;
                     
                              
            Boolean OnlysingleProject;
            system.runas(u){
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.selectedValue  = 'bridage';
            proExt.selectedCode   =  [select Project_Unit_No__c from CP_Property__c where  id=: cpproperity.Id].Project_Unit_No__c;
            proExt.getItems();
            proExt.countryDetails();
            proExt.getCountries();
            proExt.getReopenPopup();
            proExt.getPDF();
            proExt.CancelPayment(); 
            proExt.getPaymentList();
            cpList.Payment_Status__c= 'Received';
            update cpList;
            proExt.getPaymentList();
            OnlysingleProject=false;
             
           
            Test.stopTest();
            }
           //}catch(Exception e){}
 
           }     
           
             public static testMethod void testpropertyExt4(){
             try{
        
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid='',
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
            }
            catch( Exception e)
            {
                
            }                      
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.Id;
            insert uc; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+uc);
            
            CP_Sale_Order_Item__c cpSalesOrderItem =  new CP_Sale_Order_Item__c();
            cpSalesOrderItem.CP_Property__c = cpproperity.id;
            cpSalesOrderItem.Name = 'Testing';
            insert cpSalesOrderItem;
            
           
            
            CP_Payment_Schedule__c cpList = new CP_Payment_Schedule__c();
           
            cpList.Name ='Test';
            cpList.Payment_Status__c= 'A';
            cpList.Service_Tax__c =100;
            cpList.VAT__c =100;
            cpList.Education_Cess__c =100;
            cpList.Secondary_Education_Cess__c = 100;
            
            cpList.Bill_Value__c = 123;
            cpList.CP_Property__c = cpproperity.id;
            cpList.CP_Sale_Order_Item__c = cpSalesOrderItem.id;
            insert cpList;
                     
                              
            Boolean OnlysingleProject;
            system.runas(u){
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.getItems();
            proExt.countryDetails();
            proExt.getCountries();
            proExt.getReopenPopup();
            proExt.getPDF();
            proExt.CancelPayment(); 
            proExt.getPaymentList();
            OnlysingleProject=false;
             
           
            Test.stopTest();
            }
 
           }
           catch(Exception e){} 
      }
      
       public static testMethod void testpropertyExt5(){
            
           account a=new account();
           a.name='Subas Mallick';
           insert a; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+a);
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='SiteVisit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
           // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
            insert opp; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+opp);
            //Contact Information                
            contact c=new contact();
            c.lastname='Mehulkumar NavinchandraPancholi';
            c.Contact_Type__c='First Applicant';
            c.email='developer@extentor.com';
            c.accountid=a.id;
            insert c; 
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+c);           
        
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];
          
            User u = new User(Alias = 'standt', Email='Developer@extentor.com', 
                                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                                TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
           try{
            insert u;                    
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);
            }
            catch( Exception e)
            {
                
            }                      
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+u);                    
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='Cosmopolis';
            pl.Allowed_portal_access__c=true;
            insert pl;
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+pl);   
            
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=u.id;
            cpproperity.Unit_Code__c='BG-ALT-B-X-0114-XX';
            cpproperity.Project_Name__c='bridage';
            cpproperity.Opportunity_Id__c=opp.id;
            cpproperity.Active__c=true;
            Insert cpproperity;  
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@'+cpproperity); 
            Test.startTest();
            propertyExt proExt = new propertyExt();
            proExt.countryDetails();
           
            Test.stopTest();
            }
            
           
            }