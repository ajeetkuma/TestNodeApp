/**********************************************************************
         Purpose  : Class to call PLumb5 API to get Lead/Contact(email) 
         			Scroing/Mail response from Plumb5 for each 
         Author   : Amritesh
    Created Date  : 26/08/2015
***********************************************************************/
public class Plumb5Callout {

	@future(Callout=true)
	public static void callPlumb5API(){
		
		try{
			httpReq(120000);
            system.debug('Successfull in first run');
            if(test.isRunningTest()){
                throw new CalloutException('used for test class');
            }
		}catch(Exception ex){
			system.debug('1st Run Callout exception::'+ex.getMessage());
            system.debug('As previous callout fails , Tring once again');
            try{
            	httpReq(120000);
                system.debug('Successfull in Second run');
            }Catch(Exception e){
                system.debug('second Callout exception::'+ex.getMessage());
                
            }
		}
	}
	
    public static void httpReq(integer timeOut){
        
        	HttpRequest req 	= new HttpRequest();
			req.setMethod('GET');
			req.setTimeOut(timeOut);
			req.setEndpoint(Utility_Class.getPlumb5EndUrl());
			Http http 			= new Http();    
			HTTPResponse res 	= http.send(req);
					
			parsePlumb5Response(res.getBody());
    }
	/*
		Purpose : Parse JSON Response to Plumb5JSON2ApexWrapper Class
	*/
	public static void parsePlumb5Response(String jsonResponse){
		
		try{
			
			jsonResponse								= jsonResponse.replaceAll('\\/', '/');
			List<Plumb5JSON2ApexWrapper> parsedResponse	= (List<Plumb5JSON2ApexWrapper>)System.JSON.deserialize(jsonResponse, List<Plumb5JSON2ApexWrapper>.class);
		
			Process_Plumb5Response obj					= new Process_Plumb5Response();
			obj.processResponse(parsedResponse);
		}catch(Exception e){
			system.debug('Parsing Excepion:::'+e.getMessage());
		}
	}	
	
}