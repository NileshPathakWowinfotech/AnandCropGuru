
import 'package:flutter_application_1/utils/app_urls.dart';

import '../../data/Model/CropModels/my_post_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class MyPostRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<MyPostModel> myPostListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
     return response = MyPostModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 


 }