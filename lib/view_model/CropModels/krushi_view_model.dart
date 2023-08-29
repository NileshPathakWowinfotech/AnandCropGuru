import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/Model/CropModels/blog_model.dart';
import '../../data/Model/CropModels/krushi_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModels/krushi_repository.dart';
import '../../utils/app_urls.dart';
import '../user_view_model.dart';

class KrushiViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = KrushiRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<KrushiLIstModel> krushiList = ApiResponse.loading();

  setKrushi(ApiResponse<KrushiLIstModel> response) {
    krushiList = response;

    print('Report data $response');
    notifyListeners();
  }

  Future<void> krushiListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": "",
        "END": "",
        "WORD": "",
        "GET_DATA": "Get_StarProducts",
        "ID1": "",
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
      setKrushi(ApiResponse.loading());
      _myRepo.krushiListApi(data).then((value) {
        setKrushi(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setKrushi(ApiResponse.error(error.toString()));
      });
    });
  }
}
