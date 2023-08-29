import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.userId.toString());
    sp.setString('fullName', user.fullName.toString());
    sp.setString('MobileNumber', user.mobileNumber.toString());
    sp.setString('address', user.address.toString());
    sp.setString('email', user.email.toString());
    sp.setString('taluka', user.email.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String token = sp.getString('token').toString();
    final String fullName = sp.getString('fullName').toString();
    final String mobileNumber = sp.getString('MobileNumber').toString();
    final String address = sp.getString('address').toString();
    final String email = sp.getString('email').toString();
    final String destrict = sp.getString('destrict').toString();
    final String taluke = sp.getString('taluka').toString();

    return UserModel(
        userId: token,
        fullName: fullName,
        mobileNumber: mobileNumber,
        address: address,
        email: email, 
        destrict:destrict,
        taluke:taluke);
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
