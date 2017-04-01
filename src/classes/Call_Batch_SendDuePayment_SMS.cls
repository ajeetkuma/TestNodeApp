/*
    Descrition : This class used in custom button JS to run batches
    Author     : Shikha Devi
    Created on : 31/12/2015
*/

global class Call_Batch_SendDuePayment_SMS {
    webservice static void runBatch_SendDuePayment_SMS(string plantid){
        
        SendSMStoALLContact b = new SendSMStoALLContact(plantid);       
        database.executebatch(b);
    }
}