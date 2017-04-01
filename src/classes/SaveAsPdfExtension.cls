global without sharing class SaveAsPdfExtension {
    private ApexPages.StandardController std;
    public Opportunity op;
    public Application_Form__c appForm{get;set;}
    // the associated contacts
    public List<Contact> contacts;
    //public Boolean isTest{get; set;}
    
    // the associated contacts
    public Contact contact;
    
    public Application_form__c app;
    
    public Opportunity oppAgentReferrel;
    public Opportunity oppNotAgentReferrel;
    public string applicant1{get;set;}
    public string applicant2{get;set;}
    public string applicant3{get;set;}
    // Required extension constructor (empty, no-op)
    public SaveAsPDFExtension(ApexPages.StandardController controller) {
         std=controller;
         op=(Opportunity)std.getRecord();
        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm() + '/'; 
         
        system.debug(op+'!!!!!!!!'+op.id);
        List<Application_Form__c> appList1=new List<Application_Form__c>();
        appList1=[Select id,Terrace_Area__c,Terrace_Area_Price__c,Garden_Area__c,Garden_Area_Price__c,AGREEMENT_VALUE__c,Application_Status__c,Referred_by_Name__r.Name,Recommend_Brigade_to_your_friends__c,Rate_Brigade_as_a_Brand__c,Experience_with_Brigade__c,Rate_Our_Product_Portfolio__c,Channel_Partner__r.Name,Customer_Bank_HFI__c from Application_Form__c where Opportunity__c=:op.Id LIMIT 1];
       
        appForm = (appList1.size()>0 ) ? appList1[0] : new Application_Form__c(); 
        List<contact> contactList=[SELECT Id, Contact_Type__c from Contact where AccountId=:op.AccountId 
        And(Contact_Type__c='First Applicant' OR Contact_Type__c='Second Applicant' OR Contact_Type__c='Third Applicant') 
        order by createdDate Limit 3 ];
        String firstApplicant='';
        String secondApplicent='';
        String thridApplicent='';
        
        for(Contact c: contactList){
        if(c.Contact_Type__c =='First Applicant')
        firstApplicant=c.Id;
        if(c.Contact_Type__c =='Second Applicant')
        secondApplicent=c.Id;
        if(c.Contact_Type__c =='Third Applicant')
        thridApplicent=c.Id;
        
        }
        
        
           applicant1='';
        applicant2='';
        applicant3='';
        
        List<Project_Docs__c> docs= [SELECT Id,Name,Contact__c,AttachmentId__c,Document_Url__c,Document_Url_link__c,Contact_type__c,CP_Property__c FROM Project_Docs__c WHERE Opportunity__c=:op.Id ];
        
        if(docs.size() > 0){
            for(Project_Docs__c d : docs){
            if(firstApplicant !='' && d.Contact__c ==firstApplicant && d.Name=='Photo ID Proof')
                applicant1= '/servlet/servlet.FileDownload?file=' + d.AttachmentId__c;
                 if(secondApplicent!='' && d.Contact__c ==secondApplicent && d.Name=='Photo ID Proof')
                applicant2='/servlet/servlet.FileDownload?file=' + d.AttachmentId__c;
                 if(thridApplicent!='' && d.Contact__c ==thridApplicent && d.Name=='Photo ID Proof')
                applicant3= '/servlet/servlet.FileDownload?file=' + d.AttachmentId__c;
                
            }
            
        }
        List<StaticResource> resourceList;
        if(applicant1==''){
         resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :'Applicant1Image'];
        
        applicant1= '/resource/'+String.valueOf(resourceList[0].SystemModstamp.getTime())+'/'+resourceList[0].Name;
        }
        if(applicant2==''){
         resourceList = [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :'Applicant2Image'];
         applicant2= '/resource/'+String.valueOf(resourceList[0].SystemModstamp.getTime())+'/'+resourceList[0].Name;
        }
        
        if(applicant3==''){ 
         resourceList = [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :'Applicant3Image'];
        applicant3= '/resource/'+String.valueOf(resourceList[0].SystemModstamp.getTime())+'/'+resourceList[0].Name;
        }
            
            }

    /*
    // Determines what kind of rendering to use for the page request
    public String renderingService { get; private set; }
    
    // Allow the page to set the PDF file name
    public String renderedFileName { 
        get; 
        set { renderedFileName = this.sanitizeFileName(value); }
    }
   */
    public Opportunity getOpportunity()
    {
     return (Opportunity) std.getRecord();
    }
    /*
    // Rendered content MIME type, used to affect HTTP response
    public String renderedContentType {
        get {
            String renderedContentType = 'text/html'; // the default
            
            if( ! this.renderingAsHtml() ) {
                // Provides a MIME type for a PDF document 
                renderedContentType = 'application/pdf';
                
                // Add a file name for the PDF file
                if( this.renderedFileName != null) {
                    // This is supposed to set the file name, but it doesn't work
                    renderedContentType += '#' + this.renderedFileName;
                    
                    // This is a work-around to set the file name
                    ApexPages.currentPage().getHeaders().put(
                        'content-disposition', 'attachment; filename=' + 
                         this.renderedFileName);
                }
            }
            
            return renderedContentType;
        }
    }
    
    // Are we rendering to HTML or PDF?
    public Boolean renderingAsHtml() {
        return ( (renderingService == null) || 
                 ( ! renderingService.startsWith('PDF')) );
    }

    // Action method to save (or "print") to PDF
    public PageReference saveToPdf() {
        renderingService = 'PDF';
        return null;
    }
    
    // Private helper -- basic, conservative santization
    private String sanitizeFileName(String unsafeName) {
        String allowedCharacters = '0-9a-zA-Z-_.';
        String sanitizedName = 
            unsafeName.replaceAll('[^' + allowedCharacters + ']', '');
        // You might also want to check filename length, 
        // that the filename ends in '.pdf', etc.
        return(sanitizedName);
    }*/
    //Opportunity opp = [select Lead_source__c,Reffered_Agent__c  FROM Opportunity where ID =:getOpportunity().ID];
    public Opportunity getoppAgentReferrel(){
        Opportunity opp = [select Lead_source__c,Reffered_Agent__c  FROM Opportunity where ID =:getOpportunity().ID];
        if(opp.Lead_source__c == 'Agents' || opp.Lead_source__c == 'Referral'){
            return opp;
        }else{
            return null;
        }
    }
    public Application_form__c  getapp(){
        Application_form__c app = [SELECT id,Customer_Bank_HFI__c from Application_form__c where Opportunity__c =:getOpportunity().ID];
        return app;
        
    }
    public Opportunity getoppNotAgentReferrel(){
        Opportunity opp = [select Lead_source__c,Reffered_Agent__c FROM Opportunity where ID =:getOpportunity().ID];
        if(opp.Lead_source__c != 'Agents' && opp.Lead_source__c != 'Referral'){
            return opp;
        }else{
            return null;
        }
    }
    
    public List<Contact> getContacts()
    {
       List<OpportunityContactRole > oppcontactRole = new list<OpportunityContactRole>();
        oppcontactRole = [SELECT Id, ContactId, OpportunityId,contact.Email,contact.Name,contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =: getOpportunity().ID];
       Opportunity o= [SELECT AccountId FROM Opportunity where Id=:getOpportunity().ID];
       
        Set<ID> setOfcontact = new Set<Id>();
        if(oppcontactRole.size() > 0){
            for(OpportunityContactRole opp: oppcontactRole){
                setOfcontact.add(opp.ContactId);
            }
        }
        contacts=[SELECT Id,Contact_Type__c,Birthdate, Name, Email, Phone, Title,  
                        Salutation,LeadSource,Middle_Name__c,Company__c, LastName,Wedding_Anniversary__c,Spouse_s_Name__c,Passport_No__c,Nationality__c, 
                        Industry__c,Relation__c,Profession__c,Relation_Name__c,Residency_Status__c,Income_Tax_PAN_GIR_No__c,MobilePhone,Country_Code_for_Mobile__c,FirstName, Fax, Description, Department,Designation__c
                         FROM Contact 
                         WHERE AccountId =: o.AccountId
                         ORDER BY CreatedDate];
                                 
       return contacts;
    }
    
    public Contact getContact()
    {
        OpportunityContactRole  oppcontactRole = new OpportunityContactRole();
        try{
        oppcontactRole = [SELECT Id, ContactId, OpportunityId,contact.Email,contact.Name,contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =: getOpportunity().ID AND contact.Contact_Type__c='GPA Holder'];
        
        }catch(Exception e){
        
        }
        Contact con = new contact();
        if(oppcontactRole.ContactId != null)
        try{
            con =[SELECT Id,Contact_Type__c,Birthdate,Street1__c,Street2__c,Street3__c,MailingCity,MailingPostalCode,District__c,MailingState,MailingCountry, Name, Email, Phone, Title,  
                        Salutation,LeadSource,Middle_Name__c,Company__c, LastName,Wedding_Anniversary__c,Spouse_s_Name__c,Passport_No__c,Nationality__c, 
                        Industry__c,Relation__c,Profession__c,Relation_Name__c,Residency_Status__c,Country_Code_for_Mobile__c,Income_Tax_PAN_GIR_No__c,MobilePhone,FirstName, Fax, Description, Department,Designation__c
                         FROM Contact 
                         WHERE Id =: oppcontactRole.ContactId And Contact_Type__c='GPA Holder'
                         ORDER BY CreatedDate];
        
        }catch(Exception e){
        
        }
        
                                 
       return con;
    }
    public void createPdf(){


    }
}