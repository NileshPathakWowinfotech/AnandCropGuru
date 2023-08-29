
 import '../../data/Model/MartModels/product_details_model.dart';
import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ProductDetailsRepository{ 
 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<ProductDetailsModel> productDetailsPostApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse('http://mycropguruapiwow.cropguru.in/api/ProductList?PRODUCT_ID=1', data); 
     print(response);
     return response = ProductDetailsModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}