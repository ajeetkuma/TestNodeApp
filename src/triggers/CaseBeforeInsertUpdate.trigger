trigger CaseBeforeInsertUpdate on Case(before insert, before update) {

    Set < Id > opportunityIds = new Set < Id > ();
    Set < Id > opportunityOwnerIds = new Set < Id > ();
    Set < String > opportunityOwnerEmail = new Set < String > ();
    Set < Id > ownerIds = new Set < Id > ();
    Set < Id > ownerIds2 = new Set < Id > ();
    List < Id > userids = new List < Id > ();
    public string ownerEmail;


    try {
        for (Case cs: Trigger.new) {
            if(cs.Case_Division_Portal__c != null){
               if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(cs.Id).Case_Division_Portal__c != Trigger.NewMap.get(cs.Id).Case_Division_Portal__c)){
                if(cs.Case_Division_Portal__c == 'Custom Relationship Management' ){
                    cs.Case_Division__c  = 'CRM Team';
                }else if(cs.Case_Division_Portal__c == 'Customer Care Before Handing Over'){
                    cs.Case_Division__c  = 'CCE Team';
                }else if(cs.Case_Division_Portal__c == 'Customer Care Post Handing over'){
                    cs.Case_Division__c  = 'CCC Team';
                }else if(cs.Case_Division_Portal__c == 'Estate Management'){
                    cs.Case_Division__c  = 'EM Team';
                }
                 
                if(cs.Category_portal__c != null ){
                    cs.Category__c = cs.Category_portal__c;
                }
              }
            }    
              if(cs.Case_Division__c != null){
                 if(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(cs.Id).Case_Division__c != Trigger.NewMap.get(cs.Id).Case_Division__c)){
                if(cs.Case_Division__c  == 'CRM Team' ){
                    cs.Case_Division_Portal__c = 'Custom Relationship Management';
                }else if(cs.Case_Division__c  == 'CCE Team'){
                    cs.Case_Division_Portal__c = 'Customer Care Before Handing Over';
                }else if(cs.Case_Division__c  == 'CCC Team'){
                    cs.Case_Division_Portal__c = 'Customer Care Post Handing over';
                }else if(cs.Case_Division__c  == 'EM Team'){
                    cs.Case_Division_Portal__c = 'Estate Management';
                }
                  
                if(cs.Category__c != null){
                     cs.Category_portal__c = cs.Category__c;
                }
              }    
            }     
            
            if(Trigger.isBefore && Trigger.isInsert){
            if(cs.Case_Division__c == 'EM Team'){
               cs.OwnerId = CaseOwnership__c.getvalues('EM_Team').case_ownerID__c;
            }else if(cs.Case_Division__c == 'CCE Team' ){
                cs.OwnerId = CaseOwnership__c.getvalues('CCE_TEAM').case_ownerID__c;
            }else if(cs.Case_Division__c == 'CCC Team'){
                cs.OwnerId = CaseOwnership__c.getvalues('CCC_TEAM').case_ownerID__c;
            }else {
                if (cs.Change_owner__c == false) {
                    for (Case c: Trigger.new) {

                        if (c.Opportunity__c != null) {
                            opportunityIds.add(c.Opportunity__c);
                        }
                    }
                    system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%' + opportunityIds.size());
                    if (opportunityIds.size() <> 0) {
                        Map < Id, Opportunity > opportunityMap = new Map < Id, Opportunity > ([select Id, OwnerId, Unit__r.Plant__r.Admin_Email__c, Unit__r.Plant__r.OwnerId, Unit__r.Plant__r.Admin_User__c from Opportunity where Id IN: opportunityIds]);

                        for (Opportunity o: opportunityMap.values()) {
                            if (o.Unit__r.Plant__r.Admin_Email__c != null) {
                                opportunityOwnerEmail.add(o.Unit__r.Plant__r.Admin_Email__c);
                                opportunityOwnerIds.add(o.Unit__r.Plant__r.OwnerId); // palnt owner
                                ownerIds.add(o.Unit__r.Plant__r.Admin_User__c); // plant Admin user
                            }
                        }

                        //if(ownerIds <> null){
                        //system.assertEquals(ownerIds,null);
                        Map < Id, User > userMap = new Map < Id, User > ([select Name, Email from User where Id IN: opportunityOwnerIds]);
                        List < User > userList = new List < User > ([select Name, Email, UserRoleId from User where Id = : ownerIds AND UserRoleId <> null]);

                        system.debug('%%%%%%%%%%%%%%%%%%%%%' + userList); // bs
                        system.debug('&&&&&&&&&&&&&&&&&&&&&&&&' + userMap); // S
                        //List <User> userList2 = new List<User>([select Name, Email,UserRoleId from User where Id =:ownerIds]);
                        if (userList.size() > 0) {
                            UserRole ur = [Select Id, ParentRoleId From UserRole Where Id = : userList[0].UserRoleId];
                            List < User > user2 = [select Id, Name, UserRoleId, Email from User where UserRoleId = : ur.ParentRoleId];
                            System.debug('::::::::=======ur' + ur);
                            System.debug('::::::::=======user2' + user2);



                            //system.assertEquals(user2[0].Email,null);
                            if(userList.size() >0) {
                            for (Case c: Trigger.new) {


                                c.OwnerId = userList[0].Id;
                                c.Admin_Email__c = userList[0].Email;
                                c.Manager_Admin_Email__c = user2[0].Email;
                                System.debug('::::::::=====c.OwnerId' + c.OwnerId);

                            }
                               }
                             else{
                            if (userMap.size() > 0) {
                                System.debug('::::::::::UserMap:::::::::::');
                                for (Case c: Trigger.new) {
                                    c.OwnerId = userMap.get(opportunityMap.get(c.Opportunity__c).Unit__r.Plant__r.OwnerId).Id;
                                    List < User > userList3 = new List < User > ([select Name, Email, UserRoleId from User where Id = : c.OwnerId]);
                                    UserRole ur2 = [Select Id, ParentRoleId From UserRole Where Id = : userList3[0].UserRoleId];
                                    List < User > user3 = [select Id, Name, UserRoleId, Email from User where UserRoleId = : ur2.ParentRoleId];


                                    c.Admin_Email__c = userList3[0].Email;
                                    c.Manager_Admin_Email__c = user3[0].Email;

                                }


                            }
                              } 
                            //}**/
                        }
                    }
                }
              }  
            
        }
        }
    } Catch(Exception e) {
        for (Case c: trigger.new)
        c.addError('Query not submited, Please contact Admin.');
    }

    /**  if (Trigger.isUpdate && Trigger.isBefore) {

for (Case c : Trigger.new) {
if(c.OwnerId != null) {
ownerIds.add(c.OwnerId);
}
}
User user = [select Name,UserRoleId from User where Id =:ownerIds];
UserRole ur = [Select Id, ParentRoleId From UserRole Where Id=:user.UserRoleId];
List<User> user2 = [select Id,Name,UserRoleId from User where UserRoleId =:ur.ParentRoleId];
//List<User> user2 = [select Id,Name,UserRoleId from User where Id =:ownerIds];
EmailTemplate et = [SELECT Id,Name FROM EmailTemplate WHERE Name = 'Email to Case owner Manager'];
for(User u : user2)
{
userids.add(u.Id);
}

for (Case case2 : Trigger.new) {
if(case2.Email_to_Manager__c==true){

/**  Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
mail.setTargetObjectIds(userids);
mail.WhatIds.add(case2.Id);
mail.setTemplateId(et.Id);
mail.saveAsActivity = false;
Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail }); 
string email;
if(userList.size()==1){
email=userList[0].Email;
}
else{
if(userMap.size() > 0){ 
email=userMap.get(opportunityMap.get(case2.Opportunity__c).Unit__r.Plant__r.OwnerId).Email;
}
}

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setTargetObjectId(case2.ContactId);
mail.setWhatId(case2.Id);
mail.setTemplateId(et.Id);
mail.setToaddresses(new String[] {email});
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

}
}
}
if (Trigger.isBefore &&  (Trigger.isInsert || Trigger.isUpdate)) {

for (Case c : Trigger.new) {
if(c.OwnerId != null) {
ownerIds.add(c.OwnerId);
}
}
User user = [select Name,UserRoleId from User where Id =:ownerIds];
UserRole ur = [Select Id, ParentRoleId From UserRole Where Id=:user.UserRoleId];
List<User> user2 = [select Id,Name,UserRoleId,Email from User where UserRoleId =:ur.ParentRoleId];
//List<User> user2 = [select Id,Name,UserRoleId from User where Id =:ownerIds];
EmailTemplate et = [SELECT Id,Name FROM EmailTemplate WHERE Name = 'Email to Case owner Manager'];

ownerEmail=user2[0].Email;
for(User u : user2)
{
userids.add(u.Id);

}

if(trigger.isafter && (trigger.isInsert ||trigger.isUpdate))  {
for (Case case2 : Trigger.new) {
if(case2.Categories_Service__c=='Project Specific Updates'){
system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+case2.Id);
string email;
email=ownerEmail;
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setTargetObjectId(case2.ContactId);
mail.setWhatId(case2.Id);
mail.setTemplateId(et.Id);
mail.setToaddresses(new String[] {email});
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}


}

}
}    **/
}