import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class OneOfferRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<OneOfferModel> oneOfferListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
      print(response);
     return response = OneOfferModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }