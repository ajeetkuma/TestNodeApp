/**
 * Description : Test Class for SalesPerson_Sharing Class
  */
@isTest
private class Test_SalesPersonSharing {

    static testMethod void testCalculation() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Cosmopolis';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Lakefront';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Cosmopolis';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser1.id;
	            opData.Sales_Person_2__c	= salesUser2.id;
	            opData.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= null;
	            opData2.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= null;
	            opData3.Sales_Person_2__c	= salesUser1.id;
	            opData3.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
    static testMethod void testCalculation2() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Cosmopolis';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Lakefront';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Central'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Cosmopolis';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser1.id;
	            opData.Sales_Person_2__c	= salesUser2.id;
	            opData.Sales_Person_3__c	= salesUser3.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= salesUser3.id;
	            opData2.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser3.id;
	            opData3.Sales_Person_2__c	= salesUser1.id;
	            opData3.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
    static testMethod void testCalculation3() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Cosmopolis';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Lakefront';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Pinnacle'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Cosmopolis';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser1.id;
	            opData.Sales_Person_2__c	= salesUser2.id;
	            opData.Sales_Person_3__c	= salesUser3.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= salesUser3.id;
	            opData2.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser3.id;
	            opData3.Sales_Person_2__c	= salesUser1.id;
	            opData3.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
    static testMethod void testCalculation4() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Pinnacle'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Cosmopolis';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser1.id;
	            opData.Sales_Person_2__c	= salesUser2.id;
	            opData.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= null;
	            opData2.Sales_Person_2__c	= salesUser1.id;
	            opData2.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser1.id;
	            opData3.Sales_Person_2__c	= null;
	            opData3.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
        static testMethod void testCalculation5() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Pinnacle'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Cosmopolis';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser2.id;
	            opData.Sales_Person_2__c	= salesUser1.id;
	            opData.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= null;
	            opData2.Sales_Person_2__c	= salesUser2.id;
	            opData2.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser2.id;
	            opData3.Sales_Person_2__c	= null;
	            opData3.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
    static testMethod void testCalculation6() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Central'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Lakefront';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= null;
	            opData.Sales_Person_2__c	= salesUser1.id;
	            opData.Sales_Person_3__c	= salesUser3.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= null;
	            opData2.Sales_Person_3__c	= salesUser3.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser1.id;
	            opData3.Sales_Person_2__c	= salesUser3.id;
	            opData3.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
      static testMethod void testCalculation7() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Central'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Lakefront';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= null;
	            opData.Sales_Person_2__c	= salesUser3.id;
	            opData.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser3.id;
	            opData2.Sales_Person_2__c	= null;
	            opData2.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser3.id;
	            opData3.Sales_Person_2__c	= salesUser1.id;
	            opData3.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
    
     static testMethod void testCalculation8() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront1';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis1';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Central'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Lakefront2';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= null;
	            opData.Sales_Person_2__c	= null;
	            opData.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= null;
	            opData2.Sales_Person_3__c	= salesUser2.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
	            Opportunity opData3			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData3.Sales_Person_1__c	= salesUser3.id;
	            opData3.Sales_Person_2__c	= salesUser1.id;
	            opData3.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            
	            update opData3;
	            
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            opData2.Sales_Person_1__c	= null;
	            opData2.Sales_Person_2__c	= salesUser1.id;
	            opData2.Sales_Person_3__c	= salesUser2.id;	            
	            update opData3;
            
            Test.stopTest(); 
    	}
    	
    }
     static testMethod void testCalculation9() {
        
    	User testUser			= Utility_TestData.getTestUser();
    	insert testUser;
    	
    	system.runAs(testUser){
    		
    		Test.startTest();
    		
	    		User salesUser1			= Utility_TestData.getTestUser();
	    		salesUser1.UserName		= 'salesUser1ET@Brigade123.com';
	    		salesUser1.Team__c		= 'Lakefront1';    
	    		salesUser1.Project1__c	= 'Lakefront';
	    		insert salesUser1;
	    		
	    		User salesUser2			= Utility_TestData.getTestUser();
	    		salesUser2.UserName		= 'salesUser2ET@Brigade123.com';
	    		salesUser2.Team__c		= 'Cosmopolis';    
	    		salesUser2.Project1__c	= 'Cosmopolis1';
	    		insert salesUser2;
	    		
	    		User salesUser3			= Utility_TestData.getTestUser();
	    		salesUser3.UserName		= 'salesUser3ET@Brigade123.com';
	    		salesUser3.Team__c		= 'Central'; 
	    		insert salesUser3;
	    			    		
	    		Project__c objProject 	= new Project__c();
	    		objProject.Name			= 'Lakefront2';
	    		insert objProject;
	    		
	    		Plant__c objPlant       	= Utility_TestData.getPlant();
	    		objPlant.ProjectLookup__c 	= objProject.id;
	            insert objPlant;
	            
	            Unit__c objUnit			= Utility_TestData.getUnit(objPlant.id,2);
	            insert objUnit;
	            
	            Account objAcc			= Utility_TestData.getAccountData();
	            insert objAcc;
	            
	            Opportunity objOpp      = Utility_TestData.getOpportunity(objAcc.Id,objUnit.id,2);
	            insert objOpp;
	            
	           	Opportunity opData			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];
	            opData.Sales_Person_1__c	= salesUser2.id;
	            opData.Sales_Person_2__c	= null;
	            opData.Sales_Person_3__c	= salesUser1.id;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;
	            update opData;
	            
	            Opportunity opData2			= [select id,Sales_Person_1__c,Sales_Person_2__c,Sales_Person_3__c from Opportunity where Id=:objOpp.Id];	           
	            opData2.Sales_Person_1__c	= salesUser1.id;
	            opData2.Sales_Person_2__c	= salesUser2.id;
	            opData2.Sales_Person_3__c	= null;
	            Utility_Class.IS_OPP_TRIGGER_RUNNING    = false;	            	            
	            update opData2;
	            
            
            Test.stopTest(); 
    	}
    	
    }
}