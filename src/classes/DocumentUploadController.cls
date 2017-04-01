global with sharing class DocumentUploadController {
	public static String oppId{get;set;} 
	public static  ApplicationFormController afc{get;set;}
	public static String jsonstring{get;set;} 
	public DocumentUploadController() {
		oppId = ApexPages.currentPage().getParameters().get('Id');
		afc = new ApplicationFormController() ;    
		afc.documents=[SELECT Document_Url_link__c,Status__c,Contact__r.Name,Contact__r.Contact_Type__c,Name FROM Project_Docs__c WHERE ApplicationId__c=:oppId];

		jsonstring=String.escapeSingleQuotes(JSON.serialize(afc));
	}
    /*******************************************************************************************************
    * @description :- Method to Save Attachments
    * @param  :- Opportunity Id , Image description in String format
    * @return :- Attachment Id
    */
    @RemoteAction 
    global static String saveAttachments(String opp,String existingLead,String appData){
        System.debug('@@@@@@@@@@@@@@@@@@@@@@'+opp+'hdfd'+existingLead);

        Attachment att = new Attachment();
        att.body=EncodingUtil.base64Decode((existingLead.substringAfter('qwerty')).subString((existingLead.substringAfter('qwerty')).indexOf(',')+1,(existingLead.substringAfter('qwerty')).length()));
        att.ParentId=opp;
        att.Name=existingLead.substringBefore('qwerty');
        insert att;
        //================================================================================
        Application_Form__c app=[Select Id,Opportunity__c from Application_Form__c where Id=:opp];
        Opportunity oRec=[Select Id,AccountId from Opportunity where Id=:app.Opportunity__c];
        List<contact> ConId=[SELECT Id from Contact where AccountId=:oRec.AccountId And(Contact_Type__c=:(appData.substringAfter('########'))) order by createdDate Limit 1];

        String dUrl = 'https://bgproduction-brigadeforce-na19--p2dev.cs14.my.salesforce.com/'+att.id+'';
        Project_Docs__c doc =new Project_Docs__c();
		doc.Name=appData.substringBefore('########');
        doc.Contact__c=ConId[0].Id;
        doc.AttachmentId__c=att.id;
        doc.Opportunity__c=oRec.Id;
        doc.ApplicationId__c=opp;
        doc.Document_Url__c=dUrl;
        insert doc;
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
}