public with sharing class portalAccess {

    //List<Plant__c> Plant1 = new List<Plant__c>();
    private final Plant__c Plant1;
    public boolean isTrue {get; set;}
    public portalAccess(ApexPages.StandardController controller) {
        conList=new List<contact>();

        this.Plant1=(Plant__c)controller.getRecord();

    }
    public List<String> SerchAlpabet{get;set;}
    public String SearchVar{get;set;}
    public list<contact> con1{set;get;}
    public list<contact> ShowCon{set;get;}
    public integer sizee{get;set;}
    public boolean isAllSelect{ get; set; }
    public boolean isReverse{ get; set; }
    public boolean isAllSelect2{ get; set; }
    private integer counter=0;  //keeps track of the offset
    public integer list_size {get;set;}{list_size=500;}
    public integer total_size;
    public String selectedValue{ get; set; }
    public List<Plant__c> listOfPlants{ get; set; }
    public Plant__c idOfSelVal{ get; set; }
    public String selectedValuesid{ get; set; }
    public String selectedPlant { get; set; }
    public String isPortalAcess {get; set; }
    public String globalSearch{get; set;}
    public List<Opportunity> oppList {get; set; }
    public List<Opportunity> oppList2 {get; set; }
    public List<Opportunity> oppList3 {get; set; }
    public List<Contact> conList {get; set; }
    public List<SelectOption> getItems()
    {
        List<SelectOption> options = new List<SelectOption>(); 
        Set<String> plantSet= new Set<String>();
        Try{
            listOfPlants = [select id,name,Project__c from Plant__c where Allowed_portal_access__c = true order by Project__c asc];
            for(Plant__c Plant : listOfPlants)
            {
                plantSet.add(Plant.Project__c);
            }
            options.add(new SelectOption('','---Select---'));
            for(String plantName : plantSet)
            {
                options.add(new SelectOption(plantName,plantName));
            }

            return options;
        }
        Catch (Exception e){
            system.debug(e);
            return null;
        }
    }


    Public List<SelectOption> plantOption { get; set; }
    
    Public List<SelectOption> getPlantName(){
        conList =new List<contact>();
        plantOption= new List<SelectOption>();
        //plantOption.add(new SelectOption('','---Select---'));
        for(Plant__c plant : listOfPlants){
            system.debug('selectedValue@@@@@@@@@@@@@@@@@@@@@@@@'+selectedValue);
            if(Plant.Project__c == selectedValue){
                plantOption.add(new SelectOption(plant.Id,plant.Name));
            }

        }
        system.debug('plantOption################'+plantOption);
        return null;
    }
    public portalAccess () {
        total_size=5;
    }

    Public pagereference Search(){
        
        if(isPortalAcess == 'Yes'){
        Counter=0;
        isAllSelect=true;
        }
        else{
        Counter=0;
        isAllSelect=false;
        }

        Try{
            system.debug('################################'+selectedPlant);
            if(selectedPlant!=null){
            oppList = [select Id, StageName, AccountID, Account.ParentId, Unit__c,Unit__r.Name, name,Unit__r.Plant__r.Id From Opportunity Where Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];
            //system.assertEquals(oppList,null);
            }
            system.debug('%%%%%%%%%%%%%%%%%%oppList.size()%%%%%%%%%%%%%%%%%%%%%%%'+oppList.size());
            system.debug('%%%%%%%%%oppList%%%%%%%%%'+oppList);
            contactPageList=new List<contact>();
            conList=new List<contact>();
            List<String> oppidList = new List<String>();
            for(Opportunity opp :oppList){
            oppidList.add(opp.Account.ParentId);
            system.debug('###oppidList###'+oppidList);
            }
            
            
            //for(Opportunity opp : oppList){
                if(isPortalAcess == 'No'){
                    isTrue=true;
                    
                    conList.addALL( [select id, firstname, Email, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId, Income_Tax_PAN_GIR_No__c From Contact Where AccountId IN:oppidList AND Portal_Access__c=FALSE AND Contact_Type__c ='Primary Contact' AND AccountId<>null]);
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+conList);
                    system.debug('^^^^^^^^^^^^^^^^^^conList.size^^^^^^^^^^^^^^^^^^^^'+conList.size());
                    //system.AssertEquals(conList,null);
                    List<String> conidList = new List<String>();
                    for(Contact cont :conList){
                    conidList.add(cont.AccountId);
                    }
                    system.debug('111111111111111111111111111111'+conidList);
                    oppList2 =[select Id,AccountID, Account.ParentId,Unit__c,Unit__r.Name, name,Unit__r.Plant__r.Id From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];
                    system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oppList2);
                }
                else{
                    isTrue=true;
                    // conList = [select id, firstname, lastname, mobilephone, Portal_Access__c From Contact Where AccountID =: opp.AccountID AND Portal_Access__c =TRUE ];
                    conList.addAll( [select id, firstname,Income_Tax_PAN_GIR_No__c, Email, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact Where AccountId IN:oppidList AND Portal_Access__c =TRUE AND Contact_Type__c ='Primary Contact' AND AccountId<>null]);                   
                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+conList);
                    system.debug('^^^^^^^^^^^^^^^^^^conList.size^^^^^^^^^^^^^^^^^^^^'+conList.size());
                    //system.AssertEquals(conList,null);
                    List<String> conidList = new List<String>();
                    for(Contact cont :conList){
                    conidList.add(cont.AccountId);
                    }
                    system.debug('111111111111111111111111111111'+conidList);
                    oppList2 =[select Id,AccountID, Unit__c,Unit__r.Name,Account.ParentId, name,Unit__r.Plant__r.Id From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];
                    system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oppList2);                    
                }
                //system.assertEquals(oppList2,null);
           // }
            contactPageList=new List<Contact>();
            contactPageList=setValueTopageList();
            bindContactWithOpportunity(contactPageList,oppList2) ;
            System.debug('----------conList --------------'+conList );
            System.debug('------------------------'+contactPageList);

            return null;
        }
        Catch(Exception e){
            system.debug(e);
            return null;
        }
    }
    Public List<WrapperClass> bindedList{set;get;}
    //Public List<WrapperClass> bindedList2{set;get;}
    public void bindContactWithOpportunity(List<Contact>conList,List<Opportunity>oppList2) {
    bindedList=new List<WrapperClass>();
        for(Opportunity  op:oppList2){
        if(conList.size()>0)
        for(Contact c : conList){
            system.debug('987654321'+c.AccountId);
            system.debug('123456789'+op.Account.ParentId);            
            if(op.Account.ParentId==c.AccountId){
            bindedList.add(new portalAccess.WrapperClass( op, c));
            system.debug('11111111111111111111111111111111111111111111111111111111'+bindedList);
            //bindedList.add(new portalAccess.WrapperClass( op, conList[0]  ));
            }
            }
        }
    
    
    }
    public Class WrapperClass{
    public Contact con{get;set;}
    public Opportunity Opp{get;set;}
    public WrapperClass( Opportunity oppr,Contact cont){
        con=cont;
        opp=oppr;
    }
    
    }
    private List<contact> setValueTopageList(){

        contactPageList=new List<contact>();

        //contactPageList//
        for (contact conPg: contactPageList ){
            for (Integer j=0;j<conList.size();j++){
                if(conPg.id==conList[j].id)
                    conList[j].portal_Access__c=conPg.portal_Access__c;


            }
        }
        List<contact> tempCont=new List<contact>();
        for ( Integer i=counter; i<conList.size(); i++){
            if(i<counter+list_size){
                tempCont.add(conList[i]);
            }
        }

        return tempCont;
    }
    Public pagereference Activate(){
        //contactPageList=new LIst<Contact>();

        try{


            for (contact conPg: contactPageList ){
                for (Integer j=0;j<conList.size();j++){
                    if(conPg.id==conList[j].id)
                        conList[j].portal_Access__c=conPg.portal_Access__c;


                }
            }
            system.debug('@@@@@@@@@@@@@@@@@'+conList);
            
            for(Integer i=0;i<conList.size();i++){
                If(conList[i].portal_Access__c==TRUE){
                conList[i].Create_Date_of_Customer_Portal__c = system.today();   
                }else{
                    conList[i].De_Activate_Date_of_Portal_User__c = system.today();
                }
                
            }
            update conList;
            Search();

            return null;
        }
        Catch(Exception e){
            system.debug(e);
            return null;
        }
    }
    Public pagereference selectAllRecordToSeleted(){
        system.debug(conList+'@@@@@@@@@@@@@@@');
     
        if(isPortalAcess == 'Yes'){
         //system.assertEquals(3,4);
        for(Integer i=0;i<contactPageList.size();i++){
            System.debug('---------------------------------------');
            contactPageList[i].Portal_Access__c=isAllSelect;
        }
        for (contact conPg: contactPageList ){
            for (Integer j=0;j<conList.size();j++){
                if(conPg.id==conList[j].id)
                    conList[j].portal_Access__c=conPg.portal_Access__c;
            }
        }

        return null;
        }else{
       
        for(Integer i=0;i<contactPageList.size();i++){
            System.debug('---------------isAllSelect2------------------------'+isAllSelect2);
            contactPageList[i].Portal_Access__c=isAllSelect2;
        }
        for (contact conPg: contactPageList ){
            for (Integer j=0;j<conList.size();j++){
                if(conPg.id==conList[j].id)
                    conList[j].portal_Access__c=conPg.portal_Access__c;
            }
        }

        return null;
            
        }
    }

    public List<contact> contactPageList{get;set;}

    public PageReference Next() { //user clicked next button
        if(conList.size()>counter+1)
            counter += list_size;
        contactPageList=setValueTopageList();
        return null;
    }
    public PageReference Previous() { //user clicked previous button
        if(counter >=list_size)
            counter -= list_size;
        contactPageList=setValueTopageList();
        return null;
    }
    public PageReference setIsSelectToFalse() { 
        isAllSelect=false;
        return null;
    }
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    public Integer getTotal_size() {
        return total_size;
    }

    public Integer getTotalPages() {
        total_size=conList.size();
        if (total_size > 0) {
            return (total_size/list_size)+1;
        } else {

            return (total_size/list_size);
        }
    }
    
    public void sortList(List<Sobject> items, String sortField, String order){


       List<Sobject> resultList = new List<Sobject>();
   
        //Create a map that can be used for sorting 
       Map<object, List<Sobject>> objectMap = new Map<object, List<Sobject>>();
           
       for(Sobject ob : items){
                if(objectMap.get(ob.get(sortField)) == null){  // For non Sobject use obj.ProperyName
                    objectMap.put(ob.get(sortField), new List<Sobject>()); 
                }
                objectMap.get(ob.get(sortField)).add(ob);
        }       
        //Sort the keys
        List<object> keys = new List<object>(objectMap.keySet());
        keys.sort();
       
        for(object key : keys){ 
            resultList.addAll(objectMap.get(key)); 
        }
       
        //Apply the sorted values to the source list
        items.clear();
        if(order.toLowerCase() == 'asc'){
            for(Sobject ob : resultList){
                items.add(ob); 
            }
        }else if(order.toLowerCase() == 'desc'){
            for(integer i = resultList.size()-1; i >= 0; i--){
                items.add(resultList[i]);  
            }
        }
    }
    public PageReference sortlist(){
        if(isReverse==FALSE){
            isReverse=TRUE;
            sortList(contactPageList,'FirstName', 'ASC');
        }
        else{
            isReverse=FALSE;
            sortList(contactPageList,'FirstName', 'DESC');
        }
        
        return null;
    }

        Public pagereference Search2(){
            List<Id> conId=new List<Id>();
            set<Id> oppId=new set<Id>(); 
            for (WrapperClass bind2 : bindedList){
                conId.add(bind2.Con.Id);
                oppId.add(bind2.Opp.Id);
            }
            
            globalSearch ='%'+globalSearch+'%';
           // string str=' SELECT Id FROM Opportunity WHERE Name LIKE' + '%' + globalSearch + '%' and ID in '+;
            //List<Opportunity> opp2
        if(isPortalAcess == 'Yes'){
        Counter=0;
        isAllSelect=true;
        }
        else{
        Counter=0;
        isAllSelect=false;
        }

        Try{
            system.debug('################################'+selectedPlant);
            system.debug('bbbbkkklllaaaxxxxqaeeesadfffff'+globalSearch);
            if(globalSearch !=null){
            oppList3=[ select Id, StageName, AccountID, Account.ParentId, Unit__c,Unit__r.Name, name,Unit__r.Plant__r.Id From Opportunity WHERE Unit__r.Name LIKE   : globalSearch and ID IN : oppId AND StageName='Allotment'];  
            }
            system.debug('99999999999999999999999999999999999'+oppList);
            if(oppList3.size()==0){
            oppList = [select Id, StageName, AccountID, Account.ParentId, Unit__c,Unit__r.Name, name,Unit__r.Plant__r.Id From Opportunity Where Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];            
            system.debug('888888888888888888888888888888888888'+oppList);
            }
            //system.assertEquals(oppList,null);
            system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+oppList);
            contactPageList=new List<contact>();
            conList=new List<contact>();
            List<String> oppidList = new List<String>();
            if(oppList3.size()==0){
            for(Opportunity opportunity :oppList){
            oppidList.add(opportunity.Account.ParentId);            
            }
            }
            else{
              for(Opportunity opportunity :oppList3){
              oppidList.add(opportunity.Account.ParentId);            
            }  
            }
            
            //for(Opportunity opp : oppList){
                if(isPortalAcess == 'No'){
                    isTrue=true;

                    if(oppList3.size()==0){                                                      
                        conList.addALL( [select id, firstname,Income_Tax_PAN_GIR_No__c, Email, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact Where AccountId IN:oppidList AND Portal_Access__c=FALSE AND Contact_Type__c ='Primary Contact' AND ((LastName LIKE : globalSearch)OR(MobilePhone LIKE : globalSearch)OR(Email LIKE : globalSearch))]);
                        system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+conList);
                    }
                    else{
                        conList.addALL( [select id, firstname,Income_Tax_PAN_GIR_No__c, Email, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact Where AccountId IN:oppidList AND Portal_Access__c=FALSE AND Contact_Type__c ='Primary Contact' ]);
                    }
                    //system.AssertEquals(conList,null);
                    List<String> conidList = new List<String>();
                    for(Contact cont :conList){
                    conidList.add(cont.AccountId);
                    }
                    system.debug('111111111111111111111111111111'+conidList);
                    oppList2 =[select Id,AccountID, Unit__c,Unit__r.Name, name,Unit__r.Plant__r.Id,Account.ParentId From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND Unit__r.Name LIKE   : globalSearch and ID IN : oppId AND StageName='Allotment'];
                    system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oppList2);
                    if(oppList2.size()==0){
                    oppList2 =[select Id,AccountID, Unit__c,Unit__r.Name,Account.ParentId, name,Unit__r.Plant__r.Id From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];

                    }
                }
                else{
                    isTrue=true;
                    // conList = [select id, firstname, lastname, mobilephone, Portal_Access__c From Contact Where AccountID =: opp.AccountID AND Portal_Access__c =TRUE ];
                    if(oppList3.size()==0){ 
                    conList.addAll( [select id, firstname, Email,Income_Tax_PAN_GIR_No__c, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact Where AccountId IN:oppidList AND Portal_Access__c =TRUE AND Contact_Type__c ='Primary Contact' AND ((LastName LIKE : globalSearch)OR(MobilePhone LIKE : globalSearch)OR(Email LIKE : globalSearch))]);                   
                    }
                    else{
                    conList.addAll( [select id, firstname, Email,Income_Tax_PAN_GIR_No__c, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact Where AccountId IN:oppidList AND Portal_Access__c =TRUE AND Contact_Type__c ='Primary Contact' ]);                   

                    system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'+conList);
                    }
                    //system.AssertEquals(conList,null);
                    List<String> conidList = new List<String>();
                    for(Contact cont :conList){
                    conidList.add(cont.AccountId);
                    }
                    system.debug('111111111111111111111111111111'+conidList);
                    if(globalSearch !=null){
                    oppList2 =[select Id,AccountID, Unit__c,Unit__r.Name,Account.ParentId, name,Unit__r.Plant__r.Id From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND Unit__r.Name LIKE   : globalSearch and ID IN : oppId AND StageName='Allotment'];
                    system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oppList2);
                    }
                    if(oppList2.size()==0){
                    oppList2 =[select Id,AccountID, Unit__c,Unit__r.Name,Account.ParentId, name,Unit__r.Plant__r.Id From Opportunity Where Account.ParentId IN:conidList AND Unit__r.Plant__r.Id =:selectedPlant AND StageName='Allotment'];

                    }                    system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+oppList2);                    
                }
                //system.assertEquals(oppList2,null);
           // }
            contactPageList=new List<Contact>();
            contactPageList=setValueTopageList();
            bindContactWithOpportunity(contactPageList,oppList2) ;
            System.debug('----------conList --------------'+conList );
            System.debug('------------------------'+contactPageList);
            globalSearch='';
            return null;
        }
        Catch(Exception e){
            system.debug(e);
            return null;
        }
    
            //oppList2=[ SELECT Id FROM Opportunity WHERE Unit__r.Name LIKE   : globalSearch and ID IN : oppId]   ;  
            //system.debug('==opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2'+oppList2);  
            //conList=[select id, firstname, Email, Phone, lastname, mobilephone, Create_Date_of_Customer_Portal__c, Portal_Access__c,AccountId From Contact WHERE LastName LIKE   : globalSearch and ID IN : conId];
             //system.debug('==opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2opp2'+conList); 
            //contactPageList=new List<Contact>();
            //contactPageList=setValueTopageList();
            //bindContactWithOpportunity(contactPageList,oppList2) ;
             //return null;
        }

}