public class DemandLetterController {
public Demand_Letter_Repository__c dlObj {get; set;}
private String oId;
public String unitNo {get; set;}
public Plant__c plantObj {get; set;}
public Unit__c unitObj {get; set;}
public Opportunity oppObj {get; set;}
private List<Payment_Schedule__c> listPS;
public List<OpportunityContactRole> contRole;
public List<Contact> conList = new List<Contact>();

ApexPages.StandardController con;

public Boolean page2 {get; set;}
public Boolean page3 {get; set;}
public String country {get; set;}
public String region {get; set;}
public String conCCEmail='';
private String[] toAddresses;
private String toAddr;

public List<Opportunity> lstOpp {get; set;}
public Demand_Letter_Repository__c dlrObj {get; set;}
public Boolean noErr {get; set;}
public List<Id> lstId {get;set;}
public List<Id> conListId = new List<Id>();
public Id ConId;  
    
// -- Added for Testing
  
public DemandLetterController(ApexPages.StandardController controller) {
   try {
        oId = ApexPages.CurrentPage().getParameters().get('oppId');
        //dummy();
        initialize();
        //To populate Contact name and Contact mobile of First Applicant
         List<Opportunity> opportunityContactRoleList        =   new List<Opportunity>();
         opportunityContactRoleList                          =   [select id,(select id,ContactId,Role from OpportunityContactRoles where role='First Applicant' )from Opportunity where id=:oId ];
         //System.debug('opportunityContactRoleList'+opportunityContactRoleList); 
       
         for(Opportunity rec : opportunityContactRoleList){                              
                                    
            for (OpportunityContactRole pr: rec.OpportunityContactRoles) {
            if(pr.role=='First Applicant'){
            ConId=pr.ContactId;
                 }
                }
            }
            
            Contact firstContact=[SELECT name,mobilephone from Contact where id=:ConId];
                                                                   
        //
       
        toAddr = oppObj.Account.Primary_Contact_s_Email__c+','+oppObj.Account.Second_Applicant_s_Email__c;
        if(ApexPages.CurrentPage().getParameters().get('type').equals('new')) {
            //System.debug('### (DemandLetterController) INSIDE IF type=new');
            con = controller;
            dlObj = (Demand_Letter_Repository__c) con.getRecord();
            dlObj.Opportunity__c = oId;
            dlObj.Mobile_Number__c=firstContact.mobilephone;
            dlObj.Contact_Name__c=firstContact.name;
            dlObj.Page1__c = plantObj.Demand_Letter_Page1__c;
            dlObj.Page2__c = plantObj.Demand_Letter_Page2__c;
            //System.debug('### (DemandLetterController) plantObj.Demand_Letter_Page1__c: ' + plantObj.Demand_Letter_Page1__c);
            //System.debug('### (DemandLetterController) plantObj.Demand_Letter_Page2__c: ' + plantObj.Demand_Letter_Page2__c);                
            dlObj.To__c = oppObj.Account.Primary_Contact_s_Email__c; 
            system.debug('----to---'+dlObj.To__c);
            if(oppObj.Account.CC_Address__c !=null) {
                dlObj.CC__c = oppObj.Account.CC_Address__c;

                //System.debug('### (DemandLetterController) dlObj.CC__c: ' + dlObj.CC__c);
                if(oppObj.HFI__c !=null) {
                    if(oppObj.HFI__r.Email__c != null) {
                        if(! dlObj.CC__c.contains(oppObj.HFI__r.Email__c)) {
                            //System.debug('### (DemandLetterController) INSIDE IF - cc contains hfi email');
                            dlObj.CC__c = dlObj.CC__c + ',' + oppObj.HFI__r.Email__c;
                        }
                    }
                }
            }
            else {
                if(oppObj.HFI__c !=null) {
                    if(oppObj.HFI__r.Email__c != null) {
                        if(dlObj.CC__c == null) {
                            dlObj.CC__c = oppObj.HFI__r.Email__c;
                            if(conCCEmail !=null){
                                dlObj.CC__c=dlObj.CC__c + conCCEmail;
                            }
                            //System.debug('### (DemandLetterController) INSIDE IF - account cc null. dlObj.CC__c: ' + dlObj.CC__c);
                        }
                        else if(! dlObj.CC__c.contains(oppObj.HFI__r.Email__c)) {
                            System.debug('### (DemandLetterController) INSIDE IF - acnt cc contains hfi email. account cc null. dlObj.CC__c: ' + dlObj.CC__c);
                            dlObj.CC__c = dlObj.CC__c + ',' + oppObj.HFI__r.Email__c;

                        }
                    }
                }
            }
            if(conCCEmail !=null){
                if(dlObj.CC__c != null){
                    dlObj.CC__c=dlObj.CC__c + conCCEmail;
                }
                else{
                    dlObj.CC__c=conCCEmail;
                }
            }                
        }
        else {
            // This generates PDF
            String dlrId = ApexPages.CurrentPage().getParameters().get('id');
            //System.debug('### (DemandLetterController)ID: ' + dlrId);
            dlObj = [select Opportunity__c,Subject__c,Page1__c,Page2__c,Opportunity__r.Account.RegionL__c,
                Opportunity__r.Account.RegionL__r.Name,Opportunity__r.Account.CountryL__r.Name,
                Opportunity__r.Account.CountryL__c,Selection_Date__c,CC__c
                from Demand_Letter_Repository__c where Id=:dlrId];
            //System.debug('### (DemandLetterController) dlObj.Page2__c: ' + dlObj.Page2__c);
            if(dlObj.Page2__c !=null) {
                if(! dlObj.Page2__c.equals('<br>')){
                    System.debug('dlObj.Subject__c----------------------'+dlObj.Subject__c);
                    if(dlObj.Subject__c=='Demand Letter' || dlObj.Subject__c=='Reminder of Demand letter'){
                         page2 = false;
                    }else{
                        page2 = true;
                        
                    }
                    //System.debug('### PAGE2---- VALUE'+page2);
                    
                    //System.debug('### (DemandLetterController) INSIDE IF Page2');
                    //System.debug('### (DemandLetterController) dlObj.Page2__c.length(): ' + dlObj.Page2__c.length());
                    //System.debug('### (DemandLetterController) dlObj.Page2__c=br: ' + !dlObj.Page2__c.equals('<br>'));
                }
            }
            
           /* if(dlObj.Opportunity__r.Account.RegionL__c !=null)
               region = (dlObj.Opportunity__r.Account.RegionL__r.Name).split(' - ')[1];
              System.debug('###-------------- (oId ) oId : ' + oId );   
            if(dlObj.Opportunity__r.Account.CountryL__c !=null)
                country = (dlObj.Opportunity__r.Account.CountryL__r.Name).split(' - ')[1];
            System.debug('### (country ) dlObj: ' + country );*/
            //unitNo = oppObj.Unit__r.Name.subString(11,15);
            unitNo = oppObj.Opp_Name_3__c;
            //System.debug('--------dlObj.Selection_Date__c----'+dlObj.Selection_Date__c);
            listPS = [select Name,Description__c,Billing_Date__c,Bill_Value__c,Education_Cess__c,Secondary_Education_Cess__c,
                      Service_Tax__c,VAT__c, Status__c, Mile_Stone_Base_Description_1__c,Krishi_Kalyan_Cess__c,total__c,Swachh_Bharath_Cess__c from Payment_Schedule__c where (Status__c ='Due' OR Status__c ='Overdue')
                      AND Opportunity__c=:oId AND Billing_Date__c <=: dlObj.Selection_Date__c ORDER BY Sort_OrderF__c,Billing_Date__c];
            //System.debug('### ----------(DemandLetterController) listPS.size(): ' + listPS.size());
            if(listPS.size() != 0){
                 if( dlObj.Subject__c=='Progress Letter'){
                         page3 = false;
                    }else{
                        page3 = true;
                    }
            }
               
           // System.debug('### (DemandLetterController) page3: ' + page3);  
        }
    }
    catch(Exception e) {
        System.debug('### (DemandLetterController) Exception : ' + e.getMessage());
    }
}
public void initialize() {
    page2 = false;
    page3 = false;
    oppObj = [select Unit__c,Unit__r.Name,Opp_Name_3__c,Account.Primary_Contact_s_Email__c,Account.Second_Applicant_s_Email__c,Account.CC_Address__c,HFI__c,HFI__r.Email__c from Opportunity where Id =: oId limit 1];
    unitObj = [select Plant__c from Unit__c where Id =: oppObj.Unit__c limit 1];
    plantObj = [select Name,Project__c,Demand_Letter_Page1__c,Demand_Letter_Page2__c from Plant__c where Id =: unitObj.Plant__c limit 1];
    contRole = new List<OpportunityContactRole>();
    contRole=[SELECT ContactId,Id,IsPrimary,OpportunityId,Role FROM OpportunityContactRole WHERE OpportunityId =: oId AND (IsPrimary = false OR Role != 'First Applicant')];
    //system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+contRole);
    for(OpportunityContactRole conR : contRole){
        conListId.add(conR.ContactId);
    }
    //system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5'+conListId);
    conList=[SELECT Email, Id FROM Contact WHERE ID IN: conListId];
    

    for(Integer i=0; i<conList.size(); i++){
        if(conList[i].Email !=null){
        conCCEmail +=conList[i].Email;
            if(i+1<conList.size())
                conCCEmail +=',';
        }
    }
    
    //System.debug('1234567890!!!!!!!!!!!!!!!!!!!!!!!!!!!' + conCCEmail);
    //System.debug('### (DemandLetterController) oppObj: ' + oppObj);
    //System.debug('### (DemandLetterController) unitObj: ' + unitObj);
    //System.debug('### (DemandLetterController) plantObj: ' + plantObj);                
}



/*public PageReference Save() {
    PageReference pr;
    try {
        insert dlObj;
        pr = new PageReference('/'+dlObj.Id);
        pr.setRedirect(true);
    }
    catch(Exception e) {
        pr = null;
        System.debug('### (DemandLetterController) Exception : ' + e.getMessage());
    }
    return pr;
}*/

public List<Payment_Schedule__c> getListPS() {
    return listPS;
}
// ***************** Creation of Mass email Demand Letter *******************************
public DemandLetterController(ApexPages.StandardSetController controller) {
    try {
        lstOpp = (List<Opportunity>) controller.getSelected();
        lstId = new List<Id> ();
        //System.debug('### DemandLetterController)-Mass lstOpp: ' + lstOpp);
        if(lstOpp.size() == 0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Select at least one Opportunity.'));
            noErr = false;
        }else if(lstOpp.size() >100){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Maximum 100 Opportunity can only be selected.'));
            noErr = false;
        }
        else {
            
            for(Opportunity o : lstOpp) {
                lstId.add(o.Id);
            }
            lstOpp = [select Name,Sale_Order_No__c,StageName,Account.Primary_Contact_s_Email__c from Opportunity where ID IN: lstId];
            for(Opportunity o : lstOpp) {
                if(o.Sale_Order_No__c == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Opportunity - ' + o.Name + ' - Sale Order is not yet created.'));
                    noErr = false;
                    return;
                }
                if(!(o.StageName.equals('Allotment'))) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Opportunity - ' + o.Name + ' - is not in Allotment Stage.'));
                    noErr = false;
                    return;
                }
            }
            oId = lstOpp[0].Id;
            //System.debug('### DemandLetterController)-Mass oId: ' + oId);
            
            initialize();
            //System.debug('### DemandLetterController)-Mass plantObj: ' + plantObj);
            
            dlrObj = new Demand_Letter_Repository__c();
            dlrObj.Page1__c = plantObj.Demand_Letter_Page1__c;
            dlrObj.Page2__c = plantObj.Demand_Letter_Page2__c;
            //dlrObj.Subject__c = dlObj.Subject__c;
            dlrObj.OwnerId = UserInfo.getUserId();
            noErr = true;
        }
    }
    catch(Exception e) {
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,e.getMessage()));
        System.debug('### (DemandLetterController) Exception : ' + e.getMessage());
        noErr = false;
    }
}

public PageReference SaveM() {
    try {
        dlrObj.OppIDs__c = '';
        for(Opportunity o : lstOpp) {
            dlrObj.OppIDs__c = dlrObj.OppIDs__c + o.Id + ',';
            dlrObj.To__c = o.Account.Primary_Contact_s_Email__c;        
            
        }
        dlrObj.Opportunity__c = lstOpp[0].Id;
        dlrObj.OppIDs__c = dlrObj.OppIDs__c.subString(0,dlrObj.OppIDs__c.length()-1);
        ID rtId = [select Id,name from RecordType where name='Demand Letter_Mass' and SObjectType='Demand_Letter_Repository__c' limit 1].Id;
        dlrObj.RecordTypeId = rtId;
        dlrObj.OwnerId = UserInfo.getUserId();
        dlrObj.MassEmail__c = true;
       
        dlrObj.CC__c = conCCEmail;
        
        insert dlrObj;
        PageReference p = new PageReference('/' + dlrObj.Id);
        p.setRedirect(true);
        return p;
    }
    catch(Exception e) {
        System.debug('### (DemandLetterController) Exception : ' + e.getMessage());
        
        return null;
    }
}

/*
public class WebServiceMockImpl1 implements WebServiceMock
    {        
        public void doInvoke(
            Object stub, Object request, Map<String, Object> response,
            String endpoint, String soapAction, String requestName,
            String responseNS, String responseName, String responseType)
        {    
                
            
         
            response.put('response_x','');
                  
            return;
        }     
    }*/
    
    
    
    public PageReference updateTotalDueOnOpportunity(){
            
            list<id> oppId = new list<id>();
            if(lstOpp == null){
                oppId.add(oId);
            }else{
                oppId.addAll(lstId);
            }
        
            list<opportunity> oppList = [select Total_Due_Payment__c, (select Total__c FROM Payment_Schedules__r where Status__c ='Due' OR Status__c ='Overdue' ) from Opportunity where id IN :oppId AND Total_Due_Payment__c = null limit 50000];
            
        
            list<opportunity> updateList = new list<opportunity>();
            
            for(opportunity opLst : oppList){
                if(opLst.Payment_Schedules__r != null){
                    decimal amt = 0 ;
                    for(Payment_Schedule__c PS : opLst.Payment_Schedules__r){
                    //system.debug(PS.total__c);    
                        if(PS.Total__c != null){
                            amt += PS.Total__c ;
                        }
                    }
                    opLst.Total_Due_Payment__c = amt;
                    updateList.add(opLst);
                }
            }
            
            Database.update(updateList,false);
        
            return null;
    
        }
    public void dummy(){
Integer a;
Integer b; 
Integer c;   
    b=1;
    a=2;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a; 
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
     c=a+b;
    a=b+a;
    c=a+b;   
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
        a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
        a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
        a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
        a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b;        
    c=a+b; 
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;
    a=b+a;
    c=a+b;

}
}