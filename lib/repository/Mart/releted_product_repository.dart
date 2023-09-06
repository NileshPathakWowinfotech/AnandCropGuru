
import '../../data/Model/MartModels/relatedProduct_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class RelatedRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<RelatedProductModel> shopForYourCropPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Product, data);
     print(response);
     return response = RelatedProductModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}