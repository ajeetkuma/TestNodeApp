global without sharing class AppFormController {
    public static String oppId{get;set;} 
    public static String jsonstring{get;set;} 
    public static Application_Form__c app{get; set;}
    public static  ApplicationFormController afc{get;set;}
    public AppFormController(ApexPages.StandardController controller) {

        oppId = ApexPages.currentPage().getParameters().get('Id');
    
        afc = new ApplicationFormController() ;    
        afc.contacts = New List<Contact>();
        afc.AppForm = new Application_Form__c();
        afc.DateFields = new List<String>();
        afc.plant= new Plant__c();
        afc.unit = new Unit__c();
        
        afc.opport   = [SELECT AccountId,Referred_By_Name_Text__c,Car_park_reservation_Charges__c,OTP_Generated__c,Unit__r.Terrace_Area_Price__c,Unit__r.Garden_Area_Price__c,Car_Park_Value__c,Plant2__r.Project_Head__c,Plant2__r.Rate_of_Sheltered_car_park_Rs__c,Plant2__r.Rate_of_Open_car_park_Rs__c,Plant2__r.Rate_of_Stilt_car_park_Rs__c,Referred_by_Name2__r.Name,PT_Unit_Price_Agreed__c,Channel_Partner__r.Name,Buisness_Card_Primary_Applicant__c,Mode_Of_Funding__c,Purpose_of_Buying__c,CH_Branch_Name__c,Provisional_Allotment_letter__c,CH_Bank_Name__c,Booking_Amount__c,Bank_Name__c,Branch_Name_c__c,CH_Mode_of_Payments__c,CH_Booking_Amount__c,Received_the_Passport_Copy_for_NRI__c,Photocopy_Power_of_Attorney__c,Permanent_Address_Proof__c,Received_the_Address_Proof_Copy__c,Received_the_PAN_Card_Copy__c,Photographs_Received__c,Plant2__r.Club_Membership__c,Plant2__r.ProjectLookup__r.Name,Plant2__r.Name,Unit_No__c,Unit__r.Floor_Description__c,Unit__r.Name,Unit__r.Terrace_Area__c,Unit__r.Garden_Area__c,Unit__r.Area__c,  Lead_Source__c,No_of_Car_Park_S__c,Car_Parking_Type__c,Mode_of_Payment__c,Transaction_number_c__c,CH_Transaction_Number__c FROM Opportunity where Id=:oppId Limit 1];
        afc.isOtpGenrated=afc.opport.OTP_Generated__c;
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

        afc.Acc  = [SELECT Id,Name,A_Street_1__c,A_Street_2__c,A_Street_3__c,Street1__c,Street2__c,MobilePhone__c ,Street3__c,A_City__c, City__c,Postal_Code__c,A_Postal_Code__c,A_District__c,District__c,Same_as_Correspondence_Address__c,A_Country__c,A_MobilePhone__c from Account where Id=:accId];
        afc.plant.Name ='Ajeet is super developer!!';
        //List<OpportunityContactRole> ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId=:oppId order by createddate];
        
        List<contact> ConId=[SELECT Id from Contact where AccountId=:o.AccountId order by createdDate Limit 3 ];
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
        
        List<Contact> con=[SELECT Id,AccountId,Description,Alternate_Email__c,Name,District__c,Street1__c,Street2__c,Street3__c,MobilePhone,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Relation_Name__c,Designation__c,Country_Code_for_Mobile__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName,Salutation,Middle_Name__c,Relation__c,Industry__c,Profession__c,Residency_Status__c,Nationality__c,Passport_No__c,Spouse_s_Name__c FROM Contact where Id In:contactids And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') LIMIT 3];
        afc.contacts.addAll(con);

        //============================================Enhanced code for getting contact to autopopulate genral power of attorney======
        List<contact> ConRecord=[SELECT Id,Name,LastName,Email,Contact_Type__c,Salutation,District__c,Street1__c,Street2__c,Street3__c,MobilePhone,Country_Code_for_Mobile__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet from Contact where AccountId=:o.AccountId And  Contact_Type__c='GPA Holder'];
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

        app.Opportunity__c = oppId;

        list<project__c> prr = [select name, (select name from Plants__r) from project__c] ;
        afc.plantsToProject = new Map<String, List<String>>();
        for(Project__c pr : prr) {
            for(Plant__c plantObj : pr.Plants__r){
                if(afc.plantsToProject.containsKey(pr.name)) {
                afc.plantsToProject.get(pr.name).add(plantObj.Name);
                } else {
                afc.plantsToProject.put(pr.name, new List<String> { plantObj.Name });
            }
           
            }
        }

        list<Plant__c> plantt = [select name, (select name from Units__r) from Plant__c] ;
        afc.unitsToPlant = new Map<String, List<String>>();
        for(Plant__c pr : plantt) {
            for(Unit__c plantObj : pr.Units__r){
                if(afc.unitsToPlant.containsKey(pr.name)) {
                afc.unitsToPlant.get(pr.name).add(plantObj.Name);
                } else {
                afc.unitsToPlant.put(pr.name, new List<String> { plantObj.Name });
            }
           
            }
        }

        jsonstring=String.escapeSingleQuotes(JSON.serialize(afc));
        //jsonstring=jsonstring.replace('\r\n', '');
        
        
    }
    public AppFormController (){
    }
    @RemoteAction
    public static string otpGenration(String ConId){ 
    System.debug('conId ' +ConId); 
    ToGenerateRandomOTP.generateRandomOTP(ConId);
      
        return 'done';
    }
    @RemoteAction
    public static string otpVerification(String op,String conId,string otp){  
        System.debug('conId ' +conId +'string' + otp+'oppiud'+op); 
        string res=ToGenerateRandomOTP.validateOTP(op,conId,otp);
        if(res == 'OTP validated successfully.')
        return 'done';
        else
        return 'fail';
    }
    @RemoteAction
    public static ApplicationFormController Intialize(){  
    ApplicationFormController afc1 = new ApplicationFormController() ; 

    afc1.contacts = New List<Contact>();
    System.debug('afc');  
    System.debug(afc1);    
        return afc1;
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
    @RemoteAction
    public static ProjectWrapper ChangeProjectDetails(String OppIddd,String ProjectName,String PlantName,String UnitName){        
            
            ProjectWrapper pr= new ProjectWrapper();

            Unit__c unit=[Select Id,Terrace_Area__c,Garden_Area__c,Area__c from Unit__c where Name=:UnitName];
            Plant__c plant=[Select Club_Membership__c from Plant__c where Name=:PlantName];
            

            pr.Area             = unit.Area__c;
            pr.TerraceArea      = unit.Terrace_Area__c;
            pr.GardenArea       = unit.Garden_Area__c;
            pr.ClubHouseFee     = plant.Club_Membership__c;
            
            
            return pr;
    }

    @RemoteAction 
    global static String saveContacts(String opp,Account accRecord,List<Contact> con,Opportunity oppor,Application_Form__c appform,Unit__c u,String existingLead,String lead,Plant__c p,String channelPartner,Boolean flag,List<String> dateFields,List<String> oppdateFields,Contact genralPowerofAttorney){
        
        /*System.debug('Asssss');
        System.debug(genralPowerofAttorney.);*/
        update accRecord;
        if(genralPowerofAttorney != null){
            System.debug('inside 1 if');
            if(genralPowerofAttorney.Id != null){
                update genralPowerofAttorney;
                System.debug('inside 2 if');
                }else{
                System.debug('inside 3 if');
                genralPowerofAttorney.Contact_Type__c='GPA Holder';
                //genralPowerofAttorney.LastName='.';
                genralPowerofAttorney.AccountId=accRecord.Id;

                insert genralPowerofAttorney;
            }
        }
        
        
        System.debug('@@@@@@@@@'+oppor);
        Id ChannelPartnerId;
        Id RefferedById;
        if(channelPartner != ''){
            ChannelPartnerId=[Select Id from Channel_Partner__c where Name=:channelPartner Limit 1].Id;
        }else{
            ChannelPartnerId=null;
        }
        String refferedByName            = System.Label.ToBeupdateLabel;
        if(refferedByName != '' && oppor.LeadSource == 'Referral'){
            RefferedById=[Select Id from Contact where LastName=:refferedByName Limit 1].Id;
        }else{
            RefferedById=null;
        }
        
        Opportunity o= new Opportunity();
        
            system.debug('#######'+opp);
         o=[SELECT AccountId,Id,Unit__r.Unit_Rate_Per_SFT__c ,PT_Unit_Price_Agreed__c FROM Opportunity where Id=:opp ];
        System.debug('########'+o);
        
        
        Double discount;
        if(oppor.PT_Unit_Price_Agreed__c != null) 
        discount = o.Unit__r.Unit_Rate_Per_SFT__c - oppor.PT_Unit_Price_Agreed__c ;
        
        Integer i=0;
        Id aacId;
        Id projectHeadId;
        Opportunity opport=[SELECT AccountId,Plant2__r.Project_Head__c from Opportunity where Id=:opp LIMIT 1]; 
        aacId=opport.AccountId;
        projectHeadId=(opport.Plant2__r.Project_Head__c != null) ? opport.Plant2__r.Project_Head__c : null;
        
        Integer j=dateFields.size();
        System.debug('QQQQQQQQQQQQ....'+j+'con');
        String EmailForPdf='';
        for(Contact c:con){

            if(i==0) {
                c.Contact_Type__c='First Applicant';
                if(c.Contact_Type__c=='First Applicant' && c.Email != null && c.Email != '')
                    EmailForPdf=c.Email;
                else{
                    if(c.Alternate_Email__c != null && c.Alternate_Email__c != '')
                    EmailForPdf=c.Alternate_Email__c;
                }

            }
            else if(i==1) {

                c.Contact_Type__c='Second Applicant';
                if(EmailForPdf == ''){
                    if(c.Contact_Type__c=='Second Applicant' && c.Email != null && c.Email != '')
                        EmailForPdf=c.Email;
                    else{
                        if(c.Alternate_Email__c != null && c.Alternate_Email__c != '')
                        EmailForPdf=c.Alternate_Email__c;
                    }
                }
            }
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
        if(ContactsToUpdate.size() > 0)
        update ContactsToUpdate;
        if(ContactsToInsert.size() > 0)
        insert ContactsToInsert;
        
        System.debug('AppForm@@@' +appform);
        Id AppId;
        Application_Form__c appRecord;
        List<Application_Form__c> appList=new List<Application_Form__c>();
        appList=[Select id,Plant__c,Unit__c,Project__c from Application_Form__c where Opportunity__c=:opp LIMIT 1];
        if(appList.size() > 0){
           AppId=appList[0].Id;
            appRecord=appList[0] ;
            appRecord.Referred_By_Name_Text__c  = oppor.Referred_By_Name_Text__c;
            appRecord.AGREEMENT_VALUE__c        =(appform.AGREEMENT_VALUE__c != null ) ?Integer.valueOf(appform.AGREEMENT_VALUE__c):0;
            appRecord.Rate_Brigade_as_a_Brand__c=(appform.Rate_Brigade_as_a_Brand__c != null ) ?Integer.valueOf(appform.Rate_Brigade_as_a_Brand__c):0;
            appRecord.Rate_Our_Product_Portfolio__c=(appform.Rate_Our_Product_Portfolio__c != null ) ?Integer.valueOf(appform.Rate_Our_Product_Portfolio__c):0;
            appRecord.Recommend_Brigade_to_your_friends__c=(appform.Recommend_Brigade_to_your_friends__c != null ) ?Integer.valueOf(appform.Recommend_Brigade_to_your_friends__c):0;
            appRecord.Experience_with_Brigade__c=(appform.Experience_with_Brigade__c != null ) ?Integer.valueOf(appform.Experience_with_Brigade__c):0;

            appRecord.Contact_Name__c=(con[0].Name != null || con[0].Name != '') ?con[0].Name:'';
            appRecord.Plant__c=(appform.Plant__c != null || appform.Plant__c != '') ?appform.Plant__c:'';
            
            appRecord.Unit__c=(appform.Unit__c != null || appform.Unit__c != '') ?appform.Unit__c:'';
           
            appRecord.Project__c= (appform.Project__c != null || appform.Project__c != '') ?appform.Project__c:'';
            appRecord.Customer_Bank_HFI__c= (appform.Customer_Bank_HFI__c != null || appform.Customer_Bank_HFI__c != '') ?appform.Customer_Bank_HFI__c:'';

            appRecord.Terrace_Area__c      =u.Terrace_Area__c;
            appRecord.Terrace_Area_Price__c=u.Terrace_Area_Price__c;
            appRecord.Garden_Area__c       =u.Garden_Area__c;
            appRecord.Garden_Area_Price__c =u.Garden_Area_Price__c;
        }
        else{
        AppId=null;
        }
        if(AppId == null){
            appRecord = new Application_Form__c();
            
            appRecord.Opportunity__c=opp;
            appRecord.AGREEMENT_VALUE__c        =(appform.AGREEMENT_VALUE__c != null ) ?Integer.valueOf(appform.AGREEMENT_VALUE__c):0;
            appRecord.Rate_Brigade_as_a_Brand__c=(appform.Rate_Brigade_as_a_Brand__c != null ) ?Integer.valueOf(appform.Rate_Brigade_as_a_Brand__c):0;
            appRecord.Rate_Our_Product_Portfolio__c=(appform.Rate_Our_Product_Portfolio__c != null ) ?Integer.valueOf(appform.Rate_Our_Product_Portfolio__c):0;
            appRecord.Recommend_Brigade_to_your_friends__c=(appform.Recommend_Brigade_to_your_friends__c != null ) ?Integer.valueOf(appform.Recommend_Brigade_to_your_friends__c):0;
            appRecord.Experience_with_Brigade__c=(appform.Experience_with_Brigade__c != null ) ?Integer.valueOf(appform.Experience_with_Brigade__c):0;
            
            appRecord.Contact_Name__c=(con[0].Name != null || con[0].Name != '') ?con[0].Name:'';
            appRecord.Plant__c=(appform.Plant__c != null || appform.Plant__c != '') ?appform.Plant__c:'';
            
            appRecord.Unit__c=(appform.Unit__c != null || appform.Unit__c != '') ?appform.Unit__c:'';
           
            appRecord.Project__c= (appform.Project__c != null || appform.Project__c != '') ?appform.Project__c:'';
            appRecord.Customer_Bank_HFI__c= (appform.Customer_Bank_HFI__c != null || appform.Customer_Bank_HFI__c != '') ?appform.Customer_Bank_HFI__c:'';


            appRecord.Lead_Source__c=existingLead;
            appRecord.Terrace_Area__c      =u.Terrace_Area__c;
            appRecord.Terrace_Area_Price__c=u.Terrace_Area_Price__c;
            appRecord.Garden_Area__c       =u.Garden_Area__c;
            appRecord.Garden_Area_Price__c =u.Garden_Area_Price__c;
            
            if(RefferedById != null)
            appRecord.Referred_by_Name__c=RefferedById;
            appRecord.Referred_By_Name_Text__c=oppor.Referred_By_Name_Text__c;
            if(ChannelPartnerId != null)
            appRecord.Channel_Partner__c=ChannelPartnerId;
            //list<Application_Form__c> appps= new List<Application_Form__c>();
            //appps.add(appRecord);
            //Database.SaveResult[] srList = Database.insert(appps, false);
            /*for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                    AppId=sr.getId();
                    AppFormController.save(opp,EmailForPdf);
                }
            }*/
            insert appRecord;  
            //AppFormController.save(opp,EmailForPdf);
            
            system.debug(appRecord+'%%%%%%%%%%%%%');
         }
         
        if(RefferedById != null)
        appRecord.Referred_by_Name__c=RefferedById;
        if(ChannelPartnerId != null)
        appRecord.Channel_Partner__c=ChannelPartnerId;
        Integer k=oppdateFields.size();
        if(k>0){
        oppor.Date__c=AppFormController.calculateDate(String.valueOf(oppdateFields[0]));
        
        }if(k==2){
        oppor.CH_Date__c=AppFormController.calculateDate(String.valueOf(oppdateFields[1]));
        
        }
        
        if(flag==true){


            if((lead =='Agents' || lead =='Referral') && (discount > 0) && existingLead != lead ){
                
             appRecord.Discount_Approval_Status__c = 'Submitted';
             appRecord.Lead_Source_Approval_Status__c = 'Submitted';
             appRecord.Mail_Send_to_SAP_on_submit__c=true;
             appRecord.Requested_Lead_source__c = lead;
             appRecord.Discount_given_in_PSFT__c = discount;
             
             update appRecord;
             Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                System.debug('GGGGGGGGGGGG0');
                req1.setComments('Submitting request for approval0...');
                req1.setObjectId(appRecord.id);
                
                if(projectHeadId == null)
                return 'fail';
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                req1.setNextApproverIds(new Id[] {projectHeadId});
                Approval.ProcessResult result1 = Approval.process(req1);
            }else if((lead =='Agents' || lead =='Referral') && existingLead != lead){
                appRecord.Lead_Source_Approval_Status__c = 'Submitted';
                appRecord.Mail_Send_to_SAP_on_submit__c=true;
                appRecord.Requested_Lead_source__c = lead;
                oppor.Discount_Mail_Send_to_SAP_on_allotment__c=true;
                update appRecord;
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                System.debug('GGGGGGGGGGGG1');
                req1.setComments('Submitting request for approval1...');
                req1.setObjectId(appRecord.id);
                
                if(projectHeadId == null)
                return 'fail';
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                req1.setNextApproverIds(new Id[] {projectHeadId});
                Approval.ProcessResult result1 = Approval.process(req1);
            }else if(discount > 0 ){
                appRecord.Discount_Approval_Status__c = 'Submitted';
                appRecord.Mail_Send_to_SAP_on_submit__c=true;
                appRecord.Discount_given_in_PSFT__c = discount;
                
                update appRecord;
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                System.debug('GGGGGGGGGGGG2');
                req1.setComments('Submitting request for approval2...');
                req1.setObjectId(appRecord.id);
                
                if(projectHeadId == null)
                return 'fail';
                System.debug('ProjectHeadId' +projectHeadId);
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                req1.setNextApproverIds(new Id[] {projectHeadId});
                Approval.ProcessResult result = Approval.process(req1);
            }else{
                system.debug(appRecord+'@@@@@@@@@@@@zzzzz');
                if(lead != '')
                oppor.Lead_Source__c=lead;
                appRecord.Discount_Approval_Status__c = 'Approved';
                appRecord.Lead_Source_Approval_Status__c = 'Approved';
                oppor.Discount_Mail_Send_to_SAP_on_allotment__c = true;
                appRecord.Referred_by_Name__c=null;
                appRecord.Channel_Partner__c=null; 
                update appRecord;
                
                System.debug('oppor.Lead_Source__c');
                System.debug(oppor.Lead_Source__c);
            }
            save(opp,EmailForPdf);
            
        }
        else{
                
                if(lead !='Agents' && lead !='Referral')
                oppor.Lead_Source__c=lead;
                appRecord.Discount_Approval_Status__c = '';
                appRecord.Lead_Source_Approval_Status__c = '';
                update appRecord;
                
                System.debug('oppor.Lead_Source__c');
                System.debug(oppor.Lead_Source__c);
        }
        System.debug('Aaaa'+oppor);
        update oppor;
        
        return 'sucess';

    }
    public static Date calculateDate(string aDate){
        string[] newDate;
        string[] tempstrtdate;
        tempstrtdate =aDate.split('T');
        newDate=tempstrtdate[0].split('-'); 
        Date valueDate = Date.newInstance(Integer.valueOf(newDate[0]),Integer.valueOf(newDate[1]),Integer.valueOf(newDate[2]));
        return valueDate ;
    }
    
    public static PageReference save(String oppIdd,String emailAdd){
        
        AppFormController.attachPDF(oppIdd,emailAdd);
        
        PageReference pageWhereWeWantToGo = new PageReference ('/'+oppIdd); //we want to redirect the User back to the Account detail page
        pageWhereWeWantToGo.setRedirect(true);
        return pageWhereWeWantToGo; 
    }
    @future(callout=true)
    public static void attachPDF(String oppIdd,String emailAdd) {
        
        PageReference pdfPage = Page.ApplicationFormPdff;
        pdfPage.getParameters().put('Id',oppIdd);
        Blob pdfBlob;
        pdfBlob= Blob.valueOf('TestData');
        if (!Test.IsRunningTest())
                     {
                          pdfBlob = pdfPage.getContent();
                           
                     }else{
                        
                     }

        Attachment attach = new Attachment(ParentId = oppIdd, Name = 'ApplicationForm.pdf', body = pdfBlob,ContentType='application/pdf'); //create the attachment object
        
        insert attach; 
        /*Messaging.EmailFileAttachment attachh = new Messaging.EmailFileAttachment();
        attachh.setContentType('application/pdf');
        attachh.setFileName('ApplicationForm.pdf');
        attachh.setInline(false);
        attachh.Body = pdfBlob;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        Id ConId;
        try{
          ConId=[SELECT ContactId FROM OpportunityContactRole where OpportunityId  =: oppIdd  Limit 1].ContactId;
          
        }catch(Exception e){
            
        }
        
        Contact con;
        String emailAddress='';
        try{
           con=[SELECT Id,AccountId,Alternate_Email__c,District__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Designation__c,Country_Code_for_Mobile__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName FROM Contact where Id=:ConId And Contact_Type__c='First Applicant'];
            
            if(con.Email != '' && con.Email != null){
                
            emailAddress=con.Email;
            }
           }catch(Exception e){

           }
           
        if(con == null){
            
            try{

                con=[SELECT Id,AccountId,Alternate_Email__c,District__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Company__c,Designation__c,Country_Code_for_Mobile__c,Email,FirstName,Income_Tax_PAN_GIR_No__c,LastName FROM Contact where Id=:ConId Limit 1];
                System.debug('what is con email1'+con.Email);
                if(con.Email != '' && con.Email != null){
                    System.debug('con.email is not null1');
                emailAddress=con.Email;
                }
                }catch(Exception e){

                }
        }
        */
        
       /* mail.setToAddresses(new String[] { emailAddress });
        mail.setSubject('Application form Submitted');
        mail.setHtmlBody('Your Application form submitted is attached.Please check the Attachment.');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachh }); 
        
        try{
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
           //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with PDF sent to '+'ajeet.kumar6171@gmail.com'));
        }catch(Exception e){
        }*/
        
        
    }
    public class ProjectWrapper{
       public Decimal Area{get;set;}
       public Decimal TerraceArea{get;set;}
       public Decimal GardenArea{get;set;}
       public Decimal ClubHouseFee{get;set;}
    }
}