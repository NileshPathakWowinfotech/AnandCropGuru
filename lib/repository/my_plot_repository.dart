import 'package:flutter_application_1/data/network/BaseApiServices.dart';
import 'package:flutter_application_1/data/network/NetworkApiServices.dart';

import '../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../utils/app_urls.dart';

class MYPlotRepository {
  BaseApiServices _myPlotServices = NetworkApiService();

  Future<MyPloatModel> myPlotApi(dynamic data , String uri) async {
    try {
      dynamic response =
          await _myPlotServices.getPostResponse(uri, data);
          print(uri);

      print(response);
      return response = MyPloatModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }



}
