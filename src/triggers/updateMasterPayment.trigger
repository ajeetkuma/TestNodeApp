trigger updateMasterPayment on Contact (before update) {
 if(contactRecursiveHelper.isupdateMasterPayment!= true){
 try{
 //Variable declaration
   Set<Id> ContactIds = new Set<Id>();

    //Adding the contact ids
    for(Contact con : Trigger.new)
    {
        ContactIds.add(con.Id);
    }

    List<Master_Payment__c> listOfMasterPayment =   [Select id,Contact_Id__c,Contact_mobile__c,Contact_Name__c,Don_t_Disturb__c 
                                                        from Master_Payment__c where Contact_Id__c =: ContactIds];
    if(listOfMasterPayment.size()>0){
        for( Contact con : trigger.new){
             for(Master_Payment__c masterPayment : listOfMasterPayment){
                if(masterPayment.Contact_Id__c == con.id){
                    masterPayment.Contact_mobile__c =   con.MobilePhone;
                    masterPayment.Don_t_Disturb__c  =   con.smagicinteract__SMSOptOut__c;
                    masterPayment.Contact_Name__c   =   con.FirstName;
                }
             }
        }
    }
    contactRecursiveHelper.isupdateMasterPayment = true;
    update listOfMasterPayment;
    }
    catch(Exception e){
     System.debug('Please Contact your admin '+e.getMessage());
       }
   }
}