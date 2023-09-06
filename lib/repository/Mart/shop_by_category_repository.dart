
import '../../data/Model/MartModels/productlist_model.dart';
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/MartModels/shop_by_Category_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/Model/MartModels/shop_subcat_model.dart';
import '../../data/Model/searchproduct_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ShopByCategoryRepository{ 

 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<ShopByCateModel> shopByCategoryCropPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.ShopByCategory, data);
   
     print(' cat =geory${AppUrls.ShopByCategory}') ;
       print('datacat ${data}') ;
     return response = ShopByCateModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

    //Sub Cat API
  Future<ShopSubCatModel> shopSubCatPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.ShopByCategory, data);
   
     print(data);
     return response = ShopSubCatModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

   //Sub Cat API
  Future<ProductListModel> productPostApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Product, data);
   
     return response = ProductListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}