

import '../../data/Model/MyPlotModel.dart/diarydetailslistmodel.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class DiaryDetailsRepository  {  

  BaseApiServices  _apiServices = NetworkApiService();

 //GET API
  Future<DiaryDetailsListModel> diaryDetailsListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 
     return response = DiaryDetailsListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }  
   
   //POST API
   Future<dynamic> addDetailsListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.AddDiaryDetils, data);
     return response;
    }catch(e){
      throw e;
    } 
  }

 

}