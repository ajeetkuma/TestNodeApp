trigger referralUpdate on Lead (before Insert, before Update) {
    public List<ID> WorkUsrId = new List<ID>();
    public List<ID> AdminId = new List<ID>();
    public List<ID> LeadId = new List<ID>();
    public List <Referral__c> referralList = new List<Referral__c>();
    public List <User> usr = new List<User>();
    
    referralList =[select ID, Status__c From Referral__c where Lead__c IN:LeadId];
    
    for(Lead ld : Trigger.New){
        if(Trigger.isUpdate){
            if(ld.isConverted == TRUE){
                for(Referral__c ref : referralList){
                    ref.Status__c = 'Site Visit';
                }
            }
        }
    }
    update referralList;
}