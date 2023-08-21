import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../data/Model/MyPlotModel.dart/my_plot_model.dart';
import '../data/Model/user_model.dart';
import '../data/response/api_response.dart';
import '../repository/my_plot_repository.dart';

class MYPlotViewModel with ChangeNotifier {
  final _myRepo = MYPlotRepository();
  Future<UserModel> getUserData() => UserViewModel().getUser();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<MyPloatModel> lablist = ApiResponse.loading();

  setMyPlotList(ApiResponse<MyPloatModel> response) {
    lablist = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> myPloatApi() async {
    getUserData().then((value) {
      final listData = jsonEncode({
        "START": "0",
        "END": "10",
        "WORD": "NPNE",
        "LANG_ID": "3",
        "ACCESS_TOKEN": "123456"
      });
      print(listData);
      setMyPlotList(ApiResponse.loading());
      _myRepo.myPlotApi(listData,'21013').then((value) {
        setMyPlotList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setMyPlotList(ApiResponse.error(error.toString()));
      });
    });
  }
}
