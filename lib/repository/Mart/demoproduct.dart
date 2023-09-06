import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/Model/MartModels/my_cart_model.dart';
import '../../data/Model/MartModels/relatedProduct_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../utils/app_urls.dart';
import '../../view_model/user_view_model.dart';

class productRepository {
  BaseApiServices _apiServices = NetworkApiService();

  //GET API
  Future<RelatedProductModel> myCartPostApi(data) async {
    try {
      dynamic response =
          await _apiServices.getPostResponse(AppUrls.Product, data);
      print(response);
      return response = RelatedProductModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}

class ProductDetailsViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = productRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<RelatedProductModel> movieslLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<RelatedProductModel> response) {
    movieslLists = response;
    notifyListeners();
  }

  Future<void> ProductDetails() async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "START": 0,
        "END": 1000,
        "WORD": "None",
        "USER_ID": "",
        "LANG_ID": "3",
        "CAT_ID": " 1",
        "TYPE": "Product",
        "SUBCAT_ID": " 0",
        "LATITUDE": "20.0086761",
        "ACCESS_TOKEN": "123456",
        "DISTRICT_ID": " ",
        "TALUKA_ID": "",
        "CROP_ID": "0",
        "PLOT_ID": "0",
        "SCHEDULE_ID": "0",
        "LONGITUDE": "73.7639122"
      });
      setlabTestingType(ApiResponse.loading());
      _myRepo.myCartPostApi(registerdata).then((value) {
        setlabTestingType(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setlabTestingType(ApiResponse.error(error.toString()));
      });
    });
  }
}
