import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../../data/Model/MartModels/product_details_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/product_details_repository.dart';

class ProductDetailsViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ProductDetailsRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ProductDetailsModel> movieslLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<ProductDetailsModel> response) {
    movieslLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> ProductDetails() async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "START": 0,
            "END": 1000,
            "WORD": "None",
            "USER_ID":"",
            "LANG_ID": "3",
            "CAT_ID":" 1",
            "TYPE": "Product",
            "SUBCAT_ID":" 0",
            "LATITUDE": "20.0086761",
            "ACCESS_TOKEN": "123456",
            "DISTRICT_ID": " ",
            "TALUKA_ID":"",
            "CROP_ID": "0",
            "PLOT_ID": "0",
            "SCHEDULE_ID": "0",
            "LONGITUDE": "73.7639122"
      });
      setlabTestingType(ApiResponse.loading());
      _myRepo.productDetailsPostApi(1, registerdata).then((value) {
        setlabTestingType(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setlabTestingType(ApiResponse.error(error.toString()));
      });
    });
  }
}
