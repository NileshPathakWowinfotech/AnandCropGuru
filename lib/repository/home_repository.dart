

   import '../data/Model/LabModel/lab_list_model.dart';
import '../data/Model/soli_testing_type_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../utils/app_urls.dart';

class HomeRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<SoilTestingTypeListModel> soilListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
      print(response);
     return response = SoilTestingTypeListModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 

  Future<dynamic> labEnquiriesService(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.labEnquiries, data);
     return response;
    }catch(e){
      throw e;
    }
  } 

   Future<LabListModel> labList(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data);
    // print(response);
     return response = LabListModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

  

 }