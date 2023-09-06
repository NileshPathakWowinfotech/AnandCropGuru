
import '../../data/Model/CropModels/blog_model.dart';
import '../../data/Model/CropModels/krushi_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class KrushiRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<KrushiLIstModel> krushiListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
     print("krusi playApi ${AppUrls.GetData}");
     print("krusi play Api ${data}");
     return response = KrushiLIstModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 


 }