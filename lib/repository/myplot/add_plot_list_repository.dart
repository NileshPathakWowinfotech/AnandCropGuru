

import 'package:flutter_application_1/utils/app_urls.dart';

import '../../data/Model/MyPlotModel.dart/addplot_list_model.dart';
import '../../data/Model/MyPlotModel.dart/crop_variety_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class CropListRepository  {  

  BaseApiServices  _apiServices = NetworkApiService();

 //GET API
  Future<CropAddListModel> AddPlotListApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.AddPlotList, data); 
     return response = CropAddListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

  //Crop variety Get Api 

   //GET API
  Future<CropVarietyListModel> CropVarietyListApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.CropVariety, data); 
      print(response);
     return response = CropVarietyListModel.fromJson(response);
     
    }catch(e){
      throw e;
    }
  } 
}