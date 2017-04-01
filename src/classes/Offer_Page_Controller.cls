public with sharing class Offer_Page_Controller {
    /*
         Variable declaration
     */
   public Attachment Attach {
        get;
        set;
    }
    public List < Offer__c > listOfffer = new List < Offer__c > ();
    public List < Plant__c > listOfPlants {
        get;
        set;
    }
    public String message {
        get;
        set;
    }
    public Offer__c offer {
        get;
        set;
    }
    public Set < String > plantSet {
        get;
        set;
    }
    public String selectedValue {
        get;
        set;
    }
    public List < Offer__c > listOfOffers = new List < Offer__c > ();
    public Set < String > originalvalues;
    public List < string > leftselected {
        get;
        set;
    }
    Public List < string > rightselected {
        get;
        set;
    }
    public Set < string > leftvalues = new Set < string > ();
    public Set < string > rightvalues = new Set < string > ();
    public Offer__c offer1 {
        get;
        set;
    }
    public string Accid {
        get;
        set;
    }
    public String accName {
        get;
        set;
    }
    String strget = '';
    List < string > lstFinal = new List < string > ();
    public List < String > listOfPlantValues = new List < String > ();

    // variable decration for 2nd mutilple list
    public List < String > listOfProjects {
        get;
        set;
    }
    public Set < String > originalvalues1;
    public List < string > leftselected1 {
        get;
        set;
    }
    Public List < string > rightselected1 {
        get;
        set;
    }
    public Set < string > leftvalues1 = new Set < string > ();
    public Set < string > rightvalues1 = new Set < string > ();
    public List < Plant__c > listOfplants1 {
        get;
        set;
    }
    public String selectedValue1 {
        get;
        set;
    }
    public List < string > lstFinal1 = new List < string > ();
    String strget1 = '';

    public Set < string > leftvaluesforUnit = new Set < string > ();
    public Set < string > rightvaluesforUnit = new Set < string > ();
    public List < string > leftselectedforUnit {
        get;
        set;
    }
    Public List < string > rightselectedforUnit {
        get;
        set;
    }
    public String selectedValueforUnit {
        get;
        set;
    }
    public Set < String > origionalValuesforUnit;
    public List < Unit__c > listOfUnits {
        get;
        set;
    }
    public String strError{
        get;
        set;
    }
     public string fileName   
    {    get;set;    }  
      
    public Blob fileBody   
    {    get;set;    } 

    // Constructor

    public Offer_Page_Controller(ApexPages.StandardController controller) {
        strError ='';
        offer1 = new Offer__c();
        this.offer1 = (Offer__c) Controller.getRecord();
        leftselected = new List < String > ();
        rightselected = new List < String > ();
        leftselected1 = new List < String > ();
        rightselected1 = new List < String > ();
        leftselectedforUnit = new List < String > ();
        rightselectedforUnit = new List < String > ();
        Attach = new Attachment();
   }

    /*
        Method : To get all project values related to Plant
    */

    public void projectInfo() {
        listOfPlants = [select id, name, Project__c from Plant__c order by Project__c asc];
        System.debug('#############listOfPlants' + listOfPlants);
        originalvalues = new Set < String > ();
        for (Plant__c Plant: listOfPlants) {
            originalvalues.add(Plant.Project__c);
            System.debug('#############33' + originalvalues);
        }
        leftvalues.addAll(originalValues);

        System.debug('#############leftvalues' + leftvalues);
    } 

    /*
          Method : To get all selected values
   
    */
    public PageReference selectclick() {
        rightselected.clear();
        for (String s: leftselected) {
            leftvalues.remove(s);
            rightvalues.add(s);

        }
        return null;
    } 

    /*
          Method : To get all unselected values
   */
    public PageReference unselectclick() {
        leftselected.clear();
        for (String s: rightselected) {
            rightvalues.remove(s);
            leftvalues.add(s);

        }
        return null;
    } 
    

    /*
          Method : To get all unselected values
   */
    public List < SelectOption > getunSelectedValues() {
        projectInfo();
        List < SelectOption > options = new List < SelectOption > ();
        List < string > tempList = new List < String > ();
        System.debug('#######unselected######tempList' + tempList);
        tempList.addAll(leftvalues);
        tempList.sort();
        System.debug('#######unselected######tempList' + tempList);
        for (string s: tempList)
        options.add(new SelectOption(s, s));
        System.debug('**********options' + options);
        return options;

    }

    /*
          Method : To get all selected values
   
     */
    public List < SelectOption > getSelectedValues() {
        List < SelectOption > options1 = new List < SelectOption > ();
        List < string > tempList = new List < String > ();
        System.debug('######Selected#######tempList' + tempList);
        tempList.addAll(rightvalues);
        System.debug('######Selected#######rightvalues' + rightvalues);
        tempList.sort();
        System.debug('######SelectedValues#######tempList' + tempList);
        for (String s: tempList)
        options1.add(new SelectOption(s, s));
        System.debug('**********selected Values' + options1);

        for (integer i = 0; i < options1.size(); i++) {
            if (i == 0) selectedvalue = options1[i].getValue();
            else selectedvalue += ',' + options1[i].getValue();
        }

        return options1;


    }

    /*
         Save Method
     */

    public PageReference doSave() {
        System.debug('&&&&&&&&&&&&&&checking' + offer1);
        
        

        Offer__c o = new Offer__c();
        o.Name = offer1.Name;
        o.Comments__c = offer1.Comments__c;
        o.Cost_PSFt__c = offer1.Cost_PSFt__c;
        o.Offer_Details__c = offer1.Offer_Details__c;
        o.Offer_Duration_End_Date__c = offer1.Offer_Duration_End_Date__c;
        o.Offer_Duration_start_Date__c = offer1.Offer_Duration_start_Date__c;
        o.Offer_Given_on__c = offer1.Offer_Given_on__c;
        o.Offer_Partner__c = offer1.Offer_Partner__c;
        o.Offer_Type__c = offer1.Offer_Type__c;
        o.Approved_BY_HOD__c = offer1.Approved_BY_HOD__c;
        o.Offer_Code__c = offer1.Offer_Code__c;
        o.Projects_Included__c = selectedvalue;
        o.Blocks_on_Offer__c = selectedValue1;
        o.Offer_on_Unit_Nos__c = selectedValueforUnit;
        if( o.Approved_BY_HOD__c == true && attach.body==null){
        
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please Choose file to upload'));
          System.debug('**********Test Condition error*******');
         }
         else if(o.Approved_BY_HOD__c == false && attach.body==null){
        insert o;
          System.debug('**********Test Condition Insert only*******');
        PageReference page = new PageReference('https://bgproduction-brigadeforce-na19.my.salesforce.com/a1H/o');
                page.setredirect(false);
                return page;
           }
           else if( o.Approved_BY_HOD__c == true && attach.body!=null){
                insert o;       

        if (o != null) {
            Attach.ParentId = o.Id;
            Attach.Description = 'file uploaded.';
            insert Attach;
            System.debug('++++++++++++++++attach' + attach);
             PageReference page = new PageReference('https://bgproduction-brigadeforce-na19.my.salesforce.com/a1H/o');
                page.setredirect(false);
                return page;
            }
                }
        
       return null;
  
        // Retun to List view of records.

      //  PageReference page = new PageReference('https://cs16.salesforce.com/a1A/o');
        //page.setredirect(false);
        //return page;

    }

    // Cancel Button Method
    public PageReference Cancel() {

        PageReference page = new PageReference('https://bgproduction-brigadeforce-na19.my.salesforce.com/a1H/o');
        page.setredirect(false);
        return page;
    }

    /*
       Method : To get all plant towared selected Projects      
   */

    public Map < id, Plant__c > mapOfPlants;
    public void selectedPlant() {
        listOfplants1 = [select id, name, Project__c from Plant__c order by Project__c asc];
        mapOfPlants = new Map < id, Plant__c > ();

        System.debug('*****************listOfplants1' + listOfplants1);
        originalvalues1 = new Set < String > ();
        System.debug('@@@@@@@@@@@@@@@@@@@@@selecte values' + selectedvalue);
        for (Plant__c p: listOfplants1) {
            //for(String pl :rightvalues){
            if (selectedvalue.contains(p.Project__c)) {
                listOfPlantValues.add(p.Project__c);
                System.debug('&&&&&&&&&&listOfPlantValues&' + listOfPlantValues);
                mapOfPlants.put(p.id, p);
            }
        }
        leftvalues1.addAll(listOfPlantValues);
        System.debug('#############leftvalues1' + leftvalues1);
    } 

    /*
         Method : To get all selected values Plant
    */

    public PageReference selectclick1() {
        rightselected1.clear();
        system.debug('leftselected1}::261::' + leftselected1);
        System.debug('262-leftvalues1' + leftvalues1);
        //system.debug();
        for (String s: leftselected1) {
            leftvalues1.remove(s);
            //rightvalues1.add(s);
            if (mapOfPlants.containsKey(s)) {
                rightvalues1.add(mapOfPlants.get(s).Name);
                system.debug('++++++++++========rightvalues1' + rightvalues1);
            }
        }
        return null;
    }

    /*
          Method : To get all unselected values for Plant
        
    */
    public PageReference unselectclick1() {
        leftselected1.clear();
        for (String s: rightselected1) {
            rightvalues1.remove(s);
            leftvalues1.add(s);
        }
        return null;
    }

    /*
          Method : To get all unselected values For Plant
       */ 

    public List < SelectOption > getunSelectedValues1() {

        selectedPlant();
        List < SelectOption > optionsPlant = new List < SelectOption > ();
        List < string > tempList = new List < String > ();


        System.debug('========leftvalues1' + leftvalues1);
        for (Plant__c pl: mapOfPlants.values()) {
            tempList.add(pl.project__c);
            optionsPlant.add(new SelectOption(pl.ID, pl.Name));
            //optionsPlant.add(new SelectOption(pl.Name,pl.ID));
        }
        System.debug('**********optionsPlant' + optionsPlant);
        return optionsPlant;

    }

    /*
          Method : To get all selected values
     */

    public List < SelectOption > getSelectedValues1() {

        List < SelectOption > optionsPlant1 = new List < SelectOption > ();
        List < string > tempList = new List < String > ();
        System.debug('######Selected#######tempList' + tempList);
        tempList.addAll(rightvalues1);
        tempList.sort();
        System.debug('######Selected#######rightvalues1' + rightvalues1);
        for (String s: tempList)
        optionsPlant1.add(new SelectOption(s, s));
        System.debug('**********selected Values' + optionsPlant1);

        for (integer i = 0; i < optionsPlant1.size(); i++) {
            if (i == 0) selectedValue1 = optionsPlant1[i].getValue();
            else selectedValue1 += ',' + optionsPlant1[i].getValue();
        }
        return optionsPlant1;
    }   

    /*
    method to get Unit information
    */

    public void selectedUnit() {
        listOfUnits = new List < Unit__c > ();
        origionalValuesforUnit = new Set < String > ();
        listOfUnits = [select id, name, Plant__c, Plant__r.Name from Unit__c where Plant__r.Name in : rightvalues1];
        System.debug('*****************listOfUnits' + listOfUnits);

        for (Unit__c un: listOfUnits) {
            origionalValuesforUnit.add(un.Name);
            System.debug('#############33' + originalvalues);
        }
        leftvaluesforUnit.addAll(origionalValuesforUnit);

        System.debug('#############leftvaluesforUnit' + leftvaluesforUnit);
    }

    /*
        Method : To get all selected values Unit
   
    */
    public PageReference selectclickforUnit() {
        rightselectedforUnit.clear();
        for (String s: leftselectedforUnit) {
            leftvaluesforUnit.remove(s);
            rightvaluesforUnit.add(s);
        }
        return null;
    } 

    /*
        Method : To get all unselected values for Unit
    */

    public PageReference unselectclickforUnit() {
        leftselectedforUnit.clear();
        for (String s: rightselectedforUnit) {
            rightvaluesforUnit.remove(s);
            leftvaluesforUnit.add(s);
        }
        return null;
    }

    /*
             Method : To get all unselected values For Plant
    */

    public List < SelectOption > getunSelectedValuesforUnit() {

        selectedUnit();
        List < SelectOption > optionsUnit = new List < SelectOption > ();
        List < string > tempList = new List < String > ();
        tempList.addAll(leftvaluesforUnit);
        tempList.sort();

        System.debug('========leftvaluesforUnit' + leftvaluesforUnit);
        for (string s: tempList) {

            optionsUnit.add(new SelectOption(s, s));

        }
        System.debug('**********optionsUnit' + optionsUnit);
        return optionsUnit;
    }

    /*
          Method : To get all selected values
   */

    public List < SelectOption > getSelectedValuesForUnit() {

        List < SelectOption > optionsPlantforUnit = new List < SelectOption > ();
        List < string > tempList = new List < String > ();
        System.debug('######Selected#######tempList' + tempList);
        tempList.addAll(rightvaluesforUnit);
        tempList.sort();
        System.debug('######Selected#######rightvalues1' + rightvalues1);
        for (String s: tempList)
        optionsPlantforUnit.add(new SelectOption(s, s));
        System.debug('**********selected Values' + optionsPlantforUnit);

        for (integer i = 0; i < optionsPlantforUnit.size(); i++) {
            if (i == 0) selectedValueforUnit = optionsPlantforUnit[i].getValue();
            else selectedValueforUnit += ',' + optionsPlantforUnit[i].getValue();
        }
        return optionsPlantforUnit;
    } 
}