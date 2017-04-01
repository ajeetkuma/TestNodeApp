/*
	Description : Calculation for Sales Person Sharing on Opportunity
	Author		: Amritesh
*/
public class SalesPerson_Sharing {
	
	public void calculateSalesSharing(List<Opportunity> oppList,Map<Id,Opportunity> oppMap){
		
		try{
			Map<Id,Opportunity> updateOppMap	= new Map<Id,Opportunity>([Select id,Sales_Person_1__c,Sales_Person_2__c,
														Sales_Person_3__c,Percentage_of_Share_for_Sales_person_1__c,
														Percentage_of_Share_for_Sales_person_2__c,Percentage_ofShare_for_Sales_person_3__c,
														Sales_Person_1__r.Team__c,Sales_Person_1__r.Project1__c,
														Sales_Person_2__r.Team__c,Sales_Person_2__r.Project1__c,
														Sales_Person_3__r.Team__c,Sales_Person_3__r.Project1__c,Project_Name__c 														
														from Opportunity where Id IN :oppMap.keySet()]);
														
			
			List<Opportunity> listToUpdate		= new List<Opportunity>();
			
			for(String s : updateOppMap.keySet()){
				
				
				// When any one of Sales person value is blank 
				if(updateOppMap.get(s).Sales_Person_1__c != null && updateOppMap.get(s).Sales_Person_2__c != null
					&& updateOppMap.get(s).Sales_Person_3__c == null){
					
					if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_2__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_2__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
							
					}else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_2__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c != updateOppMap.get(s).Sales_Person_2__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c != updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_2__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 70;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 30;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
							
					}else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_2__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c != updateOppMap.get(s).Sales_Person_2__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c != updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 30;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 70;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
							
					}else if( updateOppMap.get(s).Sales_Person_1__r.Team__c != null && (updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_1__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
							
					}else if( updateOppMap.get(s).Sales_Person_2__r.Team__c != null && (updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_2__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_1__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}else{
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}
				}
				
				else if(updateOppMap.get(s).Sales_Person_1__c != null && updateOppMap.get(s).Sales_Person_3__c != null
				&& updateOppMap.get(s).Sales_Person_2__c == null){
										
					if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
							
					}else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c != updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
					  		
 							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 70;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 30;
							
					}else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c != updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 30;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 70;
							
					}else if( updateOppMap.get(s).Sales_Person_1__r.Team__c != null && (updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_1__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_3__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
							
					}else if( updateOppMap.get(s).Sales_Person_3__r.Team__c != null && (updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_3__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_1__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
					}else{
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}
						
				}
				
				else if(updateOppMap.get(s).Sales_Person_2__c != null && updateOppMap.get(s).Sales_Person_3__c != null
				&& updateOppMap.get(s).Sales_Person_1__c == null){
					
					if((updateOppMap.get(s).Sales_Person_2__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_2__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_2__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
							
					}else if((updateOppMap.get(s).Sales_Person_2__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_2__r.Team__c != updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_2__r.Project1__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 70;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 30;
							
					}else if((updateOppMap.get(s).Sales_Person_2__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_2__r.Team__c != updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_2__r.Project1__c != updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c != updateOppMap.get(s).Sales_Person_2__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 30;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 70;
							
					}else if( updateOppMap.get(s).Sales_Person_2__r.Team__c != null && (updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_2__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_3__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
					}else if( updateOppMap.get(s).Sales_Person_3__r.Team__c != null && (updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Dubai'
					  	 	|| updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_3__r.Team__c == 'US team')
					  	 	&&(updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					  	 	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
					}else{
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}						
				}
				
				// When all 3 Sales Person values are selected
				else if(updateOppMap.get(s).Sales_Person_1__c != null && updateOppMap.get(s).Sales_Person_2__c != null
				&& updateOppMap.get(s).Sales_Person_3__c != null){
					
					// when no sales person belongs to Dubai/Central/USTeam
					if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_2__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_2__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					  	&& updateOppMap.get(s).Sales_Person_3__r.Team__c != null && (updateOppMap.get(s).Sales_Person_3__r.Team__c != 'Dubai'
					  	 && updateOppMap.get(s).Sales_Person_3__r.Team__c != 'Central' && updateOppMap.get(s).Sales_Person_3__r.Team__c != 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 35;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 35;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 30;
					}		
					
					else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c) 
					  	&& updateOppMap.get(s).Sales_Person_2__r.Team__c != null && (updateOppMap.get(s).Sales_Person_2__r.Team__c != 'Dubai'
					  	 && updateOppMap.get(s).Sales_Person_2__r.Team__c != 'Central' && updateOppMap.get(s).Sales_Person_2__r.Team__c != 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 35;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 30;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 35;
					}
					
					else if((updateOppMap.get(s).Sales_Person_2__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_2__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_2__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					  	&& updateOppMap.get(s).Sales_Person_1__r.Team__c != null && (updateOppMap.get(s).Sales_Person_1__r.Team__c != 'Dubai'
					  	 && updateOppMap.get(s).Sales_Person_1__r.Team__c != 'Central' && updateOppMap.get(s).Sales_Person_1__r.Team__c != 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 30;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 35;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 35;
					}
					
					// when any one of sales person belongs to Dubai/Central/US Team
					else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_2__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_2__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_2__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c)
					  	&& updateOppMap.get(s).Sales_Person_3__r.Team__c != null && (updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Dubai'
					  	 || updateOppMap.get(s).Sales_Person_3__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_3__r.Team__c == 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 25;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 25;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 50;
					}		
					
					else if((updateOppMap.get(s).Sales_Person_1__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_1__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_1__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_1__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_1__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c) 
					  	&& updateOppMap.get(s).Sales_Person_2__r.Team__c != null && (updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Dubai'
					  	 || updateOppMap.get(s).Sales_Person_2__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_2__r.Team__c == 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 25;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 50;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 25;
					}
					
					else if((updateOppMap.get(s).Sales_Person_2__r.Team__c != null && updateOppMap.get(s).Sales_Person_3__r.Team__c != null 
						&& updateOppMap.get(s).Sales_Person_2__r.Team__c == updateOppMap.get(s).Sales_Person_3__r.Team__c)
						&& (updateOppMap.get(s).Sales_Person_2__r.Project1__c != null && updateOppMap.get(s).Sales_Person_3__r.Project1__c != null
					 	&& updateOppMap.get(s).Sales_Person_2__r.Project1__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					 	&& (updateOppMap.get(s).Project_Name__c != null && updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_2__r.Project1__c
					  	&& updateOppMap.get(s).Project_Name__c == updateOppMap.get(s).Sales_Person_3__r.Project1__c)
					  	&& updateOppMap.get(s).Sales_Person_1__r.Team__c != null && (updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Dubai'
					  	 || updateOppMap.get(s).Sales_Person_1__r.Team__c == 'Central' || updateOppMap.get(s).Sales_Person_1__r.Team__c == 'US team')){
						
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 50;
							updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 25;
							updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 25;
					}else{
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}			
				}else{
					
					if(updateOppMap.get(s).Sales_Person_1__c != null && updateOppMap.get(s).Sales_Person_2__c == null
						&& updateOppMap.get(s).Sales_Person_3__c == null){
							
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 100;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
						
					}else if(updateOppMap.get(s).Sales_Person_1__c == null && updateOppMap.get(s).Sales_Person_2__c != null
						&& updateOppMap.get(s).Sales_Person_3__c == null){
							
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 100;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
						
					}else if(updateOppMap.get(s).Sales_Person_1__c == null && updateOppMap.get(s).Sales_Person_2__c == null
						&& updateOppMap.get(s).Sales_Person_3__c != null){
						
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 100;
						
					}else{
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_1__c = 0;
						updateOppMap.get(s).Percentage_of_Share_for_Sales_person_2__c = 0;
						updateOppMap.get(s).Percentage_ofShare_for_Sales_person_3__c = 0;
					}
				}
				
			}
			
			Utility_Class.IS_OPP_TRIGGER_RUNNING = true;
			update updateOppMap.values();
			
		}catch(Exception ex){}
	}	
	
}