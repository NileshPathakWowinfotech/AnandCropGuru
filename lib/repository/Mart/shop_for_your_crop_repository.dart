
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ShopForYourCropRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<ShopForYourCropModel> shopForYourCropPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.ShopForYourCrop, data);
      print("Api crop yourdata ${AppUrls.ShopForYourCrop}");
    print("print data $data"); 
     print(response);
     return response = ShopForYourCropModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}