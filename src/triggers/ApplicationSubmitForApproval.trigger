trigger ApplicationSubmitForApproval on Application_Form__c (after insert,after update) {
    /*
    for (Integer i = 0; i < Trigger.new.size(); i++) {

        //if (Trigger.old[i].Probability < 30 && Trigger.new[i].Probability >= 30) {
          if(Trigger.new[i].Old_Lead_Source__c != Trigger.new[i].New_Lead_Source__c || Trigger.new[i].Listed_Unit_Price__c != Trigger.new[i].Final_unit_Price__c ) {
            // create the new approval request to submit
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(Trigger.new[i].Id);
            // submit the approval request for processing
            Approval.ProcessResult result = Approval.process(req);
            // display if the reqeust was successful
            System.debug('Submitted for approval successfully: '+result.isSuccess());

        }

    }*/
    if(Trigger.isUpdate){
        applicationTriggerHandler appform = new applicationTriggerHandler ();
        List<Application_Form__c> appList = new List<Application_Form__c>();
        for(Application_Form__c app : trigger.new){
            //Execute when lead source status changed to approved from any other status.
            if(trigger.oldMap.get(app.id).Lead_Source_Approval_Status__c != trigger.newmap.get(app.id).Lead_Source_Approval_Status__c && trigger.newmap.get(app.id).Lead_Source_Approval_Status__c == 'Approved'){
                
                appform.updateLeadSource(Trigger.new); 
            }
            system.debug(trigger.oldMap.get(app.id).Application_Status__c +'old'+trigger.newmap.get(app.id).Application_Status__c +'new');
            if(trigger.oldMap.get(app.id).Application_Status__c != trigger.newmap.get(app.id).Application_Status__c){
                appList.add(app);
            }
        }
        system.debug(appList+'appList');
        if(appList.size() > 0){
            appform.updateApplicationStatus(appList); 
        }
    }

}