import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/Model/MyPlotModel.dart/diarydetailslistmodel.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/diarydetails_repository.dart';
import '../../utils/app_urls.dart';
import '../../utils/util.dart';

class DiaryDetailsViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();
  DateTime _dateTime = DateTime.now();
  String? salectedDatebackundDevloper;
  final _myRepo = DiaryDetailsRepository();
  DateTime? dateTiming;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<DiaryDetailsListModel> plotinromeationList =
      ApiResponse.loading();

  setplotInrmationList(ApiResponse<DiaryDetailsListModel> response) {
    plotinromeationList = response;

    print('  Report data $response');
    notifyListeners();
  }

  void datetiming(context) async {
    dateTiming = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        // firstDate: DateTime(2023),
        lastDate: DateTime.now(),
        firstDate: DateTime(2002));
    if (dateTiming == null) {
      return;
    } else {
      _dateTime = dateTiming!;
      salectedDatebackundDevloper =
          "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";

      print("Date $salectedDatebackundDevloper");
    }
    notifyListeners();
  }

  Future<void> diaryDetailsApi(userId, plotID, cropId) async {
    Map<String, String> queryParams = {
      "USER_ID": userId.toString(),
      "TYPE": "User",
      "AGRONOMIST_ID": userId.toString(),
      "PLOT_ID": plotID.toString(),
      "LANG_ID": "1"
    };
    final data = jsonEncode({
      "START": 0,
      "END": 10,
      "WORD": "none",
      "LANG_ID": "1",
      "CROP_ID": cropId.toString(),
      "PLOT_ID": plotID.toString(),
      "USER_ID": userId.toString(),
      "TYPE": "User"
    });
    print(data);
    Uri uri =
        Uri.parse(AppUrls.DiaryDetils).replace(queryParameters: queryParams);
    setplotInrmationList(ApiResponse.loading());
    _myRepo.diaryDetailsListApi(uri.toString(), data).then((value) {
      setplotInrmationList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      print('error this $error');
      setplotInrmationList(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  // Add diary Details
  Future<void> addDiaryDetails(
      BuildContext context, title, desc, userId, plotId, image,cropid) async {
    final registerdata = jsonEncode({
      "USER_ID": userId.toString(),
      "PLOT_ID": plotId.toString(),
      "DIARY_ID": "1",
      "AGRONOMIST_ID": userId.toString(),
      "DIARY_TITLE": title.toString(),
      "DIARY_DESC":desc.toString(),
      "LOCATION": "",
      "LATITUDE": "20.0086388",
      "LONGITUDE": "73.7639574",
      "DIARY_IMAGE": ""
    });
    print('register api data is $registerdata');

    setLoading(true);
    _myRepo.addDetailsListApi(registerdata).then((value) {
      setLoading(true);
      (false);
      Navigator.pop(context);
      // Navigator.popAndPushNamed(context, RoutesName.home);
      Util.tostMassage("Successfully submitted");
      diaryDetailsApi(userId,plotId,cropid);
      setLoading(false);
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setLoading(true);
      (false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
