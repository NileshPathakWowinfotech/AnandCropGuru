import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/MartModels/productblog_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/product_blog_repository.dart';


class ProductBlogViewViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = ProductBlogRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ProductBlogModel> productLists = ApiResponse.loading();

  setlabTestingType(ApiResponse<ProductBlogModel> response) {
    productLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> productblogaPI() async {
    getUserData().then((value) {
      final registerdata = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "",
        "GET_DATA": "Get_ProductBlogs",
        "ID1":value.userId.toString(),
        "ID2": "",
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": ""
      });
      setlabTestingType(ApiResponse.loading());
      _myRepo.productBlogPostApi(1, registerdata).then((value) {
        setlabTestingType(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setlabTestingType(ApiResponse.error(error.toString()));
      });
    });
  }
}
