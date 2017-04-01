/*
	Description : Handler class for TargetvsActualTrigger
	Author		: Amritesh
*/
public class Handler_TargetTrigger {
	
	public static boolean IS_TARGET_RUNNING	= false;
	
	public void afterInsert(final List<Target__c> newList,final Map<Id,Target__c> newMap){
		callActaulCalculation(newList,newMap);
	}
	
	public void afterUpdate(final List<Target__c> newList,final Map<Id,Target__c> newMap,final Map<Id,Target__c> oldMap){
		callActaulCalculation(newList,newMap);
	}
	
	// Call ActualsCalculation_Cls Class for Actual calculation  
	public void callActaulCalculation(List<Target__c> newList,Map<Id,Target__c> newMap){
		
		try{			
			Set<String> projectList	= new Set<String>();
			Set<String> plantList	= new Set<String>();
				
			for(String s : newMap.keySet()){
				projectList.add(String.ValueOf(newMap.get(s).Project_Lookup__c).substring(0,15));
				plantList.add(String.valueOf(newMap.get(s).Plant__c).substring(0,15));
			}
			
			ActualsCalculation_Cls obj	= new ActualsCalculation_Cls();
			obj.actualCalculationLogic(projectList, plantList);
			
		}catch(Exception ex){
			system.debug('Exception ::'+ex.getMessage());
		}
	}
}