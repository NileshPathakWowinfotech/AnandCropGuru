
import '../../data/Model/CropModels/my_post_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class MyPostRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<MyPostModel> myPostListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 

    
      print(response);
     return response = MyPostModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 


 }