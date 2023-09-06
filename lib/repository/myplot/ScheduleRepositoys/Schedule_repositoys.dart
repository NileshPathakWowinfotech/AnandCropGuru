

import '../../../data/Model/MyPlotModel.dart/Schedule/Schedule_model.dart';
import '../../../data/network/BaseApiServices.dart';
import '../../../data/network/NetworkApiServices.dart';

class scheduleRepository  {  

  BaseApiServices  _apiServices = NetworkApiService();

 //GET API
  Future<ScheduleModel> scheduleListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 
     print(uri);
     return response = ScheduleModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

  //GET API
  Future<ScheduleModel> OldscheduleListApi(uri,dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(uri, data); 
     return response = ScheduleModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 
}