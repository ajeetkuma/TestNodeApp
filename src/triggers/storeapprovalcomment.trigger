trigger storeapprovalcomment on Commission__c (after update) {
      list<Commission__c> comlist = new list<Commission__c>();
      list<Commission__c> comlist1 = new list<Commission__c>();
      list<Commission__c> comlist2 = new list<Commission__c>();
      commissionTriggerHandler ins = new commissionTriggerHandler ();
      if(Trigger.isAfter && Trigger.isUpdate){
        if(checkRecursive.runOnce()){
            for(Commission__c com : trigger.new){
                system.debug(trigger.oldMap.get(com.id).Status__c+'old'+trigger.newmap.get(com.id).Status__c+'new');
                if(trigger.oldMap.get(com.id).Status__c != trigger.newmap.get(com.id).Status__c && (trigger.newmap.get(com.id).Status__c == 'Approved' || trigger.newmap.get(com.id).Status__c == 'Approved By Project Head')){
                    comlist.add(com);
                    system.debug('first ifff');

                }else if(trigger.oldMap.get(com.id).Status__c != trigger.newmap.get(com.id).Status__c && (trigger.newmap.get(com.id).Status__c == 'Reject' )){
                    comlist1.add(com);
                    system.debug('secound ifff');
                }
                
             }
             system.debug(comlist+'comlist');
             if(comlist.size() > 0){
                 
                 ins.storingApprovalComment(comlist);
             }
             system.debug(comlist1+'comlist1');
             if(comlist1.size() > 0){
                 
                 ins.updateComStatusinOpp(comlist1);
             }
        }
        
    }
    /*
    if(Trigger.isInsert && Trigger.isAfter ){
        system.debug('called after isert');
        if(checkRecursive.runOnce()){
            system.debug('called after isert');
            for(Commission__c com : trigger.new){
                system.debug('called after isert');
                comlist2.add(com);
            }
            if(comlist2.size() > 0){
                 system.debug('called after isert');
                 ins.updateComStatusinOpp(comlist2);
             }
        }
    }*/
}