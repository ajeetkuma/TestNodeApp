trigger updateBG_profileOnAccount on account (before update) {

    if(contactRecursiveHelper.isAccountUpdate==false){
        
    //map for BG_CPprofile__c to its account records 
    map<id,list<BG_CPprofile__c>> accountOfMap = new map<id,list<BG_CPprofile__c>>();
    
   // got list of CP_Profile records based on Account Id
    List<BG_CPprofile__c> listBGprofile =[SELECT Contact__c,CPprofile_BillingCity__c,CPprofile_BillingCountry__c,CPprofile_BillingPostcode__c,CPprofile_BillingState__c,Contact__r.AccountId,
                            CPprofile_BillingStreet__c,CPprofile_BirthDate__c,CPprofile_Company__c,CPprofile_Designation__c,CPprofile_EducationalQualification__c,
                            CPprofile_EmailForCommunication__c,CPprofile_HouseNumber__c,CPprofile_IncomeTaxPANGIRNo__c,CPprofile_Industry__c,CPprofile_MailingCity__c,
                            CPprofile_MailingCountry__c,CPprofile_MailingPostCode__c,CPprofile_MailingState__c,CPprofile_MailingStreet__c,CPprofile_MirrorEducationalQualification__c,
                            CPprofile_MirroringCompany__c,CPprofile_MirroringDesignation__c,CPprofile_MirroringEmailForCommunication__c,CPprofile_MirroringHouseNumber__c,
                            CPprofile_MirroringIndustry__c,CPprofile_MirroringMailingCountry__c,CPprofile_MirroringMailingPostCode__c,CPprofile_MirroringMailingState__c,
                            CPprofile_MirroringMailingStreet__c,CPprofile_MirroringMailing_City__c,CPprofile_MirroringMobile__c,CPprofile_MirroringName__c,CPprofile_MirroringProfession__c,
                            CPprofile_MirroringStreet1__c,CPprofile_MirroringStreet2__c,CPprofile_MirroringStreet3__c,CPprofile_Mobile__c,CPprofile_Name__c,
                            CPprofile_Profession__c,CPprofile_ReasonforReject_del__c,CPprofile_Street1__c,CPprofile_Street2__c,CPprofile_Street3__c,CPprofile_Wedding_Anniversary__c,
                            CP_Profile_External_Id__c,Id,Mailing_Address__c,Name,Portal_UserMobile__c,Portal_Username__c,User__c FROM BG_CPprofile__c WHERE Contact__r.AccountId IN:Trigger.newMap.keySet()];
    
        system.debug('::::::::::listBGprofile========='+listBGprofile );
        //store account related cpprofile records in map
    for(BG_CPprofile__c cpProfileInfo : listBGprofile){
        System.debug('@cpProfileInfo List ID: ' + cpProfileInfo.Id);
        
            if(accountOfMap.get(cpProfileInfo.Contact__r.AccountId)==null) {
                accountOfMap.put(cpProfileInfo.Contact__r.AccountId,new list<BG_CPprofile__c>{cpProfileInfo});

            }
            else {
                accountOfMap.get(cpProfileInfo.Contact__r.AccountId).add(cpProfileInfo);
            }
        
     }
          system.debug('::::::::::accountOfMap========='+accountOfMap);
      for(Account ac : trigger.new){
        list<BG_CPprofile__c> cplist = new list<BG_CPprofile__c>();
        // Checking the condition for Account and CPProfile Values.
         try{
        if(ac.House_number__c != null || ac.Street1__c != null || ac.Street2__c != null || ac.Street3__c != null || ac.Postal_Code__c != null || ac.City__c != null  ){
            System.debug(':::came inside1');
            for(BG_CPprofile__c CPprofile :accountOfMap.get(ac.id)){
                System.debug(':::came inside1+inside1');
                CPprofile.CPprofile_HouseNumber__c = ac.House_number__c;
                CPprofile.CPprofile_Street1__c = ac.Street1__c;
                CPprofile.CPprofile_Street2__c = ac.Street2__c;
                CPprofile.CPprofile_Street3__c = ac.Street3__c;
                CPprofile.CPprofile_BillingPostcode__c = ac.Postal_Code__c;
                CPprofile.CPprofile_BillingCity__c = ac.City__c;
                cplist.add(CPprofile);
            
         }
    }
           contactRecursiveHelper.isAccountUpdate= true;
           system.debug('::::====Updatedlist of BGProfile'+contactRecursiveHelper.isContactUpdate);
           
            update cplist;
            System.debug(':::cplist cplist+cplist');
        }
        catch( Exception e)
        {
           System.debug('Contact your Admin');
        }
           
    }
}

}