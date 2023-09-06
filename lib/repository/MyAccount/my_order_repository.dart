import '../../data/Model/CropModels/bannarimage_model.dart';
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class MyOrderRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<MyOrderModel> myOrderListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
      print(response);
     return response = MyOrderModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }