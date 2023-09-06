



import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../utils/app_urls.dart';

class AuthRepository{

 BaseApiServices  _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.MOBILEOTPLOGIN, data);
     print(AppUrls.MOBILEOTPLOGIN);
     print(data);
     return response; 
    }catch(e){
      throw e;
    }

  } 

  Future<dynamic> registerApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.Registration, data);
      print(AppUrls.Registration);
     print(data);
     return response;
    }catch(e){
      throw e;
    }
 
  } 

  Future<dynamic> userUpdateAddress(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.UpdateRegistration, data);
      print(AppUrls.UpdateRegistration);
     print(data);
     return response;
    }catch(e){
      throw e;
    } 
  }

}