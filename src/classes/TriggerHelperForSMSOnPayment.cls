/**     Description         :   This class is used for creating SMS when Master payment is received for yesterday.
 *
 *     Created By          :   Shikha Devi (Extentor Tquila)
 *
 *     Created Date        :   09/07/2015
 *
 *      Version             :   V1.0 Created
 **/
public class TriggerHelperForSMSOnPayment {

	/*
         Method : To send sms to the contact of Master Payment after receiving payment of yesterday
                
    */


	public void sendSmsOnReceving(List < Master_Payment__c > listOfReceivedPayments) {
		List < smagicinteract__smsmagic__c > smsObjects = new List < smagicinteract__smsmagic__c > ();
		String templateText;
		try {
			//Sms magic template
			smagicinteract__SMS_Template__c tpltext = [select id, smagicinteract__Text__c from smagicinteract__SMS_Template__c where smagicinteract__Name__c = : 'After Payment Received' limit 1];

			//SMS magic starting
			templateText = tpltext.smagicinteract__Text__c;

			//Re-render template text
			String senderId = 'sms magic';
			String extraFieldText = '';
			List < String > fields;
			List < sObject > sObjects;
			List < String > args;
			String query = '';
			string userId = UserInfo.getUserId();
			string orgId = UserInfo.getOrganizationId();
			smagicinteract.TemplateEngine TEngine = new smagicinteract.TemplateEngine(templateText);

			// get field values for Master Payment
			List < Master_Payment__c > recordIds = new List < Master_Payment__c > ();
			if (listOfReceivedPayments.size() > 0) {
				for (Master_Payment__c masterPayment: listOfReceivedPayments) {
					recordIds.add(masterPayment);
				}
			}
			System.debug(':::::::::recordIds:::::::::::::' + recordIds);
			String objectType = 'Master_Payment__c';
			String NameField = 'Contact_Name__c';
			fields = TEngine.getFieldsFromSMSTextOfObjectType(objectType);
			for (string x: fields) {
				if (x.equalsIgnoreCase('Contact_Name__c')) continue;
				if (!extraFieldText.contains(x)) extraFieldText = extraFieldText + ', ' + x;
			}
			extraFieldText = String.escapeSingleQuotes(extraFieldText);
			args = new List < String > {};
			args.add(extraFieldText);
			args.add(objectType);
			query = 'select id, ' + NameField + '{0} from {1} where id in :recordIds';
			query = String.format(query, args);
			sObjects = Database.query(query);
			if (sObjects.size() > 0) {
				TEngine.getFieldMap(sObjects[0]);
			}
			Set < Master_Payment__c > setOfIds = new Set < Master_Payment__c > ();

			//send SMS  

			for (Master_Payment__c mstrRvdPyment: listOfReceivedPayments) {

				for (sObject c: sObjects) {
					if (String.valueOf(c.get('Id')) == mstrRvdPyment.Id) {
						if (mstrRvdPyment.Payment_Received_SMS__c == true && mstrRvdPyment.Don_t_Disturb__c == False && mstrRvdPyment.Don_t_Disturb_Plant__c == False) {
							System.debug(':::::::::listOfReceivedPayments:::::::::::::');
							String name = String.valueOf(c.get('Contact_Name__c'));
							String mobilephone = mstrRvdPyment.Contact_mobile__c;
							String smsText = TEngine.getReplacedTextForObject(c, 0);
							smagicinteract__smsMagic__c smsObj = new smagicinteract__smsMagic__c();
							smsObj.smagicinteract__PhoneNumber__c = mobilePhone;
							smsObj.smagicinteract__Name__c = name;
							smsObj.smagicinteract__ObjectType__c = 'Master_Payment__c'; // record type
							smsObj.smagicinteract__disableSMSOnTrigger__c = 0; // this field either be  0 or 1, if you specify the value as 1 then sms will not get send but entry of sms will get create under SMS History object    
							smsObj.smagicinteract__external_field__c = smagicinteract.ApexAPI.generateUniqueKey();
							smsObj.smagicinteract__senderId__c = senderId;
							smsObj.smagicinteract__SMSText__c = smsText;
							smsObjects.add(smsObj);
						}
					}
				}
			}

			insert smsObjects;

			if (smsObjects.size() > 0) {
				List < Master_Payment__c > updateListOfPayments = [Select id, Payment_Received_SMS__c,Received_Payment_SMS__c from Master_Payment__c where Payment_Received_SMS__c = true];
				for (Master_Payment__c mstrPay: updateListOfPayments) {
					mstrPay.Payment_Received_SMS__c = false;
					mstrPay.Received_Payment_SMS__c = true;
				}
				update updateListOfPayments;
			}
		} catch (Exception e) {
			System.debug('Please Contact your admin' + e);
		}
	}
  }