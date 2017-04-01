trigger UpdateOpptyLookupInPS on Payment_Schedule__c (before insert,before update) {
    for(Payment_Schedule__c ps: Trigger.New) {
        ps.Opportunity__c = ps.SOIOpptyID__c;
    }
}