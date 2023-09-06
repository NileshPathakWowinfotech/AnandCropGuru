import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/Model/MartModels/related_videos_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class RelatedVideoRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<RelatedVideosModel> relatedVideoListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
    print("one offer  Api ${AppUrls.Bannar}");
     print("data Api ${data}");
     return response = RelatedVideosModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }