/*
    Descrition : This Class is used to calculation Actuals and update calculated
                 actuals against Target in Target object for respective records
    Author     : Amritesh
*/
public class ActualsCalculation_Cls {
    
    Private Map<string,Double> achievedValMap;            // Map to hold Total Acheieved Value
    Private Map<string,Double> achievedAreaMap;           // Map to hold Total Achieved Area
    Private Map<string,Double> collectionsAchievedMap;    // Map to hold Total Collections Achieved
    Private Map<string,Integer> achievedNoOfUnitsMap;     // Map to hold Total Achieved no of units
    Private Map<String,String> targetUniqueKey;
    private Map<Id,Opportunity> oppWithPayment;
    private Map<String,Opportunity> previousSalesDate;
    
    // Constructor 
    public ActualsCalculation_Cls(){
        
        achievedValMap          = new Map<string,Double>();  
        achievedAreaMap         = new Map<string,Double>();  
        collectionsAchievedMap  = new Map<string,Double>();  
        achievedNoOfUnitsMap    = new Map<string,Integer>(); 
        targetUniqueKey         = new Map<String,String>();
        previousSalesDate       = new Map<String,Opportunity>();
    }
    
            
    /* 
        Method to calculate Actuals for Allocated Opportunity Only
    */
    public void oppActualCalcualtion(List<Opportunity> oppList,Map<Id,Opportunity> newMap,Map<Id,Opportunity> oldMap){
        
        try{
            achievedValMap          = new Map<string,Double>();  
            achievedAreaMap         = new Map<string,Double>();  
            collectionsAchievedMap  = new Map<string,Double>();  
            achievedNoOfUnitsMap    = new Map<string,Integer>(); 
            targetUniqueKey         = new Map<String,String>();
            previousSalesDate       = new Map<String,Opportunity>();
            
            Set<String> projectList = new Set<String>();
            Set<String> plantList   = new Set<String>();
            
            for(Opportunity op : oppList){
                if(op.Sale_Order_No__c != null && (oldMap.get(op.id).For_ROI__c != newMap.get(op.id).For_ROI__c
                 || oldMap.get(op.id).Total_No_of_SQFT__c != newMap.get(op.id).Total_No_of_SQFT__c 
                 || oldMap.get(op.id).Payment_Received_Total__c != newMap.get(op.id).Payment_Received_Total__c
                 || (oldMap.get(op.id).StageName != newMap.get(op.id).StageName 
                    && (newMap.get(op.id).StageName == Utility_Class.ALLOTMENT_STAGE)))
                 || (oldMap.get(op.id).Sale_Order_Date__c != newMap.get(op.id).Sale_Order_Date__c)){
                    projectList.add(op.Opportunity_Project__c);
                    plantList.add(op.Opportunity_Plant__c);
                    if(oldMap.containsKey(op.Id) && oldMap.get(op.Id).Sale_Order_Date__c != null){
                        previousSalesDate.put(op.Id,oldMap.get(op.Id));
                    }
                }               
            }
            
            actualCalculationLogic(projectList,plantList);
            
        }catch(Exception ex){}
    }
    
    public void actualCalculationLogic(Set<String> projectList,Set<String> plantList){
        
        try{
            // Get Opportunity with child Payment Schedule
             oppWithPayment = new Map<Id,Opportunity>([Select id,StageName,Sale_Order_Date__c,Unit__c,Sale_Order_No__c,
                                                        Unit__r.Plant__c,Unit__r.Plant__r.ProjectLookup__c,For_ROI__c,Total_No_of_SQFT__c,                                                          
                                                        Payment_Received_Total__c from Opportunity 
                                                        where StageName =: Utility_Class.ALLOTMENT_STAGE AND 
                                                        Opportunity_Project__c IN: projectList AND Opportunity_Plant__c IN: plantList]);
    
            for(String opKey : oppWithPayment.keySet()){
                    
                //String month      = String.ValueOf(oppWithPayment.get(opKey).Sale_Order_Date__c.month());
                //String Year       = String.ValueOf(oppWithPayment.get(opKey).Sale_Order_Date__c.Year());
                String projectId    = String.valueOf(oppWithPayment.get(opKey).Unit__r.Plant__r.ProjectLookup__c).substring(0,15);
                String planId       = String.valueOf(oppWithPayment.get(opKey).Unit__r.Plant__c).substring(0,15);
                //String mapKey     = projectId+'&&'+planId+'&&'+month+'&&'+Year;
                targetUniqueKey.put(projectId+'&&'+planId,opKey);
                
                if(oppWithPayment.get(opKey).Sale_Order_Date__c != null && oppWithPayment.get(opKey).Sale_Order_No__c != null){
                    String mapKey       = String.valueOf(oppWithPayment.get(opKey).Sale_Order_Date__c);
                                        
                    // Calculation for Acheieved Value                  
                    Double achievedVal  = 0;
                    if(achievedValMap.containsKey(mapKey)){
                        achievedVal = achievedValMap.get(mapKey)+oppWithPayment.get(opKey).For_ROI__c;
                        achievedValMap.put(mapKey,achievedVal);
                    }else{
                        achievedValMap.put(mapKey,oppWithPayment.get(opKey).For_ROI__c);
                    }
                    
                    // Calculation for Achieved Area                    
                    Double achievedArea = oppWithPayment.get(opKey).Total_No_of_SQFT__c!=null?Double.ValueOf(oppWithPayment.get(opKey).Total_No_of_SQFT__c):0;
                    
                    if(achievedAreaMap.containsKey(mapKey)){
                        achievedArea    = achievedAreaMap.get(mapKey)+achievedArea;
                        achievedAreaMap.put(mapKey,achievedArea);
                    }else{
                        achievedAreaMap.put(mapKey,achievedArea);
                    }
                    
                    // Calculation for No of Units                  
                    if(achievedNoOfUnitsMap.containsKey(mapKey)){
                        achievedNoOfUnitsMap.put(mapKey,achievedNoOfUnitsMap.get(mapKey)+1);    
                    }else{                      
                        achievedNoOfUnitsMap.put(mapKey,1);
                    }
                    
                    //Calculation for Collections Achieved
                    Double totalpayment = oppWithPayment.get(opKey).Payment_Received_Total__c!=null?oppWithPayment.get(opKey).Payment_Received_Total__c:0;
                    
                    if(collectionsAchievedMap.containsKey(mapKey)){
                        totalpayment    = collectionsAchievedMap.get(mapKey)+totalpayment;
                        collectionsAchievedMap.put(mapKey,totalpayment);    
                    }else{                      
                        collectionsAchievedMap.put(mapKey,totalpayment);
                    }
                }
            
            }
            
            updateTargetwithActuals();
        }catch(Exception ex){
            system.debug('Exception::'+ex.getMessage());
        }   
        
    }
    
    
    /*
        Update Target with Calculated Actuals
    */
    public void updateTargetwithActuals(){
        try{
            
            Map<Id,Target__c> updateTargets         = new Map<Id,Target__c>();
            Map<Id,Double> updateAcheievedValue     = new Map<Id,Double>();
            Map<Id,Double> updateAchievedArea       = new Map<Id,Double>();
            Map<Id,Double> updateCollection         = new Map<Id,Double>();
            Map<Id,Integer> updateAchievedUnit      = new Map<Id,Integer>();
            
            Map<Id,Target__c> existingTargets   = new Map<Id,Target__c>([Select id,Acheieved_Value__c,Achieved_Area__c,Start_Date__c,
                                                            End_Date__c,Achieved_no_of_units__c,Collections_Achieved__c,TargetExternalKey__c 
                                                            from Target__c 
                                                            where TargetExternalKey__c IN : targetUniqueKey.keySet()]);
            
            for(String opKey : oppWithPayment.keySet()){
            
                Date dt = oppWithPayment.get(opKey).Sale_Order_Date__c;
                for(String key : existingTargets.keySet()){
                    
                    if(dt >= existingTargets.get(key).Start_Date__c && dt <= existingTargets.get(key).End_Date__c){
                        
                        // Update Acheieved_Value__c
                        Double achievedVal  = 0;
                        if(updateAcheievedValue.containsKey(key)){
                            achievedVal = updateAcheievedValue.get(key)+achievedValMap.get(string.valueOf(dt));
                            updateAcheievedValue.put(key,achievedVal);
                        }else{
                            updateAcheievedValue.put(key,achievedValMap.get(string.valueOf(dt)));
                        }                                           
                        
                                        
                        // Update Achieved_Area__c
                        Double achievedArea = achievedAreaMap.get(string.valueOf(dt))!=null?achievedAreaMap.get(string.valueOf(dt)):0;
                    
                        if(updateAchievedArea.containsKey(key)){
                            achievedArea    = updateAchievedArea.get(key)+achievedArea;
                            updateAchievedArea.put(key,achievedArea);
                        }else{
                            updateAchievedArea.put(key,achievedArea);
                        }               
                        
                                            
                        // Update Achieved_no_of_units__c                       
                        if(updateAchievedUnit.containsKey(key)){
                            updateAchievedUnit.put(key,updateAchievedUnit.get(key)+1);  
                        }else{                      
                            updateAchievedUnit.put(key,1);
                        }
                                            
                        // Update Collections_Achieved__c                       
                        Double totalpayment = collectionsAchievedMap.get(string.valueOf(dt))!=null?collectionsAchievedMap.get(string.valueOf(dt)):0;
                    
                        if(updateCollection.containsKey(key)){
                            totalpayment    = updateCollection.get(key)+totalpayment;
                            updateCollection.put(key,totalpayment); 
                        }else{                      
                            updateCollection.put(key,totalpayment);
                        }
                        
                    }else if(previousSalesDate.containsKey(opKey)){
                        Date preDt  = previousSalesDate.get(opKey).Sale_Order_Date__c; 
                        if(preDt >= existingTargets.get(key).Start_Date__c && preDt <= existingTargets.get(key).End_Date__c){
                                
                                Target__c prevTarget                = new Target__c();
                                prevTarget.id                       = key;
                                prevTarget.Acheieved_Value__c       = 0;
                                prevTarget.Achieved_Area__c         = 0;
                                prevTarget.Achieved_no_of_units__c  = 0;
                                prevTarget.Collections_Achieved__c  = 0;        
                                
                                updateTargets.put(key,prevTarget);                  
                        }
                    }
                }
            }
            
            for(String s : existingTargets.keySet()){
                Target__c newTarget = new Target__c();
                boolean changed     = false;
                if(updateAcheievedValue.containsKey(s)){
                    changed = true;
                    newTarget.Acheieved_Value__c = updateAcheievedValue.get(s);
                }
                if(updateAchievedArea.containsKey(s)){
                    changed = true;
                    newTarget.Achieved_Area__c = updateAchievedArea.get(s);
                }
                if(updateAchievedUnit.containsKey(s)){
                    changed = true;
                    newTarget.Achieved_no_of_units__c = updateAchievedUnit.get(s);
                }
                if(updateCollection.containsKey(s)){
                    changed = true;
                    newTarget.Collections_Achieved__c = updateCollection.get(s);
                }
                
                if(changed){
                    newTarget.Id    = s;
                    updateTargets.put(s,newTarget);
                }
                
            }
            
            if(updateTargets.Size() > 0){
                Handler_TargetTrigger.IS_TARGET_RUNNING = true;
                update updateTargets.values();
            }           
            
        }catch(Exception ex){
            system.debug('Exception ex'+ex.getMessage());
        }
    }
    
    /*
        get Total of all Payement schedule whose status is Recieved
    */
    /*public Double getPayementReceivedTotal(List<Payment_Schedule__c> payList){
        double totalpayment = 0;
        for(Payment_Schedule__c ps : payList){
            if(ps.Status__c == Utility_Class.PAYMENT_RECIEVED){
                totalpayment    += ps.Total__c;
            }
        }
        return totalpayment;
    }*/

}