import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../../data/Model/MartModels/product_details_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/product_details_repository.dart';
import '../../repository/Mart/shop_for_your_crop_repository.dart';

class ShopForYourCropViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ShopForYourCropRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ShopForYourCropModel> shopForYourCroplLists = ApiResponse.loading();

  setShopForCrop(ApiResponse<ShopForYourCropModel> response) {
    shopForYourCroplLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> shopForYourCroplList() async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "NONE",
        "LANG_ID": 3,
        "USER_ID": value.userId.toString(),
        "ACCESS_TOKEN": "123456"
      });
      setShopForCrop(ApiResponse.loading());
      _myRepo.shopForYourCropPostApi(data).then((value) {
        setShopForCrop(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setShopForCrop(ApiResponse.error(error.toString()));
      });
    });
  }
}
