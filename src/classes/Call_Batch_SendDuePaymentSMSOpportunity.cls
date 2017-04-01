/*
  Descrition : This class used in custom button JS to run batches
  Author     : Sukesh G
  Created on : 5/2/2016
*/

global class Call_Batch_SendDuePaymentSMSOpportunity {
  webservice static void runBatch_SendDuePayment_SMS_Opportunity(List<id> opp){
    Opportunity opId;
        //System.debug('---------------------ls----------'+ls);
    Batch_SendDuePayment_SMS_Opportunity b = new Batch_SendDuePayment_SMS_Opportunity();    
        b.selectedOpIds = opp;     
        database.executebatch(b);
  }
}