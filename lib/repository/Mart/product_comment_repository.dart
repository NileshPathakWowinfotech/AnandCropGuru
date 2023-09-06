
import 'package:flutter_application_1/utils/app_urls.dart';
import 'package:flutter_application_1/utils/url.dart';

import '../../data/Model/CropModels/product_comment_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class ProductCommentRepository{ 
 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<ProductCommentModel> commentproductDetailsPostApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
     print(response);
     return response = ProductCommentModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

   //post Api
  Future<dynamic> feedBack(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.userFeedBack, data);
     return response; 
    }catch(e){
      throw e;
    }

  } 


}