import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../data/Model/searchproduct_model.dart';
import '../repository/searchproduct_repository.dart';

class SearchProdcutViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = SearchProductRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<SearchProductModel> recommendedLists = ApiResponse.loading();

  setrecommendedProduct(ApiResponse<SearchProductModel> response) {
    recommendedLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> searchProductApi(search) async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10,
        "WORD": search.toString(),
        "GET_DATA": "Get_SearchProducts",
        "ID1": "",
        "ID2": "",
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": "3"
      });
      setrecommendedProduct(ApiResponse.loading());
      _myRepo.searchListApi(data).then((value) {
        setrecommendedProduct(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setrecommendedProduct(ApiResponse.error(error.toString()));
      });
    });
  }
}
