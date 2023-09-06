
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/Model/ProfileModels/order_details_product_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class MyOrderProductRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<OrderDetailsProductModel> myOrderDetailsProductListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
      print(response);
     return response = OrderDetailsProductModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }