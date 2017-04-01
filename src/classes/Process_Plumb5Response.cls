/***************************************************************
         Purpose  : Process Plumb5 API Response and Update
                    Lead/Contact Records based on Email
         Author   : Amritesh
    Created Date  : 26/08/2015
****************************************************************/
public class Process_Plumb5Response {
    
    /*
        Process List of Plumb5JSON2ApexWrapper type records
    */
    
    public void processResponse(List<Plumb5JSON2ApexWrapper> parsedResponse){
        try{
            Map<String,Plumb5JSON2ApexWrapper> emailvsPlumb5JSON2ApexWrapper    = new Map<String,Plumb5JSON2ApexWrapper>();
            
            for(Plumb5JSON2ApexWrapper p : parsedResponse){
                if(!Utility_Class.ISBlankOrEmpty(p.EmailId)){           
                    emailvsPlumb5JSON2ApexWrapper.put(p.EmailId.tolowerCase(),p);
                }
            }
            
            // Search all Emails in Lead/Contact
            searchLeadContact(emailvsPlumb5JSON2ApexWrapper);
            
        }catch(Exception e){
            system.debug('Exception::'+e.getMessage());
        }   
    }
    
    /*
        Search Lead and Contact based on Email coming from Plumb5 API response
    */
    public void searchLeadContact(Map<String,Plumb5JSON2ApexWrapper> emailvsResponseMap){
    
        try{
            Map<Id,Lead> existingLead       = new Map<Id,Lead>([Select id,Email,Total_Page_Views__c,Geography__c,Behaviour_Score__c,
                                                    Last_mail_sent_on__c,No_of_mails_clicked__c,No_of_mails_opened__c,No_of_mails_sent__c,
                                                    No_of_Web_Sessions__c,Search_Key__c,Visitor_came_through_this_source__c 
                                                    from Lead where Email IN : emailvsResponseMap.keySet() AND IsConverted = false]);
            
            Map<Id,Contact> existingCon     = new Map<Id,Contact>([Select id,Email,Total_Page_Views__c,Geography__c,Behaviour_Score__c,         
                                                    Last_mail_sent_on__c,No_of_mails_clicked__c,No_of_mails_opened__c,No_of_mails_sent__c,
                                                    No_of_Web_Sessions__c,Search_Key__c,Visitor_came_through_this_source__c 
                                                    from Contact where Email IN : emailvsResponseMap.keySet()]);
            
            if(existingLead.size() > 0){
                updateLead(existingLead,emailvsResponseMap);
            }
            
            if(existingCon.size() > 0){             
                updateContact(existingCon,emailvsResponseMap);
            }
            
        }catch(Exception e){
            system.debug('Query Exception::'+e.getMessage());
        }   
}
    
    /*
        Update Plumb5 updates to Lead Records
    */
    public void updateLead(Map<id,Lead> leadList,Map<String,Plumb5JSON2ApexWrapper> responseMap){
        
        try{
            for(String key : leadList.keySet()){
                                
                String visiterKey   = leadList.get(key).Email;
             
                
                
                            
                if(responseMap.ContainsKey(visiterKey)){
                    
                    leadList.get(key).IsFromPlumb5__c = true;//it won't fire some validations when lead update  from this class
                    
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).TotalVisits)){
                        leadList.get(key).Total_Page_Views__c   = responseMap.get(visiterKey).TotalVisits;
                    }                   
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Score)){
                        leadList.get(key).Behaviour_Score__c    = responseMap.get(visiterKey).Score;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Sessions)){
                        leadList.get(key).No_of_Web_Sessions__c = responseMap.get(visiterKey).Sessions;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).SearchKey)){
                        leadList.get(key).Search_Key__c = responseMap.get(visiterKey).SearchKey;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Source)){
                        leadList.get(key).Visitor_came_through_this_source__c   = responseMap.get(visiterKey).Source;
                    }
                    if(responseMap.get(visiterKey).Click != null){
                        leadList.get(key).No_of_mails_clicked__c    = responseMap.get(visiterKey).Click;
                    }
                    if(responseMap.get(visiterKey).Open != null){
                        leadList.get(key).No_of_mails_opened__c = responseMap.get(visiterKey).Open;
                    }
                    if(responseMap.get(visiterKey).Sent != null){
                        leadList.get(key).No_of_mails_sent__c   = responseMap.get(visiterKey).Sent;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).LastSentDate)){
                        leadList.get(key).Last_mail_sent_on__c  = responseMap.get(visiterKey).LastSentDate;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Location)){
                        leadList.get(key).Geography__c  = responseMap.get(visiterKey).Location;
                    }
                }
            }
           system.debug(Logginglevel.FINEST, leadList.values());
           Database.SaveResult[] SR =    Database.update(leadList.values(),false);
            for(Database.SaveResult SavResult : SR){
                if(!SavResult.isSuccess()){
           			System.debug('Error: These Lead id '+SavResult.getId()+ 'Plumb file Info Dont Get updated due to '+SavResult.getErrors() );
                }
            }
        }catch(Exception e){
            system.debug('Lead update exception :::'+e.getMessage());
        }
}   
    /*
        Update Plumb5 updates to Contact Records
    */
    public void updateContact(Map<id,Contact> contactList,Map<String,Plumb5JSON2ApexWrapper> responseMap){
        //contactRecursiveHelper.isContacttrigger   =   true;
        try{
            for(String key : contactList.keySet()){
                
                String visiterKey   = contactList.get(key).Email;
                
                if(responseMap.ContainsKey(visiterKey)){
                    
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).TotalVisits)){
                        contactList.get(key).Total_Page_Views__c    = responseMap.get(visiterKey).TotalVisits;
                    }                   
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Score)){
                        contactList.get(key).Behaviour_Score__c = responseMap.get(visiterKey).Score;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Sessions)){
                        contactList.get(key).No_of_Web_Sessions__c  = responseMap.get(visiterKey).Sessions;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).SearchKey)){
                        contactList.get(key).Search_Key__c  = responseMap.get(visiterKey).SearchKey;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Source)){
                        contactList.get(key).Visitor_came_through_this_source__c    = responseMap.get(visiterKey).Source;
                    }
                    if(responseMap.get(visiterKey).Click != null){
                        contactList.get(key).No_of_mails_clicked__c = responseMap.get(visiterKey).Click;
                    }
                    if(responseMap.get(visiterKey).Open != null){
                        contactList.get(key).No_of_mails_opened__c  = responseMap.get(visiterKey).Open;
                    }
                    if(responseMap.get(visiterKey).Sent != null){
                        contactList.get(key).No_of_mails_sent__c    = responseMap.get(visiterKey).Sent;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).LastSentDate)){
                        contactList.get(key).Last_mail_sent_on__c   = responseMap.get(visiterKey).LastSentDate;
                    }
                    if(!Utility_Class.ISBlankOrEmpty(responseMap.get(visiterKey).Location)){
                        contactList.get(key).Geography__c           = responseMap.get(visiterKey).Location;
                    }
                }
            }
            
            contactRecursiveHelper.isContacttrigger = true;
            Database.SaveResult[] SR = Database.update(contactList.values());
            for(Database.SaveResult SavResult : SR){
                if(!SavResult.isSuccess()){
           			System.debug('Error: These contact id '+SavResult.getId()+ 'Plumb file Info Dont Get updated due to '+SavResult.getErrors() );
                }
            }
             
        }catch(Exception e){
            system.debug('Contact update exception ex:::'+e.getMessage());
            }
        }       
}