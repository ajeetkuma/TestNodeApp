/**  Description    :   This class is used for creating records on Master Payment Schedule Object
*    Created By     :   Anju Alexander(Extentor Tquila)
*    Created Date   :   24/6/2015
*    Version        :   v1.0
*    Modified By    :   Anju Alexander  
**/
public class TriggerHelperForPayment {
    /*
Method : To Populate Payment Fields in The Master Payment.If a master payment is already created with the existing unique id then,
update the payment schedule with the existing master payment else create a new master payment for the payment Schedule.
*/
    
    public static Boolean triggerRan = false ; 
    
    //to attach payment with master
  /*  public void populateFieldsOnMaster(List < Payment_Schedule__c > listOfPayment) {
        System.debug('populateFieldsOnMaster');
        
        List < Id > paymentIds                              = new List < Id > ();
        List < String > invoiceNo                           = new List < String > ();
        List < Master_Payment__c > newPaymentList           = new List < Master_Payment__c > ();
        List < Master_Payment__c > listOfMasterPayment      = new List < Master_Payment__c > ();
        Map < String, Id > mapofMaster       = new Map < String, Id > ();
        Map < String, Master_Payment__c > mapofMaster2     = new Map < String, Master_Payment__c > ();
        Map < Id,Payment_Schedule__c > accountMap           = new Map < Id,Payment_Schedule__c >();
        Set < String > uniqueIdSet                          = new Set < String > ();
        Set < String > uniqueIdSet2                          = new Set < String > ();
        List < Master_Payment__c > listOfMasterPayment2      = new List < Master_Payment__c > ();
        Set<Id> idd=new Set<Id>();
        List < Payment_Schedule__c > insertlist = new List < Payment_Schedule__c > ();
        Schema.Sobjectfield externalUniqueId = Master_Payment__c.Fields.Unique_Id__c ;
        
        for (Payment_Schedule__c rec: listOfPayment) {
            
            uniqueIdSet.add(rec.Unique_Id__c);   
            accountMap.put(rec.AccountId__c, rec);         
        }
        System.debug('.uniqueIdSet..'+uniqueIdSet);
        
        listOfMasterPayment                                 = [Select id, Unique_Id__c from Master_Payment__c where Unique_Id__c IN: uniqueIdSet];
        System.debug('************listOfMasterPayment********'+listOfMasterPayment);
        for (Master_Payment__c rec: listOfMasterPayment) {
            if(rec.Unique_Id__c != null){
                mapofMaster.put(rec.Unique_Id__c, rec.Id);
            }
        }
        
        System.debug('.mapofMaster..'+mapofMaster);
        
        Map<Id,Contact> contactMap                          = new Map<Id,Contact>(); 
        List<Contact> listOfContacts                        = new List<Contact>();
        listOfContacts                                      = [SELECT AccountId,Contact_Type__c,DoNotCall,Email,Id,Name,mobilephone FROM Contact where Contact_Type__c = 'First Applicant' AND AccountId IN: accountMap.keySet()];
        System.debug('************listOfContacts********'+listOfContacts);
        for(Contact rec : listOfContacts){
            contactMap.put(rec.AccountId,rec);
        }
        Set< Id> newlist = new Set< Id> ();
        List < Payment_Schedule__c > uplist= new List < Payment_Schedule__c > ();
        List < Payment_Schedule__c > llist = new List < Payment_Schedule__c > ();
        List < Payment_Schedule__c > sentlist = new List < Payment_Schedule__c > ();
        List < Payment_Schedule__c > queriedlist = new List < Payment_Schedule__c > ();
        //List < Master_Payment__c > MasterPayment1            = new List < Master_Payment__c > ();
        List < Master_Payment__c > MasterPayment2           = new List < Master_Payment__c > ();
        for (Payment_Schedule__c paySch: listOfPayment) {
            if( (paySch.Billing_Date__c!=null) && ((paySch.Unique_Id__c!='')&&(paySch.Unique_Id__c!=null)) && (((paySch.Status__c=='Due') ||(paySch.Status__c=='Overdue'))&& (paySch.Status__c!='Not Due')))
            {
                if(paySch.Status__c!='Received')
                {
                    uniqueIdSet2.add(paySch.Unique_Id__c);
                    idd.add(paySch.id);
                    insertlist.add(paySch);                          
                    Master_Payment__c mstrPay           = new Master_Payment__c();
                    mstrPay.Invoice_Number__c           = paySch.Invoice_No__c;
                    mstrPay.Unique_Id__c                = paySch.Unique_Id__c;
                    mstrPay.Description__c              = paySch.Description__c;
                    mstrPay.Invoice_Date__c             = paySch.Invoice_date__c;
                    mstrPay.Unit__c                     = paySch.Unit_Number__c;
                    mstrPay.Received_Date__c            = paySch.Payment_Received_Date__c;
                    mstrPay.Don_t_Disturb_Plant__c      = paySch.Don_t_Disturb__c;
                    if(contactMap.containsKey(paySch.AccountId__c)) {   
                        mstrPay.Contact_Name__c         = contactMap.get(paySch.AccountId__c).Name;
                        mstrPay.Contact_Mobile__c       = contactMap.get(paySch.AccountId__c).mobilephone; 
                        mstrPay.Don_t_Disturb__c        = contactMap.get(paySch.AccountId__c).DoNotCall; 
                    }
                    mstrPay.Billing_Date__c             = paySch.Billing_Date__c;   
                    
                    //MasterPayment1.add(mstrPay);
                    MasterPayment2.add(mstrPay);
                }
            }          
        }
       
        System.debug('************New Master PaymentList********'+MasterPayment2.size());
        
        List<Database.Upsertresult> allMasterResult = new List<Database.Upsertresult>();
        
        if (MasterPayment2.size()>0) {
            try {
                //allMasterResult =  Database.insert(MasterPayment2,false);
                allMasterResult =  Database.upsert(MasterPayment2,externalUniqueId,false);
            } catch (DMLException e) {
                System.debug('DMLException '+e.getLineNumber()+','+e.getmessage());
            }	            
            if(allMasterResult.size()>0){
                for(integer i=0;i<allMasterResult.size();i++){
                    if(allMasterResult[i].isSuccess()){	            		
                        mapofMaster.put(MasterPayment2[i].Unique_Id__c,allMasterResult[i].getId());
                    }
                    
                }
            }                      	
        }
        
        System.debug('Payment List Size '+listOfPayment.size());
        System.debug('Master Payment List Size '+mapofMaster.size());
        
        
        for (Payment_Schedule__c paySch: listOfPayment) {
            if (mapofMaster.containsKey(paysch.Unique_Id__c) &&(paySch.Unique_Id__c!='')&& (paySch.Billing_Date__c!=null)&& ( (paySch.Status__c=='Due' || paySch.Status__c=='Overdue') && paySch.Status__c!='Not Due' )) {
                try {
                    if((paySch.Status__c=='Due' || paySch.Status__c=='Overdue') && (paySch.Status__c!='Not Due')){
                        System.debug('Inside the block for which master should not be attached');
                        System.debug('paySch.Status__c'+paySch.Status__c);
                        newlist.add(paySch.id);
                        System.debug('...paySch..'+paySch); 
                        
                    }
                } catch (Exception e) {}
            }
            
        }
        
        //----- Updating payments 
        System.debug('...Payments List..'+newlist ); 
        try{
            queriedlist =[SELECT id,Master_Payment_Schedules__c,Unique_Id__c from Payment_Schedule__c where id IN:newlist  ];
            for(Payment_Schedule__c rec:queriedlist){
                rec.Master_Payment_Schedules__c = mapofMaster.get(rec.Unique_Id__c); 
                uplist.add(rec);
                triggerRan = true ;
            }
            System.debug('........uplist..............'+uplist+'/////'+queriedlist );
            if(uplist.size()>0){
                update uplist;
            }
        }catch(Exception e){
        }
        
    }
    
  */  
    public void rollup(List < Payment_Schedule__c > paylist) {
        System.debug('rollup'); 
        System.debug('rollup'); 
        
        Set<id> idSet = new Set<id>();
        Set<id> mpidSet = new Set<id>();
        List<Payment_Schedule__c> qerylist = new List<Payment_Schedule__c >();
        List < Master_Payment__c > updatelist = new List < Master_Payment__c > ();
        try{
        for(Payment_Schedule__c rec : paylist){
            idSet.add(rec.id);
        }
        qerylist = [select id,unique_id__c, total__c,Master_Payment_Schedules__c from Payment_Schedule__c where id in: idSet ];
        for(Payment_Schedule__c rec : qerylist ){
            mpidSet.add(rec.Master_Payment_Schedules__c); 
        }
        //Decimal count = 0;
        for(Master_Payment__c rec: [select id, name,sum_of_money__c,unique_id__c, (select id, total__c,Invoice_No__c,Invoice_date__c,Payment_Received_Date__c,Status__c,Payment_Status__c,unique_id__c from Payment_Schedules__r) from Master_Payment__c where id in: mpidSet ]){
            String invoice='';
            List<String> strinv = new List<String>();
            Set<String> strSet = new Set<String>();
            Decimal count = 0;
            
            for(Payment_Schedule__c pr: rec.Payment_Schedules__r){
                if((pr.status__c!='Not Due' || pr.status__c!='Received') && pr.unique_id__c!=''){
                    System.debug('.......pr......'+pr);
                    count= pr.total__c+count;
                }
                
                
            }
            rec.Sum_Of_Money__c=String.valueOf(count);
            System.debug('.......Sum_Of_Money__c......'+rec.Sum_Of_Money__c);
            updatelist.add(rec);
        }
        }catch(Exception e){
            System.debug(''+e.getMessage());
        }
        try{
            if(updatelist.size()>0){
        update updatelist;
            }
        }
        catch(Exception e){
            System.debug(''+e.getMessage());
        }
    }
    
    
    public void rollupDelete(List < Payment_Schedule__c > paylist) {
        System.debug('rollupDelete'); 
        try{
            List < Master_Payment__c > ulist = new List < Master_Payment__c > ();
            Set < Id > idSet = new Set < Id > ();
            Set < id > lookupSet = new Set < id > ();
            Map < Id, Payment_Schedule__c > deletedRecord = new Map < Id, Payment_Schedule__c > ();
            for (Payment_Schedule__c rec: payList) {
                idSet.add(rec.Master_Payment_Schedules__c);
                deletedRecord.put(rec.id, rec);
                
            }
            
            System.debug('..idset..'+idSet+'   '+'..deletedRecord..'+deletedRecord);
            
            Integer i = 0;
            Decimal count = 0;
            String invoice='';
            List<String> strinv = new List<String>();
            Set<String> strSet = new Set<String>();
            for (Master_Payment__c rec: [select id, name,Invoice_No__c, sum_of_money__c, (select id, total__c,Invoice_No__c,Status__c,Invoice_date__c,Payment_Received_Date__c,Payment_Status__c from Payment_Schedules__r) from Master_Payment__c where id = : idSet]) {
                
                for (Payment_Schedule__c pr: rec.Payment_Schedules__r) {
                    
                    if(pr.Invoice_No__c == null && pr.Invoice_date__c == null && pr.Payment_Received_Date__c == null && (pr.Status__c == 'Due' || pr.Status__c =='Overdue')){
                        count = count + pr.total__c;
                    }
                    if(pr.Invoice_No__c != null && pr.Invoice_date__c != null && pr.Payment_Received_Date__c != null ){
                        count = count + pr.total__c;
                    }
                    try{
                        if(!(invoice.contains(pr.Invoice_No__c))){
                            
                            invoice=invoice + pr.Invoice_No__c +',';
                        }
                    }catch(Exception e){}
                    strinv.add(invoice);
                    
                }
                
                
                rec.Sum_Of_Money__c = String.ValueOf(count);
                rec.Due_Amount__c = count;
                rec.Invoice_No__c = invoice.removeEnd(',');
                ulist.add(rec);
            }
            System.debug('-------------ulist--------'+ulist);
            if (ulist.size() > 0) {
                update ulist;
            } 
        }catch(Exception ex){
            system.debug('exception::'+ex.getMessage());
        }
        
    }
   
    /*
Update Total of all Payement whose status is Received in repective Opportunity
*/ 
    public void updateReceivedTotalInOpportunity(List<Payment_Schedule__c> paylist,Map<Id,Payment_Schedule__c> newMap,Map<Id,Payment_Schedule__c> oldMap){
        
        try{
            Map<Id,Opportunity> totalPaymentMap     = new Map<Id,Opportunity>();
            Set<Id> oppIds                          = new Set<Id>();
            Map<Id,Opportunity> paymentOppMap       = new Map<Id,Opportunity>();
            
            for(Payment_Schedule__c ps : payList){              
                if(ps.Opportunity__c != null){
                    if(oldMap != null){
                        if(newMap != null && newMap.get(ps.id).Total__c != oldMap.get(ps.id).Total__c){
                            oppIds.add(ps.Opportunity__c);
                        }else{
                            oppIds.add(ps.Opportunity__c);
                        }   
                    }else{
                        oppIds.add(ps.Opportunity__c);  
                    }                   
                }
            }
            
            if(oppIds.size() > 0){
                paymentOppMap   = new Map<Id,Opportunity>([Select id,Payment_Received_Total__c,
                                                           (Select id,Total__c,Status__c 
                                                            from Payment_Schedules__r 
                                                            where Status__c =: Utility_Class.PAYMENT_RECIEVED)
                                                           from Opportunity where Id IN: oppIds]);
                
                for(String key :paymentOppMap.keySet()){
                    
                    if(paymentOppMap.get(key).Payment_Schedules__r.size() > 0){
                        for(Payment_Schedule__c pm : paymentOppMap.get(key).Payment_Schedules__r){
                            if(totalPaymentMap.containsKey(key)){
                                double payment  = totalPaymentMap.get(key).Payment_Received_Total__c + pm.Total__c;
                                totalPaymentMap.put(key,new Opportunity(Id=key,Payment_Received_Total__c=payment));
                            }else{
                                totalPaymentMap.put(key,new Opportunity(Id=key,Payment_Received_Total__c=pm.Total__c));
                            }
                        }
                    }else{
                        totalPaymentMap.put(key,new Opportunity(Id=key,Payment_Received_Total__c=0));
                    }
                }
                
                if(totalPaymentMap.size() > 0){                                 
                    update totalPaymentMap.values();
                    system.debug('Opportunity Updated');
                }
            }
        }catch(Exception ex){
            system.debug('exception ex::'+ex.getMessage());
        }
    } 
    
}