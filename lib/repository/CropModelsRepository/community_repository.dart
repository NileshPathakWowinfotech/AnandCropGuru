
import '../../data/Model/CropModels/community_model.dart';
import '../../data/Model/CropModels/postcomment_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class CommunityRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<CommunityModel> communityListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
   print("Com Api ${AppUrls.GetData}");
     print("comm Api ${data}");
     return response = CommunityModel.fromJson(response);
    }catch(e){
      throw e;
    } 
  } 

   //Comment List Api
   Future<PostCommentModel> commentListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
       print("comment Api ${AppUrls.GetData}");
     print("Coment Api ${data}");
     return response = PostCommentModel.fromJson(response);
    }catch(e){
      throw e;
    }
   }


 }