public class OpptyUtil {
    public void setUnitStatus(Map<Id,String> unitDetails) {
        List<Unit__c> lstUnits = [select Unit_Status__c from Unit__c where 
                        Id IN: unitDetails.keySet() ];
        System.debug('##C## lstUnits(before update): ' + lstUnits);
        for(Unit__c U : lstUnits) {
            U.Unit_Status__c = unitDetails.get(u.Id);
        }
        update lstUnits;
        System.debug('##C## lstUnits(after update): ' + lstUnits);
    }
}