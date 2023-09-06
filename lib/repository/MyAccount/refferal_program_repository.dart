
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/Model/ProfileModels/referral_program_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';


class ReffrealProgramRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<ReferralProgramModel> reffrealProgramApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 
      print(response);
     return response = ReferralProgramModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 


 }