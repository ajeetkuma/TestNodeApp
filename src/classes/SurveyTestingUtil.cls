public with sharing class SurveyTestingUtil {
  public String        surveyId       {get; set;}
  public List<String>  questionIds    {get; set;}
  public String          contactId      {get; set;}
  public String          opportunityId      {get; set;}
  public String        surveyTakerId  {get; set;}
  public String        contactId2     {get; set;}
  
  
  public SurveyTestingUtil(){
    questionIds = new List<String>();
    createTestSurvey();
    createTestQuestions();
    createTestContact();
    createSurveyTaker();
    createTestResponses();
    
  }
  
  private static TestMethod void testConstructor(){
    SurveyTestingUtil tu = new SurveyTestingUtil();
    System.assert(tu.surveyId != null);
  }
  
  private void createSurveyTaker(){
    SurveyTaker__c st = new SurveyTaker__c();
    st.Contact__c = contactId;
    st.Survey__c = surveyId;
   // st.Taken__c = 'false';
    st.Opportunity__c=opportunityId;
    insert st;
    surveyTakerId = st.Id;
  }
  
  public void createTestSurvey(){
    Survey__c s = new Survey__c();
    s.Name = 'Execution Feed Back1';
    s.URL__c ='/apex/salesforce.com';
    s.Submit_Response__c = 'empty';
    s.thankYouText__c ='Thank_you';
    s.thankYouLink__c='http://www.salesforce.com';
    insert s;
    surveyId = s.Id;
  }
  
  public void createTestQuestions(){
    questionIds.add(createQuestion(0));
    questionIds.add(createQuestion(1));
    questionIds.add(createQuestion(2));
    questionIds.add(createQuestion(3));
  }
  
  private String createQuestion(Integer i){
    Survey_Question__c q = new Survey_Question__c();
    q.Name = 'Testing Question';
    q.Survey__c = surveyId;
    q.Type__c = getType(i);
    q.Choices__c = getChoices();
    q.Question__c = 'Testing Question question';
    q.OrderNumber__c = i;
    q.Required__c = true;
    insert q;
    return q.id;        
  }
  
  
  private void createTestContact() {
    Account acc = new Account();
    acc.Name='Parent';
    insert acc;
    Contact c = new Contact();
    c.LastName = 'Doe';
    c.FirstName = 'John';
    c.Email = 'surveyAppUser@hotmail.com';
    c.AccountId=acc.Id;
    c.Contact_Type__c='First Applicant';
    insert c;
    contactId = c.Id;   
    
    Contact c2 = new Contact();
    c2.LastName = 'Doe2';
    c2.FirstName = 'John2';
    c2.Email = 'surveyAppUser2@hotmail.com';
    c2.AccountId=acc.Id;
    c2.Contact_Type__c='Second Applicant';
    insert c2;
    contactId2 = c2.Id;   
    
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=acc.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
            opp.Execution_without_modification_Feed_back__c=true;
            insert opp;
            opportunityId = opp.id;
            
            Plant__c pl=new Plant__c();
            pl.Name='test';  
            pl.Admin_Email__c='deve@fmail.com';
            pl.Project__c='cosmolis';  
            insert pl;
            
            Unit__c uc=new Unit__c();
            uc.Name='bridage';
            uc.Plant__c=pl.id;
            insert uc;             
                  
            CP_Property__c cpproperity=new CP_Property__c ();
            cpproperity.Plant__c=pl.id;
            cpproperity.Contact_User_Id__c=userinfo.getuserid();
            cpproperity.Unit_Code__c='123-1232-qw';
            cpproperity.Project_Name__c ='bridage';
            cpproperity.Active__c=true;
            cpproperity.Opportunity_Id__c=opp.id;
            Insert cpproperity;
            
  }
  
  private String createTestResponses() {
    SurveyQuestionResponse__c r = new SurveyQuestionResponse__c();
    r.Response__c = 'two';
    Survey_Question__c sq = [Select id from Survey_Question__c where id=: questionIds[1] limit 1];
    r.Survey_Question__c = sq.id;
    r.SurveyTaker__c = surveyTakerId;
    insert r;
    return 'true';
  }
  
  private String getType(Integer i){
    if      (i==1)
     return 'Multi-Select--Vertical';
    else if (i==2)
     return 'Single Select--Vertical';
    else if (i==3)
     return 'Free Text';
    else
     return 'Single Select--Horizontal';
  }
  private String getChoices(){
    return 'one\ntwo\nthree\n';
  }
  
}