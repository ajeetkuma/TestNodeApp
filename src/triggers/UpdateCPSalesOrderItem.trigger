/* The trigger is used to update CPSalesorderitem when sales order item updated */
trigger UpdateCPSalesOrderItem on Sale_Order_Item__c (after insert, before update) {
    //Variables  declaration
    List<Id> SOIIds = new List<Id>();
    List<Id> oppIds = new List<Id>();
    List<CP_Sale_Order_Item__c> newCPSOIList = new List<CP_Sale_Order_Item__c>();
    List<CP_Sale_Order_Item__c> UpdateCPSOIList = new List<CP_Sale_Order_Item__c>();
    
    //Trigger.new records
    for(Sale_Order_Item__c SOI : Trigger.New){
        SOIIds.add(SOI.Id);
        oppIds.add(SOI.Opportunity__c);
    }

    //query for cp sales order item list
    List<CP_Sale_Order_Item__c>  CPSOIList = [select id,Basic_Cost__c,CP_Property__c,Name,Included_in_Allotment_letter__c,Item_category__c,Unit_of_measure__c,
                                                 Material__c,Netvalue__c,Order_Quantity__c,SOI_ID__c,Tax__c from CP_Sale_Order_Item__c where SOI_ID__c IN:SOIIds];
    
    //qyery for cp properties
    List<CP_Property__c>  cpList = [select id,Opportunity_Id__c from CP_Property__c where Opportunity_Id__c IN:oppIds];
    
    //Create new cp sales order item when new sales order item created
    if(Trigger.isInsert){
        for(Sale_Order_Item__c SOI : Trigger.New){
            for(CP_Property__c cp:cpList){
                if(cp.Opportunity_Id__c == SOI.Opportunity__c){
                    CP_Sale_Order_Item__c cpSOI = new CP_Sale_Order_Item__c();
                    cpSOI.Basic_Cost__c = SOI.Basic_Cost__c;
                    cpSOI.CP_Property__c = cp.Id;
                    cpSOI.Name = SOI.Name;
                    cpSOI.Included_in_Allotment_letter__c = SOI.Included_in_Allotment__c;
                    cpSOI.Item_category__c = SOI.Item_category__c;
                    cpSOI.Material__c = SOI.Material__c;
                    cpSOI.Netvalue__c = SOI.Netvalue__c;
                    cpSOI.Order_Quantity__c = SOI.Order_Quantity__c;
                    cpSOI.SOI_ID__c = SOI.Id;
                    cpSOI.Tax__c = SOI.Tax__c;
                    cpSOI.Unit_of_measure__c = SOI.Unit_of_measure__c;
                    newCPSOIList.add(cpSOI);
                }
            }
        }
    }
    
    //Update cp Sales order item when sales order item updated
    if(Trigger.isUpdate){
        for(Sale_Order_Item__c SOI : Trigger.New){
            for(CP_Sale_Order_Item__c cpSOI : cpSOIList){
                if(cpSOI.SOI_ID__c == SOI.Id){
                    cpSOI.Basic_Cost__c = SOI.Basic_Cost__c;
                    cpSOI.Name = SOI.Name;
                    cpSOI.Included_in_Allotment_letter__c = SOI.Included_in_Allotment__c;
                    cpSOI.Item_category__c = SOI.Item_category__c;
                    cpSOI.Material__c = SOI.Material__c;
                    cpSOI.Netvalue__c = SOI.Netvalue__c;
                    cpSOI.Order_Quantity__c = SOI.Order_Quantity__c;
                    cpSOI.Tax__c = SOI.Tax__c;
                    cpSOI.Unit_of_measure__c = SOI.Unit_of_measure__c;
                    UpdateCPSOIList.add(cpSOI);
                    
                }
            }
        }
    }
    
    //insert cp Sales order item records
    if(newCPSOIList.size()>0){
        try{
            system.debug('the trigger new'+newCPSOIList);
            Upsert newCPSOIList;
        }
        catch(DMLException e){
            system.debug('The DML Exception is'+e);
        }
    }
    //update cp sales order item records
    if(UpdateCPSOIList.size()>0){
        try{
            Update UpdateCPSOIList;
        }
        catch(DMLException e){
            system.debug('The DML Exception is'+e);
        }
    }   
}