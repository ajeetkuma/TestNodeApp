public with sharing class SendEmail_For_CostSheet_Controller {
    
    public CostSheet__c costSheetDetails                                 {get;set;}
    public Contact      contactDetails                                   {get;set;}
    public String subject { get; set; }
    public String body { get; set; }
    
    public List<CostSheet__c> listOfCostSheets                           {get;set;}
    public List<Contact> listOfContacts = new List<Contact>();
    public List<String>  listOfValues                                           {get;set;}
    String costSheetId= ApexPages.currentPage().getParameters().get('id');
    
	public transient  string CS_unit{get;set;}
	public transient  string CS_project {get;set;}
    public list<string> ContactNameList{get;set;}
	
    
    public SendEmail_For_CostSheet_Controller(ApexPages.StandardController controller) {
        
        costSheetDetails = new CostSheet__c();
        listOfCostSheets = new List<CostSheet__c>();
        listOfCostSheets = [Select id, Opportunity__c,Account_ID__c,Unit__r.name , project__r.name From CostSheet__c where id =:costSheetId  ];
		
        system.debug('::::::::====Accounts'+listOfCostSheets);
        listOfContacts = [SELECT name,AccountId,Contact_Type__c,Email,Id FROM Contact where Contact_Type__c = 'First Applicant'];
        system.debug('::::::::====Contact'+listOfContacts);
        
		if(listOfCostSheets[0].Unit__c != null){
			CS_unit = listOfCostSheets[0].Unit__r.name;
		}
		
		if(listOfCostSheets[0].project__c != null){
			CS_project = listOfCostSheets[0].project__r.name;
		}
        
        Map<id,CostSheet__c > myCostSheetMap = new Map<id,CostSheet__c >();
        for (CostSheet__c cs : listOfCostSheets){
            myCostSheetMap.put(cs.Account_ID__c, cs);
            system.debug('::::::::====myCostSheetMap'+myCostSheetMap);
        }
        listOfValues = new List<String>();
        ContactNameList = new List<string>();
        for(Contact c: listOfContacts){
            if (myCostSheetMap.containsKey(c.AccountId)){
                // System.assertequals(c.Email,'a');
                listOfValues.add(c.Email);  
                ContactNameList.add(c.name);
                
            }   
        }
    }
    public PageReference sendEmailFunction() {
        // Define the email
        list<Messaging.SingleEmailMessage> emailList = new list<Messaging.SingleEmailMessage>();
        
        
        // Reference the attachment page and pass in the account ID
        PageReference pdf =  Page.Generate_Cost_Sheet;       
        pdf.getParameters().put('id',(String)costSheetId); 
        pdf.setRedirect(true);
        
        // Take the PDF content
        Blob b;
        try{
        	b	= pdf.getContent();
        }catch(VisualforceException e){
        	b = Blob.valueOf('No Content Found.');
        }
        
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        
        String addresses;
        if (listOfValues.size()>0)
        {
            addresses = listOfValues[0];
            
        }
        
        String[] toAddresses = listOfValues;
        user loggedUser = [select name,MobilePhone,UserRoleId from user where id =:system.UserInfo.getUserId()];
		string roleName;
		if(loggedUser.UserRoleId != null){
			roleName = [select name from userRole where id=:loggedUser.UserRoleId].name;
		}
        for(integer i=0 ; i < listOfValues.size() ;i++){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        // Sets the paramaters of the email
        email.setSubject( 'Tentative Cost Sheet for Unit number : '+ CS_unit +' in Project : '+ CS_project );
            email.setToAddresses( new string[] {listOfValues[i]} );
        email.setHtmlBody('<div align="center"><h2><b>Cost Sheet Document</b></h2></div>'+
                          '<br/><br/><br/>'+
                          'Dear '+ContactNameList[i]+',<br/><br/>' +
                          'Please find attached herewith the Cost Sheet for the Apartment '+ CS_unit +' in Project : '+ CS_project +'.'+'<br/>'+
						  'Awaiting your Positive response.'
					      +'<u>'+'</u>'+'<br/><br/>'+
                          'Thanks With regards ,<br/>'+loggedUser.name+'<br/>'+roleName+'<br/>'+loggedUser.MobilePhone+'<br/>');
        
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        emailList.add(email);
        }
        // Sends the email
        Messaging.SendEmailResult [] r = 
            Messaging.sendEmail(emailList);   
        
        return null;
        
    }
    public PageReference saveAndOpenPDF() {
        
        if (String.isBlank(ApexPages.currentPage().getParameters().get('displayOnly'))) {
            Id attachmentId = savePDF();
            return openPDF(attachmentId);
        } else {
            return null;
        }
    }
    
    public Id savePDF() {
        Attachment attachment = new Attachment();
        attachment.ParentId = costSheetId;
        attachment.name = 'PDF_'+String.valueof(Datetime.now())+'.pdf';
        PageReference pdf = Page.Generate_Cost_Sheet;
        pdf.getParameters().put('Id', costSheetId);
        pdf.getParameters().put('displayOnly', '1');
        pdf.setRedirect(true);
        try {
            attachment.Body = pdf.getContent();
        }
        catch (VisualForceException e) {
            attachment.Body = Blob.valueof('There was an error.');
        }
        attachment.ContentType = 'application/pdf';
        insert attachment;
        return attachment.Id;
    }
    
    public PageReference openPDF(Id attachmentId) {
        PageReference ret = new PageReference('/servlet/servlet.FileDownload?file=' + attachmentId);
        ret.setRedirect(true);
        return ret ;
    }
    public Pagereference SaveandClose()
    {
        return null;
    }
    // Method to call both Method within one method
    
    public void sendAndSaveAttchment() {
        sendEmailFunction();
        saveAndOpenPDF();
    }
    
}