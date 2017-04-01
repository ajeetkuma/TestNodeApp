public with sharing class GettingStartedController {

public Survey__c testSurvey {get;set;}
public Boolean testSurveyAvailable {get;set;}
public List<String>  questionIds {get;set;}

public GettingStartedController()
{
// make sure getting started survey doesn't already exist
    questionIds = new List<String>();
    try
    {
        testSurvey = [select Id, Name From Survey__c where Name='SurveyForce Sample Survey' LIMIT 1];
        testSurveyAvailable = true;
    }
    catch (Exception e)
    {
        testSurveyAvailable = false;
    }
    
}

public void makeTestSurvey()
{
    
    testSurvey = new Survey__c();
    testSurvey.Name = 'Execution Feed Back1';
    testSurvey.Submit_Response__c = 'empty'; 
    testSurvey.Survey_Container_CSS__c = '#survey_container{ margin: 0 auto; width: 600px; box-shadow: 0 0 14px #CCCCCC; -moz-box-shadow: 0 0 14px #CCCCCC; -webkit-box-shadow: 0 0 14px #CCCCCC; }';
    testSurvey.URL__c ='/apex/salesforce.com';
    testSurvey.thankYouText__c ='Thank_you';
    testSurvey.thankYouLink__c='http://www.salesforce.com';    
    insert testSurvey;
    
    questionIds.add(createQuestion(0));
    questionIds.add(createQuestion(1));
    questionIds.add(createQuestion(2));
    questionIds.add(createQuestion(3));
    
    createResponses();

    testSurveyAvailable = true;
    
}

public PageReference viewSurvey()
{
    return new PageReference('/Apex/SurveyManagerPage?id=' + testSurvey.Id);
}

public PageReference takeSurvey()
{
    return new PageReference('/Apex/TakeSurvey?id=' + testSurvey.Id + '&cId=none&caId=none');
}

public PageReference viewResults()
{
    ReportFinderUtil rfu = new ReportFinderUtil();
    String reportId = rfu.findReportId('Survey with Questions and Responses');  
    
    String surveyId = testSurvey.Id;
    surveyId = surveyId.substring(0,15);
    
    return new PageReference('/' + reportId + '?pv0=' + surveyId);
}

  private String createQuestion(Integer i){
    Survey_Question__c q = new Survey_Question__c();
    q.Name = 'Testing Question';
    q.Survey__c = testSurvey.Id;
    q.Type__c = getType(i);
    q.Choices__c = getChoices(i);
    q.Question__c = 'Testing Question question' + i;
    q.OrderNumber__c = i;
    q.Required__c = true;
    insert q;
    return q.id;        
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
  private String getChoices(Integer i){
    if (i == 0)
        return 'one\ntwo\nthree\n';
    if (i == 1)
        return 'four\nfive\nsix\n';
    if (i == 2)
        return 'seven\neight\nnine\n';

        
    return '';
  }  
  
  private void createResponses()
  {
  
    account a=new account();
    a.name='Mehulkumar Navinchandra';
    insert a; 
      
    Contact c = new Contact();
    try{
        c = [Select Id From Contact where Email=:'surveyForceAppUser@survey.force'];
    }
    catch (Exception e)
    {
    c.Contact_Type__c='First Applicant';
    c.LastName = 'Doe';
    c.FirstName = 'Jane'; 
    c.accountid=a.Id;
    c.Email = 'surveyForceAppUser@survey.force';
    insert c;       
    }
            opportunity opp=new opportunity ();
            opp.name='test';
            opp.AccountId=a.id; 
            opp.StageName='Site Visit';
            opp.CloseDate=System.now().date();
           // opp.Reserving_Date__c=System.now().date();
            opp.Execution_without_modification_Feed_back__c=true;
            insert opp; 
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
    
    SurveyTaker__c st = new SurveyTaker__c();
    st.Contact__c = c.Id;
    st.Opportunity__c=opp.Id;
    st.Survey__c = testSurvey.Id;
    //st.Taken__c = 'false';
    insert st;
    
    for (Integer i = 0; i < 4; i ++)
    {
        SurveyQuestionResponse__c r = new SurveyQuestionResponse__c();
        if (i == 0) {
            r.Response__c = 'two';
        } else if (i == 1) {
            r.Response__c = 'four';
        } else if (i == 2) {
            r.Response__c = 'nine';
        } else {
            r.Response__c = 'This is a response.';
        }
        Survey_Question__c sq = [Select id from Survey_Question__c where id=: questionIds[i] limit 1];
        r.Survey_Question__c = sq.id;
        r.SurveyTaker__c = st.Id;
        insert r;   
    }

  }
  
  private static testmethod void testGettingStarted()
  {
      List<Survey__c> surveys = [select Id, Name From Survey__c where Name='Execution Feed Back1'];
      GettingStartedController gsc = new GettingStartedController();
      if (surveys.size() >=1)
      {

        //System.assertEquals(true,gsc.testSurveyAvailable);

      }
      else
      {

        //System.assertEquals(false,gsc.testSurveyAvailable);

      }
      gsc.makeTestSurvey();
      gsc.takeSurvey();
      gsc.viewResults();
      gsc.viewSurvey();
      
      
      List<Survey__c> surveys2  = [select Id, Name From Survey__c where Name='Execution Feed Back1'];
      System.assertEquals(surveys.size() + 1, surveys2.size());
      System.assertEquals(true,gsc.testSurveyAvailable);
     
      
  }

}