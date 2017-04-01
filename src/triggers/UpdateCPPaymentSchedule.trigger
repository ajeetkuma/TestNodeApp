/* The trigger is used to update cp payment schedule  when payent schedule updated */
trigger UpdateCPPaymentSchedule on Payment_Schedule__c (after insert, before update, before Delete) {
    
    //delete trigger
    If(Trigger.isDelete){
        
        Set<Id> delpaymentids = Trigger.oldMap.keyset();
        list<CP_Payment_Schedule__c> delrec = [SELECT Id FROM CP_Payment_Schedule__c  WHERE Payment_ID__c IN :delpaymentids];
            
        database.DeleteResult[] res = database.delete(delrec,false);
        
        string errorStr =''; 
        boolean sendEmail = false;
        for(Database.DeleteResult sr : res){
    
        if(sr.isSuccess()){
            //system.debug('sucess id'+sr.getId());
        }else{
            sendEmail = true;
            for(Database.Error er : sr.getErrors()){
                errorStr  += 'These Cp_payment Id  has not been deleted  https://bgproduction-brigadeforce-na19.my.salesforce.com/'+sr.getId()+ '  Error Status Code  ' + er.getStatusCode() + ' Error Message '+er.getMessage() + ' Fields due to which it fail ' +er.getFields()  + '<br/>';  
                
                }
            
            }
        }

        if(sendEmail){
            emailErrorString(errorStr);
        }
        
    }
    
    if(trigger.isInsert || trigger.isUpdate){
        //variables Declaration
        //List<Id> paymentIds = new List<Id>();
		
		//set<id> paySchID = new set<Id>();
		
        List<Id> SOIIds = new List<Id>();
        //List<Id> DelIds = new List<Id>();
        
        List<CP_Payment_Schedule__c> newcpPaymentList = new List<CP_Payment_Schedule__c>();
        List<CP_Payment_Schedule__c> updatecpPaymentList = new List<CP_Payment_Schedule__c>();
        //List<CP_Payment_Schedule__c> deletecpPaymentList = new List<CP_Payment_Schedule__c>();
        
        
        
        
        //Trigger.new records
        
         
         map<id,Payment_Schedule__c> pschMap = new map<id,Payment_Schedule__c>();
        for(Payment_Schedule__c payment:Trigger.New){
            //paymentIds.add(payment.Id);
			//paySchID.add(payment.Id);
			pschMap.put(payment.Id, payment);
            SOIIds.add(payment.Sale_Order_Item__c);
        }
        
        
        
        
        
        //create new cp payment schedules when new payment schedule created
        if(Trigger.isInsert){
             //map<id,Payment_Schedule__c> pschMap = new map<id,Payment_Schedule__c>();
              //  pschMap = Trigger.NewMap;
           newcpPaymentList = insertCpPayment(pschMap,SOIIds);
        }
        
        //update cp payment schedules when payment schedule updated
        if(Trigger.isUpdate){
			
			updatecpPaymentList = updateCpPayment(SOIIds,pschMap);
            
			
			
        }
        
        
        //insert cp  payment schedule records
        if(newcpPaymentList.size()>0){
            Database.saveResult[] svRes = Database.insert(newcpPaymentList,false);
            
            
                string errorStr ='INSERTION FAILED   Created Date :'+ system.now() +' Created By : '+userinfo.getName() +'  '; 
                boolean sendEmail = false;
                for(Database.saveResult sr : svRes){
            
                if(sr.isSuccess()){
                    //system.debug('sucess id'+sr.getId());
                }else{
                    sendEmail = true;
                    for(Database.Error er : sr.getErrors()){
                        errorStr  += '  Error Status Code  ' + er.getStatusCode() + ' Error Message '+er.getMessage() + ' Fields due to which it fail ' +er.getFields()  + '<br/>';  
                        
                        }
                    
                    }
                }

                if(sendEmail){
                    emailErrorString(errorStr);
                }
            
        }
        //update cp payment schedule records
       // system.debug('****'+updatecpPaymentList);
        if(updatecpPaymentList.size()>0){
                
                Database.upsertResult[] svRes = Database.upsert(updatecpPaymentList,false);
                string errorStr ='UPDATION FAILED   Created Date :'+ system.now() +' Created By : '+userinfo.getName() +'  '; 
                boolean sendEmail = false;
                for(Database.upsertResult sr : svRes){
            
                if(sr.isSuccess()){
                    //system.debug('sucess id'+sr.getId());
                }else{
                    sendEmail = true;
                    for(Database.Error er : sr.getErrors()){
                        errorStr  += '  Error Status Code  ' + er.getStatusCode() + ' Error Message '+er.getMessage() + ' Fields due to which it fail ' +er.getFields()  + '<br/>';  
                        
                        }
                    
                    }
                }

                if(sendEmail){
                    emailErrorString(errorStr);
                }
                
                

           
        }   
    }
    
    static void emailErrorString(string errStr){
        
        /*Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        message.toAddresses = new String[] {'SFDCsupport@brigadegroup.com' ,system.UserInfo.getUserEmail()};

        message.subject = 'CP Payment Updation Has been Failed';
        message.HtmlBody = '<b> PLEASE FORWARD THESE MAIL TO BRIGADE ADMIN  </b>'+errStr ;
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages,false);*/
        
    }
	
	static list<CP_Payment_Schedule__c> insertCpPayment(Map<id,Payment_Schedule__c> paymentSch,List<id>SOIIds){
	
	//query for cp sales order items
        List<CP_Sale_Order_Item__c> cpSOIList = [select id,SOI_ID__c,CP_Property__c from CP_Sale_Order_Item__c where SOI_ID__c IN:SOIIds];
		List<CP_Payment_Schedule__c> newcpPaymentList = new List<CP_Payment_Schedule__c>();
		
		for(Payment_Schedule__c payment:paymentSch.values()){
                for(CP_Sale_Order_Item__c cpSOI:cpSOIList ){
                    if(cpSOI.SOI_ID__c == payment.Sale_Order_Item__c){
                        paymentSch.remove(payment.id);
                        CP_Payment_Schedule__c cppayment = new CP_Payment_Schedule__c();
                        cppayment.Name = payment.Name;
                        cppayment.Bill_Value__c = payment.Bill_Value__c;
                        cppayment.Billing_Date__c = payment.Billing_Date__c;
                        cppayment.CP_Property__c = cpSOI.CP_Property__c ;
                        cppayment.CP_Sale_Order_Item__c = cpSOI.Id;
                        cppayment.Description__c = payment.Description__c;
                        cppayment.Education_Cess__c = payment.Education_Cess__c;
                        cppayment.Payment_Received_Date__c = payment.Payment_Received_Date__c;
                        cppayment.Payment_Schedule_Id__c = payment.Payment_Schedule_Id__c;
                        cppayment.Payment_Status__c = payment.Payment_Status__c;
                        cppayment.Secondary_Education_Cess__c = payment.Secondary_Education_Cess__c;
                        cppayment.Service_Tax__c = payment.Service_Tax__c;
                        cppayment.VAT__c = payment.VAT__c;
                        cppayment.External_Id__c = payment.Id+'-'+cpSOI.Id;
                        cppayment.Payment_ID__c = payment.Id;
                        cppayment.Invoice_date__c = payment.Invoice_date__c;
                        cppayment.Invoice_No__c = payment.Invoice_No__c;
                        cppayment.Courier_Doc_No__c = payment.Courier_Doc_No__c;
                        cppayment.Courier_Sent_Date__c = payment.Courier_Sent_Date__c;
                        cppayment.Date_Base_Code__c = payment.Date_Base_Code__c;
                        cppayment.Mile_Stone_Base_Code__c = payment.Mile_Stone_Base_Code__c;
                        cppayment.Mile_Stone_Block__c = payment.Mile_Stone_Block__c;  
                        cppayment.Mile_Stone_Base_Description_1__c = payment.Mile_Stone_Base_Description_1__c; 
                        cppayment.Swachh_Bharath_Cess__c = payment.Swachh_Bharath_Cess__c;
                        cppayment.Krishi_Kalyan_Cess__c = payment.Krishi_Kalyan_Cess__c;
                      
                        // cppayment.Date_Base_Description__c = payment.Date_Base_Description__c;                    
                        newcpPaymentList.add(cppayment);
                    }
                }
            }
        
        if(paymentSch.size()>0){
               emailErrorString('INSERTION FAILED   Created Date :'+ system.now() +' Created By : '+userinfo.getName() +'  '+'These Payment schedule related sales order does not exist in cp_sales_order'+paymentSch.keyset());
            
        }
		return newcpPaymentList;
	
	}
	
	

	static list<CP_Payment_Schedule__c> UpdateCpPayment(List<id>SOIIds ,Map<id,Payment_Schedule__c>paySch){
	
	//query for cp payment schedules
        List<CP_Payment_Schedule__c> updatecpPaymentList = new List<CP_Payment_Schedule__c>();
		
		List<CP_Payment_Schedule__c>  cpPaymentList = [select id,Name,Bill_Value__c,Billing_Date__c,CP_Property__c,CP_Sale_Order_Item__c,Description__c,Service_Tax__c,VAT__c,Payment_ID__c,
                                                       Mile_Stone_Base_Description_1__c, Date_Base_Description__c ,  External_Id__c,Invoice_date__c,Invoice_No__c,Education_Cess__c,Payment_Received_Date__c,Payment_Schedule_Id__c,Payment_Status__c,Secondary_Education_Cess__c,Courier_Doc_No__c,Courier_Sent_Date__c,Date_Base_Code__c,Mile_Stone_Base_Code__c,Mile_Stone_Block__c,Swachh_Bharath_Cess__c,Krishi_Kalyan_Cess__c from CP_Payment_Schedule__c where   Payment_ID__c IN:paySch.keyset()];
													   
													   
			for(Payment_Schedule__c payment:paySch.values()){
                for(CP_Payment_Schedule__c cppayment : cpPaymentList){
                    if(cppayment.Payment_ID__c == payment.Id){
					
						paySch.remove(payment.Id);
                        cppayment.Name = payment.Name;
                        cppayment.Bill_Value__c = payment.Bill_Value__c;
                        cppayment.Billing_Date__c = payment.Billing_Date__c;
                        cppayment.Description__c = payment.Description__c;
                        cppayment.Education_Cess__c = payment.Education_Cess__c;
                        cppayment.Payment_Received_Date__c = payment.Payment_Received_Date__c;
                        cppayment.Payment_Schedule_Id__c = payment.Payment_Schedule_Id__c;
                        cppayment.Payment_Status__c = payment.Payment_Status__c;
                        cppayment.Secondary_Education_Cess__c = payment.Secondary_Education_Cess__c;
                        cppayment.Service_Tax__c = payment.Service_Tax__c;
                        cppayment.VAT__c = payment.VAT__c;
                        cppayment.Invoice_date__c = payment.Invoice_date__c;
                        cppayment.Invoice_No__c = payment.Invoice_No__c;
                        cppayment.Courier_Doc_No__c = payment.Courier_Doc_No__c;
                        cppayment.Courier_Sent_Date__c = payment.Courier_Sent_Date__c;
                        cppayment.Date_Base_Code__c = payment.Date_Base_Code__c;
                        cppayment.Mile_Stone_Base_Code__c = payment.Mile_Stone_Base_Code__c;
                        cppayment.Mile_Stone_Block__c = payment.Mile_Stone_Block__c;
                        cppayment.Mile_Stone_Base_Description_1__c = payment.Mile_Stone_Base_Description_1__c;  
                        cppayment.Swachh_Bharath_Cess__c = payment.Swachh_Bharath_Cess__c;
                         cppayment.Krishi_Kalyan_Cess__c = payment.Krishi_Kalyan_Cess__c;
                        //  cppayment.Date_Base_Description__c = payment.Date_Base_Description__c;  
                        updatecpPaymentList.add(cppayment);
                    }
                }
            }
			
			
			if(paySch.size()>0){
			List<CP_Payment_Schedule__c> newcpPaymentList = new List<CP_Payment_Schedule__c>();
			newcpPaymentList = insertCpPayment(paySch,SOIIds);
			updatecpPaymentList.addAll(newcpPaymentList);
			
			}
													   
		return updatecpPaymentList ; 
	
	}
}