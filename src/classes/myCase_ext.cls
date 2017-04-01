public class myCase_ext {
    public string unitnumber{get;set;}
    public string selectedcode2new{get;set;}
    public List <Case> getCase{get; set;}
    public List <CP_Property__c> getCPpro{get; set;}
    public boolean ImagenewNoFeedBack{get;set;}    
    public List <Opportunity> getOpp{get; set;}
    public List <RecordType> rtt {get; set;}
    public List <Opportunity> getOpp2{get; set;}
    public Set<String> ConId{get;set;}
    public Case caseVal{get; set;}
    public Case caseDetail{get; set;}
    public RecordType RTcase{get; set;}
    public User user{get; set;}
    public String caseId{get;set;}
    public string userStr{get; set;}
    public String selectedCode {get; set;}
    public String selectedCode2 {get; set;}    
    public String selectedRT {get; set;}
    public String selectedValue {get; set;}
    Public List<SelectOption> projectOption { get; set; } 
    Public List<SelectOption> unitCodeOption { get; set; } 
    Public String projectValue {get;set;}
    Public Set<String> projectSet {get;set;}
    public string cat{get;set;}
    public boolean uploadatt {get;set;}
    public Attachment Attach{ get;set;} 
    public String UploadedName {get;set;} 
    //private Attachment myDocument;
    public List<CP_Property__c> listProperty {get; set;}
    public List<CP_Property__c> listProperty2 {get; set;}  
    Public blob Attach1 {get;set;}
    public boolean Imagenew{get;set;}
    public boolean errorMsg {get;set;}
    public boolean confirmMsg {get;set;}
    public boolean dispEditPg {get;set;}
    public string flag{get;set;}
    public boolean casealldata{get;set;}
    public user uu{get;set;}
    public List<Query_Footer__c> queryFooterList{get; set;}
    public String queryFooter{get; set;}
    //Savepoint sp;
    
    public myCase_ext(){
    Imagenew=true;   
       // system.assertEquals(1,2);
        Attach = new Attachment();
    }
    public myCase_ext(ApexPages.StandardController controller) {
    // unitCodeOption=new List<SelectOption>();     
    try{
        queryFooterList= Query_Footer__c.getall().values();        
        queryFooter=queryFooterList[0].Description__c;
        
        flag = Apexpages.currentpage().getparameters().get('flagvalue1');         
         if(flag =='true'){
                 ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.confirm, 'Case submitted successfully');
                 ApexPages.addMessage(myMsg);
         }
        
        UploadedName=selectedRT ; 
        Attach = new Attachment();
        uu=[select Id,OpportunityId__c,Name From User Where Id=: Userinfo.getUserId()];
        User u=[select Id, Name, OpportunityId__c From User Where Id=: Userinfo.getUserId()];
        if(u.OpportunityId__c==null){
                 listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:u.id];

                system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+listProperty);
                selectedcode2=listProperty[0].Project_Unit_No__c;
               
                list<string> ss=(listProperty[0].Project_Unit_No__c).split('-');
                selectedcode2new=ss[0];
                unitnumber=ss[3];
              
                          
            }
            else{
                listProperty2 = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Sales_Organisation__c,
                            Target__c,Unit_Code__c, Project_Name__c,Project_Unit_No__c FROM CP_Property__c Where Opportunity_Id__c =:u.OpportunityId__c];                                
                
                selectedcode2=listProperty2[0].Project_Unit_No__c;
           //     getUnitCodeValue();
                
                list<string> ss=(listProperty2[0].Project_Unit_No__c).split('-');
                selectedcode2new=ss[0];
                unitnumber=ss[3];
               
            }

        //this.caseVal = (Case)stdController.getRecord();
       
        caseVal = new Case();
        userStr = userInfo.getUserId();
        caseId = ApexPages.currentPage().getParameters().get('Id');
        user = [select Id, Name, ContactId From User Where Id=: userStr];
        system.debug('**********'+user.Id);
        projectOption = new List<SelectOption>();
        ConId = new Set<String>();
        if(user.Id != Null){
            getCPpro=[select Name, Id, Contact_User_Id__c, Opportunity_Id__c From CP_Property__c where Contact_User_Id__c=:user.Id];
                system.debug('&&&&&&&&&&&&&'+getCPpro);
                for(CP_Property__c pro : getCPpro){
                    
                    ConId.add(pro.Opportunity_Id__c);
                    system.debug('!!!!!!!!!!'+ConId);
                }
                getOpp=[select Id, Name, Plant__c, Project_Name__c,Project_Unit_No__c, Unit__r.Name From Opportunity Where Id IN:ConId];
                system.debug('!!!!!!!!!!'+getOpp);
                projectOption.add(new SelectOption('','--Select Unit--'));
                for(Opportunity opp : getOpp){
                    if(opp.Project_Unit_No__c <>null){
                        projectOption.add(new SelectOption(opp.Id,opp.Project_Unit_No__c));
                    }
                }                                      
        system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'+caseId);
                
        if(caseId != Null){
            caseDetail = [SELECT AccountId,Unique_Case_Number__c,CaseNumber,Case_Type__c,Case_Division_Portal__c,Category_portal__c,ClosedDate,ContactId,Description,Id,IsClosed,Origin,OwnerId,ParentId,Priority,
            Reason,RecordTypeId,Status,Subject,Sub_Cateogry__c,SuppliedCompany,SuppliedEmail,SuppliedName,SuppliedPhone,Type,CreatedDate,Categories_Service__c FROM Case Where Id=:caseId];
            Rtcase =[SELECT Id,Name FROM RecordType Where Id=:caseDetail.RecordTypeId];
        }
        if(user.ContactId!= null){
           
            getCase = [SELECT CreatedDate,AccountId,Unique_Case_Number__c,CaseNumber,Case_Type__c,Categories__c,ClosedDate,ContactId,Description,Id,IsClosed,Origin,OwnerId,ParentId,Priority,
            Reason,Case_Division_Portal__c,RecordTypeId,Status,Subject,Sub_Cateogry__c,SuppliedCompany,SuppliedEmail,SuppliedName,SuppliedPhone,Type,Categories_Service__c FROM Case Where ContactId=:user.ContactId order by CreatedDate ASC];       
            }
            
            else{
                
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
                
            }
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+getCase);                    
            
            // getUnitCodeValue();
        }

        
        
        
        
        //Blinking code
       
         User =[select Id,OpportunityId__c, Name From User Where Id=: Userinfo.getUserId()];
         if(user.OpportunityId__c !=null){    
              
        /* Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:user.OpportunityId__c];
           Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
               Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
        */
        
         Opportunity opp=[Select Id,X1st_year_Handover_Feedback__c,Booking_CSAT_Feed_back_form__c,Execution_with_Modification_Feed_back_fo__c,
                            Execution_without_modification_Feed_back__c,Handover_Feed_back_form__c,AccountId from Opportunity Where Id=:user.OpportunityId__c];
        
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
            
            
            
        }
        else{
        
               listProperty = [SELECT Contact_User_Id__c,Id,Name,Opportunity_Id__c,
                            Plant__c,Property_External_ID__c,Unit_Code__c, Project_Name__c,Active__c,Project_Unit_No__c FROM CP_Property__c Where Contact_User_Id__c =:user.id AND Active__c=true];
               
               /* Opportunity opp=[Select Id, AccountId from Opportunity Where Id=:listProperty[0].Opportunity_Id__c];
                Contact con=[select Id,Booking_CSAT_Feed_back_form__c,ExecutionwithModification_Feed_back_fo__c,Execution_withoutmodification_Feed_back__c,
                Handover_Feed_back_form__c,X1st_year_Handover_Feedback__c From Contact Where AccountId=:opp.AccountId AND Contact_Type__c=:'First Applicant'];
              */
              
          
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
        
        
        }
                }
        catch(exception e){
                casealldata=true;
                ImagenewNoFeedBack=true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
        }
       
      }
   
            
            
            
            public PageReference CancelReferral() { 
             
            PageReference pageRef = new PageReference('/apex/myCase');
            pageRef.setRedirect(true);
            return pageRef ;
         
             }
             
            public PageReference editPage() { 
                 
                 dispEditPg = true;
              /*  PageReference pageRef = new PageReference('/apex/myCaseEdit');
                pageRef.setRedirect(true);
                return pageRef ; */
                 return null;
             }
             
            public PageReference back() { 
             
            PageReference pageRef = new PageReference('/apex/myCase');
            pageRef.setRedirect(true);
            return pageRef ;
         
             }
             
             public PageReference save2() { 
              try{
                    update caseDetail;
                }
                Catch(Exception e){
                
                }
                return null;
         
             }
             
            public pagereference getUnitCodeValue(){
            /*unitCodeOption = new List<SelectOption>();
            unitCodeOption.add(new SelectOption('','--Select Case Type--'));
            system.debug('%%%%%%%%%%%%%%'+selectedCode);
            rtt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Case' ];
            getOpp2=[select Id, Name, Plant__c, Project_Name__c, StageName, Unit__r.Name From Opportunity Where Id =: selectedCode];
            system.debug('############################'+getOpp2);
            for(Opportunity o : getOpp2){
            if(o.StageName!='Handed Over'){
              // unitCodeOption.add(new SelectOption('','--Select Case Type--'));
                //unitCodeOption.add(new SelectOption('Suggestion','Suggestion'));
                for(RecordType r : rtt){
                if(r.Name!='Product'){
                unitCodeOption.add(new SelectOption(r.Name,r.Name));
                               }
                }
            }else{
                unitCodeOption.add(new SelectOption('','--Select Case Type--'));
                //unitCodeOption.add(new SelectOption('Suggestion','Suggestion'));
                for(RecordType r : rtt){
                unitCodeOption.add(new SelectOption(r.Name,r.Name));
                }
                //unitCodeOption.add(new SelectOption('Product','Product'));
            }
            }
            UploadedName=selectedRT;*/
                
           	selectedRT = 'Service'; 
            return null;
            }
            
            public pagereference saveAttach(){
                //Attach = new Attachment();
                //system.assertEquals(Attach1,null);
                //system.assertEquals(Attach.body,null);
                return null;
            }
            public pageReference saveSuggestion(){
                try{
                    confirmMsg = false;
                    errorMsg = false;
                    Savepoint sp = Database.setSavepoint(); 
                    caseVal = new Case();
                    system.debug('%%%%%%%%%%%selectedRT%%%%%%%%%%%%%'+selectedRT);
                    RecordType RT2 = [Select Id, Name From RecordType Where SobjectType='Case' AND Name=:selectedRT];
                    //input values
                    string Casetype2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:cstype');
                    string cate2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:cate1');
                    string reas2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:reas1');
                    string subcat2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:subcat1');
                    string pri2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:pri1');               
                    string sub2=ApexPages.currentPage().getParameters().get('page:frm2:myBlock2:myBlockSec2:sub1');
                    string des2=ApexPages.currentPage().getParameters().get('page:frm2:myBlock2:myBlockSec2:des1');
                    //system.assertEquals(sub2,'123');
             
                    if(sub2!=null){
                        caseVal.Subject=sub2;
                        caseVal.Case_Type__c='Suggestion';
                    }
                    if(sub2==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject '));
                        return null;
                    }
                    if(des2!=null){
                        caseVal.Description=des2;
                        caseVal.Case_Type__c='Suggestion';
                    }
                    if(des2==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                        return null;
                    }

                    if(selectedCode!=Null){
                        caseVal.Opportunity__c=selectedCode;
                    }
                    if(RT2.Id!=Null){
                        caseVal.RecordTypeId=RT2.Id;
                    }
                    //query for user record
                    User u =[select Id,Name, ContactID,MobilePhone From User Where Id=:UserInfo.getUserId()];
                    caseVal.ContactId =u.ContactID;
                    caseVal.Customer_Mobile_No__c=u.MobilePhone;
                    system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+caseVal);
                    
                    //insert case record
                    try{                
                        insert caseVal;
                        errorMsg = false; 
                        if(caseVal!=null && attach.body!=null && Attach.body.size()>1097152){
                            confirmMsg = true;          
                            Attach.body =null;
                            errorMsg = true;
                            Database.rollback(sp);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else if(caseVal!=null && attach.body!=null) {                         
                            attach.ParentId = caseVal.Id; 
                            attach.Description = 'file uploaded.';                                         
                            insert attach; 
                            attach.body =null;
                            errorMsg  = false; 
                        }                      
                    }
                    catch (DMLException e) {
                        confirmMsg = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                        return null;
                    }
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+errorMsg);
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+confirmMsg);
                    if(errorMsg == false){
                        PageReference ref=new PageReference('/apex/myCase?flagvalue1=true');
                        ref.setredirect(true);
                        return ref;
                    }
                } 
                catch(exception e){
                confirmMsg = true;
                casealldata = true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
        }
        return null;
      }
      public pageReference saveService(){
          try{
                    confirmMsg = false;
                    errorMsg = false;
                    Savepoint sp = Database.setSavepoint(); 
                    caseVal = new Case();
                    //system.debug('%%%%%%%%%%%selectedRT%%%%%%%%%%%%%'+selectedRT);
                    //RecordType RT2 = [Select Id, Name From RecordType Where SobjectType='Case' AND Name=:selectedRT];
                    //input values
                    string Casetype3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:cstype');
                    //string cate3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:cate1');
                    string reas3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:reas1');
                    string subcat3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:subcat1');
                    string pri3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:pri1');               
                    string sub3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:myBlockSec3:sub1');
                    string des3=ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:myBlockSec3:des1');
                    string caseDivision = ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:div');
              		string caseCategory = ApexPages.currentPage().getParameters().get('page:frm3:myBlock3:sec3:cat');
                    if(Casetype3=='' && pri3=='' && sub3=='' && des3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please fill all fields'));
                        return null;
                    }
                   
                    if(Casetype3!=null){
                        caseVal.type=Casetype3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(Casetype3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Type'));
                        return null;
                    }
                   /* if(cate3!=null){
                        caseVal.Categories_Service__c=cate3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(cate3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Categories'));
                        return null;
                    }*/
                    if(reas3!=null){
                        caseVal.Reason=reas3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(subcat3!=null){
                        caseVal.Sub_Cateogry__c=subcat3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(subcat3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Sub Categories'));
                        return null;
                    }
                    if(pri3!=null){
                        caseVal.Priority=pri3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(pri3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Priority'));
                        return null;
                    }               
                    if(sub3!=null){
                        caseVal.Subject=sub3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(sub3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject'));
                        return null;
                    }
                    if(des3!=null){
                        caseVal.Description=des3;
                        caseVal.Case_Type__c='Service';
                    }
                    if(des3==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                        return null;
                    }
                    if(selectedCode!=Null){
                        caseVal.Opportunity__c=selectedCode;
                    }
                    /*if(RT2.Id!=Null){
                        caseVal.RecordTypeId=RT2.Id;
                    }*/
              		
              		caseVal.Case_Division_Portal__c =  caseDivision ;
                    caseVal.Category_portal__c = caseCategory ;
              		caseVal.Origin = 'Customer Portal';
                    //query for user record
                    User u =[select Id,Name, ContactID From User Where Id=:UserInfo.getUserId()];
                    caseVal.ContactId =u.ContactID;
                    system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+caseVal);
                    
                    //insert case record
                    try{                
                        insert caseVal;
                        errorMsg = false; 
                        if(caseVal!=null && attach.body!=null && Attach.body.size()>1097152){
                            confirmMsg = true;          
                            Attach.body =null;
                            errorMsg = true;
                            Database.rollback(sp);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else if(caseVal!=null && attach.body!=null) {                         
                            attach.ParentId = caseVal.Id; 
                            attach.Description = 'file uploaded.';                                         
                            insert attach; 
                            attach.body =null;
                            errorMsg  = false; 
                        }                      
                    }
                    catch (DMLException e) {
                        confirmMsg = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                        return null;
                    }
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+errorMsg);
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+confirmMsg);
                    if(errorMsg == false){
                        PageReference ref=new PageReference('/apex/myCase?flagvalue1=true');
                        ref.setredirect(true);
                        return ref;
                    }
                } 
                catch(exception e){
                confirmMsg = true;
                casealldata=true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
        }
        return null;
      }
           public pagereference saveProductCase(){
               try{
                    confirmMsg = false;
                    errorMsg = false;
                    Savepoint sp = Database.setSavepoint(); 
                    caseVal = new Case();
                    system.debug('%%%%%%%%%%%selectedRT%%%%%%%%%%%%%'+selectedRT);
                    RecordType RT2 = [Select Id, Name From RecordType Where SobjectType='Case' AND Name=:selectedRT];
                    //input values
                    string Casetype=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:sec1:cstype');
                    string cate=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:sec1:cate1');
                    string reas=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:sec1:reas1');
                    string subcat=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:sec1:subcat1');
                    string pri=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:sec1:pri1');               
                    string sub=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:myBlockSec1:sub1');
                    string des=ApexPages.currentPage().getParameters().get('page:frm1:myBlock1:myBlockSec1:des1');
                   
                    if(Casetype=='' && cate=='' && subcat=='' && pri=='' && sub=='' && des==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please fill all fields'));
                        return null;
                    }
                   
                    if(Casetype!=null){
                        caseVal.type=Casetype;
                        caseVal.Case_Type__c='Product';
                    }
                    if(Casetype==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Case Type '));
                        return null;
                    }
                    if(cate!=null){
                        caseVal.Categories__c=cate;
                        caseVal.Case_Type__c='Product';
                    }
                    if(cate==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Categories '));
                        return null;
                    }
                    if(reas!=null){
                        caseVal.Reason=reas;
                        caseVal.Case_Type__c='Product';
                    }
                    if(subcat!=null){
                        caseVal.Sub_Cateogry__c=subcat;
                        caseVal.Case_Type__c='Product';
                    }
                    if(subcat==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Sub Categories '));
                        return null;
                    }
                    if(pri!=null){
                        caseVal.Priority=pri;
                        caseVal.Case_Type__c='Product';
                    }
                    if(pri==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Priority'));
                        return null;
                    }               
                    if(sub!=null){
                        caseVal.Subject=sub;
                        caseVal.Case_Type__c='Product';
                    }
                    if(sub==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject'));
                        return null;
                    }
                    if(des!=null){
                        caseVal.Description=des;
                        caseVal.Case_Type__c='Product';
                    }
                    if(des==''){                  
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                        return null;
                    }
                    if(selectedCode!=Null){
                        caseVal.Opportunity__c=selectedCode;
                    }
                    if(RT2.Id!=Null){
                        caseVal.RecordTypeId=RT2.Id;
                    }
                    //query for user record
                    User u =[select Id,ContactID, Name From User Where Id=:UserInfo.getUserId()];
                    caseVal.ContactId =u.ContactID;
                    system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+caseVal);
                    
                    //insert case record
                    try{                
                        insert caseVal;
                        errorMsg = false; 
                        if(caseVal!=null && attach.body!=null && Attach.body.size()>1097152){
                            confirmMsg = true;          
                            Attach.body =null;
                            errorMsg = true;
                            Database.rollback(sp);
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                        }
                        else if(caseVal!=null && attach.body!=null) {                         
                            attach.ParentId = caseVal.Id; 
                            attach.Description = 'file uploaded.';                                         
                            insert attach; 
                            attach.body =null;
                            errorMsg  = false; 
                        }                      
                    }
                    catch (DMLException e) {
                        confirmMsg = true;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                        return null;
                    }
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+errorMsg);
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+confirmMsg);
                    if(errorMsg == false){
                        PageReference ref=new PageReference('/apex/myCase?flagvalue1=true');
                        ref.setredirect(true);
                        return ref;
                    }
                } 
                catch(exception e){
                confirmMsg = true;
                casealldata=true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
        }
        return null;
      }
           
           
            public pagereference pageSave(){
            try{
               confirmMsg = false;
               errorMsg = false;
               Savepoint sp = Database.setSavepoint(); 
               caseVal = new Case();
               system.debug('%%%%%%%%%%%selectedRT%%%%%%%%%%%%%'+selectedRT);
               RecordType RT2 = [Select Id, Name From RecordType Where SobjectType='Case' AND Name=:selectedRT];
               string Casetype=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:sec1:cstype');
               string cate=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:sec1:cate1');
               string reas=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:sec1:reas1');
               string subcat=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:sec1:subcat1');
               string pri=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:sec1:pri1');               
               string sub=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:myBlockSec1:sub1');
               string des=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock1:myBlockSec1:des1');
               
               string Casetype2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:cstype');
               string cate2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:cate1');
               string reas2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:reas1');
               string subcat2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:subcat1');
               string pri2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:sec2:pri1');               
               string sub2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:myBlockSec2:sub1');
               string des2=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock2:myBlockSec2:des1');
               
               string Casetype3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:sec3:cstype');
               string cate3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:sec3:cate1');
               string reas3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:sec3:reas1');
               string subcat3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:sec3:subcat1');
               string pri3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:sec3:pri1');               
               string sub3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:myBlockSec3:sub1');
               string des3=ApexPages.currentPage().getParameters().get('page:frm:myBlock:myBlock3:myBlockSec3:des1');
               
               if(Casetype!=null){
               caseVal.type=Casetype;
               caseVal.Case_Type__c='Product';
               }
               if(Casetype==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Case Type '));
                    return null;
               }
              if(cate!=null){
               caseVal.Categories__c=cate;
               caseVal.Case_Type__c='Product';
               }
               if(cate==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Categories '));
                    return null;
               }
              if(reas!=null){
               caseVal.Reason=reas;
               caseVal.Case_Type__c='Product';
               }
              if(subcat!=null){
               caseVal.Sub_Cateogry__c=subcat;
               caseVal.Case_Type__c='Product';
               }
               if(subcat==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Sub Categories '));
                    return null;
               }
               if(pri!=null){
               caseVal.Priority=pri;
               caseVal.Case_Type__c='Product';
               }
               if(pri==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Priority'));
                    return null;
               }               
               if(sub!=null){
               caseVal.Subject=sub;
               caseVal.Case_Type__c='Product';
               }
               if(sub==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject'));
                    return null;
               }
              if(des!=null){
               caseVal.Description=des;
               caseVal.Case_Type__c='Product';
               }
               if(des==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                    return null;
               }
               
               
              if(Casetype2!=null){
               caseVal.type=Casetype2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(Casetype2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Case Type'));
                    return null;
               }
              if(cate2!=null){
               caseVal.Categories__c=cate2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(cate2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Categories'));
                    return null;
               }
              if(reas2!=null){
               caseVal.Reason=reas2;
               caseVal.Case_Type__c='Suggestion';
               }
              if(subcat2!=null){
               caseVal.Sub_Cateogry__c=subcat2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(subcat2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Sub Cateogry'));
                    return null;
               }
              if(pri2!=null){
               caseVal.Priority=pri2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(pri2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Priority'));
                    return null;
               }
               system.debug('##############################'+sub2);               
               if(sub2!=null){
               caseVal.Subject=sub2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(sub2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject '));
                    return null;
                }
              if(des2!=null){
               caseVal.Description=des2;
               caseVal.Case_Type__c='Suggestion';
               }
               if(des2==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                    return null;
               }
               
               
              if(Casetype3!=null){
               caseVal.type=Casetype3;
               caseVal.Case_Type__c='Service';
               }
               if(Casetype3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Type'));
                    return null;
               }
              if(cate3!=null){
               caseVal.Categories_Service__c=cate3;
               caseVal.Case_Type__c='Service';
               }
               if(cate3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Categories'));
                    return null;
               }
              if(reas3!=null){
               caseVal.Reason=reas3;
               caseVal.Case_Type__c='Service';
               }
              if(subcat3!=null){
               caseVal.Sub_Cateogry__c=subcat3;
               caseVal.Case_Type__c='Service';
               }
               if(subcat3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Sub Categories'));
                    return null;
               }
              if(pri3!=null){
               caseVal.Priority=pri3;
               caseVal.Case_Type__c='Service';
               }
               if(pri3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Priority'));
                    return null;
               }               
               if(sub3!=null){
               caseVal.Subject=sub3;
               caseVal.Case_Type__c='Service';
               }
               if(sub3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Subject'));
                    return null;
               }
              if(des3!=null){
               caseVal.Description=des3;
               caseVal.Case_Type__c='Service';
               }
               if(des3==''){                  
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.warning,'Please Enter Description'));
                    return null;
               }
               if(selectedCode!=Null){
               caseVal.Opportunity__c=selectedCode;
               
               }
               if(RT2.Id!=Null){
               caseVal.RecordTypeId=RT2.Id;
               }
               User u =[select Id,ContactID,MobilePhone, Name From User Where Id=:UserInfo.getUserId()];
               caseVal.ContactId =u.ContactID;
               caseVal.Customer_Mobile_No__c=u.MobilePhone;
               system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+caseVal);
               system.debug('-----------------------------------------'+u);
                try{ 
                                      
                     insert caseVal;
                     errorMsg = false; 
                     if(caseVal!=null && attach.body!=null && Attach.body.size()>1097152){
                         confirmMsg = true;          
                         Attach.body =null;
                         errorMsg = true;
                         Database.rollback(sp);
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Max attachment size is 1Mb'));
                      }
                      else if(caseVal!=null && attach.body!=null) {
                          //system.assertEquals(attach.body,null);
                          
                          attach.ParentId = caseVal.Id; 
                          attach.Description = 'file uploaded.';                                         
                          insert attach; 
                          attach.body =null;
                          errorMsg  = false; 
                      }                      
                     
                 }
                 catch (DMLException e) {
                  confirmMsg = true;
                  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
                  return null;
                }
                system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+errorMsg);
                system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+confirmMsg);
                if(errorMsg == false){
                    PageReference ref=new PageReference('/apex/myCase?flagvalue1=true');
                    ref.setredirect(true);
                    return ref;
                }
            } 
            ////////////
            
                catch(exception e){
                confirmMsg = true;
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'No Case Available');
                ApexPages.addMessage(myMsg);
        }
        return null;
      }  

}