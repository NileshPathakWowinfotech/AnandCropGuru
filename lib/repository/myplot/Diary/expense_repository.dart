

 import 'package:flutter_application_1/utils/app_urls.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/category_model.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/productname_model.dart';
import '../../../data/network/BaseApiServices.dart';
import '../../../data/network/NetworkApiServices.dart';



class ExpensesRepository  {  

 BaseApiServices  _apiServices = NetworkApiService();

   //CategoryName Api
  Future<CategoryNameModel> categoryNameApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.CategoryName, data); 
     return response = CategoryNameModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
   
    
   //ProductNameName Api
  Future<ProductNameModel> productNameApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.ProductName, data); 
     return response = ProductNameModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
   
  

  
}