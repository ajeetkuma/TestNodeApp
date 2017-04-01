/*
	Description : Wrapper Class for Plumb5 API Response
				  for Parsing API response				  
	Author		: Amritesh
	CreatedDate : 26/08/2015
*/
public class Plumb5JSON2ApexWrapper {
	
	public String SerialId;				//-- visitor serial id
	public String EmailId;				// --visitor email address
	public String TotalVisits;			//--Total page views
	public String Sessions;				//--No. of web sessions
	public String Location;				//--Geography – City & Country
	public String Source;				//-- Visitor came through this source
	public String SearchKey;			//--search key
	public String Score;				//-- Behaviour score
	public Integer Sent;				//----No. of mails sent
	public Integer Open;				//--No. of mails opened
	public Integer Click;				//--No. of mails clicked 
	public String LastSentDate;			//--Last mail sent on
	
}