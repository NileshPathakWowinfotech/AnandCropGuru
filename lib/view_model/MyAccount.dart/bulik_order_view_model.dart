import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/user_view_model.dart';
import '../../data/Model/user_model.dart';
import '../../repository/MyAccount/bulk_order_repository.dart';
import '../../utils/util.dart'; 

class BlukOrderViewModel with ChangeNotifier {
  final _myRepo = BulkOrderRepository();
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<UserModel> getUserData() => UserViewModel().getUser();

  Future<void> bulkOrderApi(
    BuildContext context,
    mobileNumber,orderType,
    companyName,
    address,
    pincode,
    panNumber,
    gstNumber,

  ) async {
      getUserData().then((value) {
      final data = jsonEncode({
         "BULK_ORDER_ID":"",
      "USER_ID": value.userId.toString(),
      "USER_NAME":value.fullName.toString(),
      "MOBILE_NUMBER":mobileNumber.toString(),
      "ORDER_TYPE":orderType,
      "SHOP_OR_COMPANY_NAME":companyName.toString(),
      "LATITUDE":"",
      "LONGITUDE":"",
      "ADDRESS":address.toString(),
      "PINCODE":pincode.toString(),
      "REMARK":"",
      "TASK":"ADD",
      "EXTRA1":"",
      "EXTRA2":"",
      "EXTRA3":"",
      "PAN": panNumber.toString(),
      "GST":gstNumber.toString(),
      "LANG_ID":""
      });
      print(data);
    setLoading(true);
    setLoading(true);
    _myRepo.bulkOrderApi(data).then((value) {
      setLoading(false);
      Navigator.pop(context);
      Util.tostMassage("Sucsess",);
      setLoading(false);
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Util.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  });
  }

 
  
}
