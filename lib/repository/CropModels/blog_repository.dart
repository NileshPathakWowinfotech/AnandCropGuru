
import '../../data/Model/CropModels/blog_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class BlogRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<BlogListModel> blogListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 

    
      print(response);
     return response = BlogListModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 


 }