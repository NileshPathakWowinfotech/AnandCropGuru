import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/bannarimage_model.dart';
import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModelsRepository/bannar_repository.dart';
import '../user_view_model.dart';

class BannarViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = BannarRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<BannarImageModel> bannarList = ApiResponse.loading();

  setBannar(ApiResponse<BannarImageModel> response) {
    bannarList = response;
    print('Report data $response');
    notifyListeners();
  }

  Future<void> bannarListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode(
          {"LANG_ID": "1", "ACCESS_CODE": "", "USER_ID": value.userId});
      setBannar(ApiResponse.loading());
      _myRepo.bannarListApi(data).then((value) {
        setBannar(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setBannar(ApiResponse.error(error.toString()));
      });
    });
  }
}
