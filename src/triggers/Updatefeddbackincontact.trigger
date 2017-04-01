trigger Updatefeddbackincontact on SurveyTaker__c (before insert) {

    
    // public contact con;
     public user usr;
     if(contactRecursiveHelper.Updatefeddback == false){ 
     list<CP_Property__c> listProperty =new  list<CP_Property__c>();
     List<Id> serveytakeridIds = new List<Id>();
     List<SurveyTaker__c > lstSurveyTaker;
     SurveyTaker__c SurveyTaker2=new SurveyTaker__c();
         
     for(SurveyTaker__c Surveytaker: Trigger.New) {
        serveytakeridIds.add(Surveytaker.Contact__c); 
    }
    usr=[select id,ContactId,OpportunityId__c from User where id=:UserInfo.getUserId()];
    system.debug('user00000'+usr);
    list<id> userid=new list<id>();           
        
  try{    
     if(usr.OpportunityId__c !=null){ 
             
           opportunity opp=[Select Id, AccountId,Execution_with_Modification_Feed_back_fo__c from Opportunity Where Id=:usr.OpportunityId__c];               
           
              Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact 
               Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant' ];  
    
          // contact c=[select X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,        
          //  Execution_withoutmodification_Feed_back__c,Handover_Feed_back_form__c from contact where id=:serveytakeridIds];
    
      /*  con=[select X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,        
          Execution_withoutmodification_Feed_back__c,Handover_Feed_back_form__c from contact where id=:serveytakeridIds];*/
          
       
     for(SurveyTaker__c st:trigger.new) {
                                  
                     if(st.Survey_Name__c == 'Execution Feed Back1')
                           opp.Execution_with_Modification_Feed_back_fo__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == '1st year Handover Feedback')
                           opp.X1st_year_Handover_Feedback__c=true;                              
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c == 'Booking CSAT Feed back form')
                           opp.Booking_CSAT_Feed_back_form__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == 'Execution Feed Back2')
                           opp.Execution_without_modification_Feed_back__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == 'Handover Feed back form')
                           opp.Handover_Feed_back_form__c =true;                           
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                }          
                           
       update opp;              
       update con;
         
   }
   else{

              listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                             Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id AND Active__c=true];
             system.debug('#########################'+listProperty);

               Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];

               Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact 
               Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant' ];
               
               for(SurveyTaker__c st:trigger.new) {
                                  
                     if(st.Survey_Name__c == 'Execution with Modification Feed back form')
                           opp.Execution_with_Modification_Feed_back_fo__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == '1st year Handover Feedback')
                           opp.X1st_year_Handover_Feedback__c=true;                              
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c == 'Booking CSAT Feed back form')
                           opp.Booking_CSAT_Feed_back_form__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == 'Execution without modification Feed back form')
                           opp.Execution_without_modification_Feed_back__c=true; 
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                           
                     if(st.Survey_Name__c  == 'Handover Feed back form')
                           opp.Handover_Feed_back_form__c =true;                           
                           st.Opportunity__c=opp.Id;
                           st.Contact__c=con.Id;
                }          
                  
       contactRecursiveHelper.Updatefeddback = true; 
       contactRecursiveHelper.isopportunity = true;
       contactRecursiveHelper.isUpdateCPProperty = true;                   
       update opp;  
   
   
       }

   
   }
          catch(exception e){
             Trigger.New[0].addError('No Payment Schedule Available under the Selected Contact');
             contactRecursiveHelper.Updatefeddback = true;
       }
}
}