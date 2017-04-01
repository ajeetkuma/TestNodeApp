Public class ToGenerateRandomOTP{
    /****************************************************
    Purpose     : Generate the 4 digit random number to send OTP when application form submit 
    Return Type : string
    ***************************************************/
    
    Public Static String generateRandomOTP(Id conID){            
        string str = '';
        String msg = '';
       
        Contact con = new Contact ();
        //OpportunityContactRole oppcontactRole = new OpportunityContactRole ();
        //oppcontactRole = [SELECT Id, ContactId, OpportunityId,contact.Email,contact.Name,contact.MobilePhone FROM OpportunityContactRole WHERE OpportunityId =: OppID AND IsPrimary = true ];
        con = [SELECT id,OTP__c,name,MobilePhone FROM Contact WHERE id =:conID ];
        
        
            double d = Math.random();
            str = (string.valueOf(d)).mid(2, 4);
            system.debug(d+'SSSS');
            system.debug(str+'www');
            con.OTP__c = str ;
            //system.debug(Opp+'Opp');
            update con;
            
            msg ='OTP Generated successfully.';
            
            ToGenerateRandomOTP.sendOTPBySMS(conID);
        /*}catch(Exception e){
            msg= e.getMessage();
        }*/
        system.debug(msg+'msg');
        return msg ;
    }
     @future(callout=true)
    public static void sendOTPBySMS(Id conID){
        String SMSTemplate = '';
        List<smagicinteract__smsmagic__c> smsObjectsToInsert = new list<smagicinteract__smsmagic__c>();
        list<id> conList = new list<id>();
        Contact con = new Contact ();
        con = [SELECT id,OTP__c,name,MobilePhone FROM Contact WHERE id =:conID ];
        conList.add(con.id);
        SMSTemplate = 'OTPSmsTemplate';
        smsObjectsToInsert    =  sendEKhathaSMS.SendSMStoNEWLead(conList,SMSTemplate,'CONTACT','MobilePhone',1);
        if(!Test.isRunningTest()){
            String response = smagicinteract.ApexAPI.pushSMSCallout(smsObjectsToInsert);
            system.debug(response+'response');
        }   
        if(smsObjectsToInsert.size() > 0){
            system.debug(smsObjectsToInsert+'smsObjectsToInsert');
            Database.SaveResult[] srList = Database.insert(smsObjectsToInsert,false);
            for (Database.SaveResult sr : srList) {

                if (sr.isSuccess()) {

                     // Operation was successful, so get the ID of the record that was processed

                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());

                }
                else {

                    // Operation failed, so get all errors               

                    for(Database.Error err : sr.getErrors()) {

                        System.debug('The following error has occurred.');                   
            
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
            
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }

                }

            }
            
        }
    }
    
    /****************************************************
    Purpose     : Validate OTP in opp 
    Return Type : string
    ***************************************************/
    Public Static String validateOTP(String oppid,Id conID,string OTP){            
        string str = '';
        String msg = '';
        Contact con = new Contact();
        Opportunity opp = new Opportunity();
        con = [SELECT OTP__c FROM Contact WHERE id =:conID];
        opp = [SELECT id ,OTP_Generated__c FROM Opportunity where Id =:oppid ] ;  
        try{
            If(con.OTP__c == OTP){
                msg ='OTP validated successfully.';
                con.OTP__c = '';
                opp.OTP_Generated__c = true;
                update con;
                update opp;
            }else{
                msg ='OTP validation fail.';
            }
             
        }catch(Exception e){
            msg= e.getMessage();
        }
        system.debug(msg+'msg');
        return msg ;
    }
    @future
    public static void storeApprovalcomment(set<id> comIDs){
        List<Commission__c> Commissiones = new list<Commission__c>();
        list<Commission__c> commissionToUpdate = new list<Commission__c>();
        Commissiones =[Select Id ,Status__c,Project_Head_Comment__c ,Hod_Comment__c ,(Select Id, IsPending, ProcessInstanceId, TargetObjectId, StepStatus, OriginalActorId, ActorId, RemindersSent, Comments, IsDeleted, CreatedDate, CreatedById, SystemModstamp From ProcessSteps WHERE StepStatus = 'Approved' ORDER BY CreatedDate DESC LIMIT 1) 
                      From Commission__c  where id IN: comIDs];
        for(Commission__c cs : Commissiones){
             system.debug(cs.Status__c+'FFFFFFFF');
             for (ProcessInstanceHistory ps : cs.ProcessSteps)
             {
                 system.debug(ps+'GGGGGGG');
                 if(cs.Status__c == 'Approved By Project Head' && cs.Project_Head_Comment__c != ''){
                     system.debug('SSSSSS');
                     cs.Project_Head_Comment__c = ps.comments;
                     commissionToUpdate.add(cs);
                 } 
                 else if(cs.Status__c == 'Approved' && cs.Hod_Comment__c != ''){
                     system.debug('DDDDDDDD');
                     cs.Hod_Comment__c = ps.comments;
                     commissionToUpdate.add(cs);
                 }
                
             }
        }
        system.debug(commissionToUpdate+'commissionToUpdate');
        system.debug(commissionToUpdate.size()+'commissionToUpdate');
         if(commissionToUpdate.size() > 0){
             checkRecursive.runOnce();
             update commissionToUpdate;
         }
     }
}