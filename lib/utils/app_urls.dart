class AppUrls { 
   
   static  var BASEURL = "http://mycropguruapiwow.cropguru.in/api/";  

   static  var WATHERURL = "http://api.weatherapi.com/v1/forecast.json?";  
   
   static  var IMAGEURL = "http:"; 
  
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

 
//Product Details Api 
 static var ProductDetails =  BASEURL+'ProductList?PRODUCT_ID='; 

//Video catgeory Api 
 static var VideoCategory=  BASEURL+'GetVideoHome?';

//Video blog Api 
 static var blog =  BASEURL+'HomeScreenNews?'; 

 //Bannar blog Api 
 static var Bannar =  BASEURL+'Banner';

 //Mart Apis
  static var ShopForYourCrop =  BASEURL+'CropMaster'; 

  static var ShopByCategory =  BASEURL+'Category'; 

   //Bluk Order Apis
  static var BulikOrder =  BASEURL+'CropMaster';   

  //Bluk Order Apis
  static var Schedule =  BASEURL+'Schedule?'; 

  //ProductList
  static var Product =  BASEURL+'ProductList'; 


  //userFeedBack
  static var userFeedBack =  BASEURL+'UserFeedback';  

 //  ploat list
  static var Plot =  BASEURL+'PlotList?'; 

 //  Farmer purchase list
  static var purchase =  BASEURL+'FarmerPurchase/1';   


  // Pursches purchase list
  static var purchasecategory =  BASEURL+'PurchaseCategory/1';  

   // Product purchase list
  static var ProductCategory =  BASEURL+'PurchaseProduct/1';    


  // Unit  purchase list
  static var Unit =  BASEURL+'Get_DataPlotPurchase';  

  // Add  purchase list
  static var AddPurchase =  BASEURL+'FarmerPurchase';  

    // Unit Count  purchase list
  static var UnitCount =  BASEURL+'UserProductUnit';  


  // Add  Expenses post 
  static var Expance =  BASEURL+'FarmerPlotExpence';  

    // Total Expanse 
  static var TotalExpanse =  BASEURL+'FarmerPlotExpence/1';  

  // Total Expanse 
  static var TotalArea =  BASEURL+'UpdatePlotDetails?TYPE='; 



 


 
  


 

}