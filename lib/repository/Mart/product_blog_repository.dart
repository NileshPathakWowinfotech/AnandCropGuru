
 import '../../data/Model/MartModels/product_details_model.dart';
import '../../data/Model/MartModels/productblog_model.dart';
import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ProductBlogRepository{ 
 BaseApiServices  _apiServices = NetworkApiService();  

   
  
  //GET API
  Future<ProductBlogModel> productBlogPostApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
     print(response);
     return response = ProductBlogModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }

}