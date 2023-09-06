import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/MartModels/productlist_model.dart';
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/MartModels/shop_by_Category_model.dart';
import '../../data/Model/MartModels/shop_for_your_master_model.dart';
import '../../data/Model/MartModels/shop_subcat_model.dart';
import '../../data/Model/searchproduct_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/shop_by_category_repository.dart';

class ShopByCategoryViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ShopByCategoryRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ShopByCateModel> shopByCategorylLists = ApiResponse.loading();

  setShopByCategory(ApiResponse<ShopByCateModel> response) {
    shopByCategorylLists = response;

    print('  Report data $response');
    notifyListeners();
  }

//Sub Cat
  ApiResponse<ShopSubCatModel> SubCategorylLists = ApiResponse.loading();

  setSubCategory(ApiResponse<ShopSubCatModel> response) {
    SubCategorylLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  //Produtt List
  ApiResponse<ProductListModel> productList = ApiResponse.loading();

  setProductList(ApiResponse<ProductListModel> response) {
    productList = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> shopByCategorylList(cat) async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "NONE",
        "USER_ID": value.userId.toString(),
        "LANG_ID": "3",
        "CAT_ID": "0",
        "TYPE": "CAT",
        "SUBCAT_ID": "0",
        "LATITUDE": "",
        "ACCESS_TOKEN": "123456",
        "DISTRICT_ID": "",
        "TALUKA_ID": "",
        "SCHEDULE_ID": "0",
        "LONGITUDE": "",
        "CROP_ID":cat,
        "PLOT_ID": "0"
      });
      setShopByCategory(ApiResponse.loading());
      _myRepo.shopByCategoryCropPostApi(data).then((value) {
        setShopByCategory(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setShopByCategory(ApiResponse.error(error.toString()));
      });
    });
  }

  Future<void> shopSubList(cat) async {
    getUserData().then((value) {
      final data = jsonEncode({
         "START": 0,
    "END": 1000,
    "WORD": "NONE",
    "USER_ID": "21013",
    "LANG_ID": "3",
    "CAT_ID": cat,
    "TYPE": "SUBCAT",
    "SUBCAT_ID": "0",
    "LATITUDE": "",
    "ACCESS_TOKEN": "123456",
    "DISTRICT_ID": "482",
    "TALUKA_ID": "3887",
    "SCHEDULE_ID": "0",
    "LONGITUDE": "",
    "CROP_ID": "3",
    "PLOT_ID": "0"
      });
      setSubCategory(ApiResponse.loading());
      _myRepo.shopSubCatPostApi(data).then((value) {
        setSubCategory(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setSubCategory(ApiResponse.error(error.toString()));
      });
    });
  }

  Future<void> ProductList(subcat) async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10000000,
        "WORD": "NONE",
        "USER_ID":value.userId,
        "LANG_ID": "3",
        "CAT_ID": '1',
        "TYPE": "CropProduct",
        "SUBCAT_ID": subcat,
        "LATITUDE": "",
        "ACCESS_TOKEN": "123456",
        "DISTRICT_ID": "482",
        "TALUKA_ID": "3887",
        "SCHEDULE_ID": "0",
        "LONGITUDE": "",
        "CROP_ID": "3",
        "PLOT_ID": "0"
      });
      setProductList(ApiResponse.loading());
      _myRepo.productPostApi(data).then((value) {
        setProductList(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setProductList(ApiResponse.error(error.toString()));
      });
    });
  }
}
