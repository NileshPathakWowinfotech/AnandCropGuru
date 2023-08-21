
import '../../data/Model/MyPlotModel.dart/reportmaster_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class ReportMasterRepository  {  

  BaseApiServices  _apiServices = NetworkApiService();

 //GET API
  Future<TestingReportListModel> reportMasterListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 
     return response = TestingReportListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

  // post Api
  Future<dynamic> addReportApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.AddReportMaster, data);
     return response;
    }catch(e){
      throw e;
    }

  } 

}