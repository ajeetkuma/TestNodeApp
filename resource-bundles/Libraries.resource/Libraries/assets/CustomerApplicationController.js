		var filename='';
		//====================================================================================
		var app = angular.module("app", ['angularFileUpload']);
        app.factory('NumaanFactory', ['$q', '$log', function($q, $log){
		var service={};
		
		service.removeAngularjsKey = function(targetData) {

			   var toJson = angular.toJson(targetData);
			   var fromJson = angular.fromJson(toJson);
			  
			   return fromJson;

			}
			
			service.intialize = function(con){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.Intialize(function(result, event) {

                if (event.status) {
                	console.log(event);
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      
			service.saveContact = function(opp,oppRec,acc,con,dateFields,genralPowerofAttorney,afcrec,listAttIds,CountryAndStateslst){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.saveContacts(opp,oppRec,acc,con,dateFields,genralPowerofAttorney,afcrec,listAttIds,CountryAndStateslst,function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                	
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.saveAttachment = function(opp,acc){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.saveAttachments(opp,acc,function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                	
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.deleteAttachment = function(att){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.deleteAttachments(att,function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                	
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchIndustryTypes = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchIndustryType(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  

                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.getImagee= function(t) {
             var defer = $q.defer();
		        
	            debugger;
	           	var checkPhoto='';
	            var reader = new FileReader();
	            var attachFile='';
	            attachFile = document.getElementById(t.id);
	            
	            
	            var filenamee=document.getElementById(t.id).files[0].name;
	            if(document.getElementById(t.id).files[0].size>=1000000){
	            	document.getElementById(t.id).value = "";
	            	alertify.alert('size cant be more than 1 MB');
	            	return;
	            }
	            if(t.id=='finalAttacment'){
	            	var afterDot = filenamee.substr(filenamee.indexOf('.'));
	            	filename='Application Form'+afterDot+'qwerty';
	            }
	            else
	            filename=filenamee+'qwerty';
	            
	            reader.onload = function(e) {
	                console.log('get me printed');
	                console.log(e);/*document.getElementById(t.id).files[0].name+'qwerty'+*/
	                 defer.resolve(filename+e.target.result);
				}
            
            	reader.readAsDataURL(attachFile.files[0]);
			 
		        return defer.promise;
		    
            
        }
			service.fetchCarParking = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchCarParkingType(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  

                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchSalutationType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchSalutation(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchresidencyType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchResidencyStatus(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchRelationType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchRelationTypes(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchPaymentsType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchPaymentTypes(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetch_CH_PaymentsType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetch_CH_PaymentTypes(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchFinancesType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchFinanceTypes(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchBuyingPurposeType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchBuyingPurpose(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchLeadSourceType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchLeadSource(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchRefferedByType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchRefferedBy(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
	      service.fetchChannelPartnerType = function(){

	         var defer = $q.defer();
	         
	         CustomerApplicationController.fetchChannelPartner(function(result, event) {

                if (event.status) {
                	
                    defer.resolve(result);
                       
                } else {
                    $log.error(event.message);
     				defer.reject(event.message);
                  
                }
	         },{ buffer: true, escape: true} );  
	         return defer.promise;
	      }
		return service;
	}]);    
            
    app.controller('Controller',['$filter','$scope','$timeout','$q','NumaanFactory','FileUploader', function($filter,$scope,$timeout,$q,NumaanFactory,FileUploader) {
        
	    alertify.defaults = {
	        autoReset:true,
	        basic:false,
	        closable:true,
	        closableByDimmer:true,
	        frameless:false,
	        maintainFocus:true, // <== global default not per instance, applies to all dialogs
	        maximizable:true,
	        modal:true,
	        movable:true,
	        moveBounded:false,
	        overflow:true,
	        padding: true,
	        pinnable:true,
	        pinned:true,
	        preventBodyShift:false, // <== global default not per instance, applies to all dialogs
	        resizable:true,
	        startMaximized:false,
	        transition:'pulse',

	        notifier:{
	            delay:5,
	            position:'bottom-right'
	        },

	        glossary:{
	            title:'',
	            ok: 'OK',
	            cancel: 'Cancel'            
	        },
			theme:{
	            input:'ajs-input',
	            ok:'ajs-ok',
	            cancel:'ajs-cancel'
	        }
	    };
	    $scope.StateList=[];
	    $scope.StateList2=[];
	    $scope.changestate =function(con){
        	var tempState=[];
        	angular.forEach(sometext.SubCategoreyToCategorey,function(key,value){
        	
        	
	        	if(value==con){
	        		angular.forEach(key,function(key1,value1){
						//alert(key1);
						tempState.push(key1);
					});
					
	        	}
			});
			$scope.StateList=tempState;
			//$scope.State1=$scope.StateList[0];
        }
        $scope.changestate2 =function(con){
        	var tempState=[];
        	angular.forEach(sometext.SubCategoreyToCategorey,function(key,value){
        	
        	
	        	if(value==con){
	        		angular.forEach(key,function(key1,value1){
						//alert(key1);
						tempState.push(key1);
					});
					
	        	}
			});
			$scope.StateList2=tempState;
			//$scope.State2=$scope.StateList[0];
        }

	    $scope.CountryAndStates=['','','',''];

	    $scope.Account=sometext.Acc;

	    $scope.State1='';
		$scope.State2='';
		$scope.Country1='';
		$scope.Country2='';

		debugger;
		if($scope.Account.CountryL__r != undefined)
	    $scope.Country1=$scope.Account.CountryL__r.Name;
	    if($scope.Country1 != '')
	    $scope.changestate($scope.Country1);
		if($scope.Account.RegionL__r != undefined)
	    $scope.State1=$scope.Account.RegionL__r.Name;
		if($scope.Account.A_Country__r != undefined)
	    $scope.Country2=$scope.Account.A_Country__r.Name;
	    if($scope.Country2 != '')
	    $scope.changestate2($scope.Country2);
		if($scope.Account.A_Region__r != undefined)
		$scope.State2=$scope.Account.A_Region__r.Name;
		
		

		

        $scope.todayy = $filter('date')(new Date(), 'dd/MM/yyyy');
		$scope.GenralPowerOfAttorneyy=sometext.genralPowerofAttorney;
		$scope.contactResponse='';
		$scope.AttachmentIds=['','','','','','','','','','','',''];
		$scope.CarParkCharges=sometext.carParkValue;
		$scope.otpResult='fail';
		$scope.showOTP=false;
		$scope.formats = ['yyyy-MM-dd', 'yyyy/MM/dd', 'dd-MM-yyyy', 'shortDate'];
  		$scope.format = $scope.formats[2];
  		$scope.OppDateFields=sometext.OppDateFields;
  		$scope.isOtpGenrated=sometext.isOtpGenrated;
		var name="5555";
  		$scope.ProjectHead=sometext.isprojectHeadExist;
		$scope.Contact=sometext.contacts;
		$scope.FloorDescription=sometext.floorDescription;
		$scope.Opportunity=sometext.opport;

		$scope.ChannelPartner=sometext.ChannelPartner;
		$scope.RefferedBy=sometext.RefferedBy;
		
		$scope.Application_Form__c=sometext.AppForm;

		$scope.Application_Form__c.Project__c=sometext.projectName;
		$scope.Application_Form__c.Plant__c=sometext.plantName;
		$scope.Application_Form__c.Unit__c=sometext.unitName;
		if($scope.Contact[0] != undefined)
		$scope.Application_Form__c.Contact_Name__c=$scope.Contact[0].Name;
		$scope.Plant__c=sometext.plant;
		$scope.Unit__c=sometext.unit;
		$scope.Application_Form__c.Garden_Area_Price__c=$scope.Unit__c.Garden_Area_Price__c;
		$scope.Application_Form__c.Garden_Area__c=$scope.Unit__c.Garden_Area__c;
		$scope.Application_Form__c.Terrace_Area__c=$scope.Unit__c.Terrace_Area__c;
		$scope.Application_Form__c.Terrace_Area_Price__c=$scope.Unit__c.Terrace_Area_Price__c;
		$scope.Application_Form__c.AGREEMENT_VALUE__c=$scope.Opportunity.For_ROI__c;
		if($scope.Contact[0] != undefined)
		$scope.ContactId = $scope.Contact[0].Id;
		$scope.SubmitStatus=(sometext.AppForm.Application_Status__c != undefined) ? sometext.AppForm.Application_Status__c : 'default';
		$scope.ExistingLeadSource=$scope.Opportunity.Lead_Source__c;
		console.log('sometext');
		console.log(sometext);
		
		$scope.DateFields=sometext.DateFields;
		console.log('$scope.DateFields');
		console.log($scope.DateFields);
		$scope.name="Ajeet";
		$scope.refferal='';
		$scope.CarParkTypes=[];
		$scope.SalutationTypes=[];
		$scope.selectedCarParkingType='';
		$scope.ResidencyTypes='';  
		$scope.RelationTypes='';
		$scope.PaymentTypes=''; 
		$scope.CH_PaymentTypes='';
		$scope.FinanceTypes=''; 
		$scope.BuyingPurposeType='';
		$scope.ProjectTypes=[];
		$scope.PlantTypes=[];
		if(sometext.opport.No_of_Car_Park_S__c <= 0)
		$scope.Opportunity.No_of_Car_Park_S__c=0;
		$scope.Opportunity.Car_park_reservation_Charges__c=0;
		$scope.Application_Form__c.Project__c=sometext.projectName;
		$scope.Application_Form__c.Plant__c=sometext.plantName;
		$scope.Application_Form__c.Unit__c=sometext.unitName;

		$scope.ContactOnePhoto='';
        $scope.ContactTwoPhoto='';
        $scope.ContactThreePhoto='';
        $scope.ContactOnePan='';
        $scope.ContactTwoPan='';
        $scope.ContactthreePan='';

        $scope.ForeignPhoto='';
        $scope.NriPhoto='';
        $scope.PowerOfAttornePhoto='';
        $scope.BuisnessCardPhoto='';
        $scope.PermanentAddressPhoto='';
        $scope.CorrespondenceAddressPhoto='';

        $scope.FinalAttachment='';
        //========================================================================================
        var tempCountry=[];
        angular.forEach(sometext.SubCategoreyToCategorey,function(key,value){
        	tempCountry.push(value);
			/*angular.forEach(key,function(key1,value1){
			alert(key1);});*/
		});
		$scope.CountryList=[];
		
		$scope.CountryList=tempCountry;
		//$scope.Country1=$scope.CountryList[0];
		//$scope.Country2=$scope.CountryList[0];
        //========================================================================================
        
        //$scope.changestate($scope.CountryList[0]);
        //$scope.changestate2($scope.CountryList[0]);
        {
			var temp=[];
			angular.forEach($scope.DateFields, function(value, key){
						
						console.log('va');
						console.log(value);
						value = (value=='') ? null:new Date(value);
						temp.push(value);
						/*if(value != '' && value != null)
						{value=new Date(value);
												temp.push(value);}else{
													value=null;
												}*/

	        });
	        $scope.DateFields=temp;
		}
		console.log('DateFields@@@@@@2');
		console.log($scope.DateFields);

        $scope.check = function(t){
        	if(t.id=='finalAttacment'){
                NumaanFactory.getImagee(t).then(function(response){
                	$scope.FinalAttachment=response;

                },function(error){

                });
                
            }
            if(t.id=='contactonephoto'){
                NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactOnePhoto=response;

                },function(error){

                });
                
            }
            if(t.id=='contacttwophoto'){
               // $scope.ContactTwoPhoto=$scope.getImagee(t);
                NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactTwoPhoto=response;

                },function(error){

                });
                
            }
            if(t.id=='contactthreephoto'){
                //$scope.ContactThreePhoto=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactThreePhoto=response;

                },function(error){

                });
                
            }
            if(t.id=='contactonepan'){
                //$scope.ContactOnePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactOnePan=response;

                },function(error){

                });
                
            }
            if(t.id=='contacttwopan'){
               // $scope.ContactTwoPan=$scope.getImagee(t);
                NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactTwoPan=response;

                },function(error){

                });
                
            }
            if(t.id=='contactthreepan'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.ContactthreePan=response;

                },function(error){

                });
                
    		}

    		if(t.id=='correspondenceaddressphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.CorrespondenceAddressPhoto=response;

                },function(error){

                });
                
    		}
    		if(t.id=='permanentaddressphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.PermanentAddressPhoto=response;

                },function(error){

                });
                
    		}
    		if(t.id=='buisnesscardphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.BuisnessCardPhoto=response;

                },function(error){

                });
                
    		}
    		if(t.id=='powerofattorneyphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.PowerOfAttornePhoto=response;

                },function(error){

                });
                
    		}
    		if(t.id=='nriphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.NriPhoto=response;

                },function(error){

                });
                
    		}
    		if(t.id=='foreignphoto'){
                //$scope.ContactthreePan=$scope.getImagee(t);
                 NumaanFactory.getImagee(t).then(function(response){
                	$scope.ForeignPhoto=response;

                },function(error){

                });
                
    		}
            
        }
           
    	$scope.getImageDyanmically=function (t){
            

        }
        $scope.startUpload =function(t){
        	debugger;
        	if(t.target.id=='finalAttacmentupload'){
                //alert('contactonephotoupload')
                if($scope.FinalAttachment !='')
                $scope.call($scope.FinalAttachment,'finalAttacmentDelete');
            	else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            if(t.target.id=='contactonephotoupload'){
                //alert('contactonephotoupload')
                if($scope.ContactOnePhoto !='')
                $scope.call($scope.ContactOnePhoto,'contactonephotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='contacttwophotoupload'){
                //alert('contacttwophotoupload')
                if($scope.ContactTwoPhoto !='')
                $scope.call($scope.ContactTwoPhoto,'contacttwophotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='contactthreephotoupload'){
                //alert('contactthreephotoupload')
                if($scope.ContactThreePhoto !='')
                $scope.call($scope.ContactThreePhoto,'contactthreephotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='contactonepanupload'){
                //alert('contactonepanupload')
                if($scope.ContactOnePan !='')
                $scope.call($scope.ContactOnePan,'contactonepanDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='contacttwopanupload'){
                //alert('contacttwopanupload')
                if($scope.ContactTwoPan !='')
                $scope.call($scope.ContactTwoPan,'contacttwopanDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='contactthreepanupload'){
                //alert('contactthreepanupload')
                if($scope.ContactthreePan !='')
                $scope.call($scope.ContactthreePan,'contactthreepanDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='correspondenceaddressphotoupload'){
                //alert('contactthreepanupload')
                if($scope.CorrespondenceAddressPhoto !='')
                $scope.call($scope.CorrespondenceAddressPhoto,'correspondenceaddressphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='permanentaddressphotoupload'){
                //alert('contactthreepanupload')
                if($scope.PermanentAddressPhoto !='')
                $scope.call($scope.PermanentAddressPhoto,'permanentaddressphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='buisnesscardphotoupload'){
                //alert('contactthreepanupload')
                if($scope.BuisnessCardPhoto !='')
                $scope.call($scope.BuisnessCardPhoto,'buisnesscardphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='powerofattorneyphotoupload'){
                //alert('contactthreepanupload')
                if($scope.PowerOfAttornePhoto !='')
                $scope.call($scope.PowerOfAttornePhoto,'powerofattorneyphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='nriphotoupload'){
                //alert('contactthreepanupload')
                if($scope.NriPhoto !='')
                $scope.call($scope.NriPhoto,'nriphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else if(t.target.id=='foreignphotoupload'){
                //alert('contactthreepanupload')
                if($scope.ForeignPhoto !='')
                $scope.call($scope.ForeignPhoto,'foreignphotoDelete');
                else
            	alertify.alert('Error:Chosen file is of 0 Byte')
            }
            else{
            	return;
            }
        }
        $scope.checkPhoto='';
        $scope.attachFile='';
        
        $scope.adddeletionAttribute='';
        $scope.call= function(t,deletionid){
            console.log(opp);
            console.log(t);
            $scope.adddeletionAttribute='';
            NumaanFactory.saveAttachment(opp,t).then(function(response){
            	debugger;
                	console.log(response);
                	//document.getElementById(deletionid).setAttribute("id", deletionid+'deleteit'+response);
                	$scope.adddeletionAttribute=response;
                	alertify.alert('Attachment has been uploaded');
                },function(error){

            });
            $timeout(function () {
            	debugger;

            	document.getElementById(deletionid).style.display = "inline-block";
		        document.getElementById(deletionid).setAttribute("id", deletionid+'deleteit'+$scope.adddeletionAttribute);
		     	if(deletionid=='contactonephotoDelete'){
                	$scope.AttachmentIds[0]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='contacttwophotoDelete'){
	                $scope.AttachmentIds[1]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='contactthreephotoDelete'){
	                $scope.AttachmentIds[2]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='contactonepanDelete'){
	                $scope.AttachmentIds[3]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='contacttwopanDelete'){
	                $scope.AttachmentIds[4]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='contactthreepanDelete'){
	                $scope.AttachmentIds[5]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='correspondenceaddressphotoDelete'){
	                $scope.AttachmentIds[6]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='permanentaddressphotoDelete'){
	                $scope.AttachmentIds[7]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='buisnesscardphotoDelete'){
	                $scope.AttachmentIds[8]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='powerofattorneyphotoDelete'){
	                $scope.AttachmentIds[9]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='nriphotoDelete'){
	                $scope.AttachmentIds[10]=$scope.adddeletionAttribute;
	            }
	            else if(deletionid=='foreignphotoDelete'){
	                $scope.AttachmentIds[11]=$scope.adddeletionAttribute;
	            }
	            else{
	            	
	            }

		    }, 3000);
            
        }
        $scope.cancel=function(ev){
        	debugger;
        	$scope.attId='';
        	var x=ev.target.id;
        	var y=x.split('deleteit');
        	var z=y[1];
        	NumaanFactory.deleteAttachment(z).then(function(response){
                	console.log(response);
                	if(response=='sucess'){
                		alertify.alert('Attachment has been deleted');
                	}
                	//document.getElementById(deletionid).setAttribute("id", deletionid+'deleteit'+deletionid);
                },function(error){
                	alertify.alert(error);
            });
            $timeout(function () {
            	document.getElementById(ev.target.id).style.display = "none";
		        document.getElementById(ev.target.id).setAttribute("id", y[0]);
		        var deleteid=y[0];
		        var inputidsplit=deleteid.split('Delete');
		        var inputId=inputidsplit[0];
		        document.getElementById(inputId).value = "";
		        
		        if(inputId=='finalAttacment'){
                //alert('contactonephotoupload')
	                $scope.FinalAttachment ='';
	                
	            }
	            else if(inputId=='contactonephoto'){
	                //alert('contactonephotoupload')
	                $scope.ContactOnePhoto ='';
	               
	            }
	            else if(inputId=='contacttwophoto'){
	                //alert('contacttwophotoupload')
	                $scope.ContactTwoPhoto !=''
	                
	            }
	            else if(inputId=='contactthreephoto'){
	                //alert('contactthreephotoupload')
	                $scope.ContactThreePhoto ='';
	               
	            }
	            else if(inputId=='contactonepan'){
	                //alert('contactonepanupload')
	                $scope.ContactOnePan ='';
	                
	            }
	            else if(inputId=='contacttwopan'){
	                //alert('contacttwopanupload')
	                $scope.ContactTwoPan ='';
	               
	            }
	            else if(inputId=='contactthreepan'){
	                //alert('contactthreepanupload')
	                $scope.ContactthreePan ='';
	                
	            }
	            else if(inputId=='correspondenceaddressphoto'){
	                //alert('contactthreepanupload')
	                $scope.CorrespondenceAddressPhoto ='';
	               
	            }
	            else if(inputId=='permanentaddressphoto'){
	                //alert('contactthreepanupload')
	                $scope.PermanentAddressPhoto ='';
	                
	            }
	            else if(inputId=='buisnesscardphoto'){
	                //alert('contactthreepanupload')
	                $scope.BuisnessCardPhoto ='';
	                
	            }
	            else if(inputId=='powerofattorneyphoto'){
	                //alert('contactthreepanupload')
	                $scope.PowerOfAttornePhoto ='';
	                
	            }
	            else if(inputId=='nriphoto'){
	                //alert('contactthreepanupload')
	                $scope.NriPhoto ='';
	                
	            }
	            else if(inputId=='foreignphoto'){
	                //alert('contactthreepanupload')
	                $scope.ForeignPhoto ='';
	                
	            }
	            else{
	            	return;
	            }
		    }, 3000);
        }

		NumaanFactory.fetchIndustryTypes().then(function(response){

		   $scope.IndustryTypes = response;
			},
		  function(error){

		});
		
		
		NumaanFactory.fetchSalutationType().then(function(response){

		   $scope.SalutationTypes = response;
		   $scope.SalutationTypes.remove('Lt Col.');
		   
		  },
		  function(error){

		});
		NumaanFactory.fetchresidencyType().then(function(response){

		   $scope.ResidencyTypes = response;
		   
		  },
		  function(error){

		});
		NumaanFactory.fetchRelationType().then(function(response){

		   $scope.RelationTypes = response;
		   
		  },
		  function(error){

		});

		$scope.ChangeAddress = function(){
			if($scope.Account.Same_as_Correspondence_Address__c == true){
				$scope.Account.A_Street_1__c	=$scope.Account.Street1__c;
				$scope.Account.A_Street_2__c	=$scope.Account.Street2__c;
				$scope.Account.A_Street_3__c	=$scope.Account.Street3__c;
				$scope.Account.A_City__c		=$scope.Account.City__c;
				$scope.Account.A_Postal_Code__c	=$scope.Account.Postal_Code__c;
				$scope.Account.A_District__c	=$scope.Account.District__c;
				$scope.Account.A_MobilePhone__c	=$scope.Account.MobilePhone__c;
			}else{
				$scope.Account.A_Street_1__c	='';
				$scope.Account.A_Street_2__c	='';
				$scope.Account.A_Street_3__c	='';
				$scope.Account.A_City__c		='';
				$scope.Account.A_Postal_Code__c	='';
				$scope.Account.A_District__c	='';
				$scope.Account.A_MobilePhone__c	='';
			}
		}
		
		var errorMsg = 'aaaaaaaaaaa'; 

		$scope.validateFormDetails = function() {
            
            
			/*if($scope.ContactForm0.dob0.$error.required) {
            errorMsg='DOB of First Applicant mandatory';return false;
        	}*/if($scope.ContactForm0.pan0.$error.required) {
            errorMsg='Pan No. of first applicant is mandatory.';return false;
        	}if($scope.ContactForm0.email0 != '' || $scope.ContactForm0.email0 != undefined) {
        		if($scope.ContactForm0.email0.$error.pattern){
        			errorMsg='Enter Valid Email for of first applicant';return false;
        		}
            }if($scope.ContactForm0.Phone0 !='' || $scope.ContactForm0.Phone0 != undefined) {
            	if($scope.ContactForm0.Phone0.$error.pattern){
            		errorMsg='Phone number of first applicant must be of 10 digits.';return false;
            	}
            	if($scope.ContactForm0.Phone0.$error.minlength  || $scope.ContactForm0.Phone0.$error.maxlength){
            		errorMsg='Phone number of first applicant must be of 10 digits.';return false;
            	}

        	}if($scope.ContactForm0.residencestatus.$error.required) {
            errorMsg='Residence status of first applicant is mandatory.';return false;
        	}
        	if($scope.ContactForm0.Nationality0.$error.required) {
            errorMsg='Nationality of first applicant is mandatory.';return false;
        	}
        	if($scope.Contact[1] != undefined){
        		if($scope.ContactForm1.dob1.$error.required) {
	            	errorMsg='DOB of  second applicant is mandatory';return false;
	        	}if($scope.ContactForm1.pan1.$error.required) {
	            	errorMsg='Pan No. of second applicant is mandatory.';return false;
	        	}if($scope.ContactForm1.email1 != '' || $scope.ContactForm1.email1 != undefined) {
        		if($scope.ContactForm1.email1.$error.pattern){
        			errorMsg='Enter Valid Email for second applicant';return false;
        		}
            	}if($scope.ContactForm1.Phone1 !='' || $scope.ContactForm1.Phone1 != undefined) {
            	if($scope.ContactForm1.Phone1.$error.pattern){
            		errorMsg='Phone number of second applicant must be of 10 digits.';return false;
            	}
            	if($scope.ContactForm1.Phone1.$error.minlength  || $scope.ContactForm1.Phone1.$error.maxlength){
            		errorMsg='Phone number of second applicant must be of 10 digits.';return false;
            	}
        		}
        		if($scope.ContactForm1.residencestatus.$error.required) {
	            errorMsg='Residence status of second applicant is mandatory.';return false;
	        	}
        		if($scope.ContactForm1.Nationality1.$error.required) {
	            	errorMsg='Nationality of second applicant is mandatory.';return false;
	        	}
        	}
        	if($scope.Contact[2] != undefined){
        		
	        	if($scope.ContactForm.dob2.$error.required) {
	            errorMsg='DOB  of third applicant is mandatory';return false;
	        	}if($scope.ContactForm.pan2.$error.required) {
	            errorMsg='Pan No. of third applicant is mandatory.';return false;
	        	}if($scope.ContactForm.email2 != '' || $scope.ContactForm.email2 != undefined) {
        		if($scope.ContactForm.email2.$error.pattern){
        			errorMsg='Enter Valid Email for of third applicant';return false;
        		}
            	}if($scope.ContactForm.Phone2 !='' || $scope.ContactForm.Phone2 != undefined) {
            	if($scope.ContactForm.Phone2.$error.pattern){
            		errorMsg='Phone number of of third applicant must be of 10 digits.';return false;
            	}
            	if($scope.ContactForm.Phone2.$error.minlength  || $scope.ContactForm.Phone2.$error.maxlength){
            		errorMsg='Phone number of third applicant must be of 10 digits.';return false;
            	}
        		}
        		if($scope.ContactForm.residencestatus.$error.required) {
	            errorMsg='Residence status of thirs applicant is mandatory.';return false;
	        	}
        		if($scope.ContactForm.Nationality2.$error.required) {
	            errorMsg='Nationality of third applicant is mandatory.';return false;
	        	}

        	}
        	
        	if($scope.CorrespondenceAddressDetails.pin !='' || $scope.CorrespondenceAddressDetails.pin != undefined){
        		if($scope.CorrespondenceAddressDetails.pin.$error.pattern) {
	            errorMsg='Postal Code / Pin must be of 6 digits.';
	            return false;
        		}
        	}
        	if($scope.CorrespondenceAddressDetails.Phone !='' || $scope.CorrespondenceAddressDetails.Phone != undefined){
        		if($scope.CorrespondenceAddressDetails.Phone.$error.pattern) {
	            errorMsg='Correspondence Address Phone must be of 10 digits';
	            return false;
        		}
        		if($scope.CorrespondenceAddressDetails.Phone.$error.minlength || $scope.CorrespondenceAddressDetails.Phone.$error.maxlength) {
	            errorMsg=' Correspondence Address Phone must be of 10 digits';
	            return false;
        		}
        	}
        	if($scope.ParmanentAddressDetails.pin !='' || $scope.ParmanentAddressDetails.pin != undefined){
        		if($scope.ParmanentAddressDetails.pin.$error.pattern) {
	            errorMsg='Postal Code / Pin must be of 6 digits.';
	            return false;
        		}
        	}
        	if($scope.ParmanentAddressDetails.Phone != '' || $scope.ParmanentAddressDetails.Phone != undefined){
        		if($scope.ParmanentAddressDetails.Phone.$error.pattern) {
	            errorMsg='Parmanent Address Phone number must be of 10 digits';
	            return false;
        		}
        		if($scope.ParmanentAddressDetails.Phone.$error.minlength || $scope.ParmanentAddressDetails.Phone.$error.maxlength) {
	            errorMsg='Parmanent Address Phone number must be of 10 digits';
	            return false;
        		}
        	}
        	if( $scope.GenralPowerOfAttorney.pin != '' || $scope.GenralPowerOfAttorney.pin != undefined){
        		if($scope.GenralPowerOfAttorney.pin.$error.pattern) {
	            errorMsg='Postal Code / Pin must be of 6 digits.';
	            return false;
        		}
        	}
        	if($scope.GenralPowerOfAttorney.email !='' || $scope.GenralPowerOfAttorney.email != undefined){
        		if($scope.GenralPowerOfAttorney.email.$error.pattern) {
	            errorMsg='Enter a valid Email.';
	            return false;
        		}
        	}
        	if($scope.GenralPowerOfAttorney.Phone !='' || $scope.GenralPowerOfAttorney.Phone !=undefined){
        		if($scope.GenralPowerOfAttorney.Phone.$error.pattern) {
	            errorMsg='Genral Power Of Attorney Phone number must be of 10 digits.';
	            return false;
        		}
        		if($scope.GenralPowerOfAttorney.Phone.$error.minlength || $scope.GenralPowerOfAttorney.Phone.$error.maxlength) {
	            errorMsg='Genral Power Of Attorney  Phone number must be of 10 digits';
	            return false;
        		}
        	}
        	debugger;
        	if($scope.Contact[0] != undefined) {
        		if(document.getElementById('contactonephotoDelete'))
	            {errorMsg='Contact one Photo is mandatory.';return false;}
	        	if(document.getElementById('contactonepanDelete'))
	            {errorMsg='Contact one pan is mandatory.';return false;}
	        }
	        if($scope.Contact[1] != undefined) {
        		if(document.getElementById('contacttwophotoDelete'))
	            {errorMsg='Contact two Photo is mandatory.';return false;}
	        	if(document.getElementById('contacttwopanDelete'))
	            {errorMsg='Contact two pan is mandatory.';return false;}
	        }
	        if($scope.Contact[2] != undefined) {
        		if(document.getElementById('contactthreephotoDelete'))
	            {errorMsg='Contact three Photo is mandatory.';return false;}
	        	if(document.getElementById('contactthreepanDelete'))
	            {errorMsg='Contact three pan is mandatory.';return false;}
	        }
        	if(document.getElementById('correspondenceaddressphotoDelete')){
        		errorMsg='Correspondence address proof is mandatory.';return false;
        	}
        	if(document.getElementById('permanentaddressphotoDelete')){
        		errorMsg='Permanent address proof is mandatory.';return false;
        	}
        	if(document.getElementById('buisnesscardphotoDelete')){
        		errorMsg='Buisness address proof is mandatory.';return false;
        	}
        	if(document.getElementById('powerofattorneyphotoDelete')){
        		errorMsg='Power of Attorney address proof is mandatory.';return false;
        	}
        	if(document.getElementById('nriphotoDelete')){
        		errorMsg='NRI address proof is mandatory.';return false;
        	}
        	if(document.getElementById('foreignphotoDelete')){
        		errorMsg='Foreign address proof is mandatory.';return false;
        	}

        		console.log('nooooooooooooooo errorrrrrrrrrrrrr');
        		return true;
        	
        	
            }
            $scope.Save = function(boolflag){

	            debugger;
	            $scope.Contact=NumaanFactory.removeAngularjsKey($scope.Contact);
				$scope.GenralPowerOfAttorneyy=NumaanFactory.removeAngularjsKey($scope.GenralPowerOfAttorneyy);
				
				delete $scope.Opportunity["attributes"];
				if($scope.Opportunity.Offer_Selected__r != undefined)
				delete $scope.Opportunity.Offer_Selected__r["attributes"];
				
				if($scope.Opportunity.Plant2__r != undefined)
				delete $scope.Opportunity.Plant2__r["attributes"];
				if($scope.Opportunity.Plant2__r.ProjectLookup__r != undefined)
				delete $scope.Opportunity.Plant2__r.ProjectLookup__r["attributes"];
				if($scope.Opportunity.Plant2__r.Project_Head__r != undefined)
				delete $scope.Opportunity.Plant2__r.Project_Head__r["attributes"];
				if($scope.Opportunity.Referred_by_Name2__r!= undefined)
				delete $scope.Opportunity.Referred_by_Name2__r["attributes"];
				if($scope.Opportunity.Unit__r!= undefined)
				delete $scope.Opportunity.Unit__r["attributes"];
				if($scope.Opportunity.Channel_Partner__r!= undefined)
				delete $scope.Opportunity.Channel_Partner__r["attributes"];

				if($scope.Account != undefined)
				delete $scope.Account["attributes"];
				
				if($scope.Account.CountryL__r != undefined)
				delete $scope.Account.CountryL__r["attributes"];

				if($scope.Account.RegionL__r != undefined)
				delete $scope.Account.RegionL__r["attributes"];

				if($scope.Account.A_Country__r != undefined)
				delete $scope.Account.A_Country__r["attributes"];

				if($scope.Account.A_Region__r != undefined)
				delete $scope.Account.CounA_Region__rtryL__r["attributes"];


				if($scope.GenralPowerOfAttorneyy != undefined)
				delete $scope.GenralPowerOfAttorneyy["attributes"];
				if($scope.Application_Form__c != undefined)
				delete $scope.Application_Form__c["attributes"];
				if($scope.Contact[0] != undefined)
				delete $scope.Contact[0]["attributes"];
				if($scope.Contact[1] != undefined)
				delete $scope.Contact[1]["attributes"];
				if($scope.Contact[2] != undefined)
				delete $scope.Contact[2]["attributes"];

				$scope.CountryAndStates[0]=$scope.State1;
				$scope.CountryAndStates[1]=$scope.State2;
				$scope.CountryAndStates[2]=$scope.Country1;
				$scope.CountryAndStates[3]=$scope.Country2;

				if($scope.DateFields.length !=6){
						$scope.DateFields[5]=undefined;
					}
					for (var i = 0;i < 6; i++) {
						if($scope.DateFields[i] >= new Date()){
							if(i==0){
								alertify.alert('First Applicant DOB cant be today or future date');
								return;
							}
							else if(i==1){
								alertify.alert('First Applicant Wedding Date cant be today or future date');
								return;
							}
							else if(i==2){
								alertify.alert('Second Applicant DOB cant be today or future date');
								return;
							}
							else if(i==3){
								alertify.alert('Second Applicant Wedding Date cant be today or future date');
								return;
							}
							else if(i==4){
								alertify.alert('Third Applicant DOB cant be today or future date');
								return;
							}
							else if(i==5){
								alertify.alert('Third Applicant Wedding Date cant be today or future date');
								return;
							}else{

							}
						
						}
						if($scope.DateFields[i] == undefined){
							$scope.DateFields[i]='';
						}
						debugger;
					}
				if($scope.validateFormDetails()){ 
					console.log('inside save if')  ;
					console.log('success')  ;
				
					
					NumaanFactory.saveContact(opp,$scope.Opportunity,$scope.Account,$scope.Contact,$scope.DateFields,$scope.GenralPowerOfAttorneyy,$scope.Application_Form__c,$scope.AttachmentIds,$scope.CountryAndStates).then(function(response){


					   console.log(response);
					   if( response == 'sucess'){
					   	alertify.alert('Your request has been saved sucessfully');
					   	$scope.contactResponse='sucess';
					   	//$scope.cancle();
					   }else{
						   alertify.alert(response);
					   }
					   
					  },
					  function(error){
					  alertify.alert('Some Error occured ! Try Again' +error);
					  //$scope.cancle();
					});

				}else{
							console.log('inside save else')  ;
	                       
	                        alertify.alert('Error :' +errorMsg);
	            }
		}

		$scope.DownloadPdf = function(){

		}




 }]);
						