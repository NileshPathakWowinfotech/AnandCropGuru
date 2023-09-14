import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../utils/app_urls.dart';

class UpdatePlotRepository {
  BaseApiServices _apiServices = NetworkApiService();

  //POST API
  Future<dynamic> totalApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrls.TotalArea, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
