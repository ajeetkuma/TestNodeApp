@isTest(seealldata=true)
private class MyDocumentsUpdateCOntrollerTest {
    static testMethod void myDocumentTest(){
            
            account a=new account();
            a.name='Ext Account';
            insert a;  
                
            //create contact records
            contact c=new contact();
            c.lastname='test';
            c.Contact_Type__c='Fisrt Applicant';
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
            
            // create property record
            CP_Property__c cp=new CP_Property__c();
            cp.Contact_User_Id__c=u.Id;
            cp.Plant__c=pl.name;
            cp.Unit_Code__c =unit.name;
            cp.Project_Name__c = 'Brigade Meadows';
            insert cp;
                        
            BG_CPprofile__c bg=new BG_CPprofile__c();
            bg.Name='test';
            bg.Portal_Username__c=u.UserName;
            bg.Portal_UserMobile__c=u.MobilePhone;
            bg.Contact__c=c.Id;
            bg.user__c=u.Id;
            insert bg; 
            system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+bg);           
                        
            //create project doc records
            List<Project_Docs__c> pdocs = new List<Project_Docs__c>();
            Project_Docs__c pdoc = new Project_Docs__c();
            pdoc.Contact__c  = c.Id;
            pdoc.Contact_type__c = 'First Applicant';
            pdoc.CP_Property__c = cp.Id;
            pdocs.add(pdoc);
            

            Project_Docs__c pdoc1 = new Project_Docs__c();
            pdoc1.Contact__c  = c1.Id;
            pdoc1.Contact_type__c = 'Second Applicant';
            pdoc1.CP_Property__c = cp.Id;
            pdocs.add(pdoc1);
            
            Project_Docs__c pdoc2 = new Project_Docs__c();
            pdoc2.Contact__c  = c2.Id;
            pdoc2.Contact_type__c = 'Third Applicant';
            pdoc2.CP_Property__c = cp.Id;
            pdocs.add(pdoc2);
            
            Project_Docs__c pdoc3 = new Project_Docs__c();
            pdoc3.Contact__c  = c3.Id;
            pdoc3.Contact_type__c = 'Fourth Applicant';
            pdoc3.CP_Property__c = cp.Id;
            pdocs.add(pdoc3);
            
            insert pdocs;
            
            List<Attachment> attachs = new List<Attachment>();
            for(Project_Docs__c pdo:pdocs){
                Attachment attach1=new Attachment();     
                attach1.Name='Unit Test Attachment.pdf';
                Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
                attach1.body=bodyBlob;
                attach1.parentId=pdo.id;
                attachs.add(attach1);
            }
            insert attachs;
            
            /*smagicinteract__SMS_Template__c tpltext = new smagicinteract__SMS_Template__c();
            tpltext.smagicinteract__Text__c='test'; 
            tpltext.smagicinteract__Name__c='Accept Documents';            
            insert tpltext;
            
            smagicinteract__SMS_Template__c tpltext2 = new smagicinteract__SMS_Template__c();
            tpltext2.smagicinteract__Text__c='test'; 
            tpltext2.smagicinteract__Name__c='Reject Documents';            
            insert tpltext2;
            
            smagicinteract__smsMagic__c smsMagic= new smagicinteract__smsMagic__c();
            smsMagic.smagicinteract__SenderId__c='sms magic';
            smsMagic.smagicinteract__PhoneNumber__c=bg.Portal_UserMobile__c;
            smsMagic.smagicinteract__Name__c=bg.Portal_Username__c;
            smsMagic.smagicinteract__ObjectType__c='BG_CPprofile__c';
            smsMagic.smagicinteract__disableSMSOnTrigger__c=0;
            smsMagic.smagicinteract__external_field__c='test12343';
            smsMagic.smagicinteract__SMSText__c='test';
            insert smsMagic;*/
            
             
            
            //Wrapper class declaration 
            
            
            // start test 
            Test.startTest();
               
                    ApexPages.currentPage().getParameters().put('ID',u.id);
                    ApexPages.currentPage().getParameters().put('Unitname',cp.Unit_Code__c);
                    MyDocumentsUpdateCOntroller myDoc=new MyDocumentsUpdateCOntroller();
                    mydoc.docsSectionListFirst[0].selected = true;
                    mydoc.docsSectionListSecond[0].selected = true;
                   // MyDocumentsUpdateCOntroller.docsSection doc=new MyDocumentsUpdateCOntroller.docsSection(pdoc1);
                    
                  //  doc.selected=false;
                    //mydoc.docsSectionListFirst.add(doc);
                    
                    myDoc.acceptDocuments();
                    
                    mydoc.docsSectionListFirst[0].selected = false;
                    mydoc.docsSectionListSecond[0].selected = false;
                    myDoc.acceptDocuments();
                    
                    mydoc.docsSectionListThird[0].selected = true;
                    mydoc.docsSectionListFourth[0].selected = true;
                    myDoc.acceptDocuments();
                    
                    mydoc.docsSectionListFirst[0].selected = false;
                   
                    myDoc.rejectDocuments();
                    
                    mydoc.docsSectionListFirst[0].selected = true;
                    mydoc.docsSectionListFirst[0].pdoc.Reason_for_Reject__c='test';
                    myDoc.rejectDocuments();  
                      
                    mydoc.docsSectionListThird[0].selected = true;
                    mydoc.docsSectionListFourth[0].selected = true;
                    myDoc.rejectDocuments();    
            Test.stopTest();
         
    }
}