import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';

import '../../data/Model/MyPlotModel.dart/reportmaster_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/myplot/reportMaster_repository.dart.dart';
import '../../utils/app_urls.dart';
import '../../utils/util.dart';
import '../data/Model/offer_model.dart';
import '../data/Model/user_model.dart';
import '../repository/offer_repository.dart';

class OfferViewModel with ChangeNotifier {
  late List datais;

  BaseApiServices _apiServices = NetworkApiService();
 Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = OfferRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<OfferListModel> offerList = ApiResponse.loading();

  setOffer(ApiResponse<OfferListModel> response) {
    offerList = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> offerListAPi() async {
      getUserData().then((value)async {
        print(value.userId);
    final data = jsonEncode({
      "START": "",
      "END": "",
      "WORD": "",
      "GET_DATA": "Get_Offers_Product",
      "ID1": "",
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
    setOffer(ApiResponse.loading());
    _myRepo.offerListApi(data).then((value) {
      setOffer(ApiResponse.completed(value));
      print('hello');
    }).onError((error, stackTrace) {
      print('error this $error');
      setOffer(ApiResponse.error(error.toString()));
    });
      });
  }
}
