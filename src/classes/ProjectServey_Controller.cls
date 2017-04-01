/*
Description : Contoller for Project Servey Page.Used to create Survey Record for Opportunity 
Author      : Amritesh
*/

public class ProjectServey_Controller {
    
    public boolean survetStatus                           {get;set;} // status field to check if Survey exist,then display thank you,otherwise display Survey    
    public List<Project_Survey__c> questionList           {get;set;}  // List of existing Survey question 
    public List<questionWrapper>   questionWrapperList    {get;set;}    
    public string oppId                                   {get;set;}
    
    
    public static final string  SURVEY_QUESTION        = 'Question';
    public static final string  SURVEY_RESPONSE        = 'Response';
    
    // get Record Type Ids for different Record Type from Project_Survey__c object
    public static String SURVEY_QUESTION_RECORDTYPE    = Schema.SObjectType.Project_Survey__c.getRecordTypeInfosByName().get(SURVEY_QUESTION).getRecordTypeId();
    public static String SURVEY_ANSWER_RECORDTYPE      = Schema.SObjectType.Project_Survey__c.getRecordTypeInfosByName().get(SURVEY_RESPONSE).getRecordTypeId();
    
    // Constructor
    public ProjectServey_Controller(){
        
        try{
            questionList                = new List<Project_Survey__c>();
            questionWrapperList         = new List<questionWrapper>();                  
            oppId                       = ApexPages.currentPage().getParameters().get('oppSurveyId');
            
            // Check if Opporunity existing against OppId or not.
            // If Existing     : then check "Project Survey" under Opportinity,if present display thankyou on Page :else display survey
            // If Not Existing : Display Thankyou message
            if(oppId != null){            
                List<Opportunity> existingOppSurvey = [Select id,(select id from Project_Survey__r) from Opportunity where Id =:oppId];
                if(existingOppSurvey.Size() > 0){
                    if(existingOppSurvey[0].Project_Survey__r.size() > 0){
                        survetStatus = false;
                    }else{
                        survetStatus = true;
                        questionList = [Select id,Question_Name__c,Answer_choice__c from Project_Survey__c where recordTypeId =: SURVEY_QUESTION_RECORDTYPE AND Opportunity__c = null AND Question_Name__c != null];
                        getQuestionList(questionList);
                    }
                    
                }else{
                    survetStatus = false;
                }
            }else{
                survetStatus = false;
            }            
           
        }catch(Exception ex){
            survetStatus = false;
        }
    }
    
    
    // Create a list of questionWrapper with Question Name with all answer list 
    public void getQuestionList(List<Project_Survey__c> questionList){        
        for(Project_Survey__c p : questionList){
            questionWrapper qw    = new questionWrapper();
            qw.qsnName            = p.Question_Name__c;
            qw.qsnId              = p.Id;
            qw.selectedValue      = '';
            qw.ansList            = new List<SelectOption>();
            
            if(p.Answer_choice__c != null){
                for(String s : p.Answer_choice__c.split(';')){
                    qw.ansList.add(new SelectOption(s,s));    
                }
            } 
            
            questionWrapperList.add(qw);
        }
        
    }
    
    // Save Survey method to check the if all Questions are 
    // answered or not and based on that call insertServey method
    public pagereference saveSurvey(){
        
        boolean notAllQsnAnswered = false;
        for(questionWrapper qw : questionWrapperList){
            if(qw.selectedValue == null){
                notAllQsnAnswered= true;
            }
        }
        
        if(notAllQsnAnswered){
            ApexPages.Message errMsg = new  ApexPages.Message(ApexPages.Severity.ERROR,'Please answer all the Question');
            ApexPages.addMessage(errMsg);
            return null;        
        }else{
            insertOppServey(questionWrapperList);
            survetStatus = false; 
            pagereference pg = new pagereference('/apex/Thank_You');
            pg.setRedirect(true);
            return pg;         
        }
        
        
        
    }
    
    // If all Questions are answered then insert Survey against related Opportunity
    public void insertOppServey(list<questionWrapper> questionWrapperList){
        
        try{            
            List<Project_Survey__c> listToInsert    = new List<Project_Survey__c>();
            for(questionWrapper qw : questionWrapperList){
                listToInsert.add(new Project_Survey__c(RecordTypeId =SURVEY_ANSWER_RECORDTYPE,Opportunity__c=oppId,Project_Survey_Question__c=qw.qsnId,Response__c=qw.selectedValue ));    
            }            
            insert listToInsert;
        }catch(Exception ex){}
    }
    
    // Wrapper class
    public class questionWrapper{
        public string qsnName              {get;set;}
        public string qsnId                {get;set;}
        public String selectedValue        {get;set;}
        public List<SelectOption> ansList  {get;set;}
    }
}