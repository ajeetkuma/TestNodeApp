/*
	Descrition : This class used in custom button JS to run batches
	Author	   : Amritesh
*/
global class CallBatchApexFromButton {

	webservice static void runDemandSendMSGBatch(){
		
		Demand_Letter_SMS_Batch b = new Demand_Letter_SMS_Batch();         
        database.executebatch(b);
	}
}