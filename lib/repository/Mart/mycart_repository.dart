
import '../../data/Model/MartModels/my_cart_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class MyCartRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API 
  Future<CartModel> myCartPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data);
     print(response);
     return response = CartModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}