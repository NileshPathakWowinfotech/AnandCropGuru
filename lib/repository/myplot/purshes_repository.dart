import '../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/totalexpenses_model.dart';
import '../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/unitcount_model.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/categorydropdownmode.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/productdropdown_model.dart';
import '../../data/Model/MyPlotModel.dart/PurshesModels/unitdropdown_model.dart';
import '../../data/Model/MyPlotModel.dart/farmerpurchase_model.dart';
import '../../data/Model/MyPlotModel.dart/question_answ_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class PurchasDropDownRepository {
  BaseApiServices _apiServices = NetworkApiService();

   //POST API
   Future<dynamic> addPursusPostApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.AddPurchase, data);
     print(AppUrls.AddPurchase);
     return response;
    }catch(e){
      throw e;
    }

  }

  //category API
  Future<CategoryDropDownModel> categoryListApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrls.purchasecategory, data);
          return response = CategoryDropDownModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  } 

  //Product API
  Future<ProductDropDownModel> productListApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrls.ProductCategory, data);
          return response = ProductDropDownModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  } 

  //Unit API
  Future<UnitDropDownModel> UnitApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrls.Unit, data);
          return response = UnitDropDownModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  } 


  //GET API
  Future<FarmerPurchaseModel> purchaseApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.purchase, data); 
     return response = FarmerPurchaseModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }  

   //Unit Count
  Future<UnitCountModel> unitCountApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.UnitCount, data); 
     return response = UnitCountModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

    //Total Expanse  Api
  Future<TotalExpensesModel> totalExpanseApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.TotalExpanse, data); 
     return response = TotalExpensesModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }
   
}
