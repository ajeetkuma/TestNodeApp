@istest
//Test class
    private class testsmssendingSENDDATEUPDATE {
    //Test method    
        public static testmethod void testsmssendingSENDDATEUPDATE(){  
        
            //Plant Information
            Plant__c pl=new Plant__c();
            pl.Name='Meadows';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;  
            
            //Unit Information 
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc; 
            
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
            
            contact c=new contact();
            c.lastname='test';
            c.Contact_Type__c='First Applicant';
            c.Email ='Developer@gmail.com';
            c.accountid=a.id;
            c.MobilePhone='8884937365';
            c.Company__c='extenotr';
            c.Educational_Qualification__c ='bbm';
            c.Designation__c ='se';
            c.Profession__c ='job';
            c.Industry__c ='it';            
            insert c;             
             
            //Opportunity Information
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
            //opp.Reserving_Date__c=System.now().date();
            opp.Set_the_Unit_Status__c='Available';
            opp.Unit__c=null;
            insert opp; 
             
             smagicinteract__smsMagic__c smsObject = new smagicinteract__smsMagic__c();
             smsObject.smagicinteract__SenderId__c ='sms magic';
             smsObject.smagicinteract__PhoneNumber__c =c.MobilePhone ;
             smsObject.smagicinteract__Name__c =c.lastname; 
             smsObject.smagicinteract__ObjectType__c = 'contact'; 
             smsObject.smagicinteract__disableSMSOnTrigger__c = System.Test.isRunningTest()? 1:0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object
             smsObject.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
             smsObject.smagicinteract__SMSText__c = 'sms text';
              system.debug('==============test=========='+smagicinteract.ApexAPI.generateUniqueKey());
             insert smsObject; 
             system.debug('==============test=========='+smsObject);
             smagicinteract__SMS_Template__c tpltext =new smagicinteract__SMS_Template__c ();
             tpltext.smagicinteract__Text__c ='tets';
             tpltext.smagicinteract__Name__c='Demand letter';
             insert tpltext ;
            
               
            
            Demand_Letter_Repository__c dp=new Demand_Letter_Repository__c();
            dp.Opportunity__c=opp.id;
            dp.Name='test';
          //  dp.Sent_Date__c=system.today();
          //  dp.Selection_Date__c=system.today();
            dp.To__c='dep@extentor.com';
            insert dp;
            
            
            dp.sent_date__c=System.today()+2;
            update dp;
            
            
             
            
            
        
        
        }
   }