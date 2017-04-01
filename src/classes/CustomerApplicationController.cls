/************************************************************************************************************
    Author  : Ajeeet
    Date    : 14/12/2016
    Purpose : Extension for CustomerApplicationPage And SendEmailPage

*************************************************************************************************************/
global without sharing class CustomerApplicationController {
    public class myException Extends Exception{}

    public static String oppId{get;set;} 
    public static String jsonstring{get;set;} 
    public static Application_Form__c app{get; set;}

    public static  ApplicationFormController afc{get;set;}

    public CustomerApplicationController(ApexPages.StandardController controller){
        oppId = ApexPages.currentPage().getParameters().get('Id');
    
        afc = new ApplicationFormController() ;    
        
        afc.contacts = New List<Contact>();
        afc.AppForm = new Application_Form__c();
        afc.DateFields = new List<String>();
        afc.plant= new Plant__c();
        afc.unit = new Unit__c();

        //=============================================================================
        list<Country__c> CatRec = [select Name, (select Name from States__r) from Country__c] ;
        afc.SubCategoreyToCategorey = new Map<String, List<String>>();
        for(Country__c cat : CatRec) {
            for(Region__c subCat : cat.States__r){
                if(afc.SubCategoreyToCategorey.containsKey(cat.name)) {
                afc.SubCategoreyToCategorey.get(cat.name).add(subCat.Name);
                } else {
                afc.SubCategoreyToCategorey.put(cat.name, new List<String> { subCat.Name });
            }
           
            }
        }
        //=============================================================================


        afc.opport   = [SELECT AccountId,Referred_By_Name_Text__c,For_ROI__c,Car_park_reservation_Charges__c,OTP_Generated__c,Unit__r.Terrace_Area_Price__c,Unit__r.Garden_Area_Price__c,Car_Park_Value__c,Plant2__r.Project_Head__c,Plant2__r.Rate_of_Sheltered_car_park_Rs__c,Plant2__r.Rate_of_Open_car_park_Rs__c,Plant2__r.Rate_of_Stilt_car_park_Rs__c,Referred_by_Name2__r.Name,PT_Unit_Price_Agreed__c,Channel_Partner__r.Name,Buisness_Card_Primary_Applicant__c,Mode_Of_Funding__c,Purpose_of_Buying__c,CH_Branch_Name__c,Provisional_Allotment_letter__c,CH_Bank_Name__c,Booking_Amount__c,Bank_Name__c,Branch_Name_c__c,CH_Mode_of_Payments__c,CH_Booking_Amount__c,Received_the_Passport_Copy_for_NRI__c,Photocopy_Power_of_Attorney__c,Permanent_Address_Proof__c,Received_the_Address_Proof_Copy__c,Received_the_PAN_Card_Copy__c,Photographs_Received__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Name,Unit__r.Terrace_Area__c,Unit__r.Garden_Area__c,Unit__r.Area__c,  Lead_Source__c,No_of_Car_Park_S__c,Car_Parking_Type__c,Mode_of_Payment__c,Transaction_number_c__c,CH_Transaction_Number__c FROM Opportunity where Id=:oppId Limit 1];
         

        afc.RefferedBy              =(afc.opport.Referred_by_Name2__r.Name != '') ? afc.opport.Referred_by_Name2__r.Name : '' ;
        afc.ChannelPartner          =(afc.opport.Channel_Partner__r.Name != '')  ? afc.opport.Channel_Partner__r.Name : '' ;
        afc.isprojectHeadExist      =(afc.opport.Plant2__r.Project_Head__c != null)? afc.opport.Plant2__r.Project_Head__c : null;
        afc.unit.Area__c            = afc.opport.Unit__r.Area__c;
        afc.unit.Terrace_Area__c    =afc.opport.Unit__r.Terrace_Area__c;
        afc.unit.Garden_Area__c     =afc.opport.Unit__r.Garden_Area__c;
        afc.unit.Terrace_Area_Price__c=afc.opport.Unit__r.Terrace_Area_Price__c;
        afc.unit.Garden_Area_Price__c =afc.opport.Unit__r.Garden_Area_Price__c;
        afc.opport.Id               =oppId;
        afc.carParkValue            =(afc.opport.Plant2__r.Rate_of_Sheltered_car_park_Rs__c != null)?afc.opport.Plant2__r.Rate_of_Sheltered_car_park_Rs__c :((afc.opport.Plant2__r.Rate_of_Open_car_park_Rs__c != null) ?afc.opport.Plant2__r.Rate_of_Open_car_park_Rs__c:((afc.opport.Plant2__r.Rate_of_Stilt_car_park_Rs__c != null)?afc.opport.Plant2__r.Rate_of_Stilt_car_park_Rs__c:0));
        //For Autopopulation of Date fields(Date__c && CH_Date__c)
        Opportunity oforDate=[SELECT CH_Date__c,Date__c from Opportunity where Id=:oppId Limit 1];
        if(oforDate.Date__c != null)
        afc.OppDateFields.add(String.valueOf(oforDate.Date__c));
        if(oforDate.CH_Date__c != null)
        afc.OppDateFields.add(String.valueOf(oforDate.CH_Date__c));


        //For Autopopulation of Application form
        List<Application_Form__c> appList1=new List<Application_Form__c>();
        appList1=[Select id,Application_Status__c,Referred_by_Name__r.Name,Recommend_Brigade_to_your_friends__c,Rate_Brigade_as_a_Brand__c,Experience_with_Brigade__c,Rate_Our_Product_Portfolio__c,Channel_Partner__r.Name,Customer_Bank_HFI__c from Application_Form__c where Opportunity__c=:oppId LIMIT 1];
        app = (appList1 != null && appList1.size()>0 ) ? appList1[0] : new Application_Form__c(); 
        afc.AppForm=app;
        
        
        
        Opportunity o=[SELECT AccountId,Unit__r.Plant__r.Name,Unit__r.Plant__r.Project__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Terrace_Area__c,Unit__r.Name FROM Opportunity where Id=:oppId Limit 1];
        System.debug('o.Unit__r.Name');
        System.debug(o.Unit__r.Name);
        System.debug(o.Unit__r.Plant__r.Name);
        System.debug(o.Unit__r.Plant__r.Project__c);
        afc.plant.Club_Membership__c=o.Plant2__r.Club_Membership__c;
        afc.unit.Terrace_Area__c=o.Unit__r.Terrace_Area__c ;
        afc.floorDescription=o.Unit__r.Floor_Description__c;
       
        afc.projectName = o.Unit__r.Plant__r.Project__c;
        afc.plantName   = o.Unit__r.Plant__r.Name;
        afc.unitName    = o.Unit__r.Name ;
        Id accId=o.AccountId;

        afc.Acc  = [SELECT Id,A_Country__r.Name,A_Region__r.Name,CountryL__r.Name,RegionL__r.Name,Name,A_Street_1__c,A_Street_2__c,A_Street_3__c,Street1__c,Street2__c,MobilePhone__c ,Street3__c,A_City__c, City__c,Postal_Code__c,A_Postal_Code__c,A_District__c,District__c,Same_as_Correspondence_Address__c,A_MobilePhone__c from Account where Id=:accId];
        afc.plant.Name ='Ajeet is super developer!!';
        //List<OpportunityContactRole> ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId=:oppId order by createddate];
        // Opportunity o=[SELECT AccountId,Unit__r.Plant__r.Name,Unit__r.Plant__r.Project__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Terrace_Area__c,Unit__r.Name FROM Opportunity where Id=:oppId Limit 1];
        
        List<contact> ConId=[SELECT Id from Contact where AccountId=:o.AccountId And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') order by createdDate Limit 3 ];
        /*Set<Id> contactids = new set<id>();
        if(ConId.size() > 0){
        for(OpportunityContactRole opp : ConId) {
         contactids.add(opp.ContactId);
        }
        }*/

        Set<Id> contactids = new set<id>();
        if(ConId.size() > 0){
        for(Contact opp : ConId) {
         contactids.add(opp.Id);
        }
        }
        
        List<Contact> con=[SELECT Id,AccountId,Description,Alternate_Email__c,Name,District__c,Street1__c,Street2__c,Street3__c,MobilePhone,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Relation_Name__c,Designation__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName,Salutation,Middle_Name__c,Relation__c,Industry__c,Profession__c,Residency_Status__c,Nationality__c,Passport_No__c,Spouse_s_Name__c FROM Contact where Id In:contactids And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') LIMIT 3];
        afc.contacts.addAll(con);

        //============================================Enhanced code for getting contact to autopopulate genral power of attorney======
        List<contact> ConRecord=[SELECT Id,Name,LastName,Email,Contact_Type__c,Salutation,District__c,Street1__c,Street2__c,Street3__c,MobilePhone,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet from Contact where AccountId=:o.AccountId And  Contact_Type__c='GPA Holder'];
        if(ConRecord.size() > 0){
            afc.genralPowerofAttorney=ConRecord[0];
        }
        //============================================================================================================================

        List<Contact> conForDate=[SELECT Id,Birthdate,Wedding_Anniversary__c FROM Contact where Id In:contactids LIMIT 3];
        for(Contact cc:conForDate){
            /*afc.DateFields.add(String.valueOf(cc.Birthdate));
            afc.DateFields.add(String.valueOf(cc.Wedding_Anniversary__c));*/

            String dob=(cc.Birthdate != null)?String.valueOf(cc.Birthdate):'';
            String wed=(cc.Wedding_Anniversary__c != null)?String.valueOf(cc.Wedding_Anniversary__c):'';
            afc.DateFields.add(dob);
            afc.DateFields.add(wed);

            
        }


        
        System.debug(''+afc.opport);
        jsonstring=String.escapeSingleQuotes(JSON.serialize(afc));
        System.debug(''+jsonstring);
    }

    public CustomerApplicationController() {
        
    }
    /*******************************************************************************************************
    * @description :- Method to Send Email to Primary contact for opportunity 
    * @param  :- OppId
    * @return :- Nothing
    */
    webService static String SendEmail(String oppIdd){

        System.debug('$$$$$$$$$$$$'+oppIdd);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        Id ConId;
        /*try{
          ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId  =: oppIdd  Limit 1].ContactId;
          
        }catch(Exception e){
            return e.getMessage();
        }*/
        Opportunity opprecc=[SELECT AccountId,Owner.Name,Unit__r.Plant__r.Project__c,Unit__r.Name FROM Opportunity where Id=:oppIdd Limit 1];
        String emailAddress='';
        List<contact> conList=[SELECT Id,MobilePhone,FirstName,LastName,Email,Contact_Type__c from Contact where AccountId=:opprecc.AccountId And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') order by createdDate Limit 3 ];
        if(conList.size()>=0){
            System.debug('$$$$$$$$$$$$'+'inside if');
            emailAddress=conList[0].Email;
            if(emailAddress==null)
            return 'First Applicant Email Address was not found';
        }else{
            System.debug('$$$$$$$$$$$$'+'inside else');
            return 'First Applicant Email Address was not found';
        }
        System.debug('$$$$$$$$$$$$'+emailAddress);

        mail.setToAddresses(new String[] { emailAddress });
        mail.setSubject('Application form Submitted');
        String emailTemp= 'Dear @Customer<br/><br/>Greetings from Team Brigade!<br/><br/>Please fill the  Application for Allotment  for your Booking of the unit @Unit in Project : @Project. <br/><br/> Please <a href="@Url">Click here </a> to fill application from. <br/><br/><br/>Thanks with Regards<br/>@OpportunityOwner<br/>@MobileNo';
        emailTemp= emailTemp.replace('@Customer',conList[0].FirstName+' '+conList[0].LastName);
        emailTemp= emailTemp.replace('@Unit',opprecc.Unit__r.Name);
        emailTemp= emailTemp.replace('@Project',opprecc.Unit__r.Plant__r.Project__c);
        emailTemp= emailTemp.replace('@Url','http://qa-bgproduction-brigadeforce-na19.cs14.force.com/CustomerApplication?id='+oppIdd);
        emailTemp= emailTemp.replace('@OpportunityOwner',opprecc.Owner.Name);
        if(conList[0].MobilePhone !=null){
           emailTemp= emailTemp.replace('@MobileNo',conList[0].MobilePhone); 
            System.debug('$$$$$$$$$$$$'+'mobile  found');
        }
        else{
            System.debug('$$$$$$$$$$$$'+'mobile  not found');
         	return 'First Applicant Mobile number is not specified';   
        }
        
        mail.setHtmlBody(emailTemp);
       // mail.setHtmlBody('Your Application form submitted is attached.Please check the Attachment.'+'<br/>'+'http://p2dev-bgproduction-brigadeforce-na19.cs14.force.com/CustomerApplication?id='+oppIdd);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachh }); 
        
        try{
            System.debug('$$$$$$$');
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+'ajeet.kumar6171@gmail.com'));
        }catch(Exception e){
            return e.getMessage();
        }
        return null;
    }
    /*******************************************************************************************************
    * @description :- Method to Save Attachments
    * @param  :- Opportunity Id , Image description in String format
    * @return :- Attachment Id
    */
    @RemoteAction 
    global static String saveAttachments(String opp,String existingLead){
        System.debug('@@@@@@@@@@@@@@@@@@@@@@'+opp+'hdfd'+existingLead);
        /*String name='Ajeet.png'+'qwerty'+'eegrtyrty';*/
        /*String a=existingLead.substringBefore('qwerty');
        System.debug('@@@@@@@@@@@@@@@@@@@@@@'+a);

        String b=existingLead.substringAfter('qwerty');
        System.debug('@@@@@@@@@@@@@@@@@@@@@@'+b);*/
        Attachment att = new Attachment();
        att.body=EncodingUtil.base64Decode((existingLead.substringAfter('qwerty')).subString((existingLead.substringAfter('qwerty')).indexOf(',')+1,(existingLead.substringAfter('qwerty')).length()));
        att.ParentId=opp;
        att.Name=existingLead.substringBefore('qwerty');
        insert att;

        
        /*Application_Form__c afccc=[Select id,Application_Status__c,Referred_by_Name__r.Name,Recommend_Brigade_to_your_friends__c,Rate_Brigade_as_a_Brand__c,Experience_with_Brigade__c,Rate_Our_Product_Portfolio__c,Channel_Partner__r.Name,Customer_Bank_HFI__c from Application_Form__c where Opportunity__c=:opp LIMIT 1];
        
        String dUrl = '/'+att.id+'';
        Project_Docs__c doc =new Project_Docs__c();
        doc.AttachmentId__c=att.id;
        doc.Opportunity__c=opp;
        doc.ApplicationId__c=afccc.Id;
        doc.Document_Url__c=dUrl;

        Insert doc;*/

        return att.Id;
    }
    /*******************************************************************************************************
    * @description :- Method to Delete Attachments
    * @param  :- Attachments Id 
    * @return :- string 'sucess'
    */
    @RemoteAction 
    global static String deleteAttachments(String attid){
            try{
                Database.delete(attid);
                return 'sucess';
            }catch(Exception e){
                return 'gth'+e.getMessage();
            }
        
    }

    /*******************************************************************************************************
    * @description :- Method to Save Contacts
    * @param  :- Opportunity Id , Image description in String format
    * @return :- Attachment Id
    */
    
    @RemoteAction 
    global static String saveContacts(String opp,Opportunity oppRec,Account accRecord,List<Contact> con,List<String> dateFields,Contact genralPowerofAttorney,Application_Form__c afcrecc,List<String> listAttIds,List<String> countryAndStates){
        //Code change to handle all "Business Entity" requirement
        List<Application_Form__c> appList=new List<Application_Form__c>();
        Application_Form__c afcrec = new Application_Form__c();
        appList=[Select id,Application_Status__c,Referred_by_Name__r.Name,Recommend_Brigade_to_your_friends__c,Rate_Brigade_as_a_Brand__c,Experience_with_Brigade__c,Rate_Our_Product_Portfolio__c,Channel_Partner__r.Name,Customer_Bank_HFI__c from Application_Form__c where Opportunity__c=:opp LIMIT 1];
        
        

        System.debug('###############'+opp);
        System.debug('###############'+oppRec);
        System.debug('###############'+accRecord);
        System.debug('###############'+con);
        System.debug('###############'+dateFields);
        System.debug('###############'+genralPowerofAttorney);
        System.debug('###############'+afcrecc);
        System.debug('###############'+listAttIds);
        Id country1;
        Id country2;
        Id state1;
        Id state2;
        Integer z=0;
        For(String s:countryAndStates){

            if(z==0 &&  s != '')
            state1=[Select Id,Name from Region__c where Name=:s].Id;
            else if(z==1 &&  s != '')
            state2=[Select Id,Name from Region__c where Name=:s].Id;
            else if(z==2 &&  s != '')
            country1=[Select Id,Name from Country__c where Name=:s].Id;
            else if(z==3 &&  s != '')
            country2=[Select Id,Name from Country__c where Name=:s].Id;

            z++;
        }
        System.debug('###############'+state1);
        System.debug('###############'+state2);
        System.debug('###############'+country1);
        System.debug('###############'+country2);
        accRecord.A_Country__c=country2;
        accRecord.A_Region__c=state2;
        accRecord.CountryL__c=country1;
        accRecord.RegionL__c=state1;
        
        if(con[0].Residency_Status__c == 'Resident Indian'){
           oppRec.Recon_Account__c='0023000010- Debtors - Domestic';
           oppRec.Cash_Management_Group__c='E1- Customer Sales Domestic'; 

           afcrecc.Recon_Account__c='0023000010- Debtors - Domestic';
           afcrecc.Cash_Management_Group__c='E1- Customer Sales Domestic';
           afcrecc.Account_Group__c='Z02-Indian customer';

           accRecord.Account_Group__c='Z02-Indian customer';
        }
        
        if(con[0].Residency_Status__c == 'NRI' || con[0].Residency_Status__c == 'PIO'){
            if(con[0].Residency_Status__c == 'NRI'){
                accRecord.Account_Group__c='Z03-NRI/Indian Citizen';
                afcrecc.Account_Group__c='Z03-NRI/Indian Citizen';
            }

            if(con[0].Residency_Status__c == 'PIO'){
                accRecord.Account_Group__c='Z04-NRI Foreign Citizen (PIO)';
                afcrecc.Account_Group__c='Z04-NRI Foreign Citizen (PIO)';
            }
            
            afcrecc.Recon_Account__c='0023000020- Debtors - NRI & Foreigner';
            afcrecc.Cash_Management_Group__c='   E2- Customer Sales NRI';
            
            oppRec.Recon_Account__c='0023000020- Debtors - NRI & Foreigner';
            oppRec.Cash_Management_Group__c='   E2- Customer Sales NRI';
        }
        try{
            update accRecord;
            
        }catch(Exception e){
            return e.getMessage();
        }

        try{
            update oppRec;
        }catch(Exception e){
            return e.getMessage();
        }
        try{
            update accRecord;
        }catch(Exception e){
            return e.getMessage();
        }
        
        
        // Code to save Application form record------if there is not an already--------
        
        if(appList.size()==0){

            afcrec.Opportunity__c =opp;
            afcrec.Customer_Submitted__c=true;
            afcrec.Discount_Approval_Status__c='';
            afcrec.Lead_Source_Approval_Status__c ='';

            /*afcrec=afcrecc;*/
            //== fill up other fileds============Ask dheeraj what fields need to be included
            afcrec.Garden_Area_Price__c =afcrecc.Garden_Area_Price__c;
            afcrec.Garden_Area__c =afcrecc.Garden_Area__c;
            afcrec.Terrace_Area__c =afcrecc.Terrace_Area__c;
            afcrec.Terrace_Area_Price__c =afcrecc.Terrace_Area_Price__c;
            afcrec.AGREEMENT_VALUE__c =afcrecc.AGREEMENT_VALUE__c;
            
            afcrec.Recon_Account__c =afcrecc.Recon_Account__c;
            afcrec.Cash_Management_Group__c =afcrecc.Cash_Management_Group__c;
            afcrec.Account_Group__c =afcrecc.Account_Group__c;
           
            /*try{
                System.debug('@@@@@'+afcrec);
                insert afcrec;
            }catch(Exception e){
                return e.getMessage();
            }  */
        }else{
            afcrec=appList[0];
            afcrec.Recon_Account__c =afcrecc.Recon_Account__c;
            afcrec.Cash_Management_Group__c =afcrecc.Cash_Management_Group__c;
            afcrec.Account_Group__c =afcrecc.Account_Group__c;
        }
        
        





        System.debug('@@@@@@@@@@@@@@'+con);
        if(genralPowerofAttorney != null){
            System.debug('inside 1 if');
            if(genralPowerofAttorney.Id != null){
                genralPowerofAttorney.LastName='a';
                update genralPowerofAttorney;
                System.debug('inside 2 if');
                }else{
                System.debug('inside 3 if');
                genralPowerofAttorney.Contact_Type__c='GPA Holder';
                //genralPowerofAttorney.LastName='.';
                genralPowerofAttorney.AccountId=accRecord.Id;
                genralPowerofAttorney.LastName='a';
                insert genralPowerofAttorney;
            }
        }
        Id aacId;
        
        Opportunity opport=[SELECT AccountId,Plant2__r.Project_Head__c from Opportunity where Id=:opp LIMIT 1]; 
        aacId=opport.AccountId;
        Integer i=0;
        Integer j=dateFields.size();
        String EmailForPdf='';
        for(Contact c:con){
            if(i==0) {c.Contact_Type__c='First Applicant';}
            else if(i==1) {c.Contact_Type__c='Second Applicant';}
            else if(i==2) {c.Contact_Type__c='Third Applicant';}
            
            c.AccountId=aacId;
            if(c.LastName == null || c.LastName == '')
            c.LastName='';
            if(i<j){
               if(dateFields[i] != '') 
            c.Birthdate=AppFormController.calculateDate(String.valueOf(dateFields[i])); 
            }
            
            if(i+1 <j){
                System.debug('QQQQQQQQQQQQ....'+i+'con'+c.Wedding_Anniversary__c);
                if(dateFields[i+1] != '') 
            c.Wedding_Anniversary__c=AppFormController.calculateDate(String.valueOf(dateFields[i+1]));
            
            }
            System.debug('QQQQQQQQQQQQ....'+i+'con'+c.Wedding_Anniversary__c+'birth'+c.Birthdate);
            i++;

        }
        List<contact> ContactsToUpdate = new List<Contact>();
        List<contact> ContactsToInsert = new List<Contact>();
        for(Contact c:con){
            if(c.Id != null)
            ContactsToUpdate.add(c);
            else
            ContactsToInsert.add(c);
        }
        System.debug('@@@@@@@@@@@@@@$$$$$$$'+ContactsToUpdate);
        System.debug('@@@@@@@@@@@@@@$$$$$$$$'+ContactsToInsert);
        try{
            if(ContactsToUpdate.size() > 0)
            update ContactsToUpdate;
            if(ContactsToInsert.size() > 0)
            insert ContactsToInsert;
            System.debug('$$$$$%%%%%%bbbbbb'+listAttIds);
            System.debug('$$$$$%%%%%%bbbbbb'+opp);
            upsert afcrec;
            System.debug('$$$$$%%%%%%bbbbbb'+afcrec.Id);
            String errormsg1=sendEmailtosalesRep(opp);
            String errormsg=saveApplicationDocuments(listAttIds,opp,afcrec.Id);
            if(errormsg!='sucess')
            throw new myException('Something went wrong while saving Application documents records');
            return 'sucess';
        }catch(Exception e){
            return e.getMessage();
        }
            
        

    }
    public static string sendEmailtosalesRep(string oppIdd){
        System.debug('$$$$$$$$$$$$'+oppIdd);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        Id ConId;
        /*try{
          ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId  =: oppIdd  Limit 1].ContactId;
          
        }catch(Exception e){
            return e.getMessage();
        }*/
        Opportunity opprecc=[SELECT AccountId,Sales_Person_1__r.name,Sales_Person_1__r.Email,Owner.Name,Unit__r.Plant__r.Project__c,Unit__r.Name FROM Opportunity where Id=:oppIdd Limit 1];
        String emailAddress='';
        
        Application_Form__c appList1=[Select id from Application_Form__c where Opportunity__c=:oppIdd LIMIT 1];
        
        List<contact> conList=[SELECT Id,MobilePhone,FirstName,LastName,Email,Contact_Type__c from Contact where AccountId=:opprecc.AccountId And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') order by createdDate Limit 3 ];
        /*if(conList.size()>=0){
            System.debug('$$$$$$$$$$$$'+'inside if');
            emailAddress=conList[0].Email;
            if(emailAddress==null)
            return 'First Applicant Email Address was not found';
        }else{
            System.debug('$$$$$$$$$$$$'+'inside else');
            return 'First Applicant Email Address was not found';
        }*/
        emailAddress=opprecc.Sales_Person_1__r.Email;
        if(emailAddress=='')
        return 'Sales rep Email Address was not found';
        System.debug('$$$$$$$$$$$$'+emailAddress);

        mail.setToAddresses(new String[] { emailAddress });
        mail.setSubject('Application form Submitted');
        String emailTemp= 'Dear @Customer<br/><br/><br/><br/>The application form is submitted by '+conList[0].FirstName+' '+conList[0].LastName +' for your Booking of the unit @Unit in Project : @Project. <br/><br/> Please <a href="@Url">Click here </a> to see/edit application from. <br/><br/><br/>Thanks with Regards<br/>';
        emailTemp= emailTemp.replace('@Customer',opprecc.Sales_Person_1__r.name);
        emailTemp= emailTemp.replace('@Unit',opprecc.Unit__r.Name);
        emailTemp= emailTemp.replace('@Project',opprecc.Unit__r.Plant__r.Project__c);
        emailTemp= emailTemp.replace('@Url','https://bgproduction-brigadeforce-na19--qa.cs14.my.salesforce.com/'+appList1.Id);
       
        
        mail.setHtmlBody(emailTemp);
       // mail.setHtmlBody('Your Application form submitted is attached.Please check the Attachment.'+'<br/>'+'http://p2dev-bgproduction-brigadeforce-na19.cs14.force.com/CustomerApplication?id='+oppIdd);
        //mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachh }); 
        
        try{
            System.debug('$$$$$$$');
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+'ajeet.kumar6171@gmail.com'));
        }catch(Exception e){
            return e.getMessage();
        }
        return null;
    }
    /*******************************************************************************************************
    * @description :- Method to save Application Documnets
    * @param  :- List if Attachment Id's , Opportunity id, Application form Id
    * @return :- String representing sucess or failure
    */
    public static String saveApplicationDocuments(List<String> attIds,String opp,String appformId){
        // Make a list of Application doc record which will be inserted later on 
        System.debug('$$$$$%%%%%%'+attIds);
        System.debug('$$$$$%%%%%%'+opp);
        System.debug('$$$$$%%%%%%'+appformId);
        Opportunity o=[SELECT AccountId FROM Opportunity where Id=:opp Limit 1];

        List<contact> ConId=[SELECT Id from Contact where AccountId=:o.AccountId And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') order by createdDate Limit 3 ];

        System.debug('$$$$$'+attIds+'$$$'+opp+'######'+appformId);
        List<Project_Docs__c> appdocRecList = new List<Project_Docs__c>();

        //Iterate over all the id
        Integer i=0;
        For(String attid:attIds){
            System.debug('$$$$$'+attid);
            if(attid != ''){
                String dUrl = 'https://bgproduction-brigadeforce-na19--qa.cs14.my.salesforce.com/'+attid+'';
                Project_Docs__c doc =new Project_Docs__c();

                if(i==0 || i==1 || i==2){
                    doc.Name='Photo ID Proof';
                    if(i==0 && ConId.size() >=i)
                    doc.Contact__c=ConId[i].Id;
                    if(i==1 && ConId.size() >=i)
                    doc.Contact__c=ConId[i].Id;
                    if(i==2 && ConId.size() >=i)
                    doc.Contact__c=ConId[i].Id;

                    o.Photographs_Received__c=true;
                }
                
                if(i==3 || i==4 || i==5){
                    doc.Name='PAN Card';
                    if(i==3 && ConId.size() >=i)
                    doc.Contact__c=ConId[0].Id;
                    if(i==4 && ConId.size() >=i)
                    doc.Contact__c=ConId[1].Id;
                    if(i==5 && ConId.size() >=i)
                    doc.Contact__c=ConId[2].Id;
                    o.Received_the_PAN_Card_Copy__c=true;
                }
                

                if(i==6){
                   doc.Name='Permanent Address Proof'; 
                   doc.Contact__c=ConId[0].Id;
                    doc.Account__c=o.AccountId;
                   o.Permanent_Address_Proof__c=true;
                }
                
                if(i==7){
                    doc.Name='Correspondence Address Proof';
                    doc.Contact__c=ConId[0].Id;
                    doc.Account__c=o.AccountId;
                   o.Received_the_Address_Proof_Copy__c=true;

                }
                
                if(i==8){
                    doc.Name='Business Card Proof';
                    doc.Contact__c=ConId[0].Id;
                    o.Buisness_Card_Primary_Applicant__c=true;
                }
                
                if(i==9){
                    doc.Name='Power of Attorney Proof';
                    doc.Contact__c=ConId[0].Id;
                    o.Photocopy_Power_of_Attorney__c=true;
                }
                
                if(i==10){
                    doc.Name='NRI Proof';
                    doc.Contact__c=ConId[0].Id;
                    o.Provisional_Allotment_letter__c=true;
                }
                
                if(i==11){
                    doc.Name='NRI Proof';
                    doc.Contact__c=ConId[0].Id;
                    o.Received_the_Passport_Copy_for_NRI__c=true;
                }
                

                doc.AttachmentId__c=attid;
                doc.Opportunity__c=opp;
                doc.ApplicationId__c=appformId;
                doc.Document_Url__c=dUrl;

                appdocRecList.add(doc);
            }
            i++;
        }
        try{
            System.debug('$$$$$'+appdocRecList.size());
            if(appdocRecList.size() >= 0)
            insert appdocRecList;
            update o;
            return 'sucess';
        }catch(Exception e){
            return 'Error while saving Application doc';
        }

    }


    /*******************************************************************************************************
    * @description :- Method to Change Date format 
    * @param  :- String date
    * @return :- Date
    */
    public static Date calculateDate(string aDate){
        string[] newDate;
        string[] tempstrtdate;
        tempstrtdate =aDate.split('T');
        newDate=tempstrtdate[0].split('-'); 
        Date valueDate = Date.newInstance(Integer.valueOf(newDate[0]),Integer.valueOf(newDate[1]),Integer.valueOf(newDate[2]));
        return valueDate ;
    }
    @RemoteAction
    global static List<String> fetchIndustryType(){        
        System.debug('Anydatatype_msg');
        List<String> CarParkTypes = new List<String>();
        for(Schema.PicklistEntry pe : Contact.getSObjectType().getDescribe().fields.getMap().get('Industry__c').getDescribe().getPickListValues()) {
            CarParkTypes.add(pe.getValue());
        }
        System.debug(CarParkTypes);
        return CarParkTypes;
    }
    @RemoteAction
    global static List<String> fetchCarParkingType(){        
        System.debug('Anydatatype_msg');
        List<String> IndustryTypes = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Car_Parking_Type__c').getDescribe().getPickListValues()) {
            IndustryTypes.add(pe.getValue());
        }
        System.debug(IndustryTypes);
        return IndustryTypes;
    }
    @RemoteAction 
    global static List<String> fetchSalutation(){        
       
        List<String> SalutationTypes = new List<String>();
        for(Schema.PicklistEntry pe : Contact.getSObjectType().getDescribe().fields.getMap().get('Salutation').getDescribe().getPickListValues()) {
            SalutationTypes.add(pe.getValue());
        }
        
        return SalutationTypes;
    }
    @RemoteAction 
    global static List<String> fetchResidencyStatus(){        
       
        List<String> ResidencyTypes = new List<String>();
        for(Schema.PicklistEntry pe : Contact.getSObjectType().getDescribe().fields.getMap().get('Residency_Status__c').getDescribe().getPickListValues()) {
            ResidencyTypes.add(pe.getValue());
        }
        
        return ResidencyTypes;
    }
    @RemoteAction 
    global static List<String> fetchRelationTypes(){        
       
        List<String> RelationTypes = new List<String>();
        for(Schema.PicklistEntry pe : Contact.getSObjectType().getDescribe().fields.getMap().get('Relation__c').getDescribe().getPickListValues()) {
            RelationTypes.add(pe.getValue());
        }
        
        return RelationTypes;
    }
    @RemoteAction 
    global static List<String> fetchPaymentTypes(){        
       // To be changed for earnest + Ch mode of payment
        List<String> PaymentTypes = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Mode_of_Payment__c').getDescribe().getPickListValues()) {
            PaymentTypes.add(pe.getValue());
        }
        
        return PaymentTypes;
    }
    @RemoteAction 
    global static List<String> fetch_CH_PaymentTypes(){        
       // To be changed for earnest + Ch mode of payment
        List<String> PaymentTypes = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('CH_Mode_of_Payments__c').getDescribe().getPickListValues()) {
            PaymentTypes.add(pe.getValue());
        }
        
        return PaymentTypes;
    }
    @RemoteAction 
    global static List<String> fetchFinanceTypes(){        
       
        List<String> FinanceTypes = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Mode_Of_Funding__c').getDescribe().getPickListValues()) {
            FinanceTypes.add(pe.getValue());
        }
        
        return FinanceTypes;
    }
    @RemoteAction 
    global static List<String> fetchBuyingPurpose(){        
       
        List<String> BuyingPurpose = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Purpose_of_Buying__c').getDescribe().getPickListValues()) {
            BuyingPurpose.add(pe.getValue());
        }
        
        return BuyingPurpose;
    }
    @RemoteAction 
    global static List<String> fetchLeadSource(){        
       
        List<String> LeadSource = new List<String>();
        for(Schema.PicklistEntry pe : Opportunity.getSObjectType().getDescribe().fields.getMap().get('Lead_Source__c').getDescribe().getPickListValues()) {
            LeadSource.add(pe.getValue());
        }
        
        return LeadSource;
    }
    @RemoteAction 
    global static List<String> fetchRefferedBy(){        
       
        List<Contact> cc=[select Name from contact];
        List<String> lst = new List<String>();
        for(contact c:cc){
            lst.add(c.Name);
        }
        
        return lst;
    }
    @RemoteAction 
    global static List<String> fetchChannelPartner(){        
       
        List<Channel_Partner__c> cp=[select Name from Channel_Partner__c];
        List<String> lst = new List<String>();
        for(Channel_Partner__c c:cp){
            lst.add(c.Name);
        }
        
        return lst;
    }
    public PageReference downlaodAsPdf() {
        PageReference pdfPage = Page.CustomerApplicationFormPdf;
        pdfPage.getParameters().put('id',oppId);
        return pdfPage;
    }
    @RemoteAction 
    global static String SaveProjectDetails(Opportunity opprec,Application_Form__c appform,Unit__c urec){        
            System.debug('#####'+opprec);
            System.debug('#####'+appform);
            System.debug('#####'+urec);

            List<Application_Form__c> appList=new List<Application_Form__c>();
            Application_Form__c afcrec = new Application_Form__c();

            appList=[Select id,Application_Status__c,Referred_by_Name__r.Name,Recommend_Brigade_to_your_friends__c,Rate_Brigade_as_a_Brand__c,Experience_with_Brigade__c,Rate_Our_Product_Portfolio__c,Channel_Partner__r.Name,Customer_Bank_HFI__c from Application_Form__c where Opportunity__c=:opprec.Id LIMIT 1];
        
            if(appList.size()==0){

                afcrec.Opportunity__c                =opprec.Id;
               

                
                afcrec.Garden_Area_Price__c         = urec.Garden_Area_Price__c;
                afcrec.Garden_Area__c               = urec.Garden_Area__c;
                afcrec.Terrace_Area__c              = urec.Terrace_Area__c;
                afcrec.Terrace_Area_Price__c        = urec.Terrace_Area_Price__c;
                afcrec.AGREEMENT_VALUE__c           = appform.AGREEMENT_VALUE__c;

                afcrec.Project__c                   =appform.Project__c;
                afcrec.Plant__c                     =appform.Plant__c;
                afcrec.Unit__c                      =appform.Unit__c;
                try{
                    System.debug('@@@@@'+afcrec);
                    insert afcrec;
                }catch(Exception e){
                    return e.getMessage();
                }  
            }else{
                afcrec=appList[0];
            }

            try{

                update opprec;
                //update urec;
        
            }catch(Exception e){
                return e.getMessage();
            }


            return 'sucess';
        
    }

    
}