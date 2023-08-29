

import '../../data/Model/MyPlotModel.dart/plotInformation_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';
import '../data/Model/wather_model.dart';
import '../data/Model/weather_shedule_model.dart';

class WatherRepository{

 BaseApiServices  _apiServices = NetworkApiService();

 
   Future<WatherModel> watherList(uri)async{
    try{
     dynamic response = await _apiServices.getResponse(uri);
     print(response);
     return response = WatherModel.fromJson(response);
    }catch(e){
      throw e;
    }
  }  

   Future<WeatherScheduleModel> ScheduleWatherList(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse( AppUrls.GetData,data);
     print(response);
     return response = WeatherScheduleModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

}