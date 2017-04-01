trigger updateInactive on Plant__c (before update, before insert) {
    List<Id> PlantIds =new List<Id>();
    List<String> unitName =new List<String>();
    List<CP_Property__c> listProperty =new List<CP_Property__c>();
     Set<Id> PlantId =new Set<Id>();
    
    for(Plant__c plant : trigger.new){
         PlantId.add(plant.id);
            if(plant.id!=null){
                Plant__c oldPlant = trigger.oldMap.get(plant.Id);
                    if(oldPlant.id!=null){
                        if(plant.Allowed_portal_access__c==false && oldPlant.Allowed_portal_access__c==false){
                        PlantIds.add(plant.Id);
                            }  
                        }
                    else{
                        if(plant.Allowed_portal_access__c==false ){
                            PlantIds.add(plant.Id);
                            }  
                         }
                    }  
                }
    
    if(PlantIds.size() > 0 ){
        List<Unit__c> unitList = new List<Unit__c>([select Name,Plant__c from Unit__c where Plant__c IN :PlantIds]);
    
    for(Unit__c u : unitList){
        unitName.add(u.Name);
    }
        if(unitList.size() > 0) {
            listProperty = new List<CP_Property__c>([Select Name, Active__c,Unit_Code__c from CP_Property__c Where Unit_Code__c IN :unitName limit 50000]);
        }
        for(CP_Property__c lp : listProperty){
            lp.Active__c=false;
        }
        update listProperty;
    }
   
    List<Master_Payment__c> listOfMasterPayment =   [Select id,Plant_Code__c,Don_t_Disturb_Plant__c 
                                                        from Master_Payment__c where  Plant_Code__c  in : PlantId limit 50000];
         List<Master_Payment__c> listToUpdate = new  List<Master_Payment__c>();                                                
        for( Plant__c pl : trigger.new){
             for(Master_Payment__c masterPayment : listOfMasterPayment){
               // if(masterPayment.Plant_Code__c == pl.id){
                    masterPayment.Don_t_Disturb_Plant__c =   pl.Don_t_Disturb__c;
                    listToUpdate.add(masterPayment );
               // }
             }
        }
        try{
         update listToUpdate ;
        }
        catch( Exception e){
             System.debug('Please Contact your admin '+e.getMessage());
        }
}