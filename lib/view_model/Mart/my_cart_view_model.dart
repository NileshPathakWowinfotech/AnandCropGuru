import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/MartModels/my_cart_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/response/api_response.dart';
import '../../repository/Mart/mycart_repository.dart';

class MyCartViewModel with ChangeNotifier {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  final _myRepo = MyCartRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<CartModel> myCartLists = ApiResponse.loading();

  setMyCart(ApiResponse<CartModel> response) {
    myCartLists = response;

    print('  Report data $response');
    notifyListeners();
  }

  Future<void> addCartApi() async {
    getUserData().then((value) {
      final data = jsonEncode({
        "START": '0',
        "END": '500000000',
        "WORD": "NONE",
        "GET_DATA": "Get_MyCartList",
        "ID1": '21013',
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
      setMyCart(ApiResponse.loading());
      _myRepo.myCartPostApi(data).then((value) {
        setMyCart(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        print('error this $error');
        setMyCart(ApiResponse.error(error.toString()));
      });
    });
  }
}
