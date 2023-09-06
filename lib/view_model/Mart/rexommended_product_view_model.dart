import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../../data/Model/MartModels/product_details_model.dart';
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/recommended_product_repository.dart';

class RecoummendedProdcutViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = RecommendedProductRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<RecmmendedProductModel> recommendedLists = ApiResponse.loading();

  setrecommendedProduct(ApiResponse<RecmmendedProductModel> response) {
    recommendedLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> recommenedProductApi() async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "",
        "GET_DATA": "Get_RandomProducts",
        "ID1": 84533,
        "ID2": "",
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": 3
      });
      setrecommendedProduct(ApiResponse.loading());
      _myRepo.recommendedProductPostApi(data).then((value) {
        setrecommendedProduct(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setrecommendedProduct(ApiResponse.error(error.toString()));
      });
    });
  }
}
