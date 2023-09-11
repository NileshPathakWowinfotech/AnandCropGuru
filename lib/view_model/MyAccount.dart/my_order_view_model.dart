import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/CropModels/oneoffer_model.dart';
import '../../data/Model/ProfileModels/my_order_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/MyAccount/my_order_repository.dart';
import '../user_view_model.dart';

class MyOrderViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = MyOrderRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<MyOrderModel> myOrderList = ApiResponse.loading();

  setmyOrder(ApiResponse<MyOrderModel> response) {
    myOrderList = response;
    print('Report data $response');
    notifyListeners();
  }

  Future<void> myOrderListAPi() async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": 0,
        "END": 500000000,
        "WORD": "NONE",
        "GET_DATA": "Get_MyOrderList",
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
      print(value.distructName .toString());
       print(' dfff ${value.distructName.toString()}');
      setmyOrder(ApiResponse.loading());
      _myRepo.myOrderListApi(data).then((value) {
        setmyOrder(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setmyOrder(ApiResponse.error(error.toString()));
      });
    });
  }
}
