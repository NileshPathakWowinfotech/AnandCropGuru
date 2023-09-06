import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/Model/MyPlotModel.dart/Schedule/Schedule_model.dart';
import '../../data/Model/MyPlotModel.dart/diarydetailslistmodel.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/ScheduleRepositoys/Schedule_repositoys.dart';
import '../../repository/myplot/diarydetails_repository.dart';
import '../../utils/app_urls.dart';
import '../../utils/util.dart';

class SchduleViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();
   String typename = "Spray";

  String? salectedDatebackundDevloper;
  final _myRepo = scheduleRepository();
  DateTime? dateTiming;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ScheduleModel> scheduleList = ApiResponse.loading();

  setScheduleListList(ApiResponse<ScheduleModel> response) {
    scheduleList = response;
typename;
    print('  Report data $response');
    notifyListeners();
  }
  
  ApiResponse<ScheduleModel> oldScheduleList = ApiResponse.loading();

  setOldScheduleListList(ApiResponse<ScheduleModel> response) {
    oldScheduleList = response;
typename;
    print('  Report data $response');
    notifyListeners();
  }

  Future<void> scheduleApi(cropId,plotID,userId) async {
    Map<String, String> queryParams = {
      "AGRONOMIST_ID": userId.toString()
    };
    final data = jsonEncode({
      "START": "0",
      "END": "100000",
      "WORD": "Current Schedule",
      "LANG_ID": "3",
      "CROP_ID": cropId,
      "PLOT_ID":plotID,
      "ACCESS_CODE": "123456",
      "USER_ID": userId.toString(),
      "TYPE": typename
    });
    print(typename);
    print(data);
    Uri uri =
        Uri.parse(AppUrls.Schedule).replace(queryParameters: queryParams);
    setScheduleListList(ApiResponse.loading());
    _myRepo.scheduleListApi(uri.toString(), data).then((value) {
      typename;
      setScheduleListList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setScheduleListList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  } 



  Future<void> oldScheduleApi(type ,cropId,plotID,userId) async {
    Map<String, String> queryParams = {
      "AGRONOMIST_ID": userId.toString()
    };
    final data = jsonEncode({
      "START": "0",
      "END": "100000",
      "WORD": "Previous Schedule",
      "LANG_ID": "3",
      "CROP_ID": cropId.toString(),
      "PLOT_ID":plotID.toString(),
      "ACCESS_CODE": "123456",
      "USER_ID": userId.toString(),
      "TYPE": type.toString()
    });
        print(typename);
   
    Uri uri =
        Uri.parse(AppUrls.Schedule).replace(queryParameters: queryParams);
    setOldScheduleListList(ApiResponse.loading());
    _myRepo.OldscheduleListApi(uri.toString(), data).then((value) {
      setOldScheduleListList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setOldScheduleListList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }
}
