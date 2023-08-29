import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/MyPlotModel.dart/plotInformation_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/plotinformation_repository.dart';
import '../../utils/app_urls.dart';
import '../data/Model/wather_model.dart';
import '../data/Model/weather_shedule_model.dart';
import '../repository/wather_repository.dart';

class WatherViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  final _myRepo = WatherRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<WatherModel> watherList = ApiResponse.loading();

  setWatherList(ApiResponse<WatherModel> response) {
    watherList = response;
    print('  Report data $response');
    notifyListeners();
  }
  //shedule wather Api 
  ApiResponse<WeatherScheduleModel> sheduleApiwatherList =
      ApiResponse.loading();

  setSchedukeWatherList(ApiResponse<WeatherScheduleModel> response) {
    sheduleApiwatherList = response;
    print('  Report data $response');
    notifyListeners();
  }

  Future<void> watherModelCurrent() async {
    Map<String, String> queryParams = {
      "key": '581836bdc25a4f3b846104040221807',
      "q": "nasik",
      "days": '8',
      "aqi": 'no',
      "alerts": "no"
    };
    Uri uri =
        Uri.parse(AppUrls.WATHERURL).replace(queryParameters: queryParams);
    print('response model $uri');
    setWatherList(ApiResponse.loading());
    _myRepo.watherList(uri.toString()).then((value) {
      setWatherList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setWatherList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> schduleListApi() async {
    final data = jsonEncode({
      "START": 0,
      "END": 10000,
      "WORD": "",
      "GET_DATA": "Get_WeatherScheduleByUserId",
      "ID1": "5",
      "ID2": "",
      "ID3": "",
      "STATUS": "",
      "START_DATE": "",
      "END_DATE": "",
      "EXTRA1": "",
      "EXTRA2": "",
      "EXTRA3": "",
      "LANG_ID": "1"
    });
    setSchedukeWatherList(ApiResponse.loading());
    _myRepo.ScheduleWatherList(data).then((value) {
      setSchedukeWatherList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setSchedukeWatherList(ApiResponse.error(error.toString()));
    });
  }
}
