import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../data/Model/CropModels/blog_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModelsRepository/blog_repository.dart';
import '../../utils/app_urls.dart';
import '../user_view_model.dart';

class BlogViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = BlogRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<BlogListModel> blogList = ApiResponse.loading();

  setblog(ApiResponse<BlogListModel> response) {
    blogList = response;

    print('Report data $response');
    notifyListeners();
  }

  Future<void> blogListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode(
          {"START": "0", "END": "5", "LANG_ID": "1", "WORD": ""});
      Map<String, String> queryParams = {
        "USER_ID":"21013",
      };
      Uri uri = Uri.parse(AppUrls.blog).replace(queryParameters: queryParams);
      print(uri);
      setblog(ApiResponse.loading());
      _myRepo.blogListApi(uri.toString(), data).then((value) {
        setblog(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setblog(ApiResponse.error(error.toString()));
      });
    });
  }
}
