@isTest(SeeAllData =true)

//Test class
    private class testUpdatepage{
    //Test method    
        public static testmethod void testUpdatepagemethod(){        
        //Profile Information                
                  
            //Account Information
            account a=new account();
            a.name='testfor';
            a.House_number__c ='2-128';
            a.Street1__c      ='LastLine';
            a.Street2__c      ='Postoffice';
            a.Street3__c      ='Nextone';
            a.Postal_Code__c  ='123456';
            a.City__c         ='bangalore';  
            a.CC_Address__c   ='wernext';      
            insert a;  
            
            //Contact Information                
            contact c=new contact();
            c.lastname='test';
            c.Contact_Type__c='FisrtApplicant';
            c.Email ='Developer@gmail.com';
            c.accountid=a.id;
            c.MobilePhone='8884937365';
            c.Company__c='extenotr';
            c.Educational_Qualification__c ='bbm';
            c.Designation__c ='se';
            c.Profession__c ='job';
            c.Industry__c ='it';            
            insert c; 
            
            //profile Information
            Profile p = [SELECT Id FROM Profile WHERE Name='Overage High Volume Customer Portal User_Custom'];    
                                
            User u = new User(Alias = 'standt', Email='Developer@gmail.com', 
                      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                      LocaleSidKey='en_US', ProfileId = p.Id, department = 'STP',MobilePhone='2345234567',contactid=c.id,
                      TimeZoneSidKey='America/Los_Angeles', UserName=Math.random() + '@test.com');
                      insert u;
                      
            
            //Create CP properity             
            CP_Property__c cp=new CP_Property__c();
            cp.Contact_User_Id__c=u.id;
            cp.Plant__c='MeadowsExt';            
            insert cp;        
                
            //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name=cp.Plant__c;   
            pl.Project__c='cosmolis';  
            pl.Admin_Email__c='developer@extentor.com';
            insert pl; 
            
           
            //BgProfile Information
            BG_CPprofile__c bgprofile=new BG_CPprofile__c();
            bgprofile.name='test';
           // bgprofile.Portal_Username__c='Uday';
            bgprofile.CPprofile_Name__c='test2';           
            bgprofile.CPprofile_EmailForCommunication__c='uday@gmail.com';
            bgprofile.CPprofile_BillingStreet__c='Marathali';           
            bgprofile.Portal_UserMobile__c='3245344454';
            bgprofile.CPprofile_Mobile__c='8884937365';
          //  bgprofile.Portal_Username__c='test';
            bgprofile.CPprofile_MailingCountry__c='India';
            bgprofile.CPprofile_MailingPostCode__c='346373';
            bgprofile.CPprofile_BillingState__c='india';
            bgprofile.CPprofile_MailingCity__c='Bnagwel';   
            bgprofile.CPprofile_BillingPostcode__c='232342';
            bgprofile.CPprofile_BillingCountry__c='indi';
            bgprofile.CPprofile_Designation__c ='CEO';
            bgprofile.CPprofile_IncomeTaxPANGIRNo__c ='12343333';
            bgprofile.CPprofile_Company__c='EXTER';
            bgprofile.CPprofile_MailingState__c='AP';
            bgprofile.CPprofile_MirroringName__c='UASDTEST';
            bgprofile.CPprofile_Industry__c='IT';
            bgprofile.CPprofile_ReasonforReject_del__c='TIRESTMEFOR';
            bgprofile.CPprofile_EducationalQualification__c='MCA';
            bgprofile.CPprofile_MirroringIndustry__c='NONIT';
            bgprofile.CPprofile_MirroringProfession__c='JOSA';
            bgprofile.CPprofile_MirrorEducationalQualification__c='DEF';  
            bgprofile.CPprofile_MirroringDesignation__c='IEDIW';
            bgprofile.CPprofile_MirroringCompany__c='WEFW';
            //bgprofile.Mailing_Address__c='ASDA,ASD';
            bgprofile.CPprofile_Profession__c='ETSFRO'; 
            bgprofile.CPprofile_MailingStreet__c='SADSA';
            bgprofile.CPprofile_HouseNumber__c='231';
            bgprofile.CPprofile_BillingCity__c='KARNATAKA';
            bgprofile.CPprofile_Street1__c='HASDA';
            bgprofile.CPprofile_Street2__c='SDHISA';
            bgprofile.CPprofile_Street3__c='ADA';
            bgprofile.CPprofile_MirroringName__c='test2';
            bgprofile.CPprofile_MirroringEmailForCommunication__c='developer@extentor.com';
            bgprofile.CPprofile_MirroringMobile__c='1231222345';            
            bgprofile.CPprofile_MirroringHouseNumber__c='233';
            bgprofile.CPprofile_MirroringStreet1__c='wew';
            bgprofile.CPprofile_MirroringStreet2__c='2ndline';
            bgprofile.CPprofile_MirroringStreet3__c='ardstage';
            bgprofile.CPprofile_MirroringMailing_City__c='Bnaglore';
            bgprofile.CPprofile_MirroringMailingState__c='ap';
            bgprofile.CPprofile_MirroringMailingPostCode__c='522647';
            bgprofile.CPprofile_MirroringMailingCountry__c='India';
            bgprofile.CPprofile_MirroringCompany__c='extentor';
            bgprofile.CPprofile_MirroringDesignation__c='It';
            bgprofile.CPprofile_MirroringIndustry__c='it';
            bgprofile.CPprofile_MirrorEducationalQualification__c='mca';
            bgprofile.CPprofile_MirroringProfession__c='sda'; 
            bgprofile.User__c=u.id;
            bgprofile.CPprofile_ReasonforReject_del__c='Time is over';
            bgprofile.Contact__c=c.id;
           // bgprofile.id=bgprofile1.id;
           
            insert bgprofile;             
                          
            /* smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c = bgprofile.Portal_UserMobile__c;
             smsObject.smagicinteract__Name__c =bgprofile.Portal_Username__c; 
             smsObject.smagicinteract__ObjectType__c = 'BG_CPprofile__c'; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
             insert smsObject; 
            
             smagicinteract__SMS_Template__c tpltext =new smagicinteract__SMS_Template__c ();
             tpltext.smagicinteract__Text__c ='tets';
             tpltext.smagicinteract__Name__c='Accept Personal Information';
             insert tpltext ;
             
             smagicinteract__SMS_Template__c tpltext1 =new smagicinteract__SMS_Template__c ();
             tpltext1.smagicinteract__Text__c ='tets';
             tpltext1.smagicinteract__Name__c='Reject Personal Information';
             insert tpltext1 ;*/
             
             
                         
         /*   EmailTemplate emailTlate=new EmailTemplate();
            emailTlate.Name='Accept Information';  
            emailTlate.body='testfordata';           
            insert emailTlate;
            */
            
          /*  Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {u.email};
           // message.setTemplateId(emailTlate.id); 
            message.setTargetObjectId(u.ContactId);
            message.setWhatId(bgprofile.Id);
            message.saveAsActivity=false;
            message.setToAddresses(toAddresses);
       */      
                       
            Test.startTest();              
           
            Test.setCurrentPageReference(new PageReference('/apex/updatepage_RD?id='+bgprofile.Contact__c));   
                        
            Updatepagecon Updatepage=new Updatepagecon();
           
            System.debug('Current User: ' + UserInfo.getUserName());
            System.debug('Current Profile: ' + UserInfo.getProfileId()); 
                    
               ApexPages.currentPage().getParameters().put('id', 'bgprofile.Contact__c');
              
               // BG_CPprofile__c bgprofile=new BG_CPprofile__c(); 
          
               Updatepage.CPprofileObj3.CPprofile_ReasonforReject_del__c='time is over';
               
             //  Updatepage.CPprofileObj.Portal_Username__c=bgprofile.Portal_Username__c;
               
               Updatepage.acceptpage();               
               
               Updatepage.rejectpage(); 
               
               Updatepage.Homepage();
                 
             Test.stopTest();
         
         }
    }