


import '../../../data/Model/MyPlotModel.dart/DiaryModel/ExpenseModel.dart/unitcount_model.dart';
import '../../../data/Model/MyPlotModel.dart/DiaryModel/IncomeModels/unit_model.dart';
import '../../../data/network/BaseApiServices.dart';
import '../../../data/network/NetworkApiServices.dart';
import '../../../utils/app_urls.dart';

class IncomeUnitRepository{ 
 BaseApiServices  _apiServices = NetworkApiService();  

  //  //POST API
  //  Future<dynamic> qutionAnswerPostApi(dynamic data)async{
  //   try{
  //    dynamic response = await _apiServices.getPostResponse(AppUrls.QutionsAnsPostApi, data);
  //    return response;
  //   }catch(e){
  //     throw e;
  //   }

  // } 
 

  //GET API
  Future<IncomeUnitModel> incomeUnittApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Unit, data); 
     return response = IncomeUnitModel.fromJson(response);
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
}