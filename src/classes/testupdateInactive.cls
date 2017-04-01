@isTest
private class testupdateInactive{     
   public static testmethod void testupdateInactive(){   
        
         Plant__c pl=new Plant__c();
         pl.Name='Meadows1';  
         pl.Admin_Email__c='deve@fmail.com';
         pl.Project__c='cosmolis';  
         pl.Allowed_portal_access__c=false;
         insert pl;
         
          Unit__c uc=new Unit__c();
          uc.Name='BG-MED-B-X-0701-XX1';
          uc.Plant__c=pl.Id;
          insert uc; 
          system.debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+uc);
         
         Plant__c p2=new Plant__c();
         p2.Id=pl.Id;
         p2.Name='Meadows1';  
         p2.Admin_Email__c='devea@fmail.com';
         p2.Project__c='cosmolis s';  
         p2.Allowed_portal_access__c=false;
         Update p2;
         
         CP_Property__c cpproperity=new CP_Property__c ();
         cpproperity.Plant__c='Exotica';
         cpproperity.Contact_User_Id__c=userinfo.getuserid();
         cpproperity.Unit_Code__c='BG-MED-B-X-0701-XX1';
         cpproperity.Active__c=false;
         cpproperity.Project_Name__c='bridage';
         cpproperity.name='sample'; 
         contactRecursiveHelper.createProjectDocs  = true;       
         Insert cpproperity; 
        
          
          

 }
 
  public static testmethod void testupdateInactive2(){   
        
        

        
         Plant__c pl=new Plant__c();
         pl.Name='Meadows2';  
         pl.Admin_Email__c='deve@fmail.com';
         pl.Project__c='cosmolis';  
         pl.Allowed_portal_access__c=true;
        
         insert pl;
         
         String PlantId = pl.id;
         
         Unit__c uc=new Unit__c();
          uc.Name='BG-MED-B-X-0701-XX2';
          uc.Plant__c=pl.Id;
          insert uc; 

         CP_Property__c cpproperity=new CP_Property__c ();
         cpproperity.Unit_Code__c='123-1231-qw';
         cpproperity.Active__c=true;
         cpproperity.Project_Name__c='bridage2';
         contactRecursiveHelper.createProjectDocs  = true;
         Insert cpproperity; 
          
                  
         Master_Payment__c mp = new Master_Payment__c();
         mp.Unit__c = 'Test Data';
         mp.Don_t_Disturb_Plant__c= false;
         mp.Plant_Code__c = pl.id;
         insert mp;
         
         
         pl.Don_t_Disturb__c  = true;
         update pl;
         mp.Don_t_Disturb_Plant__c = pl.Don_t_Disturb__c;
         update mp;
         
         

        


 }
  /* public static testmethod void testupdateInactive3(){   
        
        
         CP_Property__c cpproperity=new CP_Property__c ();
         cpproperity.Unit_Code__c='123-1231-qw';
         cpproperity.Active__c=true;
         cpproperity.Project_Name__c='bridage';
         //Insert cpproperity; 
        
         Plant__c pl=new Plant__c();
         pl.Name='Meadows';  
         pl.Admin_Email__c='deve@fmail.com';
         pl.Project__c='cosmolis';  
         pl.Allowed_portal_access__c=true;
         insert pl;
         
         Plant__c pl1=new Plant__c();
         pl1.id=pl.id;
         pl1.Allowed_portal_access__c=false;
         //update pl1;
        


 } */
 
}