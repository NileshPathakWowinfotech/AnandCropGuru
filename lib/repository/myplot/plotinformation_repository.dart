

import '../../data/Model/MyPlotModel.dart/plotInformation_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class PlotInformationRepository{

 BaseApiServices  _apiServices = NetworkApiService();

 
   Future<PlotInformationModel> plotInformationList(uri)async{
    try{
     dynamic response = await _apiServices.getResponse(uri);
    // print(response);
     return response = PlotInformationModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

}