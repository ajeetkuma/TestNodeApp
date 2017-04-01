/******************************************
	Description : This Trigger is Used for
				  Actuals Calculation
	Author		: Amritesh 
******************************************/
trigger TargetvsActualTrigger on Target__c (after insert, after update) {
	
	Handler_TargetTrigger trgObj	= new Handler_TargetTrigger();
	
	if(Trigger.isAfter && Trigger.isInsert && Handler_TargetTrigger.IS_TARGET_RUNNING == false){
		trgObj.afterInsert(Trigger.new, Trigger.newMap);
	}
	
	if(Trigger.isAfter && Trigger.isUpdate && Handler_TargetTrigger.IS_TARGET_RUNNING == false){
		trgObj.afterUpdate(Trigger.new, Trigger.newMap,Trigger.oldMap);
	}
}