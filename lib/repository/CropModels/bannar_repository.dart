import '../../data/Model/CropModels/bannarimage_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class BannarRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<BannarImageModel> bannarListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Bannar, data); 
      print(response);
     return response = BannarImageModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }