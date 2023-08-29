
import '../../data/Model/CropModels/community_model.dart';
import '../../data/Model/CropModels/postcomment_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class CommentRepository{


BaseApiServices  _apiServices = NetworkApiService();

   //Comment List Api
   Future<PostCommentModel> commentListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
      print(response);
     return response = PostCommentModel.fromJson(response);
    }catch(e){
      throw e;
    }
   }


 }