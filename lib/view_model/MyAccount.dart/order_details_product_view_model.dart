import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../data/Model/ProfileModels/order_details_product_model.dart';
import '../../data/Model/user_model.dart';
import '../../data/network/BaseApiServices.dart';
import '../../data/network/NetworkApiServices.dart';
import '../../data/response/api_response.dart';
import '../../repository/MyAccount/order_details_product_repository.dart';
import '../user_view_model.dart';

class OrderDetailsProductViewModel with ChangeNotifier {
  BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> getUserData() => UserViewModel().getUser();
  final _myRepo = MyOrderProductRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ApiResponse<OrderDetailsProductModel> myOrderDetailsProductList =
      ApiResponse.loading();

  setmyOrderdetailsProduct(ApiResponse<OrderDetailsProductModel> response) {
    myOrderDetailsProductList = response;
    print('Report data $response');
    notifyListeners();
  }

  Future<void> myOrderProductListAPi(orderId) async {
    getUserData().then((value) async {
      print(value.userId);
      final data = jsonEncode({
        "START": 0,
        "END": 500000000,
        "WORD": "NONE",
        "GET_DATA": "Get_OrderDetails",
        "ID1": value.userId,
        "ID2": orderId.toString(),
        "ID3": "",
        "STATUS": "",
        "START_DATE": "",
        "END_DATE": "",
        "EXTRA1": "",
        "EXTRA2": "",
        "EXTRA3": "",
        "LANG_ID": ""
      });
      setmyOrderdetailsProduct(ApiResponse.loading());
      _myRepo.myOrderDetailsProductListApi(data).then((value) {
        setmyOrderdetailsProduct(ApiResponse.completed(value));
      }).onError((error, stackTrace) {
        setmyOrderdetailsProduct(ApiResponse.error(error.toString()));
      });
    });
  }
}
