trigger ContactBeforeDelete on Contact (before delete) {
    if(contactRecursiveHelper.isContactBeforeDelete == false) {
    List<Id> actIds = new List<Id> ();
    List<Account> lstAct = new List<Account> ();
    Map<Id,Account> mapAcnt = new Map<Id,Account> ();
    
    for(Contact c: Trigger.Old) {
        actIds.add(c.AccountId);
    }
    System.debug('### (ContactBeforeDelete) lstAct: ' + lstAct);
    
    for(Account a : [select Primary_Contact_s_Email__c,Primary_Contact_s_Name__c,FirstApplicant__c,
    SecondApplicant__c,ThirdApplicant__c,FourthApplicant__c,GPAHolder__c,CC_Address__c from Account where Id IN:actIds]) {
        mapAcnt.put(a.Id,a);
    }
    
    for(Contact c: Trigger.Old) {
        System.debug('### (ContactBeforeDelete) inside for loop');
        if(c.Contact_Type__c !=null) {
            System.debug('### (ContactBeforeDelete) inside IF contact type !=null');
            if(c.Contact_Type__c.equals('First Applicant'))
                mapAcnt.get(c.AccountId).FirstApplicant__c = false;
            else if(c.Contact_Type__c.equals('Second Applicant'))
                mapAcnt.get(c.AccountId).SecondApplicant__c = false;
            else if(c.Contact_Type__c.equals('Third Applicant'))
                mapAcnt.get(c.AccountId).ThirdApplicant__c = false;
            else if(c.Contact_Type__c.equals('Fourth Applicant'))
                mapAcnt.get(c.AccountId).FourthApplicant__c = false;
            else if(c.Contact_Type__c.equals('GPA Holder'))
                mapAcnt.get(c.AccountId).GPAHolder__c = false;
        }
        // CC address
        System.debug('### (ContactBeforeDelete) mapAcnt.get(c.AccountId): ' + mapAcnt.get(c.AccountId));
        if(mapAcnt.get(c.AccountId).CC_Address__c !=null) {
            System.debug('### (ContactBeforeDelete) inside IF cc address !=null');
            if(c.CC_GPA__c) {
                System.debug('### (ContactBeforeDelete) inside IF cc gpa true');
                if(mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email)) {
                    System.debug('### (ContactBeforeDelete) inside IF contains email');
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(c.Email,'');
                 }
            }
            if(c.CC_Email2__c) {
                if(mapAcnt.get(c.AccountId).CC_Address__c.contains(c.Email2__c)) {
                    mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.replace(c.Email2__c,'');
                }
            }
            if(mapAcnt.get(c.AccountId).CC_Address__c.endsWith(','))
                mapAcnt.get(c.AccountId).CC_Address__c = mapAcnt.get(c.AccountId).CC_Address__c.subString(0,mapAcnt.get(c.AccountId).CC_Address__c.length()-1);
        }        
    }
    contactRecursiveHelper.isContactBeforeDelete = true;
    update mapAcnt.values();
    }
}