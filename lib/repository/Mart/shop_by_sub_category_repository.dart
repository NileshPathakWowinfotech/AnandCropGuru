
import '../../data/Model/MartModels/product_model.dart';
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/MartModels/shop_by_sub_category_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ShopbySubCategoryRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  
  //GET API
  Future<ShopBySubCategoryModel> shopbySubCategoryPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.ShopByCategory, data);
     print(response);
     return response = ShopBySubCategoryModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

    // Sub Category GET API
  Future<ProductModel> shopProductPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Product, data);
     print(response);
     return response = ProductModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}