//test class for my document page
@isTest(seeAllData=false)
private class MyDocumentTestClass {
    static testMethod void myDocumentTest(){
        
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        /* EmailTemplate emailtemp=new EmailTemplate ();
emailtemp.Name ='Update document email';
emailtemp.DeveloperName='Update_document_email_test';
emailtemp.FolderId=fol.Id;
emailtemp.TemplateType='Custom';
insert emailtemp; */
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com';
        //p1.Plant_Code__c = 'bm';
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=true;
        opp.Handover_Feed_back_form__c=true ;
        opp.Execution_without_modification_Feed_back__c=true ;
        opp.Execution_with_Modification_Feed_back_fo__c=true ;
        opp.Booking_CSAT_Feed_back_form__c=true;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp;
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        //cp.Plant__c=p1.Plant_Code__c+' - '+ p1.Name;
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        cp.Opportunity_Id__c=opp.id;
        insert cp;
        
        //create project doc records
        Project_Docs__c pdoc = new Project_Docs__c();
        pdoc.Contact__c  = c.Id;
        pdoc.Contact_type__c = 'First Applicant';
        pdoc.CP_Property__c = cp.Id;
        insert pdoc;
        /*
//create project doc records
Project_Docs__c pdoc1 = new Project_Docs__c();
pdoc1.Contact__c  = c.Id;
pdoc1.Contact_type__c = 'Second Applicant';
pdoc1.CP_Property__c = cp.Id;
insert pdoc1;
*/
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                mydoc.docsSectionListFirst=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFirst.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
        
    }
    static testMethod void myDocumentTest2(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Second Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListSecond=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListSecond.add(docs);
               // mydoc.plants = new list<Plant__c>();
               // mydoc.plants.add(pl);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();

            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest3(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Third Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListThird=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListThird.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest4(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        contact c3=new contact();
        c3.lastname='test';
        c3.Contact_Type__c='Fourth Applicant';
        c3.email='Developer@gmail.com';
        c3.accountid=a.id;
        insert c3;      
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c3.Id;
        pdoc1.Contact_type__c = 'Fourth Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListFourth=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFourth.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    //------------------------------------------------
    
    static testMethod void myDocumentTest5(){
        
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        /* EmailTemplate emailtemp=new EmailTemplate ();
emailtemp.Name ='Update document email';
emailtemp.DeveloperName='Update_document_email_test';
emailtemp.FolderId=fol.Id;
emailtemp.TemplateType='Custom';
insert emailtemp; */
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com';
        //p1.Plant_Code__c = 'bm';
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=true;
        opp.Handover_Feed_back_form__c=true ;
        opp.Execution_without_modification_Feed_back__c=true ;
        opp.Execution_with_Modification_Feed_back_fo__c=true ;
        opp.Booking_CSAT_Feed_back_form__c=true;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp;
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        //cp.Plant__c=p1.Plant_Code__c+' - '+ p1.Name;
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        cp.Opportunity_Id__c=opp.id;
        insert cp;
        
        //create project doc records
        Project_Docs__c pdoc = new Project_Docs__c();
        pdoc.Contact__c  = c.Id;
        pdoc.Contact_type__c = 'First Applicant';
        pdoc.CP_Property__c = cp.Id;
        insert pdoc;
        /*
//create project doc records
Project_Docs__c pdoc1 = new Project_Docs__c();
pdoc1.Contact__c  = c.Id;
pdoc1.Contact_type__c = 'Second Applicant';
pdoc1.CP_Property__c = cp.Id;
insert pdoc1;
*/
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                mydoc.docsSectionListFirst=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFirst.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
        
    }
    static testMethod void myDocumentTest6(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Second Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListSecond=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListSecond.add(docs);
               // mydoc.plants = new list<Plant__c>();
               // mydoc.plants.add(pl);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();

            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest7(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Third Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListThird=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListThird.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest8(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        contact c3=new contact();
        c3.lastname='test';
        c3.Contact_Type__c='Fourth Applicant';
        c3.email='Developer@gmail.com';
        c3.accountid=a.id;
        insert c3;      
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c3.Id;
        pdoc1.Contact_type__c = 'Fourth Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListFourth=new List<MyDocumentsCOntroller.docsSection>();
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFourth.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    //=======================
    static testMethod void myDocumentTest9(){
        
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        /* EmailTemplate emailtemp=new EmailTemplate ();
emailtemp.Name ='Update document email';
emailtemp.DeveloperName='Update_document_email_test';
emailtemp.FolderId=fol.Id;
emailtemp.TemplateType='Custom';
insert emailtemp; */
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com';
        //p1.Plant_Code__c = 'bm';
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=true;
        opp.Handover_Feed_back_form__c=true ;
        opp.Execution_without_modification_Feed_back__c=true ;
        opp.Execution_with_Modification_Feed_back_fo__c=true ;
        opp.Booking_CSAT_Feed_back_form__c=true;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp;
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        //cp.Plant__c=p1.Plant_Code__c+' - '+ p1.Name;
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        cp.Opportunity_Id__c=opp.id;
        insert cp;
        
        //create project doc records
        Project_Docs__c pdoc = new Project_Docs__c();
        pdoc.Contact__c  = c.Id;
        pdoc.Contact_type__c = 'First Applicant';
        pdoc.CP_Property__c = cp.Id;
        insert pdoc;
        /*
//create project doc records
Project_Docs__c pdoc1 = new Project_Docs__c();
pdoc1.Contact__c  = c.Id;
pdoc1.Contact_type__c = 'Second Applicant';
pdoc1.CP_Property__c = cp.Id;
insert pdoc1;
*/
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                mydoc.docsSectionListFirst=new List<MyDocumentsCOntroller.docsSection>();
                pdoc=null;
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFirst.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
        
    }
    static testMethod void myDocumentTest10(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Second Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListSecond=new List<MyDocumentsCOntroller.docsSection>();
                pdoc1=null;
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListSecond.add(docs);
               // mydoc.plants = new list<Plant__c>();
               // mydoc.plants.add(pl);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();

            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest11(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c1.Id;
        pdoc1.Contact_type__c = 'Third Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListThird=new List<MyDocumentsCOntroller.docsSection>();
                pdoc1=null;
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListThird.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    static testMethod void myDocumentTest12(){
        //variable declaration
        //Blob Attach;
        
        //create Account record
        Folder fol=[Select Id From Folder Where Name=:'Brigade Email Templates'];
        
        
        EmailTemplate emailtemp=[Select Id, Name From EmailTemplate Where Name=:'Update document email'];
        
        account a=new account();
        a.name='Ext Account';
        insert a;  
        
        //create contact records
        contact c=new contact();
        c.lastname='test';
        c.Contact_Type__c='First Applicant';
        c.email='Developer@gmail.com';
        c.accountid=a.id;
        insert c;
        
        contact c1=new contact();
        c1.lastname='test';
        c1.Contact_Type__c='Second Applicant';
        c1.email='Developer@gmail.com';
        c1.accountid=a.id;
        insert c1;  
        
        contact c2=new contact();
        c2.lastname='test';
        c2.Contact_Type__c='Third Applicant';
        c2.email='Developer@gmail.com';
        c2.accountid=a.id;
        insert c2;
        
        contact c3=new contact();
        c3.lastname='test';
        c3.Contact_Type__c='Fourth Applicant';
        c3.email='Developer@gmail.com';
        c3.accountid=a.id;
        insert c3;      
        
        //create user record
        Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];        
        User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                          TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
        insert u;
        
        //create plant record 
        Plant__c pl=new Plant__c();
        pl.Name='MeadowsExt';   
        pl.Project__c='Brigade Meadows'; 
        pl.Admin_Email__c = 'developer@extentor.com'; 
        insert pl;  
        
        //create unit code
        Unit__c unit = new Unit__c();
        unit.name = 'BG-MED-B-X-0701-XXXX';
        unit.Plant__c = pl.Id;
        insert unit;
        opportunity opp=new opportunity ();
        opp.name='test';
        opp.AccountId=a.id; 
        opp.StageName='Handed Over';
        opp.CloseDate=System.now().date();
        opp.Reserving_Date__c=System.now().date();
        opp.Unit__c=unit.Id;
        opp.X1st_year_Handover_Feedback__c=false;
        opp.Handover_Feed_back_form__c=false ;
        opp.Execution_without_modification_Feed_back__c=false ;
        opp.Execution_with_Modification_Feed_back_fo__c=false ;
        opp.Booking_CSAT_Feed_back_form__c=false;
        
        // opp.Project_Unit_No__c='Brigade Meadows-X-123456';
        insert opp; 
        
        
        // create property record
        CP_Property__c cp=new CP_Property__c();
        cp.Contact_User_Id__c=u.Id;
        cp.Plant__c='- MeadowsExt';
        cp.Unit_Code__c =unit.name;
        cp.Project_Name__c = 'Brigade Meadows';
        cp.active__c=true;
        insert cp;
        
        
        //create project doc records
        Project_Docs__c pdoc1 = new Project_Docs__c();
        pdoc1.Contact__c  = c3.Id;
        pdoc1.Contact_type__c = 'Fourth Applicant';
        pdoc1.CP_Property__c = cp.Id;
        insert pdoc1;
        
        Attachment attach1=new Attachment();     
        attach1.Name='Unit Test Attachment.pdf';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach1.body=bodyBlob;
        attach1.parentId=pdoc1.id;
        insert attach1;
        
        
        
        //Wrapper class declaration 
        try{
            
            // start test 
            Test.startTest();
            system.runAs(u){
                
                //Test.setCurrentPageReference(new PageReference('/apex/MyDocuments'));
                MyDocumentsCOntroller  mydoc = new MyDocumentsCOntroller();
                
                //mydoc.selectedValue='Brigade Meadows';
                //mydoc.selectedCode='Brigade Meadows BG-MED-B-X-0701';
                mydoc.getDocumentsList();
                
                //mydoc.docsSectionListFourth.add(doc);
                mydoc.docsSectionList[0].Attach = attach1;
                
                mydoc.docsSectionListFourth=new List<MyDocumentsCOntroller.docsSection>();
                pdoc1=null;
                MyDocumentsCOntroller.docsSection docs=new MyDocumentsCOntroller.docsSection (pdoc1);
                //docs.Attach.body =Blob.valueOf('Unit Test Document Body.pdf');
                docs.Attach=attach1;
                mydoc.docsSectionListFourth.add(docs);
                mydoc.uploadDocuments();
                
                mydoc.countryDetails();
                mydoc.getItems();
                mydoc.getCountries();
                mydoc.getReopenPopup();
                
            }
            
            Test.stopTest();
        }
        catch(Exception e){
        }
    }
    
    
}