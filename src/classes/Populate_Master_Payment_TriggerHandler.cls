/*
* Description    :   Handler to create/update master records
* Created By     :   Pavithra Gajendra(ET Marlabs)
* Created Date   :   18/12/2015   
* Modified By    :   Shikha devi ( ET marlabs)
* Modified Date  :   07/01/2016
*/
public class Populate_Master_Payment_TriggerHandler {

   /* public static Boolean triggerRan = false ; 
    
    public void createMasterAndUpdatePayment(List<Payment_Schedule__c> listOfPayment){
        
        //----- Attributes
        Set<String> allUniqueId = new Set<String>();
        Map<String,Payment_Schedule__c> accountMap = new Map<String,Payment_Schedule__c>();
        List<Master_Payment__c> allMasterPayments = new List<Master_Payment__c>();
        Map<String,Id> masterUniqueIdMap = new Map<String,Id>();
        List<Master_Payment__c> newListMasterPayment = new List<Master_Payment__c>();
        Map<Id,Contact> contactMap = new Map<Id,Contact>();
        List<Payment_Schedule__c> paymentsWithUniqueId = new List<Payment_Schedule__c>();
        List<Database.Upsertresult> allMasterResult = new List<Database.Upsertresult>();
        Schema.Sobjectfield externalUniqueId = Master_Payment__c.Fields.Unique_Id__c ;
        List<Payment_Schedule__c> paymentsToUpdate = new List<Payment_Schedule__c>();
        List<Master_Payment__c> masterList = new   List<Master_Payment__c>();
        List<Contact> contactList = new   List<Contact>();
        List<Payment_Schedule__c> uniquePayments = new List<Payment_Schedule__c>();
        
        //---- New Attributes
        List<Id> allPaymentsWithUniqueId = new List<Id>();
         
        //----- Get all Unique Id & accounts 
        for (Payment_Schedule__c payments : listOfPayment) { 
            if(payments.Unique_Id__c !=null && payments.Unique_Id__c !=''){
                allPaymentsWithUniqueId.add(payments.Id);
                accountMap.put(payments.AccountId__c, payments);
            }
            
            if(payments.Unique_Id__c !=null && payments.Unique_Id__c !='' && !allUniqueId.contains(payments.Unique_Id__c)){
                allUniqueId.add(payments.Unique_Id__c);   
                //accountMap.put(payments.AccountId__c, payments);
                uniquePayments.add(payments);
            }
                                                   
        }
        System.debug('<>accountMap<>'+accountMap);
        System.debug('<>uniquePayments<>'+uniquePayments);
        
         //---- Get contact details for all accounts
        contactList = [Select Id,Name,AccountId,mobilephone,DoNotCall From Contact WHERE AccountId IN: accountMap.keySet() AND Contact_Type__c = 'First Applicant'];
        for(Contact con :contactList){
            contactMap.put(con.AccountId,con);
        }
        System.debug('contactMap'+contactMap);
        
        System.debug('Payments with unique Set '+allPaymentsWithUniqueId.size());
        
         //----- Get all Master payement for Unique Id        
        masterList = [Select Id,Name,Unique_Id__c From Master_Payment__c Where Unique_Id__c IN:allUniqueId] ;
        for(Master_Payment__c masterPay : masterList){
            masterUniqueIdMap.put(masterPay.Unique_Id__c,masterPay.Id);
        }
         System.debug('Master Payments Size '+masterList.size());
          System.debug('Master Payments'+masterList);
         System.debug('Unique Payments Size '+uniquePayments.size());
         
         List<Payment_Schedule__c> allPayments = [Select id,Unique_Id__c,Invoice_No__c,Description__c,AccountId__c,Billing_Date__c FROM Payment_Schedule__c WHERE Id IN:allPaymentsWithUniqueId AND Billing_Date__c!= null AND Unique_Id__c!='' AND (Status__c='Due' OR Status__c='Overdue') ORDER BY Unique_Id__c] ;
         String uniqueKey = '';
         Id acctId ;
         Date billingDate ;
         Integer payCount = 0 ;
         for(Payment_Schedule__c allPays :allPayments){
            System.debug('Payment Sch'+allPays);
            if(uniqueKey=='' || uniqueKey ==allPays.Unique_Id__c){
                uniqueKey = allPays.Unique_Id__c ;
                acctId = allPays.AccountId__c ; 
                billingDate = allPays.Billing_Date__c;                
            }else if(uniqueKey != allPays.Unique_Id__c && payCount != 0){
                 Master_Payment__c mstrPay           = new Master_Payment__c();                
                 mstrPay.Unique_Id__c                = uniqueKey ;                     
                 if(contactMap.containsKey(acctId)) {   
                        mstrPay.Contact_Name__c         = contactMap.get(acctId).Name;
                        mstrPay.Contact_Mobile__c       = contactMap.get(acctId).mobilephone; 
                        mstrPay.Don_t_Disturb__c        = contactMap.get(acctId).DoNotCall; 
                 }
                mstrPay.Billing_Date__c             = billingDate ;
                newListMasterPayment.add(mstrPay);
                uniqueKey = allPays.Unique_Id__c ;
                acctId = allPays.AccountId__c ; 
                billingDate = allPays.Billing_Date__c;                                                
            }  
            payCount ++ ;                       
         }
         
         if(payCount==allPayments.size()){
                 Master_Payment__c mstrPay           = new Master_Payment__c();                
                 mstrPay.Unique_Id__c                = uniqueKey ;                     
                 if(contactMap.containsKey(acctId)) {   
                        mstrPay.Contact_Name__c         = contactMap.get(acctId).Name;
                        mstrPay.Contact_Mobile__c       = contactMap.get(acctId).mobilephone; 
                        mstrPay.Don_t_Disturb__c        = contactMap.get(acctId).DoNotCall; 
                 }
                 mstrPay.Billing_Date__c             = billingDate ;
                 newListMasterPayment.add(mstrPay);
         }
         
        //----- Insert all Master Payments 
        if (newListMasterPayment.size()>0) {
            try {   
                    System.debug('Master Payment '+newListMasterPayment);                                   
                    allMasterResult =  Database.upsert(newListMasterPayment,externalUniqueId,false);
                } catch (DMLException e) {
                    System.debug('DMLException '+e.getLineNumber()+','+e.getmessage());
                }
                System.debug('------Master PaymentList Result--------'+allMasterResult);                
                if(allMasterResult.size()>0){
                    for(integer i=0;i<allMasterResult.size();i++){
                        if(allMasterResult[i].isSuccess()){                     
                            masterUniqueIdMap.put(newListMasterPayment[i].Unique_Id__c,allMasterResult[i].getId());
                        }
                        
                    }
                }  
                triggerRan = true ;                     
        }  
        
          //---- Update Payments with New Master Id
        for(Payment_Schedule__c paySch: allPayments){
            //Id masterId = masterUniqueIdMap.get(paySch.Unique_Id__c) ;            
                paySch.Master_Payment_Schedules__c = masterUniqueIdMap.get(paySch.Unique_Id__c) ;
                paymentsToUpdate.add(paySch);                   
        }
        triggerRan = true ;
        if(paymentsToUpdate.size()>0){
            try{
                update  paymentsToUpdate ;
            }Catch(Exception e){
                System.debug('Update Payments Error '+e.getMessage());
            }
        }       
    }*/
    /*
        Modified By : Vijay Naik
        
    */
    
    public void updateMasterPayment(List<Payment_Schedule__c> paymentScheduleList){
        //----- Attributes
        Set<String> uniqueIdSet = new Set<String>();
        Map<String,Payment_Schedule__c> accountMap = new Map<String,Payment_Schedule__c>();
        Map<String, String> masterPaymentMap = new Map<String, String>();
        Set<String> newParentCreatedFor = new Set<String>();
        List<Master_Payment__c> masterPaymentListToInsert = new List<Master_Payment__c>();
        Map<Id,Contact> contactMap = new Map<Id,Contact>();
        
        for(Payment_Schedule__c paymentSchedule :paymentScheduleList){
            if(paymentSchedule.Unique_Id__c !='' && paymentSchedule.Unique_Id__c !=null){
                uniqueIdSet.add(paymentSchedule.Unique_Id__c);
                accountMap.put(paymentSchedule.AccountId__c, paymentSchedule);
                
            }           
        }
        System.debug('...accountMap...'+accountMap);
        //---- Get contact details for all accounts
        for(Contact con :[Select Id,Name,AccountId,mobilephone,DoNotCall,smagicinteract__SMSOptOut__c From Contact WHERE AccountId IN: accountMap.keySet() AND Contact_Type__c = 'First Applicant' ]){
            contactMap.put(con.AccountId,con);
            
        }
        System.debug('...contactMap...'+contactMap);    
        for(Master_Payment__c masterPayment :[SELECT Id,Stage__c,Plant_Code__c, Unique_Id__c,Unit__c,Don_t_Disturb__c,Don_t_Disturb_Plant__c FROM Master_Payment__c WHERE Unique_Id__c IN:uniqueIdSet]){
            masterPaymentMap.put(masterPayment.Unique_Id__c, masterPayment.Id);
            
        }
        System.debug('...contactMap...'+masterPaymentMap);
        for(Payment_Schedule__c paymentSchedule :paymentScheduleList){
            if(paymentSchedule.Unique_Id__c !='' && paymentSchedule.Unique_Id__c !=null  && paymentSchedule.Billing_Date__c!= null &&  ( paymentSchedule.Status__c=='Due' || paymentSchedule.Status__c=='Overdue')){
                if(masterPaymentMap.containsKey(paymentSchedule.Unique_Id__c)){
                }
                else{
                    if(!newParentCreatedFor.contains(paymentSchedule.Unique_Id__c)){
                        newParentCreatedFor.add(paymentSchedule.Unique_Id__c);
                        Master_Payment__c mstrPay = new Master_Payment__c();
                            mstrPay.Unique_Id__c = paymentSchedule.Unique_Id__c ;
                            mstrPay.Don_t_Disturb_Plant__c  =  paymentSchedule.Don_t_Disturb__c; 
                            mstrPay.Billing_Date__c = paymentSchedule.Billing_Date__c;
                            mstrPay.Unit__c =   paymentSchedule.Unit_Number__c;
                            mstrPay.Stage__c   =  paymentSchedule.Stage__c;
                            mstrPay.Plant_Code__c = paymentSchedule.Plant_Id__c;
                            if(contactMap.containsKey(paymentSchedule.AccountId__c)) {   
                                mstrPay.Contact_Name__c         = contactMap.get(paymentSchedule.AccountId__c).Name;
                                mstrPay.Contact_Mobile__c       = contactMap.get(paymentSchedule.AccountId__c).mobilephone; 
                                mstrPay.Don_t_Disturb__c        = contactMap.get(paymentSchedule.AccountId__c).smagicinteract__SMSOptOut__c; 
                                mstrPay.Contact_Id__c           = contactMap.get(paymentSchedule.AccountId__c).id; 
                            }
                        masterPaymentListToInsert.add(mstrPay);
                    }
                }
            }
        }
        
        insert masterPaymentListToInsert;
        System.debug('::::::::::::::======masterPaymentListToInsert'+masterPaymentListToInsert);
        
        for(Master_Payment__c masterPayment :masterPaymentListToInsert){
            masterPaymentMap.put(masterPayment.Unique_Id__c, masterPayment.Id);
            System.debug('::::::::::::::======masterPaymentMap'+masterPaymentMap);
        }
        
        newParentCreatedFor.clear();
         System.debug('::::::::::::::======newParentCreatedFor'+newParentCreatedFor);
        for(Payment_Schedule__c paymentSchedule :paymentScheduleList){
            if(paymentSchedule.Unique_Id__c !='' && paymentSchedule.Unique_Id__c !=null  && paymentSchedule.Billing_Date__c!= null &&  ( paymentSchedule.Status__c=='Due' || paymentSchedule.Status__c=='Overdue')){
                if(masterPaymentMap.containsKey(paymentSchedule.Unique_Id__c)){
                    paymentSchedule.Master_Payment_Schedules__c = masterPaymentMap.get(paymentSchedule.Unique_Id__c);
                     System.debug('::::::::::::::======paymentSchedule'+paymentSchedule);
                }
            }
            else{ // modified by Shikha
                paymentSchedule.Master_Payment_Schedules__c = null;
            }
        }
    }
    /*
        Modified By Shikha.
        Description : This method is doing rollup summary functionality, when
                      New Payment Record is inserted / updated/ deleted
    */
    public static void updateTotalAmountOnMaster(List<Payment_Schedule__c> paymentScheduleList){
        Set<Id> masterPaymentIdSet = new Set<Id>();
        
        for(Payment_Schedule__c paymentSchedule :paymentScheduleList){
            if(paymentSchedule.Master_Payment_Schedules__c != null){
                masterPaymentIdSet.add(paymentSchedule.Master_Payment_Schedules__c);
            }
        }
        
        if(masterPaymentIdSet.size() > 0){
            Populate_Master_Payment_TriggerHandler.updateTotalAmountOnMaster(masterPaymentIdSet);
        }
    }

 
 public static void updateTotalAmountOnMaster(List<Payment_Schedule__c> paymentScheduleList, Map<Id, Payment_Schedule__c> paymentScheduleMap){
        Set<Id> masterPaymentIdSet = new Set<Id>();
        
        for(Payment_Schedule__c paymentSchedule :paymentScheduleList){
          //  if(paymentSchedule.Party_Size__c != paymentScheduleMap.get(paymentSchedule.Id).Party_Size__c){ //Check if party size changed
                masterPaymentIdSet.add(paymentSchedule.Master_Payment_Schedules__c);
                if(paymentScheduleMap.get(paymentSchedule.Id).Master_Payment_Schedules__c != null){
                    masterPaymentIdSet.add(paymentScheduleMap.get(paymentSchedule.Id).Master_Payment_Schedules__c);
                }
            //}
        }
        
        if(masterPaymentIdSet.size() > 0){
            Populate_Master_Payment_TriggerHandler.updateTotalAmountOnMaster(masterPaymentIdSet);
        }
    }
 

 public static void updateTotalAmountOnMaster(Set<Id> masterPaymentIdSet){
        Map<Id, Double> revenueMap = new Map<Id, Double>();
        
        for(AggregateResult paymentScheduleAggregate :Populate_Master_Payment_TriggerHandler.getTotalAmount(masterPaymentIdSet)){ 
            Id masterPaymentId = (Id) paymentScheduleAggregate.get('Master_Payment_Schedules__c');
            Double totalAmount = (Double) paymentScheduleAggregate.get('totalAmount');
            
            revenueMap.put(masterPaymentId, totalAmount);
        }
        
        List<Master_Payment__c> masterPaymentListToUpdate = new List<Master_Payment__c>();
        
        for(Master_Payment__c masterPayment :getmasterPaymentList(masterPaymentIdSet)){


            masterPayment.Total_Amount__c = 0;
            
            if(revenueMap.containsKey(masterPayment.Id)){
                masterPayment.Total_Amount__c = revenueMap.get(masterPayment.Id);
                System.debug('::::::::====masterPayment.Total_Amount__c'+masterPayment.Total_Amount__c);
            }
            
            masterPaymentListToUpdate.add(masterPayment);
            System.debug('::::::::====masterPaymentListToUpdate'+masterPaymentListToUpdate);
        } 
        
        update masterPaymentListToUpdate;
         System.debug('::::::::====masterPaymentListToUpdate'+masterPaymentListToUpdate);
    }
 
 
 public static List<AggregateResult> getTotalAmount(Set<Id> masterPaymentIdSet){
     System.debug(':::::::::=======masterPaymentIdSet'+masterPaymentIdSet.size());
        return [SELECT Master_Payment_Schedules__c, SUM(Total__c)totalAmount  FROM Payment_Schedule__c WHERE Master_Payment_Schedules__c IN :masterPaymentIdSet AND Master_Payment_Schedules__c != null GROUP BY Master_Payment_Schedules__c];
        }
       

    public static List<Master_Payment__c> getmasterPaymentList(Set<Id> showTimeIdSet){
         System.debug(':::::::::=======showTimeIdSet'+showTimeIdSet.size());
        return [SELECT Id, Total_Amount__c FROM Master_Payment__c WHERE Id IN :showTimeIdSet];
        }
        
        
  /*--------------------------------------------------------------------------------------------
        Modified By :Sukesh H.
        Description : This method used for roll up the Total in the Payment schedule to the Opportunity
        Date Modified: 2/2/2016
    -----------------------------------------------------------------------------------------------*/
    public static void rollupToOpportunity(List<Payment_Schedule__c> newPayList){
        
           //List<Payment_Schedule__c> listOfPaymentSchedules = [Select id,Total__c,Opportunity__c From Payment_Schedule__c where Opportunity__c =: selectedOpportunities AND (Status__c =: 'Due' OR Status__c=:'Overdue')];
           
           //List<Demand_Letter_Repository__c>  dmandLetterList = [select id,Selection_Date__c,Opportunity__c from Demand_Letter_Repository__c where Opportunity__c =: selectedOpportunities order by Selection_Date__c];
           Set<Id>  setPayList = new Set<Id>();
           //System.debug('dmandLetterList -----'+dmandLetterList );
          
           for(Payment_Schedule__c paySchedule : newPayList ){
              setPayList.add(paySchedule.Opportunity__c );
           
           }
          
           /*System.debug('Log last');
           List<aggregateResult> results = [SELECT  Opportunity__c,Sum(Total__c) sumTot FROM Payment_Schedule__c where Opportunity__c in : setPayList AND  (Status__c =:'Due' OR Status__c =:'Overdue') AND Stage__c=:'Allotment' GROUP BY  Opportunity__c];
           System.debug('-----------------------results --'+results );
          
           
           map<Id,Integer> oppMap = new  map<id,integer> ();
           for(aggregateResult agg:results ){
                 Id dID = String.valueof(agg.Get('Opportunity__c'));
                 Integer sums = Integer.valueof(agg.Get('sumTot'));
                 oppMap.put(dID,sums );
             
              }
             List<Opportunity> listAllOpp = [select id,Total_Due_Payment__c from Opportunity];
             List<Opportunity> updateList = new List<Opportunity>();
             for(Opportunity opUpdate : listAllOpp ){
                if(oppMap.containsKey(opUpdate.id)){
                  
                   opUpdate.Total_Due_Payment__c  =  oppMap.get(opUpdate.id);
                   updateList.add(opUpdate);
                   
                 
                 }
             }
             update updateList;*/
             
             
             list<opportunity> oppList = [select Total_Due_Payment__c, (select Total__c FROM Payment_Schedules__r where Status__c =:'Due' OR Status__c =:'Overdue' ) from Opportunity where id IN : setPayList limit 50000];
   
           list<opportunity> updateList = new list<opportunity>();
           
               for(opportunity opLst : oppList){
                if(opLst.Payment_Schedules__r != null){
                 decimal amt = 0 ;
                 for(Payment_Schedule__c PS : opLst.Payment_Schedules__r){
                 system.debug(PS.total__c); 
                                    if(PS.Total__c != null){
                   amt += PS.Total__c ;
                                    }
                 }
                 opLst.Total_Due_Payment__c = amt;
                 updateList.add(opLst);
                }
               }
               
            Database.update(updateList,false);
               
                       
    }
        
        
}