//-----------------------------------------------------------------------------------------------
// Visualforce Custom Controller: BrigadeHomePageControllerv1 ()
// Purpose:Dynamic The image displaying
// Depending on selection display the data on documents and pants   
// -----------------------------------------------------------------------------------------------

    public class BrigadeHomePageControllerv1 { 
        public String selectcontry { get; set; } 
        public boolean ImagenewNoFeedBack{get;set;}{ImagenewNoFeedBack=False;}
        public boolean homepageall{get;set;}
        public String headerCountry1 { get; set; } 
        public String headerCountry2 { get; set; } 
        public String seletecedCity{ get; set; } 
        public boolean Imagenew{get;set;}{Imagenew=False;}
        ////  Controlling POPup
        Public List<SelectOption> Options { get; set; } 
        public boolean displayPopup {get; set;}
        public boolean displayfeedPopup {get; set;}
        public boolean displaySkip {get; set;} {displaySkip=true;}
        List <String> countries {get; set;} 
        public User user {get; set;}
        //variable Declaration
        public List<CP_Property__c> listProperty {get; set;}
        public List<CP_Property__c> listProperty2 {get; set;}
        public List<Plant__c> listOfPlants{ get; set; }
        Set<String> plsSet= new Set<String>();
        list<Plant__c> plants = new list<Plant__c>();
        public user usr{get; set;}
        public List<CP_Property__c> cpList {get;set;}
        public String selectPlant{ get; set; }
        Public List<SelectOption> projectOption { get; set; }
        Public String projectValue {get;set;}
        public list<Notification_Documents__c> notificationdocument{get;set;}
        public list<Notification_Documents__c> notificationdocument1{get;set;}
         public list<Notification_Documents__c> notificationdocument2{get;set;}
        public list<Notification_Documents__c> SelectprojectDeatils{get;set;}
        public list<Notification_Documents__c> NotificationDocUpolad{get;set;}
        public list<Notification_Documents__c> NotificationImages{get;set;}
        public list<Notification_Documents__c> NotificationImagesFlashfirstsection{get;set;}
        public list<Notification_Documents__c> NotificationImagesFlashsecondsection{get;set;}        
        public list<Notification_Documents__c> notificationdocumenttext{get;set;}  
        public string unitnumber{get;set;}
        public boolean OnlysingleProject{get;set;}
        public PortalFooter__c footer {get;set;}
        public String dispFooter {get;set;}
         //Constructor
        public BrigadeHomePageControllerv1(){
          try{          
              //displayPopup = true;
              //query custom settings
              List<PortalFooter__c> footer = PortalFooter__c.getall().values();
              //system.assertEquals(footer[0].Footer__c,null);
              
              dispFooter =footer[0].Footer__c;
              
              //footer = [select id, name,Footer__c from PortalFooter__c];
               
                   if(UserInfo.getUserId()!=null){  
                                     
                    system.debug('--------------UserInfo.getUserId--------------'+UserInfo.getUserId());
                     
                    NotificationImages=new list<Notification_Documents__c>();            
                    notificationdocument=new list<Notification_Documents__c>();
                    notificationdocument1=new list<Notification_Documents__c>();
                    notificationdocument2=new list<Notification_Documents__c>();
                    SelectprojectDeatils=new list<Notification_Documents__c>();
                    NotificationDocUpolad=new list<Notification_Documents__c>();
                    NotificationImagesFlashfirstsection=new list<Notification_Documents__c>();
                    NotificationImagesFlashsecondsection=new list<Notification_Documents__c>();
                    notificationdocumenttext=new list<Notification_Documents__c>();
                    
                    cpList =new List<CP_Property__c>();
                    projectOption  = new List<SelectOption>(); 
                                       
                    //system.assertEquals(NotificationImagesFlashsecondsection[0].Document_URL_link__c,null);
                                        
                     usr=[select id,lastname,firstname,name,OpportunityId__c,Feedback_Check__c,Feedback_Skip_Count__c,Contactid,AccountId,email from user where id=:UserInfo.getUserId()]; 
                     system.debug('*********************usrInfo'+usr);                                 
                     notificationdocument=[select id,Name__c, News_URL__c,Notifications__c ,Document_URL_link__c from Notification_Documents__c where CategoryN_EandPro__c= 'News and Events' and
                                           Notification_Type__c='text'and Active__c=true and Plant__c=null ];
                     // system.assertEquals(notificationdocument,Null);
                     system.debug('%%%%%%%%%%%notificationdocument%%%%%%%%%%%%notitext'+notificationdocument);             
                     notificationdocument1=[select Notifications__c,News_URL__c,Document_URL_link__c  from Notification_Documents__c 
                                               where Notification_Type__c='Document' and Active__c=true and CategoryDocandPro__c='General Document' and Plant__c=null ];
                    // system.assertEquals(notificationdocument1,null);                                  
                     system.debug('%%%%%%%%%%%notificationdocument1%%%%%%%%%%%%notitext'+notificationdocument1);
                     getItems(); 
                                  
                  }                  
           if(usr.OpportunityId__c != Null){       
             displayPopup = true;
             Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:usr.OpportunityId__c];
             system.debug('oppoppoppoppopp'+opp);
             
             if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false)
             {
                Imagenew=true;
                ImagenewNoFeedBack=false;
             } 
            
            else
            {
                 if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true)
                 {
                         ImagenewNoFeedBack=true;
                         Imagenew=false;
                 }    
            }
         
           system.debug('---------------usr.feedbackcheck-------------'+usr.Feedback_Check__c);
           if(usr.Feedback_Check__c==False){            
            if(opp.Booking_CSAT_Feed_back_form__c==false ||opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Handover_Feed_back_form__c==false || opp.X1st_year_Handover_Feedback__c==false)
            {
                if(displayPopup==false){
                  displayfeedPopup=true;
                }
                if(usr.Feedback_Skip_Count__c>2){
                 displaySkip=false;
               }         
            }
          }  
         } 
          else{
            displayPopup = false;
            listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:usr.id AND Active__c=true];
            
            Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];     
          
            if(opp.X1st_year_Handover_Feedback__c==false || opp.Handover_Feed_back_form__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Booking_CSAT_Feed_back_form__c==false){
                
                Imagenew=true;
                ImagenewNoFeedBack=false;
                
            } 
            else{
                  if(opp.X1st_year_Handover_Feedback__c==true && opp.Handover_Feed_back_form__c==true && opp.Execution_without_modification_Feed_back__c==true && opp.Execution_with_Modification_Feed_back_fo__c==true && opp.Booking_CSAT_Feed_back_form__c==true){
            
                     ImagenewNoFeedBack=true;
                     Imagenew=false;
             }    
            }
               if(listProperty.size()==1){
                   if(usr.Feedback_Check__c==False){
                            if(opp.Booking_CSAT_Feed_back_form__c==false ||opp.Execution_with_Modification_Feed_back_fo__c==false || opp.Execution_without_modification_Feed_back__c==false || opp.Handover_Feed_back_form__c==false || opp.X1st_year_Handover_Feedback__c==false)
                            {
                                if(displayPopup ==false){
                                displayfeedPopup=true;
                                }
                            if(usr.Feedback_Skip_Count__c>2){
                                displaySkip=false;
                              }         
                            }
                      }  
                }
          }
             //getProjectNotifications();
       } 
          
          catch(Exception e){
                        displayPopup = false; 
                        homepageall=true;  
                        ImagenewNoFeedBack=true;                       
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Information not yet available,Please check after some time');
                        ApexPages.addMessage(myMsg);       
                        
             }
         }
           // Drop Down Data
            public PageReference getProjectNotifications(){          
            try{
                  
                //projectValue  = selectPlant;            
                User u =[select Id, Name, OpportunityId__c, ContactId From User Where Id=: Userinfo.getUserId()];  
                
                               
              //  system.assertEquals(1,2);               
               
                if(u.OpportunityId__c==Null){
                    CP_Property__c cp =[Select Id,Contact_User_Id__c, Opportunity_Id__c From CP_Property__c Where  Contact_User_Id__c=:u.Id];                    
                    Opportunity opp = [Select Id,Unit__r.Name, Unit__r.Plant__r.Project__c From Opportunity Where Id=:cp.Opportunity_Id__c];                
                    //system.assertEquals(opp.Unit__r.Plant__r.Project__c,null);
                    SelectprojectDeatils=[SELECT Notifications__c, News_URL__c from Notification_Documents__c 
                                        where Plant__R.Project__c=:opp.Unit__r.Plant__r.Project__c and Notification_Type__c='Text' and Active__c=true and CategoryN_EandPro__c='Project Specefic Updates' and Plant__c!=null]; 
                
                
                system.debug('---------------------SelectprojectDeatils---------------------------------'+ SelectprojectDeatils);          
                NotificationDocUpolad=[SELECT id, Name,Document_URL_link__c from Notification_Documents__c 
                                        where Plant__r.Project__c=:opp.Unit__r.Plant__r.Project__c and Notification_Type__c='Document' and 
                                        Document_URL_link__c != null and CategoryDocandPro__c='Project Specific Documents' and Plant__c!=null]; 
               
                }
                else{
                
                notificationdocument2=[select id,Name__c,Notifications__c ,Document_URL_link__c from Notification_Documents__c where Category__c= 'News and Events' and
                                       Notification_Type__c='text' and Active__c=true and Plant__c=null ];
                //system.assertEquals(notificationdocument2,null);
                
                Opportunity opp = [Select Id,Unit__r.Name, Unit__r.Plant__r.Project__c From Opportunity Where Id=:u.OpportunityId__c];
               
                
                SelectprojectDeatils=[SELECT Notifications__c,News_URL__c  from Notification_Documents__c 
                                        where Plant__R.Project__c=:opp.Unit__r.Plant__r.Project__c and Notification_Type__c='Text' and Active__c=true and CategoryN_EandPro__c='Project Specefic Updates' and Plant__c!=null]; 
                // system.assertEquals(SelectprojectDeatils,null);
                
                system.debug('---------------------SelectprojectDeatils---------------------------------'+ SelectprojectDeatils);          
                NotificationDocUpolad=[SELECT id, Name,Document_URL_link__c from Notification_Documents__c 
                                        where Plant__r.Project__c=:opp.Unit__r.Plant__r.Project__c and Notification_Type__c='Document' 
                                        and Document_URL_link__c != null and CategoryDocandPro__c='Project Specific Documents' and Plant__c!=null];  
              //  system.assertEquals(NotificationDocUpolad,null);  
                system.debug('*****************'+ NotificationDocUpolad);
                }
                //getItems();     
                    
                return null; 
                }catch(Exception e){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'User details is not correct. Please contact Administrator');
                         ApexPages.addMessage(myMsg);
                         return null;
                }
        }
        //===============================================================
        
        
        public pagereference countryDetails(){
        try{
        displayPopUp=false;
        //displayfeedPopup=true;
        system.debug('@@@@@@@@@@@@@@@@@'+headerCountry1);
        User u =[select Id, Name, OpportunityId__c,ContactId,Feedback_Skip_Count__c,Feedback_Check__c From User Where Id=: Userinfo.getUserId()];
        listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c FROM CP_Property__c Where Contact_User_Id__c =:u.id];
        if(listProperty.size()>1){
        u.OpportunityId__c=headerCountry1;
        update u;
        }
        Opportunity opp = [Select Id,Unit__r.Name,Project_Unit_No__c From Opportunity Where Id=:headerCountry1];
         
        list<string> ss=(opp.Project_Unit_No__c).split('-');
        headerCountry2=ss[0];
        unitnumber=ss[3];
        OnlysingleProject=true;
        
      //  system.assertEquals(unitnumber,null);
        
       // system.assertequals(opp,null);
        //BrigadeHomePageControllerv1 clt=new BrigadeHomePageControllerv1 ();
        getProjectNotifications();
        
        if(u.Feedback_Check__c==False){
        
       /* Contact con=[Select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where Id=:u.ContactId];*/
      
        Opportunity oppFeed=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:u.OpportunityId__c];
                            
        if(oppFeed.Booking_CSAT_Feed_back_form__c==false ||oppFeed.Execution_with_Modification_Feed_back_fo__c==false || oppFeed.Execution_without_modification_Feed_back__c==false || oppFeed.Handover_Feed_back_form__c==false || oppFeed.X1st_year_Handover_Feedback__c==false){
            displayfeedPopup=true;
         }
         else{
         
          if(oppFeed.Booking_CSAT_Feed_back_form__c==true && oppFeed.Execution_with_Modification_Feed_back_fo__c==true && oppFeed.Execution_without_modification_Feed_back__c==true && oppFeed.Handover_Feed_back_form__c==true && oppFeed.X1st_year_Handover_Feedback__c==true){
            displayfeedPopup=false;
            }
         }
         
        
        if(u.Feedback_Skip_Count__c>2){
            displaySkip=false;
         }         
        }
        }
        catch(exception e){
             ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'User details is not correct. Please contact Administrator');
             ApexPages.addMessage(myMsg);
        }
        
        return null;
      }
   ///////////////////// poupup controll End 
           public List<SelectOption> getItems() {          
          
            //displayPopup = false;
            user = [select Id, Name,Feedback_Skip_Count__c, ContactId,Feedback_Check__c From User Where Id=: Userinfo.getUserId()];             
            listProperty = [SELECT Contact_User_Id__c,Active__c,Id,Name,Opportunity_Id__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
           
            system.debug('##########listProperty#########'+listProperty);                       
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('','---Please Select Project---'));
            if(listProperty.size()==1){
            displayPopup = false;
            headerCountry1=listProperty[0].Opportunity_Id__c;            
                     
           // headerCountry2=listProperty[0].Project_Unit_No__c;         
           
            list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
            
            system.debug(ss+'sssssssssssssss.............');
            
            headerCountry2=ss[0];
            system.debug('headerCountry2------------'+headerCountry2);
                     
            unitnumber=ss[3];   
            system.debug('unitnumber...........'+unitnumber);   
            OnlysingleProject=false;
                                 
            if(user.Feedback_Check__c==False){                   
                Contact con=[Select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where Id=:user.ContactId];
                if(con.Booking_CSAT_Feed_back_form__c==false ||con.ExecutionwithModification_Feed_back_fo__c==false || con.Execution_withoutmodification_Feed_back__c==false || con.Handover_Feed_back_form__c==false || con.X1st_year_Handover_Feedback__c==false)
                {
                    if(displayPopup ==false){
                    displayfeedPopup=true;
                    }
                if(user.Feedback_Skip_Count__c>2){
                    displaySkip=false;
                   }         
                }
             }               
               getProjectNotifications();
            }
            system.debug('!!!!!!!!!!!!!!!!!!!!!!'+listProperty);
            
            for(CP_Property__c cpProperty : listProperty ){
           
                if(cpProperty.Opportunity_Id__c != null && cpProperty.Project_Unit_No__c!=null){               
                 
                    options.add(new SelectOption(cpProperty.Opportunity_Id__c,cpProperty.Project_Unit_No__c));
                
                }

            }
                
                return options;
                 
                
        }               
            public String[] getCountries() {
            return countries;
        }
        public pagereference Feedback1() {
        if(UserInfo.getUserId() !=Null){
            User user=[Select Id,Name,Feedback_Check__c,Feedback_Skip_Count__c From User Where Id=:UserInfo.getUserId()];
            user.Feedback_Check__c=true;
            update user;
           }    
            PageReference pageRef = new PageReference('/apex/FeedBack');
            pageRef.setRedirect(true);
            return pageRef;
        
        }
        public PageReference skipFeedback() {
        try{
            displayfeedPopup=false;
            if(UserInfo.getUserId() !=Null){
               User user1=[Select Id,Name,Feedback_Check__c,Feedback_Skip_Count__c From User Where Id=:UserInfo.getUserId()];
                user1.Feedback_Check__c=true;
                user1.Feedback_Skip_Count__c=user1.Feedback_Skip_Count__c+1;
                //system.AssertEquals(user,null);
                update user1;
            }
          }
             catch(Exception e){ 
                                            
                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Information not yet available,Please check after some time');
                        ApexPages.addMessage(myMsg);       
                        
             }  
            return null;
    }

    }