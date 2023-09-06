import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/MartModels/product_model.dart';
import '../../data/Model/MartModels/recommended_product_model.dart';
import '../../data/Model/MartModels/shop_by_sub_category_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/shop_by_sub_category_repository.dart';

class ShopBySubCategoryViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ShopbySubCategoryRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ShopBySubCategoryModel> shopBySublLists = ApiResponse.loading();

  setShopBySubCategory(ApiResponse<ShopBySubCategoryModel> response) {
    shopBySublLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  ApiResponse<ProductModel> productLists = ApiResponse.loading();

  setProduct(ApiResponse<ProductModel> response) {
    productLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> shopForYourCroplList() async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "NONE",
        "USER_ID": "21013",
        "LANG_ID": "3",
        "CAT_ID": "1",
        "TYPE": "SUBCAT",
        "SUBCAT_ID": "0",
        "LATITUDE": "",
        "ACCESS_TOKEN": "123456",
        "DISTRICT_ID": "482",
        "TALUKA_ID": "3887",
        "SCHEDULE_ID": "0",
        "LONGITUDE": "",
        "CROP_ID": "0",
        "PLOT_ID": "0"
      });
      setShopBySubCategory(ApiResponse.loading());
      _myRepo.shopbySubCategoryPostApi(data).then((value) {
        setShopBySubCategory(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setShopBySubCategory(ApiResponse.error(error.toString()));
      });
    });
  }

  Future<void> ProductApi(cat) async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": 21,
        "END": 30,
        "WORD": "NONE",
        "USER_ID":value.userId,
        "LANG_ID": "3",
        "CAT_ID": cat.toString(),
        "TYPE": "Product",
        "SUBCAT_ID": "0",
        "LATITUDE": "",
        "ACCESS_TOKEN": "123456",
        "DISTRICT_ID": "482",
        "TALUKA_ID": "3887",
        "SCHEDULE_ID": "0",
        "LONGITUDE": "",
        "CROP_ID": "0",
        "PLOT_ID": "0"
      });
      setProduct(ApiResponse.loading());
      _myRepo.shopProductPostApi(data).then((value) {
        setProduct(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setProduct(ApiResponse.error(error.toString()));
      });
    });
  }
}
