

import 'package:flutter_application_1/utils/app_urls.dart';
import '../../data/Model/MyPlotModel.dart/farmerpurchase_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';

class PurchaseRepository  {  

  BaseApiServices  _apiServices = NetworkApiService();

 //GET API
  Future<FarmerPurchaseModel> purchaseApi(data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.purchase, data); 
     return response = FarmerPurchaseModel.fromJson(response);
    }catch(e){
      throw e;
    }
  } 

}