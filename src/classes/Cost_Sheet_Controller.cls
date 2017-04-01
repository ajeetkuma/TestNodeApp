/* =================================================
@Name:  Cost_Sheet_Controller
@Copyright notice: Copyright (coffee) 2015, Brigade Group. and developed by Extentor
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are not permitted.                                                                                                    

@Purpose: This is a controller class to create orderpdf format from cost sheet .

@History                                                                                                                    
@---------                                                                                                                       
@VERSION________AUTHOR______________DATE______________DETAIL                   
1.0       Shikha    18/06/2015      DEVELOPMENT  
                            
Modified By : Sukesh G
Modified Date: 30-dec-2015
@=======================================================  */

public with sharing class Cost_Sheet_Controller {
   
      public CostSheet__c costSheetDetails     {get;set;}
       public CostSheet__c costSheetDetails1    {get;set;}
      public List<CostSheet__c> listOfCostDeatails    {get;set;}
       public Date Date2;
       public String valueinfo;
     String costSheetId= ApexPages.currentPage().getParameters().get('id');

     public String getvalueinfo(){
       Date selectedDate =  Date.today(); //Give your date
       Date firstDate = selectedDate.toStartOfMonth();
      Date2 = firstDate.addDays(date.daysInMonth(selectedDate.year(),selectedDate.month())  - 1);
      valueinfo = Date2.format();
        system.debug(firstDate  + ' **** ' +Date2 );
      return valueinfo;
    }


     //Constructor
    public Cost_Sheet_Controller (){
      System.debug('---------------------------------');  
      costSheetDetails  = new CostSheet__c();
      costSheetDetails1 =new CostSheet__c();   
      listOfCostDeatails = new List<CostSheet__c>();
      costSheetDetails = [Select id,Name,Apartment_No__c,Apartment_Type__c,Area_in_sq_ft__c,Base_rate_Rs_Psf__c,Floor_rise_Rs_Psf_per_floor__c,Covered_Car_parking_reservation_charges__c,
                           Preferential_location_charge__c,Premium_Rs_Psf__c,Discount__c,Less_Special_Discount__c,Final_Rate_per_sft__c,
                           Basic_cost_of_apartment__c,Agreement_Value_Rs__c,Basic_Sale_Consideration_including_car__c,Registration_Amount__c,X1st_installment_Rs__c,
                           X1st_installment__c,X2nd_installment__c,X2nd_installment_Rs__c,X3rd_installment_Rs__c,X3rd_installment__c,X4th_installment__c,
                           X4th_installment_Rs__c,X5th_installment__c,X5th_installment_Rs__c,X6th_installment__c,X6th_installment_Rs__c,X7th_installment_Rs__c,
                           X7th_installment__c,X8th_installment_Rs__c,X8th_installment__c,Project_Name__c,Prelaunched_Registeration__c,Booking_amount__c,Booking_amount_Rs__c,Less_Registration_Amount__c,
                           X9th_installment_Rs__c,X9th_installment__c,X10th_installment_Rs__c,X10th_installment__c,DD_Cheque_in_favour__c,Maintenance_rate_Rs_Psf_p_m__c ,
                           X11th_installment_Rs__c,X11th_installment__c, X12th_installment_Rs__c,X12th_installment__c,X13th_installment_Rs__c,X13th_installment__c,
                           X14th_installment_Rs__c,X14th_installment__c,X15th_installment_Rs__c,X15th_installment__c,TOTAL_CONSIDERATION_INCLUDING_CAR_PARK__c,
                           On_Possession_Registration__c,On_Possession_Registration_Rs__c,ADDITIONAL_EXPENSE_approx__c,ADDITIONAL_EXPENSE_appro__c,TOTAL_CONSIDERATION__c,
                           Club_Membership__c,Club_House_Fee_including_Service_Tax__c,Tentative_Building_Maintenance__c,Service_Tax_12_36_on_Building_Mainten__c,
                           Corpus_fund_equivalent_to_one_year_main__c,Total_VAT_Rs__c ,Total_Service_Tax_Rs__c ,APPROXIMATE_TOTAL_COST__c,Campus_Corpus_Fund_With_Service_Tax__c,Generator_Charges__c,
                           Reticulated_Gas_Connection_Charges__c,Plant__r.Name,Opportunity__r.Contact_Name__c,VAT_calculated_at__c,Service_Tax_calculated_at__c,Total_additional_expenses_Rs__c,
                           Project__r.Service_Tax__c,Project__r.VAT__c,Plant__r.Corpus_Fund__c From CostSheet__c where id =:costSheetId];
       
      System.debug('costSheetDetails-----------------------'+costSheetDetails);
       }
}