trigger UpdateLeadOwner on Referral__c (after insert,after update) {
    public List<Id> referralIds=new List<Id>();
    public List<Lead> ldList=new List<Lead>();
    public List<User> usr= new List<User>();
    for(Referral__c ref : Trigger.new){
        referralIds.add(ref.lead__c);
    }
    usr=[select Id, name From User Where Profile.Name <>'Overage High Volume Customer Portal User_Custom'];
    if(referralIds.size() >0) {
        List<Lead> leadList=[select Id, OwnerId From Lead Where Id IN:referralIds];
        //system.assertEquals(leadList,null);
        if(usr.size()>0){
            
            for(User u: usr){
                for(Lead ld:LeadList){
                    if(u.Name=='Work Flow'){
                        ld.OwnerId=u.Id;
                        
                    }else{
                        if(u.Name=='Brigadeforce Admin'){
                            ld.OwnerId=u.Id;
                            
                        }
                    }
                    
                }
            }
            try{
                update LeadList; 
            }Catch(Exception e){
                for(Referral__c ref : Trigger.new){
                    ref.addError('Referral not submited, Please contact Admin.');
                }
            }
        }
    }
}