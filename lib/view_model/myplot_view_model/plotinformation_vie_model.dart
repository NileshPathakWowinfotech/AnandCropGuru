


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/MyPlotModel.dart/plotInformation_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/plotinformation_repository.dart';
import '../../utils/app_urls.dart';

class PlotInformationViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = PlotInformationRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<PlotInformationModel> plotinromeationList = ApiResponse.loading();

   setplotInrmationList(ApiResponse<PlotInformationModel> response) {
    plotinromeationList = response;

    print('  Report data $response');
    notifyListeners();
  
  
  } 

   Future<void> plotInformationApi(userID,plotid ,lngId) async {
     Map<String, String> queryParams = {
      "USER_ID":userID.toString(),
      "TYPE": "All",
      "AGRONOMIST_ID":userID.toString(),
      "PLOT_ID":plotid.toString(),
      "LANG_ID":"1"
    };
    Uri uri = Uri.parse(AppUrls.PlotInformation).replace(queryParameters: queryParams);
    setplotInrmationList(ApiResponse.loading());
    _myRepo.plotInformationList(uri.toString()).then((value) {
      setplotInrmationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setplotInrmationList(ApiResponse.error(error.toString()));
    });
  }
}