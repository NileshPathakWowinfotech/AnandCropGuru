import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/Model/MartModels/related_videos_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/CropModelsRepository/oneoffer_repository.dart';
import '../../repository/CropModelsRepository/related_video_repository.dart';
import '../user_view_model.dart';

class RelatedVideoViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = RelatedVideoRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<RelatedVideosModel> relatedVideoList = ApiResponse.loading();

  setComment(ApiResponse<RelatedVideosModel> response) {
    relatedVideoList = response;
    print('Report data $response');
    notifyListeners();
  }

  Future<void> relatedVideoAPi(productID) async {
    getUserData().then((value) async {
      print(productID);
      final data = jsonEncode({
        "START": 0,
        "END": 10000,
        "WORD": "",
        "GET_DATA": "Get_ProductVideos",
        "ID1":productID.toString(),
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
      _myRepo.relatedVideoListApi(data).then((value) {
        setComment(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setComment(ApiResponse.error(error.toString()));
      });
    });
  }
}
