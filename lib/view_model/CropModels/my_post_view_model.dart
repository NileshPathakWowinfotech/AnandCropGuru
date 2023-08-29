import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/my_post_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModels/my_post_repository.dart';
import '../../utils/app_urls.dart';
import '../user_view_model.dart';

class MyPostViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = MyPostRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<MyPostModel> myPostList = ApiResponse.loading();

  setMyPost(ApiResponse<MyPostModel> response) {
    myPostList = response;

    print('Report data $response');
    notifyListeners();
  }

  Future<void> myPosListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data =
          jsonEncode({"START": 0, "END": 4, "WORD": "nONE", "LANG_ID": "1"});
      Map<String, String> queryParams = {
        "USER_ID": "21013",
      };
      Uri uri = Uri.parse(AppUrls.blog).replace(queryParameters: queryParams);
      print(uri);
      setMyPost(ApiResponse.loading());
      _myRepo.myPostListApi(uri.toString(), data).then((value) {
        setMyPost(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setMyPost(ApiResponse.error(error.toString()));
      });
    });
  }
}
