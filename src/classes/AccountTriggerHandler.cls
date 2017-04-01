public with sharing class AccountTriggerHandler {
   private boolean m_isExecuting = false;

    public AccountTriggerHandler(){
        
    }

    public void OnBeforeInsert(Account[] Acc){
        // EXECUTE BEFORE INSERT LOGIC
            system.debug('++++'+acc);  
      Map<ID,RecordType> rt_Map = New Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Account' ]);

       for(Account a :Acc){   
          system.debug('+++++++++++++++++'+ rt_map.get(a.recordTypeID).name);
        if(a.Same_as_Correspondence_Address__c==true && rt_map.get(a.recordTypeID).name.containsIgnoreCase('Child Account')){

             a.A_House_Number__c=a.House_number__c;
             a.A_Street_1__c=a.Street1__c;
             a.A_Street_2__c=a.Street2__c;
             a.A_Street_3__c=a.Street3__c;
             a.A_Postal_Code__c=a.Postal_Code__c;
             a.A_City__c=a.City__c;
             a.A_Region__c=a.RegionL__c;
             a.A_Country__c=a.CountryL__c;
             system.debug('++');
           }  
         
     }
  }
}