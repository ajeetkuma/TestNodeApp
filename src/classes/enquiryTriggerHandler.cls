/**
* Handler Class     : enquiryTriggerHandler
* Created by        : ETMarlabs (22-08-2016)
* Description       : Trigger Hanndler contains all the logic for AfterInsertTriger trigger.
*                   : Inline comments are added to get specific details.
**/
public class enquiryTriggerHandler {
   
    public void checkingForExistingLead(List<Lead> listOfLead){
        system.debug('listOfLead::'+listOfLead);
        /*Variable declaration */
        Set<String> setOfEmailID                    = new Set<String>();
        Set<String> setOfMobileNo                   = new Set<String>();
        Set<String> setOfalias                      = new Set<String>();
        Set<ID> setOfLeadID                         = new Set<ID>();
        
        List<Lead> ListOfexistingLead               = new List<Lead>();
        List<Lead> LeadToUpdateNotConverted         = new List<Lead>();
        List<Lead> LeadToUpdateToConverted          = new List<Lead>();
        List<Lead> LeadMarkedforDeletion            = new List<Lead>();
        List<Lead> leadList                         = new List<Lead>();
        List<User> listOfUser                       = new List<User>();
       
        
        Map<String,Lead> mapOfMobileOrEmailAndLead  = new Map<String,Lead>();
        Map<id,id> leadAccountID                    = new Map<Id,id>();
        Map<id,id> leadContactID                    = new Map<Id,id>();
        Map<id,Lead> MapOfleadIdAndLead             = new Map<Id,Lead>();
        Map<string,User> mapOfaliasAndUser          = new Map<String,User>();
        Map<ID,ID> mapOfAccAndContact               = new Map<ID,ID>();
        String [] stralias                          = new List<String>();
        String [] strfollowupDate                   = new List<String>();
        Lead leadrecord ; 
        Boolean flag ;
        //Getting the lead status for converting the lead 
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        //Prepare map for email id , mobile number and alias for sales persons
        for(Lead leadtemp : listOfLead){
            if(leadtemp.Email != null){
                setOfEmailID.add(leadtemp.Email);
            }
           
            setOfLeadID.add(leadtemp.id);
            //setOfMobileNo.add(leadtemp.Phone);
            if(leadtemp.MobilePhone != null){
                setOfMobileNo.add(leadtemp.MobilePhone);
            }
            if(leadtemp.Sales_Person_Alias__c != null ){
                
                stralias = new list<String>();
                if(leadtemp.Sales_Person_Alias__c.contains(';')){
                    stralias = leadtemp.Sales_Person_Alias__c.split(';');
                    if(stralias.size() > 0){
                          for(String str : stralias ){
                              setOfalias.add(str);
                          }
                    }
                }else{
                    setOfalias.add(leadtemp.Sales_Person_Alias__c);
                }
            }
            
                    
         }
         // Getting the list of all lead which is there in after insert to perform dml operation
         leadList = [SELECT Mode_of_Enquiry__c,Active_Validation__c,Follow_up_Date_text__c,Follow_up_Date__c,Sales_Person_1__c,id,Sales_Person_2__c,Sales_Person_3__c,Mark_For_Deletion__c,Company_Name__c FROM Lead WHERE id IN: setOfLeadID];
         for(lead ld : leadList){
            MapOfleadIdAndLead.put(ld.id,ld);
            
         }
         system.debug(MapOfleadIdAndLead+'MapOfleadIdAndLead');
          system.debug(leadList +'leadList ');
          system.debug(setOfLeadID+'setOfLeadID');
         // Getting all the users based on alias
         listOfUser = [SELECT id,Alias,EmployeeNumber from User WHERE EmployeeNumber IN: setOfalias];
         if(listOfUser.size() > 0){
            for(User uins : listOfUser){
                mapOfaliasAndUser.put(uins.EmployeeNumber,uins);
            }
         }
         system.debug(setOfEmailID+'setOfEmailID'+setOfMobileNo+'setOfMobileNo');
         
         //Getting all the existing lead in sfdc based on mobile number and email id   
         if(setOfEmailID.size() > 0 && setOfMobileNo.size() > 0){    
              system.debug('WWWW::'+setOfLeadID);
              ListOfexistingLead = [SELECT id,Company_Name__c,Date_of_Enquiry__c,Phone2__c,Mobile_1__c,Location1__c,COuntry_code_for_mobile__c,Company,Designation__c,Rate_Brigade_as_a_Brand__c,Rate_Our_Product__c,Project__c,Description,FirstName,Lastname,Experience_with_Brigade__c,Project_Domain__c,Active_Validation__c,Follow_up_Date_text__c,Follow_up_Date__c,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c,ConvertedAccountId,ConvertedContactId,Mode_of_Enquiry__c,isConverted,Email,MobilePhone,Phone FROM Lead WHERE (ID NOT IN: setOfLeadID) AND (Email IN: setOfEmailID OR MobilePhone IN: setOfMobileNo OR Phone  IN: setOfMobileNo OR Phone2__c IN: setOfMobileNo OR Mobile_1__c IN : setOfMobileNo) order by IsConverted ASC];
         }else if(setOfEmailID.size() > 0 && setOfMobileNo.size() == 0){
              system.debug('NNNN::'+setOfLeadID);
              ListOfexistingLead = [SELECT id,Company_Name__c,Date_of_Enquiry__c,Phone2__c,Mobile_1__c,Location1__c,COuntry_code_for_mobile__c,Company,Designation__c,Rate_Brigade_as_a_Brand__c,Rate_Our_Product__c,Project__c,Description,FirstName,Lastname,Experience_with_Brigade__c,Project_Domain__c,Active_Validation__c,Follow_up_Date_text__c,Follow_up_Date__c,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c,ConvertedAccountId,ConvertedContactId,Mode_of_Enquiry__c,isConverted,Email,MobilePhone,Phone FROM Lead WHERE (ID NOT IN: setOfLeadID) AND (Email IN: setOfEmailID) order by IsConverted ASC];

         }else if(setOfEmailID.size() == 0 && setOfMobileNo.size() > 0){
              system.debug('MMM::'+setOfLeadID);
              ListOfexistingLead = [SELECT id,Company_Name__c,Date_of_Enquiry__c,Phone2__c,Mobile_1__c,Location1__c,COuntry_code_for_mobile__c,Company,Designation__c,Rate_Brigade_as_a_Brand__c,Rate_Our_Product__c,Project__c,Description,FirstName,Lastname,Experience_with_Brigade__c,Project_Domain__c,Active_Validation__c,Follow_up_Date_text__c,Follow_up_Date__c,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c,ConvertedAccountId,ConvertedContactId,Mode_of_Enquiry__c,isConverted,Email,MobilePhone,Phone FROM Lead WHERE (ID NOT IN: setOfLeadID) AND (MobilePhone IN: setOfMobileNo OR Phone  IN: setOfMobileNo OR Phone2__c IN: setOfMobileNo OR Mobile_1__c IN : setOfMobileNo) order by IsConverted ASC ];
         }
        system.debug('ListOfexistingLead:::'+ListOfexistingLead);
         if(ListOfexistingLead.size() > 0){
            for(Lead lTemp  : ListOfexistingLead){
                if(lTemp.Email != null){
                    mapOfMobileOrEmailAndLead.put(lTemp.Email,lTemp);
                }
                if(lTemp.MobilePhone != null){
                    mapOfMobileOrEmailAndLead.put(lTemp.MobilePhone,lTemp);
                }
                if(lTemp.Phone != null){
                    mapOfMobileOrEmailAndLead.put(lTemp.Phone ,lTemp);
                }
                if(lTemp.Phone2__c != null){
                    mapOfMobileOrEmailAndLead.put(lTemp.Phone2__c ,lTemp);
                }
                if(lTemp.Mobile_1__c != null){
                    mapOfMobileOrEmailAndLead.put(lTemp.Mobile_1__c ,lTemp);
                }
                
            }
         }
         system.debug(ListOfexistingLead+'ListOfexistingLead');
         system.debug(mapOfMobileOrEmailAndLead+'mapOfMobileOrEmailAndLead');
         for(Lead leadtemp1 : listOfLead){
               if(leadtemp1.Mode_of_Enquiry__c != null && leadtemp1.Mode_of_Enquiry__c.contains('Walk-in') && leadtemp1.Mode_of_Enquiry__c !='Exhibition Walk-in' ){
                        // Creating list of alias string
                        if(leadtemp1.Sales_Person_Alias__c != null && leadtemp1.Sales_Person_Alias__c.contains(';')){
                                stralias = new list<String>();
                                stralias = leadtemp1.Sales_Person_Alias__c.split(';');
                        }else{
                                stralias = new list<String>();
                                stralias.add(leadtemp1.Sales_Person_Alias__c);
                        }
                        // checking for lead found based on email id
                        if(mapOfMobileOrEmailAndLead.containskey(leadtemp1.Email)){
                            // lead exist but not converted 
                            system.debug('AAAAAAAAAAAA');
                            if(mapOfMobileOrEmailAndLead.get(leadtemp1.Email).isConverted == False){
                                system.debug('Enteredddddddddddddd');
                                Lead ldupdate = mapOfMobileOrEmailAndLead.get(leadtemp1.Email); 
                                ldupdate.Type_of_Apartment__c = leadtemp1.Type_of_Apartment__c;
                                ldupdate.Location1__c = leadtemp1.Location1__c;
                                ldupdate.Budget__c = leadtemp1.Budget__c;
                                //ldupdate.Date_of_Enquiry__c = system.now();
                                ldupdate.COuntry_code_for_mobile__c= leadtemp1.COuntry_code_for_mobile__c;
                                ldupdate.Company= leadtemp1.Company;
                                if(ldupdate.Company_Name__c == ''){
                                    ldupdate.Company_Name__c = leadtemp1.Company;
                                }
                                ldupdate.Designation__c= leadtemp1.Designation__c;
                                ldupdate.Rate_Brigade_as_a_Brand__c= leadtemp1.Rate_Brigade_as_a_Brand__c;
                                ldupdate.Experience_with_Brigade__c= leadtemp1.Experience_with_Brigade__c;
                                ldupdate.Rate_Our_Product__c= leadtemp1.Rate_Our_Product__c;
                                String str = (leadtemp1.Project__c != null ? leadtemp1.Project__c : '');
                                ldupdate.Project__c= str;
                                String str2 = (leadtemp1.Multiple_Projects__c != null ? leadtemp1.Multiple_Projects__c : '');
                                ldupdate.Multiple_Projects__c = str2;
                                ldupdate.Follow_up_Date_text__c= leadtemp1.Follow_up_Date_text__c;
                                ldupdate.Description= leadtemp1.Description;
                                ldupdate.FirstName= leadtemp1.FirstName;
                                ldupdate.Lastname= leadtemp1.Lastname;
                                String str1 = (leadtemp1.Project_Domain__c!= null ? leadtemp1.Project_Domain__c : '');
                                ldupdate.Project_Domain__c= str1;
                                if(stralias.size() > 0){
                                    // max size for alias is 3 
                                    if(stralias.size() == 3){
                                  
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_2__c == null && mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0] ){
                                            if(mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_3__c == null && mapOfaliasAndUser.containskey(stralias[2]) && stralias[2] != stralias[1] && stralias[2] != stralias[0]){
                                            if(mapOfaliasAndUser.get(stralias[2]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[2]).id != ldupdate.Sales_Person_2__c ){
                                                ldupdate.Sales_Person_3__c = mapOfaliasAndUser.get(stralias[2]).id;
                                            }
                                        }
                                  
                                }else if(stralias.size() == 2){
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_2__c == null && mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0]){
                                            if(mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            }
                                        }
                                        
                                }else if(stralias.size() == 1){
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        
                                }
                            }
                            
                            LeadToUpdateNotConverted.add(ldupdate);
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            system.debug(leadrecord+'leadrecord');
                            // marking the new lead as mark for deletion if lead exist but not converted. 
                            leadrecord.Mark_For_Deletion__c = true;
                            if(leadrecord.Company_Name__c == ''){
                                leadrecord.Company_Name__c = leadtemp1.Company;
                            }
                            //leadrecord.Date_of_Enquiry__c = system.now();
                            LeadMarkedforDeletion.add(leadrecord);
                            system.debug(LeadMarkedforDeletion+'LeadMarkedforDeletion');
                        }else{
                            system.debug('BBBBBBBBB');
                            // lead exist but converted so will create the new lead but tag to existing account and contact but create new opp
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            //leadrecord.Date_of_Enquiry__c = system.now();
                            if(leadrecord.Company_Name__c == ''){
                                leadrecord.Company_Name__c = leadtemp1.Company;
                            }
                            if(leadrecord.Follow_up_Date_text__c != null ){
                                strfollowupDate = new list<String>();
                                strfollowupDate = leadrecord.Follow_up_Date_text__c.split('-');
                                Date myDate = date.newinstance(Integer.valueOF(strfollowupDate[0]), Integer.valueOF(strfollowupDate[1]),Integer.valueOF( strfollowupDate[2]));
                                leadrecord.Follow_up_Date__c =  myDate;  
                                
                            }
                            //leadrecord.Active_Validation__c = true;
                            if(stralias.size() > 0){
                                // max size for alias is 3 
                                    if(stralias.size() == 3){
                                  
                                        if( mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0] ){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[2]) && stralias[2] != stralias[1] && stralias[2] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_3__c = mapOfaliasAndUser.get(stralias[2]).id;
                                            
                                        }
                                  
                                }else if(stralias.size() == 2){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        
                                }else if(stralias.size() == 1){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        
                                }
                            }
                            
                            LeadToUpdateToConverted.add(leadrecord);
                            //Getting the account id and contact id of already converted lead
                            leadAccountID.put(leadtemp1.id,mapOfMobileOrEmailAndLead.get(leadtemp1.Email).ConvertedAccountId);
                            leadContactID.put(leadtemp1.id,mapOfMobileOrEmailAndLead.get(leadtemp1.Email).ConvertedContactId);
                        }
                        // checking for lead found based on mobile number
                    }else if(mapOfMobileOrEmailAndLead.containskey(leadtemp1.MobilePhone)){
                        // lead exist but not converted 
                        system.debug('CCCCCCCCCCCC');
                        if(mapOfMobileOrEmailAndLead.get(leadtemp1.MobilePhone).isConverted == False){
                            system.debug('DDDDDDDDDDD');
                            Lead ldupdate = mapOfMobileOrEmailAndLead.get(leadtemp1.MobilePhone); 
                            ldupdate.Type_of_Apartment__c = leadtemp1.Type_of_Apartment__c;
                            ldupdate.Location1__c = leadtemp1.Location1__c;
                            //ldupdate.Date_of_Enquiry__c = system.now();
                            ldupdate.Budget__c = leadtemp1.Budget__c;
                            ldupdate.COuntry_code_for_mobile__c= leadtemp1.COuntry_code_for_mobile__c;
                            ldupdate.Company= leadtemp1.Company;
                            if(ldupdate.Company_Name__c == ''){
                                ldupdate.Company_Name__c = leadtemp1.Company;
                            }
                            ldupdate.Designation__c= leadtemp1.Designation__c;
                            ldupdate.Rate_Brigade_as_a_Brand__c= leadtemp1.Rate_Brigade_as_a_Brand__c;
                            ldupdate.Experience_with_Brigade__c= leadtemp1.Experience_with_Brigade__c;
                            ldupdate.Rate_Our_Product__c= leadtemp1.Rate_Our_Product__c;
                            String str = (leadtemp1.Project__c != null ? leadtemp1.Project__c : '');
                            ldupdate.Project__c= str;
                            String str2 = (leadtemp1.Multiple_Projects__c != null ? leadtemp1.Multiple_Projects__c : '');
                            ldupdate.Multiple_Projects__c = str2;
                            ldupdate.Follow_up_Date_text__c= leadtemp1.Follow_up_Date_text__c;
                            ldupdate.Description= leadtemp1.Description;
                            ldupdate.FirstName= leadtemp1.FirstName;
                            ldupdate.Lastname= leadtemp1.Lastname;
                            String str1 = (leadtemp1.Project_Domain__c!= null ? leadtemp1.Project_Domain__c : '');
                            ldupdate.Project_Domain__c= str1;
                            
                            
                            if(stralias.size() > 0){
                                // max size for alias is 3 
                                    if(stralias.size() == 3){
                                  
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_2__c == null && mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0] ){
                                            if(mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_3__c == null && mapOfaliasAndUser.containskey(stralias[2]) && stralias[2] != stralias[1] && stralias[2] != stralias[0]){
                                            if(mapOfaliasAndUser.get(stralias[2]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[2]).id != ldupdate.Sales_Person_2__c ){
                                                ldupdate.Sales_Person_3__c = mapOfaliasAndUser.get(stralias[2]).id;
                                            }
                                        }
                                  
                                }else if(stralias.size() == 2){
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        if(ldupdate.Sales_Person_2__c == null && mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0]){
                                            if(mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_1__c && mapOfaliasAndUser.get(stralias[1]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            }
                                        }
                                        
                                }else if(stralias.size() == 1){
                                        if(ldupdate.Sales_Person_1__c == null && mapOfaliasAndUser.containskey(stralias[0])){
                                            if(mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_2__c && mapOfaliasAndUser.get(stralias[0]).id != ldupdate.Sales_Person_3__c ){
                                                ldupdate.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            }
                                        }
                                        
                                }
                            }
                            LeadToUpdateNotConverted.add(ldupdate);
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            system.debug(leadrecord +'leadrecord1');
                            // marking the new lead as mark for deletion if lead exist but not converted. 
                            leadrecord.Mark_For_Deletion__c = true;
                            //leadrecord.Date_of_Enquiry__c = system.now();
                            if(leadrecord.Company_Name__c == ''){
                                leadrecord.Company_Name__c = leadtemp1.Company;
                            }
                            LeadMarkedforDeletion.add(leadrecord);
                            system.debug(LeadMarkedforDeletion+'LeadMarkedforDeletion1');
                        }else{
                            system.debug('EEEEEEE');
                            // lead exist but converted so will create the new lead but tag to existing account and contact but create new opp
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            //leadrecord.Date_of_Enquiry__c = system.now();
                            if(leadrecord.Company_Name__c == ''){
                                leadrecord.Company_Name__c = leadtemp1.Company;
                            }
                            if(leadrecord.Follow_up_Date_text__c != null ){
                                strfollowupDate = new list<String>();
                                strfollowupDate = leadrecord.Follow_up_Date_text__c.split('-');
                                Date myDate = date.newinstance(Integer.valueOF(strfollowupDate[0]), Integer.valueOF(strfollowupDate[1]),Integer.valueOF( strfollowupDate[2]));
                                leadrecord.Follow_up_Date__c =  myDate;  
                                
                            }
                            //leadrecord.Active_Validation__c = true;
                            if(stralias.size() > 0){
                                    if(stralias.size() == 3){
                                  
                                        if( mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0] ){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[2]) && stralias[2] != stralias[1] && stralias[2] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_3__c = mapOfaliasAndUser.get(stralias[2]).id;
                                            
                                        }
                                  
                                }else if(stralias.size() == 2){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        
                                }else if(stralias.size() == 1){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        
                                }
                            }
                            LeadToUpdateToConverted.add(leadrecord);
                            //Getting the account id and contact id of already converted lead
                            leadAccountID.put(leadtemp1.id,mapOfMobileOrEmailAndLead.get(leadtemp1.MobilePhone).ConvertedAccountId); //ConvertedAccountId 
                            leadContactID.put(leadtemp1.id,mapOfMobileOrEmailAndLead.get(leadtemp1.MobilePhone).ConvertedContactId);
                        }
                    }else{
                         system.debug('FFFFFFFF');
                        //New lead - no match found in sfdc with email id or with mobile number
                          leadrecord = new lead();
                          leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);  
                          //leadrecord.Date_of_Enquiry__c = system.now();  
                          if(leadrecord.Company_Name__c == ''){
                              leadrecord.Company_Name__c = leadtemp1.Company;
                          }
                          if(leadrecord.Follow_up_Date_text__c != null ){
                                strfollowupDate = new list<String>();
                                strfollowupDate = leadrecord.Follow_up_Date_text__c.split('-');
                                Date myDate = date.newinstance(Integer.valueOF(strfollowupDate[0]), Integer.valueOF(strfollowupDate[1]),Integer.valueOF( strfollowupDate[2]));
                                leadrecord.Follow_up_Date__c =  myDate;  
                                
                          } 
                          //leadrecord.Active_Validation__c = true;
                          if(stralias.size() > 0){
                                    if(stralias.size() == 3){
                                  
                                        if( mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0] ){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[2]) && stralias[2] != stralias[1] && stralias[2] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_3__c = mapOfaliasAndUser.get(stralias[2]).id;
                                            
                                        }
                                  
                                }else if(stralias.size() == 2){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        if(mapOfaliasAndUser.containskey(stralias[1]) && stralias[1] != stralias[0]){
                                            
                                                leadrecord.Sales_Person_2__c = mapOfaliasAndUser.get(stralias[1]).id;
                                            
                                        }
                                        
                                }else if(stralias.size() == 1){
                                        if(mapOfaliasAndUser.containskey(stralias[0])){
                                            
                                                leadrecord.Sales_Person_1__c = mapOfaliasAndUser.get(stralias[0]).id;
                                            
                                        }
                                        
                                }
                            }   
                          LeadToUpdateToConverted.add(leadrecord);
                    }
               }else{
                    if(mapOfMobileOrEmailAndLead.containskey(leadtemp1.Email)){
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            system.debug(leadrecord +'leadrecord1');
                            // marking the new lead as mark for deletion if lead exist but not converted. 
                            leadrecord.Mark_For_Deletion__c = true;
                            LeadMarkedforDeletion.add(leadrecord);
                        
                    }else if((mapOfMobileOrEmailAndLead.containskey(leadtemp1.MobilePhone)) || (mapOfMobileOrEmailAndLead.containskey(leadtemp1.Mobile_1__c)) || (mapOfMobileOrEmailAndLead.containskey(leadtemp1.Phone) || (mapOfMobileOrEmailAndLead.containskey(leadtemp1.Phone2__c)))){                             
                            leadrecord = new lead();
                            leadrecord = MapOfleadIdAndLead.get(leadtemp1.id);
                            system.debug(leadrecord +'leadrecord1');
                            // marking the new lead as mark for deletion if lead exist but not converted. 
                            leadrecord.Mark_For_Deletion__c = true;
                            LeadMarkedforDeletion.add(leadrecord);
                    }
               }
          }
                system.debug(LeadToUpdateNotConverted+'LeadToUpdateNotConverted');
                // update the existing lead which is not converted , except lead source and mode of enquiry
                if(LeadToUpdateNotConverted.size() > 0){
                    
                    update LeadToUpdateNotConverted;
                    
                    for(Lead leUpdate : LeadToUpdateNotConverted){
                        //Convert only those leads which have "walk in" in mode of enquiry
                        if(leUpdate.Mode_of_Enquiry__c.contains('Walk-in') && leUpdate.Mode_of_Enquiry__c != 'Exhibition Walk-in'){
                            Database.LeadConvert dl = new Database.LeadConvert();
                            dl.setLeadId(leUpdate.id);
                            if(leUpdate.Sales_Person_1__c != null ){
                                dl.setOwnerId(leUpdate.Sales_Person_1__c);
                            }
                            dl.setConvertedStatus(convertStatus.MasterLabel);
            
                            Database.LeadConvertResult lcr = Database.convertLead(dl);
                            System.assert(lcr.isSuccess());
                            mapOfAccAndContact.put(lcr.getAccountId(),lcr.getContactId());
                         }
        
                    }
                    
                }
                // update the new lead with sales person 1 , sales person 2 and sales person 3
                if(LeadToUpdateToConverted.size() > 0){
                        update LeadToUpdateToConverted;
                        
                        for(Lead leUpdate1 : LeadToUpdateToConverted){
                                 flag = false;
                           // if((leUpdate1.Mode_of_Enquiry__c != 'Event Walk-in') && leUpdate1.Mode_of_Enquiry__c.contains('Walk-in')){
                                 Database.LeadConvert dl = new Database.LeadConvert();
                                 dl.setLeadId(leUpdate1.id);
                                 if(leUpdate1.Sales_Person_1__c != null ){
                                    dl.setOwnerId(leUpdate1.Sales_Person_1__c);
                                 }
                                 dl.setConvertedStatus(convertStatus.MasterLabel);
                                 //setting the account id while converting the lead if match found
                                 if(leadAccountID.containskey(leUpdate1.id)){
                                     system.debug('ennnnn');
                                     flag = true;
                                     dl.setAccountId(leadAccountID.get(leUpdate1.id));
                                 }
                                 
                                 //setting the contact id while converting the lead if match found
                                 if(leadContactID.containsKey(leUpdate1.id)){
                                     system.debug('outtttt');
                                     system.debug(leadContactID.get(leUpdate1.id)+'aaaa');
                                     flag = true;
                                     dl.setContactId(leadContactID.get(leUpdate1.id));
                                 }
                                 //run = false;
                                 Database.LeadConvertResult lcr = Database.convertLead(dl);
                                 System.assert(lcr.isSuccess());
                                 if(flag == false){
                                     mapOfAccAndContact.put(lcr.getAccountId(),lcr.getContactId());
                                 }
                            // }
                        }
                       
        
                }
                if(mapOfAccAndContact.size() > 0){    
                    updateAccountName(mapOfAccAndContact);
                }
                system.debug(LeadMarkedforDeletion+'LeadMarkedforDeletion');
                // Update the new lead which is marked for deletion  
                if(LeadMarkedforDeletion.size() > 0){
                    //system.assertequals(LeadMarkedforDeletion,null);
                    update LeadMarkedforDeletion;
                }
                
        
   // }
  }
  public void updateAccountName(Map<ID,ID> mapOfAccAndCon){
      List<Account> listOfAccountToUpdate = new List<Account>();
      List<Contact> listOfContact         = new List<Contact>();
      List<Account> listOfAccount         = new List<Account>();
      Map<id,Account> mapOfIDAndAcc       = new Map<id,Account>();
      Account accRecord ;
      listOfContact = [SELECT id,FirstName,LastName,AccountID From Contact WHERE ID IN: mapOfAccAndCon.values()];
      listOfAccount = [SELECT id,Name FROM Account WHERE ID IN: mapOfAccAndCon.keySet()];
      if(listOfAccount.size() > 0){
          for(Account acc : listOfAccount ){
              mapOfIDAndAcc.put(acc.id,acc);
          }
      }
      if(listOfContact.size() > 0){
          for(Contact con : listOfContact){
              accRecord = new Account();
              accRecord = mapOfIDAndAcc.get(con.AccountID);
              accRecord.name = con.FirstName + ' ' + con.LastName;
              listOfAccountToUpdate.add(accRecord);
          }
      }
      if(listOfAccountToUpdate.size() > 0){
          update listOfAccountToUpdate;
      }
  }
}