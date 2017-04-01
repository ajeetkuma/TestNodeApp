trigger ContactTrigger on Contact (after insert, after update, before delete) {
    
        
    /*
         Modified By :Shikha
         Modified Date : 8-7-2014
   
    */
        //Check for DML event
        
        
              if(Trigger.isInsert || Trigger.isUpdate) {
    Set<id> accountMap = new Set<id>();
   List<Account> listAccount = new List<Account>();
   List<Opportunity> listOpportunity = new List<Opportunity>();
        List<Opportunity> listopp = new List<opportunity>();
 
   for(Contact con : trigger.new)
   {
     accountMap.add(con.AccountId);
      
   }
       // listAccount = [Select id,Name from Account where id IN :accountMap];
        listOpportunity = [Select id,Name,StageName,Match_Field_Validation__c,AccountId  from Opportunity where AccountId IN:accountMap];
        Map<Id,list<Opportunity>> OpportunityMap = new Map<Id,list<Opportunity>>();    
        for(Opportunity opp:listOpportunity){
            if(OpportunityMap.get(opp.AccountId)==null){
                
                OpportunityMap.put(opp.AccountId,new list<Opportunity>{opp});
            }
            
            else{
                OpportunityMap.get(opp.AccountId).add(opp);
                
            }
            
         }           
        System.debug(listOpportunity);
    for(contact cont : trigger.new)
        {
            if(OpportunityMap.containsKey(cont.AccountId)) {
        for(Opportunity opp :OpportunityMap.get(cont.AccountId))
        {
          System.debug(':::::::::::::=====opp.StageName'+opp.StageName);
          System.debug(':::::::::::::=====opp.Match_Field_Validation__c'+opp.Match_Field_Validation__c);
          
            if(opp.StageName == 'Allotment' && opp.Match_Field_Validation__c == true) {
                System.debug(':::::::::::::=====Yes');
                System.debug('**Birthdate'+cont.Birthdate+'1'+cont.Company__c+ ' 2'+cont.Designation__c+'3'+cont.Income_Tax_PAN_GIR_No__c+'4'+cont.Industry__c+'5'+cont.Profession__c);
            
               //if(!test.isrunnigtest()){
                if(cont.Birthdate == Null && cont.Company__c == Null && cont.Designation__c == Null && /*cont.Educational_Qualification__c == Null &&*/ cont.Income_Tax_PAN_GIR_No__c == Null && cont.Industry__c == Null && cont.Profession__c == Null )
                {
                  cont.BirthDate.addError('Please fill this value');
                  cont.Company__c.addError('Please provide some value to Company');
                  cont.Designation__c.addError('Please provide some value to Desiganation');
                 // cont.Educational_Qualification__c.addError('Please provide some value to Educational Qualification');
                  cont.Income_Tax_PAN_GIR_No__c.addError('Please provide some value to Income Tax Pan GIR No.');
                  cont.Industry__c.addError('Please provide some value to Industry');
                  cont.Profession__c.addError('Please provide some value to Profession');
                 }
                
                else if(cont.Birthdate == Null)
                {
               cont.BirthDate.addError('Please fill this value');
                }  
                else if(cont.Company__c == Null)
                {
             cont.Company__c.addError('Please provide some value to Company');
                }
                else If(cont.Designation__c == Null)
                {
             cont.Designation__c.addError('Please provide some value to Desiganation');
                }
                //else If(cont.Educational_Qualification__c == Null)
               // {
            // cont.Educational_Qualification__c.addError('Please provide some value to Educational Qualification');
              //  }
                else If(cont.Income_Tax_PAN_GIR_No__c == Null)
                {
             cont.Income_Tax_PAN_GIR_No__c.addError('Please provide some value to Income Tax Pan GIR No.');
                }
                else If(cont.Industry__c == Null)
                {
             cont.Industry__c.addError('Please provide some value to Industry');
                }
                else if(cont.Profession__c == Null)
                {
             cont.Profession__c.addError('Please provide some value to Profession');
                } 
              //} 
        }                   
            
     }
            } }
}
    
      
   /*

   Finished Modification
*/

   if(contactRecursiveHelper.isContacttrigger== false){ 
    // CopyPContactDetailsToAccount
    List<Id> actIds = new List<Id> ();
    List<Account> lstAct;
    Map<Id,Account> mapAcnt = new Map<Id,Account> ();
    //List<Opportunity> lstOppty;
    //Map<Id,Opportunity> mapOppty = new Map<Id,Opportunity> ();
    String cName;
    String cPhone;
    if(Trigger.isUpdate || Trigger.isInsert){ //Modified by 23-04-2014(by Subas)
    for(Contact con: Trigger.New) {
        actIds.add(con.AccountId);
    }
   } 
    system.debug('-----------------------------------'+actIds.size());
    if(actIds.size()>0 & actIds !=null){ //Modified by 21-03-2014
    
    lstAct = [select Primary_Contact_s_Email__c,Primary_Contact_s_Name__c,FirstApplicant__c,Third_Applicant_Name__c,
    First_Applicant_Name__c,Second_Applicant_Name__c,SecondApplicant__c, ThirdApplicant__c,FourthApplicant__c,GPAHolder__c,
    CC_Address__c, Primary_Contact__c, First_Applicant_Activities_Count__c, GPA_Applicant_Activities_Count__c, Fourth_Applicant_Activities_Count__c, 
    Third_Applicant_Activities_Count__c, Second_Applicant_Activities_Count__c from Account where Id IN:actIds];
    
    System.debug('### (ContactTrigger) lstAct: ' + lstAct);
    
    //lstOppty = [select Email__c,AccountId from Opportunity where AccountId IN: actIds and Active__c = true];
    for(Account a : lstAct) {
        mapAcnt.put(a.Id,a);
    }
    //for(Opportunity o : lstOppty) {
    //    mapOppty.put(o.AccountId,o);
    //}
    System.debug('### (ContactTrigger) mapAcnt before update: ' + mapAcnt);
    //System.debug('### (ContactTrigger) mapOppty before update: ' + mapOppty);
    for(Contact c: Trigger.New) {
      if(c.AccountId !=null){
        if(c.Contact_Type__c !=null) {
            if(Trigger.oldMap !=null) {
                System.debug('### (ContactTrigger) Inside IF oldMap =null');
                if(Trigger.oldMap.get(c.Id).Contact_Type__c != null) {
                    if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('First Applicant'))
                        mapAcnt.get(c.AccountId).FirstApplicant__c = false;
                    else if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('Second Applicant'))
                        mapAcnt.get(c.AccountId).SecondApplicant__c = false;
                    else if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('Third Applicant'))
                        mapAcnt.get(c.AccountId).ThirdApplicant__c = false;
                    else if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('Fourth Applicant'))
                        mapAcnt.get(c.AccountId).FourthApplicant__c = false;
                    else if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('GPA Holder'))
                        mapAcnt.get(c.AccountId).GPAHolder__c = false;
                    else if(Trigger.oldMap.get(c.Id).Contact_Type__c.equals('Primary Contact'))
                        mapAcnt.get(c.AccountId).Primary_Contact__c = false;
                }
            }
            
            if(c.Contact_Type__c.equals('First Applicant')) {
                System.debug('### (ContactTrigger) c: ' + c);
                System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@' + c.AccountId);
                
                mapAcnt.get(c.AccountId).Primary_Contact_s_Email__c = c.Email;
                //mapOppty.get(c.AccountId).Email__c = c.Email;
                mapAcnt.get(c.AccountId).First_Applicant_Activities_Count__c = c.Activity_Count__c;
                cName = c.LastName;
                if(c.FirstName != null)
                    cName = c.FirstName + ' ' + cName;
                mapAcnt.get(c.AccountId).First_Applicant_Name__c = cName;   
                if(c.Salutation != null)
                    cName = c.Salutation + ' ' + cName;
                mapAcnt.get(c.AccountId).Primary_Contact_s_Name__c = cName;
                
                cPhone = ''; // Added on 29/10/2013 - since this field was not reset for different contacts.
                if(c.Phone != null)
                    cPhone = c.Phone;
                 // Added on 29/10/2013 - since this field was not reset for different contacts.   
                if(c.Mobilephone != null && cPhone != '') { 
                 cPhone = cPhone + ' / ' + c.MobilePhone;
                }
                else {
                 cPhone = c.MobilePhone;
                } // Added on 29/10/2013 - since this field was not reset for different contacts.
                mapAcnt.get(c.AccountId).Primary_Contact_s_Tel_Mob__c = cPhone;
                
                mapAcnt.get(c.AccountId).Primary_Contact_s_Record_ID__c = c.Id;
                
                // Validation to prevent adding same Contact Type - First Applicant
                if(! mapAcnt.get(c.AccountId).FirstApplicant__c) {
                    System.debug('### (ContactTrigger) FirstApplicant =false');
                    mapAcnt.get(c.AccountId).FirstApplicant__c = true;
                }
                else
                    c.addError('There is already a First Applicant for this Account');
            }   
            
            else if(c.Contact_Type__c.equals('Second Applicant')) {
            //adding second applicant contact name
                mapAcnt.get(c.AccountId).Second_Applicant_Activities_Count__c = c.Activity_Count__c;
                cName = c.LastName;
                if(c.FirstName != null)
                    cName = c.FirstName + ' ' + cName;
                //if(c.Salutation != null)
                    //cName = c.Salutation + ' ' + cName;
                mapAcnt.get(c.AccountId).Second_Applicant_Name__c = cName;
                
            // Validation to prevent adding same Contact Type - Second Applicant
                if(! mapAcnt.get(c.AccountId).SecondApplicant__c) {
                    //System.debug('### (ContactTrigger) SecondApplicant =false');
                    mapAcnt.get(c.AccountId).SecondApplicant__c = true;
                }
                else
                    c.addError('There is already a Second Applicant for this Account');     
            }
            else if(c.Contact_Type__c.equals('Third Applicant')) {
                //adding third applicant contact name
                mapAcnt.get(c.AccountId).Third_Applicant_Activities_Count__c= c.Activity_Count__c;
                cName = c.LastName;
                if(c.FirstName != null)
                    cName = c.FirstName + ' ' + cName;
                //if(c.Salutation != null)
                    //cName = c.Salutation + ' ' + cName;
                mapAcnt.get(c.AccountId).Third_Applicant_Name__c = cName;
                // Validation to prevent adding same Contact Type - Third Applicant
                if(! mapAcnt.get(c.AccountId).ThirdApplicant__c) {
                    //System.debug('### (ContactTrigger) ThirdApplicant =false');
                    mapAcnt.get(c.AccountId).ThirdApplicant__c = true;
                }
                else
                    c.addError('There is already a Third Applicant for this Account');     
            }
            else if(c.Contact_Type__c.equals('Fourth Applicant')) {
                mapAcnt.get(c.AccountId).Fourth_Applicant_Activities_Count__c= c.Activity_Count__c;
                // Validation to prevent adding same Contact Type - Fourth Applicant
                if(! mapAcnt.get(c.AccountId).FourthApplicant__c) {
                    //System.debug('### (ContactTrigger) FourthApplicant =false');
                    mapAcnt.get(c.AccountId).FourthApplicant__c = true;
                }
                else
                    c.addError('There is already a Fourth Applicant for this Account');     
            }
            else if(c.Contact_Type__c.equals('GPA Holder')) {
                // Validation to prevent adding same Contact Type - GPA Holder
                mapAcnt.get(c.AccountId).GPA_Applicant_Activities_Count__c= c.Activity_Count__c;
                System.debug('### (ContactTrigger) cName: ' + cName);
                cName = c.LastName;
                if(c.FirstName != null)
                    cName = c.FirstName + ' ' + cName;
                if(c.Salutation != null)
                    cName = c.Salutation + ' ' + cName;
                mapAcnt.get(c.AccountId).GPA_Name__c = cName;
                System.debug('### (ContactTrigger) cName: ' + cName);
                if(! mapAcnt.get(c.AccountId).GPAHolder__c) {
                    //System.debug('### (ContactTrigger) GPAHolder =false');
                    mapAcnt.get(c.AccountId).GPAHolder__c = true;
                }
                else
                    c.addError('There is already a GPA Holder for this Account');     
            }
            else if(c.Contact_Type__c.equals('Primary Contact')) {
                // Validation to prevent adding same Contact Type - Primary Contact                
                if(! mapAcnt.get(c.AccountId).Primary_Contact__c) {
                    //System.debug('### (ContactTrigger) GPAHolder =false');
                    mapAcnt.get(c.AccountId).Primary_Contact__c = true;
                }
                else
                    c.addError('There is already a Primary Contact for this Account');     
            }
            // Update the CC address
            if(mapAcnt.get(c.AccountId).CC_Address__c !=null) {
                if(Trigger.oldMap !=null) {
                    System.debug('### (ContactTrigger) Inside IF oldMap !=null. Update CC address');
                    if(Trigger.oldMap.get(c.Id).CC_GPA__c) {
                        System.debug('### (ContactTrigger) Inside IF oldmap cc gpa = true');
                        System.debug('### (ContactTrigger)  cc address: ' + mapAcnt.get(c.AccountId).CC_Address__c);
                        System.debug('### (ContactTrigger)  c.Email: ' + c.Email);
                        if(mapAcnt.get(c.AccountId).CC_Address__c.contains(Trigger.oldMap.get(c.Id).Email) && ! Trigger.oldMap.get(c.Id).Email.equals(c.Email)) {
                            System.debug('### (ContactTrigger) Inside IF contains email');
                            mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(Trigger.oldMap.get(c.Id).Email,'');
                        }
                    }
                    if(Trigger.oldMap.get(c.Id).CC_Email2__c) {
                        System.debug('### (ContactTrigger) Inside IF oldmap cc email2');
                        if(mapAcnt.get(c.AccountId).CC_Address__c.contains(Trigger.oldMap.get(c.Id).Email2__c) && ! Trigger.oldMap.get(c.Id).Email2__c.equals(c.Email2__c)) {
                            System.debug('### (ContactTrigger) Inside IF contains email2');
                            mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(Trigger.oldMap.get(c.Id).Email2__c,'');
                        }
                   }
                }
                if(c.Email !=null) {
                    if(c.CC_GPA__c==false && mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email))
                        mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(c.Email,'');
                }
                if(c.Email2__c !=null) {
                    if(c.CC_Email2__c==false && mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email2__c))
                        mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(c.Email2__c,'');                
                }
            }
            if(c.CC_GPA__c) {
                System.debug('### (ContactTrigger) Inside IF CC_GPA =true');
                if(mapAcnt.get(c.AccountId).CC_Address__c == null) {
                    System.debug('### (ContactTrigger) Inside IF CC_Address=true');
                    System.debug('### (ContactTrigger) mapAcnt.get(c.AccountId).CC_Address__c: ' + mapAcnt.get(c.AccountId).CC_Address__c);
                    mapAcnt.get(c.AccountId).CC_Address__c = c.Email;
                }
                else if(! mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email)) {
                    System.debug('### (ContactTrigger) Inside IF CC_address not equal to email');
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c + ' ,' + c.Email;
                }
            }
            if(c.CC_Email2__c) {
                if(mapAcnt.get(c.AccountId).CC_Address__c == null)
                    mapAcnt.get(c.AccountId).CC_Address__c = c.Email2__c;
                else if(! mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email2__c))
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c + ' ,' + c.Email2__c;
            }
            if(mapAcnt.get(c.AccountId).CC_Address__c != null) {
                if(mapAcnt.get(c.AccountId).CC_Address__c.EndsWith(','))
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.subString(0,mapAcnt.get(c.AccountId).CC_Address__c.length()-1);
                if(mapAcnt.get(c.AccountId).CC_Address__c.StartsWith(' ,'))
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.subString(2,mapAcnt.get(c.AccountId).CC_Address__c.length());
            }
        }
       } 
    }
    update mapAcnt.values();
    System.debug('### (ContactTrigger) mapAcnt after update: ' + mapAcnt);    
    //update mapOppty.values();
    
    // *** Update the 'Opportunity Flag' of Opportunity ***
    if(Trigger.isUpdate && Trigger.isafter) {
        //List<Account> lstAcnt = new List<Account> ();
        
        List<Id> acntId = new List<Id> ();
        for(Contact c: Trigger.New) {
         if(c.AccountId !=null){
            acntId.add(c.AccountId);
            }
        }
        List<Opportunity> lstOpp = [select Update_Flag__c from Opportunity
                    where AccountId IN: acntId and Active__c =: True and Customer_ID__c != null];
        system.debug('%%%%%%%%%%%%%%%%'+lstOpp);            
        for(Opportunity o : lstOpp) {
            system.debug('%%%%%%%%%%%%%%%%'+o.Update_Flag__c );  
            o.Update_Flag__c = 'U';
        }
        contactRecursiveHelper.isopportunity= true;     
        update lstOpp;
   }
    contactRecursiveHelper.isContactUpdate = true;
  } 
  try{
  if(Trigger.isDelete){ //Modified by 23-04-2014(by Subas)
    for(Contact con: Trigger.Old) {
        actIds.add(con.AccountId);
    }     
   if(actIds.size()>0 & actIds !=null){ 
    lstAct = [select Primary_Contact_s_Email__c,Primary_Contact_s_Name__c,FirstApplicant__c,Third_Applicant_Name__c,First_Applicant_Name__c,Second_Applicant_Name__c,SecondApplicant__c, ThirdApplicant__c,FourthApplicant__c,GPAHolder__c,CC_Address__c, Primary_Contact__c from Account where Id IN:actIds];
    System.debug('### (ContactTrigger) lstAct: ' + lstAct);
   
    for(Account a : lstAct) {
        mapAcnt.put(a.Id,a);
    }
    for(Contact c: Trigger.Old) {
        if(c.Contact_Type__c.equals('First Applicant')) {
            mapAcnt.get(c.AccountId).First_Applicant_Name__c = '';
        }
        if(c.Contact_Type__c.equals('Second Applicant')) {
            mapAcnt.get(c.AccountId).Second_Applicant_Name__c = '';
        }
        if(c.Contact_Type__c.equals('Third Applicant')) {
            mapAcnt.get(c.AccountId).Third_Applicant_Name__c = '';
        }                       
    }
    contactRecursiveHelper.isContacttrigger= true;
    update mapAcnt.values();
    
   } 
     contactRecursiveHelper.isContactUpdate = true;
             }
        }
        catch(DmlException  e){
            System.debug('Please fill Contact Type Value / Contact your admin '+e.getMessage());
            }
        }
    }