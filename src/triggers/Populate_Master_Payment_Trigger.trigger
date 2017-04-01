trigger Populate_Master_Payment_Trigger on Payment_Schedule__c (after insert, after update,before insert,before update,after delete,before delete) {
    
    //-- Instantiate the handler
    TriggerHelperForPayment handler = new TriggerHelperForPayment();
    Populate_Master_Payment_TriggerHandler paymentHandler = new Populate_Master_Payment_TriggerHandler();
    
     //-- Insert new Payment
        if ((Trigger.isInsert || Trigger.isUpdate )&& Trigger.isBefore)
        {        
                    paymentHandler.updateMasterPayment(Trigger.new);                                    
        }   
        if (Trigger.isInsert && Trigger.isAfter)
        {             
                    Populate_Master_Payment_TriggerHandler.updateTotalAmountOnMaster(Trigger.new);
                    Populate_Master_Payment_TriggerHandler.rollupToOpportunity(Trigger.new);    
        }
        
        if(Trigger.isUpdate && Trigger.isAfter)
        {
            
                Populate_Master_Payment_TriggerHandler.updateTotalAmountOnMaster(Trigger.new, Trigger.oldMap);
                Populate_Master_Payment_TriggerHandler.rollupToOpportunity(Trigger.new);
              
               System.debug('::::====updateTrigger');
           
        }
       
       if (Trigger.isDelete && (trigger.isAfter)){
           Populate_Master_Payment_TriggerHandler.updateTotalAmountOnMaster(Trigger.old);
           Populate_Master_Payment_TriggerHandler.rollupToOpportunity(Trigger.old);
           System.debug('::::====delete');
        }
        
}