import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/Model/ProfileModels/referral_program_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/MyAccount/my_order_repository.dart';
import '../../repository/MyAccount/refferal_program_repository.dart';
import '../user_view_model.dart';

class RefrealProgramViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = ReffrealProgramRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<ReferralProgramModel> refrealProgramList = ApiResponse.loading();

  setmyOrder(ApiResponse<ReferralProgramModel> response) {
    refrealProgramList = response;
    print('Report data $response');
    notifyListeners();
  }

  Future<void> reffrealProgramListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": "",
        "END": "",
        "WORD": "",
        "GET_DATA": "Get_My_Refrence",
        "ID1": "",
        "ID2": "",
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": value.mobileNumber.toString(),
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": "1",
        "USER_ID":value.userId.toString(),
        "CAT_ID": "",
        "PLOT_ID": ""
      });
      print("reffreal data $data");
      setmyOrder(ApiResponse.loading());
      _myRepo.reffrealProgramApi(data).then((value) {
        setmyOrder(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setmyOrder(ApiResponse.error(error.toString()));
      });
    });
  }
}
