//-----------------------------------------------------------------------------------------------
// Visualforce Custom Controller: CPprofileCreationpagecon()
// Purpose:Override the mirror information,send a mail to admin
// Requires Sending mailing messages
// Portals user logged details
// Overrideing the mirror information     
// -----------------------------------------------------------------------------------------------

public class CPprofileCreationpagecon {

	public string selectedcodenew {
		get;
		set;
	}
	public String selectcontry {
		get;
		set;
	}
	public String headerCountry1 {
		get;
		set;
	}
	public String headerCountry2 {
		get;
		set;
	}
	public String seletecedCity {
		get;
		set;
	}
	public boolean ImagenewNoFeedBack {
		get;
		set;
	}
	public String selectedRT {
		get;
		set;
	}
	public String contactTypeValue {
		get;
		set;
	}
	Public List < SelectOption > contactTypeCode {
		get;
		set;
	}
	////  Controlling POPup
	//Public List<SelectOption> Options { get; set; } 
	public boolean displayPopup {
		get;
		set;
	}
	List < String > countries {
		get;
		set;
	}
	//public User usr {get; set;}
	public List < CP_Property__c > listProperty {
		get;
		set;
	}
	public List < CP_Property__c > listProperty2 {
		get;
		set;
	}
	public String selectedValue {
		get;
		set;
	}
	public String selectedCode {
		get;
		set;
	}
	Public List < SelectOption > projectOption {
		get;
		set;
	}
	Public List < SelectOption > unitCodeOption {
		get;
		set;
	}
	Public String projectValue {
		get;
		set;
	}
	Public Set < String > projectSet {
		get;
		set;
	}
	public boolean Imagenew {
		get;
		set;
	}
	public boolean cpprofileall {
		get;
		set;
	}

	// variable Declaration
	public List < Admin_URL__c > admUrl = new List < Admin_URL__c > ();
	public string flag {
		get;
		set;
	}
	public BG_CPprofile__c CPprofileObj {
		get;
		set;
	}
	public BG_CPprofile__c CPprofileObj2 {
		get;
		set;
	}
	public BG_CPprofile__c CPprofileObj3 {
		get;
		set;
	}
	public user usr;
	public user usrAdmin;
	public boolean dispCon {
		get;
		set;
	}
	public boolean CPupdatepage {
		get;
		set;
	}
	public boolean CPupdatepage1 {
		get;
		set;
	}
	public boolean newInfo {
		get;
		set;
	}
	String userinfomail = UserInfo.getUserId();
	public boolean fieldvalues {
		get;
		set;
	}
	public boolean fieldvalues1 {
		get;
		set;
	}
	public BG_CPprofile__c fieldvalues2 {
		get;
		set;
	}
	public contact con {
		get;
		set;
	}
	public account acc {
		get;
		set;
	}
	public boolean test {
		get;
		set;
	}
	public opportunity opp;
	public Plant__c plant;
	public boolean OnlysingleProject {
		get;
		set;
	}
	public user uu {
		get;
		set;
	}
	public Brigade_Admin_Email__c briAd = new Brigade_Admin_Email__c();
	list < Plant__c > plants = new list < Plant__c > ();
	list < Contact > listCon = new list < Contact > ();
	List < Id > accIds = new List < Id > ();
	public string unitnumber {
		get;
		set;
	}
	Set < String > adminEmails = new Set < String > ();
	// Constructor
	public CPprofileCreationpagecon() {

		cpProfile();
		admUrl = Admin_URL__c.getall().values();

	}
	public pagereference cpProfile() {
		//system.assertEquals(1,2);
		dispCon = false;
		CPprofileObj = new BG_CPprofile__c();
		try {
			if (Userinfo.getUserId() != null) {

				/* contactTypeCode = new List<SelectOption>();
                contactTypeCode.add(new SelectOption('First Applicant','First Applicant'));
                contactTypeCode.add(new SelectOption('Second Applicant','Second Applicant'));
                contactTypeCode.add(new SelectOption('Third Applicant','Third Applicant'));
                contactTypeCode.add(new SelectOption('Fourth Applicant','Fourth Applicant'));
            
            if(selectedRT==null){
                contactTypeValue='First Applicant';
                system.debug('***********1**************'+contactTypeValue);
            }
            else{
                contactTypeValue=selectedRT;
                system.debug('*************2************'+contactTypeValue);
            }
            system.debug('*************3************'+contactTypeValue); */


				projectSet = new Set < String > ();

				uu = [select Id, Name, ContactId From User Where Id = : Userinfo.getUserId()];

				User user = [select Id, Name, ContactId From User Where Id = : Userinfo.getUserId()];

				if (user.ContactId != Null) {
					listProperty = [SELECT Contact_User_Id__c, Id, Name, Opportunity_Id__c,
					Plant__c, Property_External_ID__c, Sales_Organisation__c,
					Target__c, Unit_Code__c, Project_Name__c, Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c = : user.id AND Active__c = true];

					User u = [select Id, Name, OpportunityId__c From User Where Id = : Userinfo.getUserId()];
					system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' + u.OpportunityId__c);

					if (u.OpportunityId__c == null) {
						system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^' + listProperty);
						selectedValue = listProperty[0].Project_Name__c;
						//getUnitCodeValue();
						selectedcode = listProperty[0].Project_Unit_No__c;
						//getPaymentList();          
						list < string > ss = (listProperty[0].Project_Unit_No__c).split('-');
						selectedcodenew = ss[0];
						unitnumber = ss[3];
						OnlysingleProject = false;


					} else {
						listProperty2 = [SELECT Contact_User_Id__c, Id, Name, Opportunity_Id__c,
						Plant__c, Property_External_ID__c, Sales_Organisation__c,
						Target__c, Unit_Code__c, Project_Name__c, Project_Unit_No__c FROM CP_Property__c Where Opportunity_Id__c = : u.OpportunityId__c AND Active__c = true];
						selectedValue = listProperty2[0].Project_Name__c;

						selectedcode = listProperty2[0].Project_Unit_No__c;

						list < string > ss = (listProperty2[0].Project_Unit_No__c).split('-');
						selectedcodenew = ss[0];
						unitnumber = ss[3];
						OnlysingleProject = true;


					}

				} else {
					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Project Available');
					ApexPages.addMessage(myMsg);
				}


				//-------------------------------------------------------------------------------------------------------             
				flag = Apexpages.currentpage().getparameters().get('flagvalue');
				system.debug('********************flag ' + flag);
				if (flag == 'true') {
					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'Information uploaded succesfully. To be verified by Portal administration.');
					ApexPages.addMessage(myMsg);
				}
				CPprofileObj2 = new BG_CPprofile__c();
				CPprofileObj = new BG_CPprofile__c();

				con = new contact();

				usr = [select id, lastname, firstname, Name, Contactid, AccountId, email, OpportunityId__c from user where id = : UserInfo.getUserId()];

				//  usr=[SELECT id,OpportunityId__c,contactid FROM User where OpportunityId__c ='006f0000003Sqya']; 
				system.debug('??????????????????????????????????' + usr);

				try {

					if (usr.OpportunityId__c != null) {

						opp = [SELECT id, accountid, Plant_Owner__c, Unit_Name__c from opportunity where id = : usr.OpportunityId__c];
						system.debug('*************4************' + contactTypeValue);

						listCon = [SELECT Id, Contact_Type__c FROM Contact Where Accountid = : opp.accountid ORDER BY CreatedDate ASC];
						contactTypeCode = new List < SelectOption > ();
						for (Contact c: listCon) {
							contactTypeCode.add(new SelectOption(c.Contact_Type__c, c.Contact_Type__c));

						}
						system.debug('987654321' + selectedRT);
						if (selectedRT == 'Second Applicant') {
							dispCon = true;
							system.debug('123456789' + dispCon);
						}

						if (selectedRT == null) {
							contactTypeValue = 'First Applicant';
							system.debug('***********1**************' + contactTypeValue);
						} else {
							contactTypeValue = selectedRT;
							system.debug('*************2************' + contactTypeValue);
						}
						system.debug('*************3************' + contactTypeValue);

						con = [SELECT id, accountid, name, LastName, Birthdate, Email, Wedding_Anniversary__c, MobilePhone, Income_Tax_PAN_GIR_No__c, Company__c,
						Designation__c, Educational_Qualification__c, Profession__c, Booking_CSAT_Feed_back_form__c, ExecutionwithModification_Feed_back_fo__c, Execution_withoutmodification_Feed_back__c,
						Handover_Feed_back_form__c, X1st_year_Handover_Feedback__c, Industry__c, Contact_Type__c, House_number__c, Mailingcity, MailingStreet, MailingCountry, MailingPostalCode
						from contact where accountid = : opp.accountid and Contact_Type__c = : contactTypeValue limit 1];

						acc = [SELECT Id, House_number__c, Street1__c, Street2__c, Street3__c, Postal_Code__c, City__c, CountryL__r.Name FROM Account WHERE Id = : opp.accountid];
						system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' + con);

						if (con.Contact_Type__c == 'First Applicant') {
							CPprofileObj = [SELECT id, CPprofile_Name__c, Contact__c, CPprofile_Mobile__c, name, CPprofile_BirthDate__c, CPprofile_EmailForCommunication__c, CPprofile_BillingStreet__c,
							CPprofile_Wedding_Anniversary__c, Portal_UserMobile__c, CPprofile_MailingCountry__c, CPprofile_MailingPostCode__c, CPprofile_BillingState__c,
							CPprofile_MailingCity__c, CPprofile_BillingPostcode__c, CPprofile_BillingCountry__c, CPprofile_Designation__c, CPprofile_IncomeTaxPANGIRNo__c, CPprofile_Company__c,
							CPprofile_MailingState__c, CPprofile_MirroringName__c, CPprofile_Industry__c, CPprofile_ReasonforReject_del__c,
							CPprofile_EducationalQualification__c, CPprofile_MirroringIndustry__c, CPprofile_MirroringProfession__c,
							CPprofile_MirrorEducationalQualification__c, CPprofile_MirroringDesignation__c, CPprofile_MirroringCompany__c,
							Mailing_Address__c, CPprofile_Profession__c, CPprofile_MailingStreet__c, CPprofile_HouseNumber__c,
							CPprofile_BillingCity__c, CPprofile_Street1__c, CPprofile_Street2__c, CPprofile_Street3__c, CP_profile_MirrorBirthdate__c, CP_Profile_MirrorWedding_Anniversary__c from BG_CPprofile__c
							where Contact__c = : con.id limit 1];

							system.debug('********************CPprofileObj' + CPprofileObj);


							system.debug('***********************************' + usr.id);
							List < CP_Property__c > cpList = [select id, Project_Unit_No__c, Plant__c from CP_Property__c where Contact_User_Id__c = : usr.id and Opportunity_Id__c = : usr.OpportunityId__c];
							system.debug('***********************************cplist' + cplist);
							set < String > pList = new Set < String > ();
							for (CP_Property__c cpproperty: cpList) {
								pList.add(cpproperty.Plant__c);
							}
							system.debug('***********************************pList' + pList);
							plants = [select id, Name, OwnerId, Admin_Email__c, Plant__c,Admin_Full_Name__c,Admin_User__c from Plant__c where Plant__c IN: pList];
							system.debug('++++++++++++++++++adminEmails' + plants);
							for (Plant__c pl: plants) {
								adminEmails.add(pl.Admin_Email__c);


							}
							system.debug('***********************************' + plants);
						}

					} else {

						CP_Property__c cp = [Select Id, Contact_User_Id__c, Opportunity_Id__c From CP_Property__c Where Contact_User_Id__c = : usr.Id];
						system.debug('***********************************cp' + cp);
						system.debug([select id, name from opportunity limit 10]);
						opp = [SELECT id, accountid, Account.Parent.Id, Plant_Owner__c, Unit_Name__c from opportunity where id = : cp.Opportunity_Id__c];
						system.debug('***********************************opp ' + opp);
						listCon = [SELECT Id, Contact_Type__c FROM Contact Where Accountid = : opp.accountid ORDER BY CreatedDate ASC];
						contactTypeCode = new List < SelectOption > ();
						for (Contact c: listCon) {
							contactTypeCode.add(new SelectOption(c.Contact_Type__c, c.Contact_Type__c));

						}
						system.debug('987654321' + selectedRT);
						if (selectedRT == 'Second Applicant') {
							dispCon = true;
							system.debug('123456789' + dispCon);
						}

						if (selectedRT == null) {
							contactTypeValue = 'First Applicant';
							system.debug('***********1**************' + contactTypeValue);
						} else {
							contactTypeValue = selectedRT;
							system.debug('*************2************' + contactTypeValue);
						}
						system.debug('*************3************' + contactTypeValue);

						con = [SELECT id, accountid, name, LastName, Birthdate, Email, Wedding_Anniversary__c, MobilePhone, Income_Tax_PAN_GIR_No__c, Company__c,
						Designation__c, Educational_Qualification__c, Profession__c, Booking_CSAT_Feed_back_form__c, ExecutionwithModification_Feed_back_fo__c, Execution_withoutmodification_Feed_back__c,
						Handover_Feed_back_form__c, X1st_year_Handover_Feedback__c, Industry__c, Contact_Type__c, House_number__c, Mailingcity, MailingStreet, MailingCountry, MailingPostalCode
						from contact where accountid = : opp.accountid and Contact_Type__c = : contactTypeValue limit 1];

						acc = [SELECT Id, House_number__c, Street1__c, Street2__c, Street3__c, Postal_Code__c, City__c, CountryL__r.Name FROM Account WHERE Id = : opp.accountid];
						system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' + con);

						CPprofileObj = [SELECT id, CPprofile_Name__c, Contact__c, name, CPprofile_Mobile__c, CPprofile_BirthDate__c, CPprofile_EmailForCommunication__c, CPprofile_BillingStreet__c,
						CPprofile_Wedding_Anniversary__c, CPprofile_MailingCountry__c, CPprofile_MailingPostCode__c, CPprofile_BillingState__c,
						CPprofile_MailingCity__c, Portal_UserMobile__c, CPprofile_BillingPostcode__c, CPprofile_BillingCountry__c, CPprofile_Designation__c, CPprofile_IncomeTaxPANGIRNo__c, CPprofile_Company__c,
						CPprofile_MailingState__c, CPprofile_MirroringName__c, CPprofile_Industry__c, CPprofile_ReasonforReject_del__c,
						CPprofile_EducationalQualification__c, CPprofile_MirroringIndustry__c, CPprofile_MirroringProfession__c,
						CPprofile_MirrorEducationalQualification__c, CPprofile_MirroringDesignation__c, CPprofile_MirroringCompany__c,
						Mailing_Address__c, CPprofile_Profession__c, CPprofile_MailingStreet__c, CPprofile_HouseNumber__c,
						CPprofile_BillingCity__c, CPprofile_Street1__c, CPprofile_Street2__c, CPprofile_Street3__c, CP_profile_MirrorBirthdate__c, CP_Profile_MirrorWedding_Anniversary__c from BG_CPprofile__c
						where Contact__c = : con.id];

						system.debug('********************CPprofileObj' + CPprofileObj);

						system.debug('***********************************' + usr.id);
						List < CP_Property__c > cpList = [select id, Plant__c from CP_Property__c where Contact_User_Id__c = : usr.id];
						system.debug('***********************************cplist' + cplist);
						set < String > pList = new Set < String > ();
						for (CP_Property__c cpproperty: cpList) {
							pList.add(cpproperty.Plant__c);
						}
						system.debug('***********************************pList' + pList);
						plants = [select id, ownerId, Name, Admin_Email__c, Plant__c,Admin_Full_Name__c,Admin_User__c from Plant__c where Plant__c IN: pList];
						system.debug('++++++++++++++++++adminEmails' + plants);
						for (Plant__c pl: plants) {
							adminEmails.add(pl.Admin_Email__c);
						}
						system.debug('***********************************' + plants);
					}

				} catch (DmlException ex) {

					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
					ApexPages.addMessage(myMsg);

				}

			}

		} catch (Exception e) {
			cpprofileall = true;
			ImagenewNoFeedBack = true;
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
			ApexPages.addMessage(myMsg);

		}



		//Blinking Part
		try {

			if (usr.OpportunityId__c != Null) {

				/*  Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:usr.OpportunityId__c];
           
           Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];  
               
               */

				Opportunity opp = [Select Id, X1st_year_Handover_Feedback__c, Booking_CSAT_Feed_back_form__c, Execution_with_Modification_Feed_back_fo__c,
				Execution_without_modification_Feed_back__c, Handover_Feed_back_form__c, AccountId, Unit_Name__c from Opportunity Where Id = : usr.OpportunityId__c];


				if (opp.X1st_year_Handover_Feedback__c == false || opp.Handover_Feed_back_form__c == false || opp.Execution_without_modification_Feed_back__c == false || opp.Execution_with_Modification_Feed_back_fo__c == false || opp.Booking_CSAT_Feed_back_form__c == false) {

					Imagenew = true;
					ImagenewNoFeedBack = false;

				} else if (opp.X1st_year_Handover_Feedback__c == true && opp.Handover_Feed_back_form__c == true && opp.Execution_without_modification_Feed_back__c == true && opp.Execution_with_Modification_Feed_back_fo__c == true && opp.Booking_CSAT_Feed_back_form__c == true) {

					ImagenewNoFeedBack = true;
					Imagenew = false;

				}

			} else {

				listProperty = [SELECT Contact_User_Id__c, Id, Name, Opportunity_Id__c,
				Plant__c, Property_External_ID__c, Unit_Code__c, Project_Name__c, Active__c, Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c = : usr.id AND Active__c = true];

				/*    Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
                
                Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
                
                */

				system.debug('***********************************listProperty ' + listProperty);
				Opportunity opp = [Select Id, X1st_year_Handover_Feedback__c, Booking_CSAT_Feed_back_form__c, Execution_with_Modification_Feed_back_fo__c,
				Execution_without_modification_Feed_back__c, Handover_Feed_back_form__c, AccountId, Unit_Name__c, Plant2__r.Admin_User__r.Name from Opportunity Where Id = : listProperty[0].Opportunity_Id__c];
				system.debug('***********************************opp' + opp);
				if (opp.X1st_year_Handover_Feedback__c == false || opp.Handover_Feed_back_form__c == false || opp.Execution_without_modification_Feed_back__c == false || opp.Execution_with_Modification_Feed_back_fo__c == false || opp.Booking_CSAT_Feed_back_form__c == false) {

					Imagenew = true;
					ImagenewNoFeedBack = false;
				} else if (opp.X1st_year_Handover_Feedback__c == true && opp.Handover_Feed_back_form__c == true && opp.Execution_without_modification_Feed_back__c == true && opp.Execution_with_Modification_Feed_back_fo__c == true && opp.Booking_CSAT_Feed_back_form__c == true) {

					ImagenewNoFeedBack = true;
					Imagenew = false;
				}

			}
		} Catch(Exception e) {
			cpprofileall = true;
			ImagenewNoFeedBack = true;
			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'User Information currently not available');
			ApexPages.addMessage(myMsg);

		}
		return null;
	}

	// New Informtion section 
	public PageReference searchPage() {
		fieldvalues = true;
		return null;
	}


	// Cancel page            
	public PageReference cancelpage() {
		pagereference celpage = new pagereference('/apex/CPprofileCreationpage');
		celpage.setredirect(true);
		return celpage;
	}
	// Edit button page
	public pageReference updatepage() {
		try {

			if (CPprofileObj2.CP_profile_MirrorBirthdate__c == null && CPprofileObj2.CP_Profile_MirrorWedding_Anniversary__c == null && CPprofileObj2.CPprofile_MirroringName__c == null && CPprofileObj2.CPprofile_MirroringEmailForCommunication__c == Null && CPprofileObj2.CPprofile_MirroringMobile__c == null && CPprofileObj2.CPprofile_MirroringHouseNumber__c == Null && CPprofileObj2.CPprofile_MirroringStreet1__c == null && CPprofileObj2.CPprofile_MirroringStreet2__c == null && CPprofileObj2.CPprofile_MirroringStreet3__c == null && CPprofileObj2.CPprofile_MirroringMailing_City__c == null && CPprofileObj2.CPprofile_MirroringMailingState__c == null && CPprofileObj2.CPprofile_MirroringMailingPostCode__c == null && CPprofileObj2.CPprofile_MirroringMailingCountry__c == null && CPprofileObj2.CPprofile_MirroringCompany__c == null && CPprofileObj2.CPprofile_MirroringDesignation__c == null && CPprofileObj2.CPprofile_MirroringIndustry__c == null && CPprofileObj2.CPprofile_MirrorEducationalQualification__c == null && CPprofileObj2.CPprofile_MirroringProfession__c == null) {
				ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Fill New Information ');
				ApexPages.addMessage(myMsg);
				return null;

			} else {
				CPprofileObj.CPprofile_MirroringName__c = CPprofileObj2.CPprofile_MirroringName__c;
				CPprofileObj.CPprofile_MirroringEmailForCommunication__c = CPprofileObj2.CPprofile_MirroringEmailForCommunication__c;
				CPprofileObj.CPprofile_MirroringMobile__c = CPprofileObj2.CPprofile_MirroringMobile__c;
				CPprofileObj.CPprofile_MirroringHouseNumber__c = CPprofileObj2.CPprofile_MirroringHouseNumber__c;
				CPprofileObj.CPprofile_MirroringStreet1__c = CPprofileObj2.CPprofile_MirroringStreet1__c;
				CPprofileObj.CPprofile_MirroringStreet2__c = CPprofileObj2.CPprofile_MirroringStreet2__c;
				CPprofileObj.CPprofile_MirroringStreet3__c = CPprofileObj2.CPprofile_MirroringStreet3__c;
				CPprofileObj.CPprofile_MirroringMailing_City__c = CPprofileObj2.CPprofile_MirroringMailing_City__c;
				CPprofileObj.CPprofile_MirroringMailingState__c = CPprofileObj2.CPprofile_MirroringMailingState__c;
				CPprofileObj.CPprofile_MirroringMailingPostCode__c = CPprofileObj2.CPprofile_MirroringMailingPostCode__c;
				CPprofileObj.CPprofile_MirroringMailingCountry__c = CPprofileObj2.CPprofile_MirroringMailingCountry__c;
				CPprofileObj.CPprofile_MirroringCompany__c = CPprofileObj2.CPprofile_MirroringCompany__c;
				CPprofileObj.CPprofile_MirroringDesignation__c = CPprofileObj2.CPprofile_MirroringDesignation__c;
				CPprofileObj.CPprofile_MirroringIndustry__c = CPprofileObj2.CPprofile_MirroringIndustry__c;
				CPprofileObj.CPprofile_MirrorEducationalQualification__c = CPprofileObj2.CPprofile_MirrorEducationalQualification__c;
				CPprofileObj.CPprofile_MirroringProfession__c = CPprofileObj2.CPprofile_MirroringProfession__c;
				CPprofileObj.CP_profile_MirrorBirthdate__c = CPprofileObj2.CP_profile_MirrorBirthdate__c;
				CPprofileObj.CP_Profile_MirrorWedding_Anniversary__c = CPprofileObj2.CP_Profile_MirrorWedding_Anniversary__c;



				try {
					update CPprofileObj;
					system.debug('***********************************' + CPprofileObj);

					system.debug('admin emaill information' + usr);

					//Unit__c unit=[SELECT Id From Unit__c where Plant__c =: plants[0].Id ];
					//system.assertEquals(unit,null);
					EmailTemplate Emailtemplate = [SELECT Description, Body, Id, Name, BrandTemplateId, Markup, NamespacePrefix, TemplateStyle, Subject,
					TemplateType FROM EmailTemplate where name = : 'Brigade CPprofile Email'];
					system.debug('$$$$$$$$$$$$$$$$' + Emailtemplate.id);
					system.debug('$$$$$$$$$$$$$$$$' + plants);
					system.debug('$$$$$$$$$$$$$$$$' + adminEmails);
					//system.assertEquals(adminEmails,null);
					List < Task > tasklist = new List < Task > ();
					briAd = [select Name, Email__c FROM Brigade_Admin_Email__c LIMIT 1];
					List < Messaging.SingleEmailMessage > mails = new List < Messaging.SingleEmailMessage > ();
					for (Plant__c pl: plants) {
						system.debug('admin emaill information' + pl.Admin_Email__c);
						for (String adminmail: adminEmails) {
							if (adminmail == pl.Admin_Email__c && pl.Admin_Email__c <> Null) {
								//for(Unit__c u : unit){
								system.debug('admin emaill information' + adminmail);
								Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
								// system.assertEquals(adminmail,null);
								String[] ccAddresses = new String[] {
									briAd.Email__c
								};
								String[] toAddresses = new String[] {
									adminmail
								};
								// String[] toAddresses = new String[] {'udaya.kiran@extentor.com'};
								// string messageBody ;
								// mail.setTemplateId('00Xf0000000QJAN');
								//  mail.setTemplateId(Emailtemplate.id);
								//   mail.setTargetObjectId(CPprofileObj.Contact__c);
								system.debug('***********************************' + usr.contactid);
								//   mail.setwhatid(Opp.Id);  
								mail.setSubject('Portal User Updated Personal Information');
								mail.setToAddresses(toAddresses);
								mail.setCcAddresses(ccAddresses);
								
								string messageBody ='<html><body>Dear&nbsp; <FONT style = "BACKGROUND-COLOR: Yellow ; color : Red">'+pl.Admin_Full_Name__c+'</FONT>,<br/><br/>Portal user&nbsp;&nbsp;'+Usr.Name+'&nbsp;of&nbsp;'+opp.Unit_Name__c +'&nbsp; updated personal information.<br/>'+'<br/>'+'Click the link below to access it:'+'<br/>'+admUrl[1].URL_link__c+'/apex/Updatepage_RD?id='+CPprofileObj.Contact__c+'<br/>'+'<br/>'+'The Master Account Link of this Customer is:'+'<br/>'+admUrl[0].URL_link__c+''+Usr.AccountId+'<br/><br/><br/>Thanks & Regards,'+'<br/>'+'Portal Admin';
								
								system.debug('===================================: MesageBoday' + messageBody);
								mail.setHtmlBody(messageBody);
								mail.saveAsActivity = false;
								mails.add(mail);
								//}
								Task t = new task();
								t.OwnerId = pl.Admin_User__c;
								t.Whatid = opp.id;
								t.Whoid = CPprofileObj.Contact__c;
								t.Subject = 'Portal user updated personal information';
								t.ActivityDate = system.today() + 1;
								tasklist.add(t);
							}
						}
					}

					//system.assertEquals(mails,null); 
					Messaging.sendEmail(mails);
					//List<Messaging.SendEmailResult> results=
					//system.debug('the results is '+results);
					insert tasklist;
					PageReference ref = new PageReference('/apex/CPprofileCreationpage?flagvalue=true');
					ref.setredirect(true);
					return ref;
				} catch (DmlException ex) {
					ApexPages.addMessages(ex);
					return null;
				}
			}
		} catch (DmlException ex) {

			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
			ApexPages.addMessage(myMsg);

		}

		return null;
	}

	public pagereference countryDetails() {

		try {
			displayPopUp = false;
			system.debug('@@@@@@@@@@@@@@@@@' + headerCountry1);
			User u = [select Id, Name, OpportunityId__c, ContactId From User Where Id = : Userinfo.getUserId()];
			listProperty = [SELECT Contact_User_Id__c, Id, Active__c, Name, Opportunity_Id__c FROM CP_Property__c Where Contact_User_Id__c = : u.id];
			if (listProperty.size() > 1) {
				u.OpportunityId__c = headerCountry1;
				update u;
			}
			if (headerCountry1 != '') {
				Opportunity opp = [Select Id, Unit__r.Name, Project_Unit_No__c From Opportunity Where Id = : headerCountry1];
				headerCountry2 = opp.Project_Unit_No__c;
				system.debug('&&&&&&&&&&&&&&&&&&' + headerCountry2);

				//return null;
			}
			PageReference pageRef = new PageReference('/apex/CPprofileCreationpage#');
			pageRef.setRedirect(true);
			return pageRef;
		} catch (Exception e) {

			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
			ApexPages.addMessage(myMsg);
			return null;

		}


	}

	public List < SelectOption > getItems() {
		List < SelectOption > options = new List < SelectOption > ();
		try {
			displayPopup = false;
			User user = [select Id, Name, ContactId From User Where Id = : Userinfo.getUserId()];
			listProperty = [SELECT Contact_User_Id__c, Id, Name, Opportunity_Id__c, Unit_Code__c, Project_Unit_No__c, Project_Name__c, Active__c FROM CP_Property__c Where Contact_User_Id__c = : user.id AND Active__c = true];
			system.debug('##########listProperty#########' + listProperty);
			options.add(new SelectOption('', '---Please Select Project---'));
			if (listProperty.size() == 1) {
				displayPopup = false;
				headerCountry1 = listProperty[0].Opportunity_Id__c;
				headerCountry2 = listProperty[0].Project_Unit_No__c;
			}
			for (CP_Property__c cpProperty: listProperty) {
				if (cpProperty.Opportunity_Id__c <> null && cpProperty.Project_Unit_No__c <> null) {
					options.add(new SelectOption(cpProperty.Opportunity_Id__c, cpProperty.Project_Unit_No__c));
				}

			}
		} catch (DmlException ex) {

			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
			ApexPages.addMessage(myMsg);

		}

		return options;


	}
	public String[] getCountries() {
		return countries;
	}
	public void getReopenPopup() {
		try {
			User u = [select Id, Name, OpportunityId__c From User Where Id = : Userinfo.getUserId()];
			system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$' + u);
			if (u.OpportunityId__c != null) {
				displayPopup = true;
				system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@' + displayPopup);
			}
			system.debug('%%%%%%%%%%%%%%%%%%' + displayPopup);
			//PageReference pageRef = new PageReference('/apex/myPayment_ext#');
			//pageRef.setRedirect(true);
			//return pageRef ;
		} catch (DmlException ex) {

			ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cpprofile dont have contact information');
			ApexPages.addMessage(myMsg);

		}

	}

}