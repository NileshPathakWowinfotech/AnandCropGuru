


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/Model/MyPlotModel.dart/reportmaster_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/reportMaster_repository.dart.dart';
import '../../utils/app_urls.dart';
import '../../utils/util.dart';

class ReportMasterViewModel with ChangeNotifier {
   
   late List datais;
  
  BaseApiServices _apiServices = NetworkApiService();

         final _myRepo = ReportMasterRepository(); 

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  } 

  ApiResponse<TestingReportListModel> reportMasterList = ApiResponse.loading();

  setlabTestingType(ApiResponse<TestingReportListModel> response) {
    reportMasterList = response;

    print('  Report data $response');
    notifyListeners();
  }


   Future<void> reportMasterListView(userID, ploatID) async {
    Map<String, String> queryParams = {
      "USER_ID": userID.toString(),
      "TYPE": "user",
      "AGRONOMIST_ID":userID.toString(),
      "PLOT_ID": ploatID.toString(),
    };
    Uri uri = Uri.parse(AppUrls.ReportMaster).replace(queryParameters: queryParams);
    print(uri);
    final registerdata =
        jsonEncode({"START": "0", "END": "10", "WORD": "NONE", "LANG_ID": "1"});
    setlabTestingType(ApiResponse.loading());
    _myRepo.reportMasterListApi(uri.toString(), registerdata).then((value) {
      setlabTestingType(ApiResponse.completed(value));
      print('hello');
      datais = reportMasterList.data!.data;
    }).onError((error, stackTrace) {
      print('error this $error');
      setlabTestingType(ApiResponse.error(error.toString()));
    });
  }



  Future<void> addReportMasterApi(
      dynamic data, BuildContext context,) async {
    setLoading(true);
    _myRepo.addReportApi(data).then((value) {
      setLoading(false);
      
      Util.tostMassage("Successfully Added");
      Navigator.pop(context);
      
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

}