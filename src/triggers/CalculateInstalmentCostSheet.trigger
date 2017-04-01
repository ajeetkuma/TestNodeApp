/*
---------------------------------
Author: Nirosha MG
Date Created: 22/11/16
Purpose: 
--------------------------------- 
*/

trigger CalculateInstalmentCostSheet on CostSheet__c (before update, before insert) {
   
 
   Set<String> FieldNames = new Set<String>{'Booking_Amount_B__c','On_Possession_Registration_P__c','X1st_installment_1__c','X2nd_Installment_2__c','X3rd_Installment_3__c','X4th_Installment_4__c','X5th_Installment_5__c','X6th_Installment_6__c','X7th_Installment_7__c','X8th_Installment_8__c','X9th_Installment_9__c','X10th_Installment_10__c','X11th_Installment_11__c','X12th_Installment_12__c','X13th_Installment_13__c','X14th_Installment_14__c','X15th_Installment_15__c'};
   Set<String> ChangedFieldNames = new Set<String>();
   Set<String> DifferenceFieldNames = new Set<String>();
   set<id> plantIDs = new set<id>();
   map<ID,Plant__c> plantIDToPlantRecordMap = new map<ID,Plant__c>();
   set<id> unitIDs = new set<id>();
   map<ID,Unit__c> unitIDtoUnitRecordMap = new map<ID,Unit__c>();
   
   for(CostSheet__c eachCostSheet:Trigger.New){
      plantIDs.add(eachCostSheet.Plant__c); 
      unitIDs.add(eachCostSheet.Unit__c);
   }
   
   for(Plant__c eachPlant:[SELECT id,Basic_Rate_PSFT__c from Plant__c where ID IN:plantIDs]){
       plantIDToPlantRecordMap.put(eachPlant.id,eachPlant);
   }
   for(Unit__c eachUnit: [SELECT id,Unit_Floor_Rise_Charg__c,PLC_Unit__c  from Unit__c where ID IN:unitIDs]){
       unitIDtoUnitRecordMap.put(eachUnit.id,eachUnit);
   }
   
   for(CostSheet__c cs:Trigger.New){
   if(Trigger.isBefore && Trigger.isUpdate){
   
    for(String fn:FieldNames){
            if(cs.Booking_Amount_B__c != null){
                ChangedFieldNames.add(fn);
            }
            //System.debug('Field Name'+fn+'---'+cs.get(fn)+'=>'+Trigger.oldMap.get(cs.id).get(fn));
            if ((cs.Booking_Amount_B__c != null) && (cs.On_Possession_Registration_P__c != null)){
                ChangedFieldNames.add(fn);
            }
            if(cs.Booking_Amount_B__c != null && (cs.On_Possession_Registration_P__c != null) && cs.get(fn) != null){
                ChangedFieldNames.add(fn);
            }
        }
        System.debug('---Changed--'+ChangedFieldNames);
        for(String dl: FieldNames){
                if(cs.get(dl) == null)
                     cs.put(dl,0);  
            }
         //System.debug('---Diff--'+DifferenceFieldNames); 
        
        if(ChangedFieldNames != null && ChangedFieldNames.size()>0){
            
            
            Integer TotalPercentage = 0;
            for(String fn:FieldNames){
            if(Integer.valueOf(cs.get(fn)) != null)
                TotalPercentage += Integer.valueOf(cs.get(fn));
            }
            
            if(TotalPercentage != 100){
                cs.addError('The Total Percentage should be 100%');
            }
       }
       }
       if(cs.Owner != null){
            cs.TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c = cs.Registration_Amount__c+ cs.X1st_installment_Rs__c+ cs.X2nd_installment_Rs__c + cs.X3rd_installment_Rs__c + cs.X4th_installment_Rs__c + cs.X5th_installment_Rs__c +cs.X6th_installment_Rs__c + cs.X7th_installment_Rs__c + cs.X8th_installment_Rs__c + cs.X9th_installment_Rs__c + cs.X10th_installment_Rs__c + cs.X11th_installment_Rs__c+cs.X11th_installment_Rs__c+ cs.X12th_installment_Rs__c+ cs.X13th_installment_Rs__c + cs.X14th_installment_Rs__c+ cs.X15th_installment_Rs__c+ cs.Prelaunched_Registeration__c+cs.On_Possession_Registration_Rs__c;
            }
       System.debug('---TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c --'+cs.TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c );
       
       if(cs.Apartment_Type__c != null){
              
               if(plantIDToPlantRecordMap.get(cs.plant__c).Basic_Rate_PSFT__c != null && unitIDtoUnitRecordMap.get(cs.unit__c).Unit_Floor_Rise_Charg__c != null && unitIDtoUnitRecordMap.get(cs.unit__c).PLC_Unit__c != null && cs.Discount__c != null){
               
               cs.Final_Rate_psft__c = plantIDToPlantRecordMap.get(cs.plant__c).Basic_Rate_PSFT__c+ unitIDtoUnitRecordMap.get(cs.unit__c).Unit_Floor_Rise_Charg__c+ unitIDtoUnitRecordMap.get(cs.unit__c).PLC_Unit__c - cs.Discount__c;
               cs.TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c = cs.Basic_cost_of_apartment__c + cs.Sheltered_car_park_Rs__c + cs.Stilt_car_park_Rs__c + cs.X2_wheeler_parking_Rs__c + cs.Open_car_park_Rs__c;
              
               System.debug('---Final_Rate_psft__c ---'+cs.Final_Rate_psft__c );
               System.debug('---TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c --'+cs.TOTAL_CONSIDERATION_INCLUDING_CAR_PARK_1__c );
               }
       }
   }
   
   
}