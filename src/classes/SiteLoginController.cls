/**
* An apex page controller that exposes the site login functionality
*/
global with sharing class SiteLoginController {
    //set username/ password variables via page
   
    global String username {get; set;}
    global String password {get; set;} 
    public BridageDynamicFields__c bc;
    
    global SiteLoginController () {
    bc=new BridageDynamicFields__c ();
    bc=[select Organisation_ID__c,Portal_Id__c,URL__c from BridageDynamicFields__c limit 1];
    
   // system.assertEquals(bc.Organisation_ID__c,null);
    }
    
    
    //system.assertEquals(bc.Portal_Id__c,'axd');
    global PageReference login() {
       
        //static org-id and portal id
      //  String strOrgID = '00Df0000002KWPO';
         string strOrgID =bc.Organisation_ID__c;        
       // String strPortalID = '060a0000001FNRL';
       
          String strPortalID = bc.Portal_Id__c;       
        //String strURL = URL.getSalesforceBaseUrl().toExternalForm();
      
        // String strURL = 'https://cs16.salesforce.com';
        String strURL=bc.URL__c ;
        
        //start url of the page
        String startUrl = strURL + '/secur/login_portal.jsp?orgId=' + strOrgID + '&portalId=' + strPortalID;
        
        startUrl += '&un=' + username;
        startUrl += '&pw='+ password;
        
        //set reference and attempt login
        PageReference portalPage = new PageReference(startUrl);
        portalPage.setRedirect(true);
        PageReference p = Site.login(username, password, startUrl);
        
        //if p==null, no login
        if (p == null) {
            return Site.login(username, password, null);
        } else {
            return portalPage;
        }
    }
    
}