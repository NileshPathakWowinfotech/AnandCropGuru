

import '../data/Model/LabModel/lab_list_model.dart';
import '../data/Model/offer_model.dart';
import '../data/Model/soli_testing_type_model.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../utils/app_urls.dart';

class OfferRepository{


BaseApiServices  _apiServices = NetworkApiService();
  
  Future<OfferListModel> offerListApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.GetData, data); 

    
      print(response);
     return response = OfferListModel.fromJson(response);
    }catch(e){
      throw e;
    }

 
  } 

 }