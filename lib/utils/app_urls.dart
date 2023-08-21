class AppUrls { 
   
   static  var BASEURL = "http://mycropguruapiwow.cropguru.in/api/";  
  
  //Mobile OTP Base url
   static var MOBILEOTPLOGIN = BASEURL+"OTP_Mobile";   
  
    //Mobile  registration Base url
   static var Registration = BASEURL+"User_Registration";   
   
   // address user update
   static var UpdateRegistration = BASEURL+"User_Registration/1";   
   
   //Ftech data
   static var GetData = BASEURL+"Get_Data";  

  // lab Enquires From
  static var labEnquiries = BASEURL + '/LabEnquiries'; 
   
   
  static var MyPlot_URL = BASEURL + 'PlotList?&SALESTEAM_USER_ID='; 

  static var TYPE = BASEURL + '&TYPE=ALL'; 

 //question answer api key 

 static var QutionsAnsPostApi = BASEURL + '/QANDAAgronomist?';  
 //agronomistApi
 static var AgronomistID =  ' &TYPE=user&AGRONOMIST_ID=';   
 //plot ID
 static var PloatID =  ' &PLOT_ID=';  

 //FAQ Api  
   static var FaqDisease =  BASEURL+'/Question';
 
 //SUB Api  
  static var FaqSubDetails =  BASEURL+'Question?CAT_ID=';

  
 //Report Master Api
 static var ReportMaster=  BASEURL+'Report?'; 
 

 static var AddReportMaster=  BASEURL+'Report';

// Diary Api key 
 // 1)Expance Api 
  static var CategoryName=  BASEURL+'PurchaseCategory/1'; 

  // 1)ProductApi Api 
  static var ProductName=  BASEURL+'PurchaseProduct/1';

  //PlotInformation Api 
 static var PlotInformation=  BASEURL+'PlotInfo?'; 

 //Diary Detils Api 
 static var DiaryDetils =  BASEURL+'Diary?';  

 //AddDiary Detils Api 
 static var AddDiaryDetils =  BASEURL+'Diary';  

  //AddPlotList Api 
 static var AddPlotList =  BASEURL+'CropCatMaster';  


//Crop Variety List Api 
 static var CropVariety =  BASEURL+'GetChataniType'; 


}