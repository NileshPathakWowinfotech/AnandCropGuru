import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../../../data/Model/MyPlotModel.dart/reportmaster_model.dart';
import '../../../data/network/BaseApiServices.dart';
import '../../../data/network/NetworkApiServices.dart';
import '../../../data/response/api_response.dart';
import '../../../repository/myplot/reportMaster_repository.dart.dart';
import '../../../utils/app_urls.dart';
import '../../../utils/util.dart';
import '../../data/Model/CropModels/video_list_model.dart';
import '../../data/Model/CropModels/video_playlist_model.dart';
import '../../data/Model/offer_model.dart';
import '../../data/Model/user_model.dart';
import '../../repository/offer_repository.dart';
import '../../repository/CropModels/video_repository.dart';

class VideoViewModel with ChangeNotifier {
  late List datais;

  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = VideoRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<VideoListModel> videoList = ApiResponse.loading();

  setVideo(ApiResponse<VideoListModel> response) {
    videoList = response;

    print('  Report data $response');
    notifyListeners();
  } 

   ApiResponse<VideoPlayListModel> videoPlayList = ApiResponse.loading();

  setVideoPlay(ApiResponse<VideoPlayListModel> response) {
    videoPlayList = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> videoListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data =
          jsonEncode({"START": 0, "END": 100, "LANG_ID": "1", "WORD": "None"});
      Map<String, String> queryParams = {
        "USER_ID": value.userId.toString(),
        "TYPE": "User",
      };

      Uri uri = Uri.parse(AppUrls.VideoCategory)
          .replace(queryParameters: queryParams);
      setVideo(ApiResponse.loading());
      _myRepo.VideoListApi(uri.toString(), data).then((value) {
        setVideo(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setVideo(ApiResponse.error(error.toString()));
      });
    });
  } 

  Future<void> videoPlayListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data =
          jsonEncode({"START": 0, "END": 100, "LANG_ID": "1", "WORD": "None"});
      Map<String, String> queryParams = {
        "USER_ID": value.userId.toString(),
        "TYPE": "User",
        "CAT_ID": "3",
      };
      Uri uri = Uri.parse(AppUrls.VideoCategory)
          .replace(queryParameters: queryParams);
      setVideoPlay(ApiResponse.loading());
      _myRepo.VideoPlayListApi(uri.toString(), data).then((value) {
        setVideoPlay(ApiResponse.completed(value));
        print('hello');
      }).onError((error, stackTrace) {
        print('error this $error');
        setVideoPlay(ApiResponse.error(error.toString()));
      });
    });
  }
}
