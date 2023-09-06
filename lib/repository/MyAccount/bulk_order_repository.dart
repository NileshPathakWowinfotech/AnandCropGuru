
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class BulkOrderRepository{

 BaseApiServices  _apiServices = NetworkApiService();

  Future<dynamic> bulkOrderApi(dynamic data)async{
    try{
     dynamic response = await _apiServices.getPostResponse(AppUrls.BulikOrder, data);
     return response;
    }catch(e){
      throw e;
    }
  } 
}