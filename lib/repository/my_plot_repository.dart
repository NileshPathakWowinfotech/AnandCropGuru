import 'package:flutter_application_1/data/network/BaseApiServices.dart';
import 'package:flutter_application_1/data/network/NetworkApiServices.dart';

import '../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../utils/app_urls.dart';

class MYPlotRepository {
  BaseApiServices _myPlotServices = NetworkApiService();

  Future<MyPloatModel> myPlotApi(dynamic data , String userId) async {
    try {
      dynamic response =
          await _myPlotServices.getPostResponse('https://mycropguruapiwow.cropguru.in/api/PlotList?&SALESTEAM_USER_ID=21013&TYPE=ALL', data);

      print(response);
      return response = MyPloatModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }



}
