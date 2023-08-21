

 import 'package:flutter_application_1/utils/app_urls.dart';

import '../../data/Model/MyPlotModel.dart/faq_model.dart';
import '../../data/Model/MyPlotModel.dart/faq_sub_Model.dart';
import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class FaqRepository  {  
 BaseApiServices  _apiServices = NetworkApiService();

   //GET API
  Future<FaqModel> faqListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.FaqDisease, data); 
     return response = FaqModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
  

  //Sub List API
  Future<FaqSubListModel> faqSubListApi(dynamic data,catId)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.FaqSubDetails+catId, data); 
     return response = FaqSubListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

  
}