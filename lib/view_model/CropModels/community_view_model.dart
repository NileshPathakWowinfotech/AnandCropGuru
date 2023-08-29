import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/community_model.dart';
import '../../data/Model/CropModels/postcomment_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModels/community_repository.dart';
import '../user_view_model.dart';

class CommunityViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = CommunityRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<CommunityModel> CommunityList = ApiResponse.loading();

  setCommunity(ApiResponse<CommunityModel> response) {
    CommunityList = response;

    print('Report data $response');
    notifyListeners();
  } 

    ApiResponse<PostCommentModel> CommentList = ApiResponse.loading();

  setComment(ApiResponse<PostCommentModel> response) {
    CommentList = response;

    print('Report data $response');
    notifyListeners();
  }

  Future<void> communityListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "NONE",
        "GET_DATA": "Get_AllPost",
        "ID1": value.userId,
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
      setCommunity(ApiResponse.loading());
      _myRepo.communityListApi(data).then((value) {
        setCommunity(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setCommunity(ApiResponse.error(error.toString()));
      });
    });
  }

  Future<void> commentListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "NONE",
        "GET_DATA": "Get_AllPostCommentsByPostId",
        "ID1": value.userId.toString(),
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
      setComment(ApiResponse.loading());
      _myRepo.commentListApi(data).then((value) {
        setComment(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setComment(ApiResponse.error(error.toString()));
      });
    });
  }
}
