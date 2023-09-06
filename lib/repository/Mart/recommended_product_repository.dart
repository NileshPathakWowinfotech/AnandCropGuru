
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class RecommendedProductRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<RecmmendedProductModel> recommendedProductPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
     print(response);
     return response = RecmmendedProductModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}